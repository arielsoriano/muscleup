import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/repositories/workout_repository.dart';
import '../../domain/usecases/get_logs_for_session_usecase.dart';
import '../../domain/usecases/get_routine_by_id_usecase.dart';
import '../../domain/usecases/get_session_by_id_usecase.dart';
import '../../domain/usecases/save_session_usecase.dart';
import '../../domain/usecases/save_set_log_usecase.dart';
import 'active_workout_state.dart';

class ActiveWorkoutCubit extends Cubit<ActiveWorkoutState> {
  ActiveWorkoutCubit({
    required String routineId,
    required WorkoutRoutine routine,
    required WorkoutRepository repository,
    required GetRoutineByIdUseCase getRoutineByIdUseCase,
    required GetSessionByIdUseCase getSessionByIdUseCase,
    required SaveSessionUseCase saveSessionUseCase,
    required SaveSetLogUseCase saveSetLogUseCase,
    required GetLogsForSessionUseCase getLogsForSessionUseCase,
    String? sessionId,
  })  : _routineId = routineId,
        _repository = repository,
        _getRoutineByIdUseCase = getRoutineByIdUseCase,
        _getSessionByIdUseCase = getSessionByIdUseCase,
        _saveSessionUseCase = saveSessionUseCase,
        _saveSetLogUseCase = saveSetLogUseCase,
        _getLogsForSessionUseCase = getLogsForSessionUseCase,
        _existingSessionId = sessionId,
        super(
          ActiveWorkoutState.loading(routine: routine, isLoading: true),
        ) {
    loadInitialData();
  }

  final String _routineId;
  final WorkoutRepository _repository;
  final GetRoutineByIdUseCase _getRoutineByIdUseCase;
  final GetSessionByIdUseCase _getSessionByIdUseCase;
  final SaveSessionUseCase _saveSessionUseCase;
  final SaveSetLogUseCase _saveSetLogUseCase;
  final GetLogsForSessionUseCase _getLogsForSessionUseCase;
  final String? _existingSessionId;
  final _uuid = const Uuid();
  late final String _sessionId;
  Timer? _restTimer;

  Future<void> loadInitialData() async {
    emit(ActiveWorkoutState.loading(routine: state.routine, isLoading: true));

    final routineResult = await _getRoutineByIdUseCase(
      GetRoutineByIdParams(id: _routineId),
    );

    final fullRoutineOrNull = await routineResult.fold(
      (failure) async {
        emit(
          ActiveWorkoutState.error(
            routine: state.routine,
            setLogs: [],
            displayTitle: null,
            isViewingHistory: false,
            message: _mapFailureToMessage(failure),
            isLoading: false,
          ),
        );
        return null;
      },
      (fetchedRoutine) async {
        return fetchedRoutine;
      },
    );

    if (fullRoutineOrNull == null) return;

    final fullRoutine = fullRoutineOrNull;

    if (fullRoutine.exercises.isEmpty) {
      emit(
        ActiveWorkoutState.error(
          routine: fullRoutine,
          setLogs: [],
          displayTitle: null,
          isViewingHistory: false,
          message: 'error.noExercises',
          isLoading: false,
        ),
      );
      return;
    }

    emit(
      ActiveWorkoutState.loading(
        routine: fullRoutine.copyWith(exercises: List.from(fullRoutine.exercises)),
        isLoading: true,
      ),
    );

    if (_existingSessionId != null) {
      _sessionId = _existingSessionId!;
      await _loadExistingSession(fullRoutine);
    } else {
      _createNewSession(fullRoutine);
    }
  }

  Future<void> _loadExistingSession(WorkoutRoutine routine) async {
    final sessionResult = await _getSessionByIdUseCase(
      GetSessionByIdParams(sessionId: _sessionId),
    );

    final sessionOrNull = await sessionResult.fold(
      (failure) async {
        emit(
          ActiveWorkoutState.error(
            routine: routine.copyWith(exercises: List.from(routine.exercises)),
            setLogs: [],
            message: _mapFailureToMessage(failure),
            isLoading: false,
          ),
        );
        return null;
      },
      (session) async => session,
    );

    if (sessionOrNull == null) return;

    final historicalSession = sessionOrNull;

    final result = await _getLogsForSessionUseCase(
      GetLogsForSessionParams(sessionId: _sessionId),
    );

    result.fold(
      (failure) {
        emit(
          ActiveWorkoutState.error(
            routine: routine.copyWith(exercises: List.from(routine.exercises)),
            setLogs: [],
            displayTitle: historicalSession.routineName,
            isViewingHistory: true,
            message: _mapFailureToMessage(failure),
            isLoading: false,
          ),
        );
      },
      (existingLogs) {
        if (existingLogs.isEmpty) {
          emit(
            ActiveWorkoutState.error(
              routine: routine.copyWith(
                  exercises: List.from(routine.exercises),),
              setLogs: [],
              displayTitle: historicalSession.routineName,
              isViewingHistory: true,
              message: 'error.noLogsFound',
              isLoading: false,
            ),
          );
          return;
        }

        final exerciseIdsWithLogs =
            existingLogs.map((log) => log.workoutExerciseId).toSet();

        final filteredExercises = routine.exercises
            .where((exercise) => exerciseIdsWithLogs.contains(exercise.id))
            .toList();

        final updatedExercises = filteredExercises.map((exercise) {
          final exerciseLogs = existingLogs
              .where((log) => log.workoutExerciseId == exercise.id)
              .toList();

          if (exerciseLogs.isEmpty) return exercise;

          final updatedSets = List<WorkoutSet>.from(exercise.templateSets);
          for (final log in exerciseLogs) {
            final setIndex = log.setNumber - 1;
            if (setIndex >= 0 && setIndex < updatedSets.length) {
              updatedSets[setIndex] = WorkoutSet(
                id: updatedSets[setIndex].id,
                sortOrder: updatedSets[setIndex].sortOrder,
                targetValue1: log.actualValue1,
                targetValue2: log.actualValue2,
                unit1: updatedSets[setIndex].unit1,
                unit2: updatedSets[setIndex].unit2,
              );
            }
          }

          return exercise.copyWith(templateSets: updatedSets);
        }).toList();

        final updatedRoutine = routine.copyWith(exercises: updatedExercises);

        if (updatedRoutine.exercises.isEmpty) {
          emit(
            ActiveWorkoutState.error(
              routine: updatedRoutine,
              setLogs: [],
              displayTitle: historicalSession.routineName,
              isViewingHistory: true,
              message: 'error.noExercises',
              isLoading: false,
            ),
          );
          return;
        }

        emit(
          ActiveWorkoutState.tracking(
            routine: updatedRoutine,
            setLogs: existingLogs,
            displayTitle: historicalSession.routineName,
            isViewingHistory: true,
            isLoading: false,
          ),
        );
      },
    );
  }

  void _createNewSession(WorkoutRoutine routine) async {
    await _repository.finalizeStaleSessions();
    
    _sessionId = _uuid.v4();
    final setLogs = <SetLog>[];

    for (final exercise in routine.exercises) {
      for (var i = 0; i < exercise.templateSets.length; i++) {
        final templateSet = exercise.templateSets[i];
        setLogs.add(
          SetLog(
            id: _uuid.v4(),
            sessionId: _sessionId,
            workoutExerciseId: exercise.id,
            setNumber: i + 1,
            actualValue1: templateSet.targetValue1,
            actualValue2: templateSet.targetValue2,
            unit1: templateSet.unit1,
            unit2: templateSet.unit2,
            isCompleted: false,
            timestamp: DateTime.now(),
          ),
        );
      }
    }

    if (routine.exercises.isEmpty) {
      emit(
        ActiveWorkoutState.error(
          routine: routine.copyWith(exercises: List.from(routine.exercises)),
          setLogs: [],
          displayTitle: null,
          isViewingHistory: false,
          message: 'error.noExercises',
          isLoading: false,
        ),
      );
      return;
    }

    final workoutSession = WorkoutSession(
      id: _sessionId,
      routineId: routine.id,
      routineName: routine.name,
      date: DateTime.now(),
      notes: null,
      isCompleted: false,
    );

    final sessionResult = await _saveSessionUseCase(
      SaveSessionParams(session: workoutSession),
    );

    await sessionResult.fold(
      (failure) async {
        emit(
          ActiveWorkoutState.error(
            routine: routine.copyWith(exercises: List.from(routine.exercises)),
            setLogs: [],
            displayTitle: null,
            isViewingHistory: false,
            message: _mapFailureToMessage(failure),
            isLoading: false,
          ),
        );
      },
      (_) async {
        for (final log in setLogs) {
          await _saveSetLogUseCase(SaveSetLogParams(log: log));
        }

        emit(
          ActiveWorkoutState.tracking(
            routine: routine.copyWith(exercises: List.from(routine.exercises)),
            setLogs: setLogs,
            displayTitle: null,
            isViewingHistory: false,
            isLoading: false,
          ),
        );
      },
    );
  }

  void updateSetLog(SetLog updatedLog) {
    state.maybeWhen(
      tracking: (routine, setLogs, displayTitle, isViewingHistory, _, __, ___, ____, _____) async {
        final updatedLogs = setLogs.map((log) {
          return log.id == updatedLog.id ? updatedLog : log;
        }).toList();

        emit(
          ActiveWorkoutState.tracking(
            routine: routine,
            setLogs: updatedLogs,
            displayTitle: displayTitle,
            isViewingHistory: isViewingHistory,
          ),
        );

        await _saveSetLogUseCase(
          SaveSetLogParams(log: updatedLog.copyWith(timestamp: DateTime.now())),
        );
      },
      orElse: () {},
    );
  }

  Future<void> finishWorkout() async {
    state.maybeWhen(
      tracking: (routine, setLogs, displayTitle, isViewingHistory, _, __, ___, ____, _____) async {
        emit(
          ActiveWorkoutState.saving(
            routine: routine,
            setLogs: setLogs,
            displayTitle: displayTitle,
            isViewingHistory: isViewingHistory,
          ),
        );

        final workoutSession = WorkoutSession(
          id: _sessionId,
          routineId: routine.id,
          routineName: routine.name,
          date: DateTime.now(),
          notes: null,
          isCompleted: true,
        );

        final sessionResult = await _saveSessionUseCase(
          SaveSessionParams(session: workoutSession),
        );

        sessionResult.fold(
          (failure) {
            emit(
              ActiveWorkoutState.error(
                routine: routine,
                setLogs: setLogs,
                displayTitle: displayTitle,
                isViewingHistory: isViewingHistory,
                message: _mapFailureToMessage(failure),
              ),
            );
          },
          (_) {
            emit(
              ActiveWorkoutState.success(
                routine: routine,
                setLogs: setLogs,
                displayTitle: displayTitle,
                isViewingHistory: isViewingHistory,
              ),
            );
          },
        );
      },
      orElse: () {},
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is DatabaseFailure) {
      return failure.message;
    } else if (failure is UnexpectedFailure) {
      return failure.message;
    } else {
      return 'An unexpected error occurred';
    }
  }

  void startRestTimer(int seconds) {
    _restTimer?.cancel();

    state.maybeWhen(
      tracking: (routine, setLogs, displayTitle, isViewingHistory, _, __, ___, ____, _____) {
        emit(
          ActiveWorkoutState.tracking(
            routine: routine,
            setLogs: setLogs,
            displayTitle: displayTitle,
            isViewingHistory: isViewingHistory,
            restTimerSeconds: seconds,
            totalRestTime: seconds,
            isResting: true,
          ),
        );

        _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          final currentState = state;
          currentState.maybeWhen(
            tracking: (routine, setLogs, displayTitle, isViewingHistory, _, __, restTimerSeconds, totalRestTime, isResting) {
              if (restTimerSeconds != null && restTimerSeconds > 0) {
                emit(
                  ActiveWorkoutState.tracking(
                    routine: routine,
                    setLogs: setLogs,
                    displayTitle: displayTitle,
                    isViewingHistory: isViewingHistory,
                    restTimerSeconds: restTimerSeconds - 1,
                    totalRestTime: totalRestTime,
                    isResting: true,
                  ),
                );
              } else {
                HapticFeedback.vibrate();
                stopRestTimer();
              }
            },
            orElse: () {
              timer.cancel();
            },
          );
        });
      },
      initial: (routine, setLogs, displayTitle, isViewingHistory, _, __, ___, ____, _____) {
        emit(
          ActiveWorkoutState.initial(
            routine: routine,
            setLogs: setLogs,
            displayTitle: displayTitle,
            isViewingHistory: isViewingHistory,
            restTimerSeconds: seconds,
            totalRestTime: seconds,
            isResting: true,
          ),
        );

        _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          final currentState = state;
          currentState.maybeWhen(
            initial: (routine, setLogs, displayTitle, isViewingHistory, _, __, restTimerSeconds, totalRestTime, isResting) {
              if (restTimerSeconds != null && restTimerSeconds > 0) {
                emit(
                  ActiveWorkoutState.initial(
                    routine: routine,
                    setLogs: setLogs,
                    displayTitle: displayTitle,
                    isViewingHistory: isViewingHistory,
                    restTimerSeconds: restTimerSeconds - 1,
                    totalRestTime: totalRestTime,
                    isResting: true,
                  ),
                );
              } else {
                HapticFeedback.vibrate();
                stopRestTimer();
              }
            },
            orElse: () {
              timer.cancel();
            },
          );
        });
      },
      orElse: () {},
    );
  }

  void stopRestTimer() {
    _restTimer?.cancel();
    _restTimer = null;

    state.maybeWhen(
      tracking: (routine, setLogs, displayTitle, isViewingHistory, _, __, ___, ____, _____) {
        emit(
          ActiveWorkoutState.tracking(
            routine: routine,
            setLogs: setLogs,
            displayTitle: displayTitle,
            isViewingHistory: isViewingHistory,
            restTimerSeconds: null,
            totalRestTime: null,
            isResting: false,
          ),
        );
      },
      initial: (routine, setLogs, displayTitle, isViewingHistory, _, __, ___, ____, _____) {
        emit(
          ActiveWorkoutState.initial(
            routine: routine,
            setLogs: setLogs,
            displayTitle: displayTitle,
            isViewingHistory: isViewingHistory,
            restTimerSeconds: null,
            totalRestTime: null,
            isResting: false,
          ),
        );
      },
      orElse: () {},
    );
  }

  void add30Seconds() {
    state.maybeWhen(
      tracking: (routine, setLogs, displayTitle, isViewingHistory, _, __, restTimerSeconds, totalRestTime, isResting) {
        if (restTimerSeconds != null && totalRestTime != null) {
          emit(
            ActiveWorkoutState.tracking(
              routine: routine,
              setLogs: setLogs,
              displayTitle: displayTitle,
              isViewingHistory: isViewingHistory,
              restTimerSeconds: restTimerSeconds + 30,
              totalRestTime: totalRestTime + 30,
              isResting: true,
            ),
          );
        }
      },
      initial: (routine, setLogs, displayTitle, isViewingHistory, _, __, restTimerSeconds, totalRestTime, isResting) {
        if (restTimerSeconds != null && totalRestTime != null) {
          emit(
            ActiveWorkoutState.initial(
              routine: routine,
              setLogs: setLogs,
              displayTitle: displayTitle,
              isViewingHistory: isViewingHistory,
              restTimerSeconds: restTimerSeconds + 30,
              totalRestTime: totalRestTime + 30,
              isResting: true,
            ),
          );
        }
      },
      orElse: () {},
    );
  }

  @override
  Future<void> close() {
    _restTimer?.cancel();
    return super.close();
  }
}
