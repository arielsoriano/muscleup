import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/repositories/workout_repository.dart';
import '../services/rest_timer_service.dart';
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
    required RestTimerService restTimerService,
    String? sessionId,
  })  : _routineId = routineId,
        _restTimerService = restTimerService,
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
  final RestTimerService _restTimerService;
  final GetRoutineByIdUseCase _getRoutineByIdUseCase;
  final GetSessionByIdUseCase _getSessionByIdUseCase;
  final SaveSessionUseCase _saveSessionUseCase;
  final SaveSetLogUseCase _saveSetLogUseCase;
  final GetLogsForSessionUseCase _getLogsForSessionUseCase;
  final String? _existingSessionId;
  final _uuid = const Uuid();
  late final String _sessionId;

  Future<void> loadInitialData() async {
    
    emit(ActiveWorkoutState.loading(routine: state.routine));

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
            message: _mapFailureToMessage(failure),
          ),
        );
        return null;
      },
      (fetchedRoutine) async {
        return fetchedRoutine;
      },
    );

    if (fullRoutineOrNull == null) {
      return;
    }

    final fullRoutine = fullRoutineOrNull;

    if (fullRoutine.exercises.isEmpty) {
      emit(
        ActiveWorkoutState.error(
          routine: fullRoutine,
          setLogs: [],
          displayTitle: null,
          message: 'error.noExercises',
        ),
      );
      return;
    }

    emit(
      ActiveWorkoutState.loading(
        routine: fullRoutine.copyWith(exercises: List.from(fullRoutine.exercises)),
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
          ),
        );
        return null;
      },
      (session) async {
        return session;
      },
    );

    if (sessionOrNull == null) {
      return;
    }

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
            isViewingHistory: historicalSession.isCompleted,
            message: _mapFailureToMessage(failure),
          ),
        );
      },
      (existingLogs) async {
        final mergedLogs = await _ensureMissingLogsForRoutine(
          routine: routine,
          existingLogs: existingLogs,
        );

        final updatedExercises = routine.exercises.map((exercise) {
          final exerciseLogs = mergedLogs
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

        emit(
          ActiveWorkoutState.tracking(
            routine: updatedRoutine,
            setLogs: mergedLogs,
            displayTitle: historicalSession.routineName,
            isViewingHistory: historicalSession.isCompleted,
          ),
        );
      },
    );
  }

  Future<List<SetLog>> _ensureMissingLogsForRoutine({
    required WorkoutRoutine routine,
    required List<SetLog> existingLogs,
  }) async {
    final mergedLogs = List<SetLog>.from(existingLogs);

    final existingKeys = existingLogs
        .map((log) => '${log.workoutExerciseId}:${log.setNumber}')
        .toSet();

    for (final exercise in routine.exercises) {
      final orderedSets = [...exercise.templateSets]
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

      for (var index = 0; index < orderedSets.length; index++) {
        final setNumber = index + 1;
        final setKey = '${exercise.id}:$setNumber';

        if (existingKeys.contains(setKey)) {
          continue;
        }

        final templateSet = orderedSets[index];
        final newLog = SetLog(
          id: _uuid.v4(),
          sessionId: _sessionId,
          workoutExerciseId: exercise.id,
          setNumber: setNumber,
          actualValue1: templateSet.targetValue1,
          actualValue2: templateSet.targetValue2,
          unit1: templateSet.unit1,
          unit2: templateSet.unit2,
          isCompleted: false,
          timestamp: DateTime.now(),
        );

        final saveResult = await _saveSetLogUseCase(
          SaveSetLogParams(log: newLog),
        );

        saveResult.fold(
          (_) {},
          (_) {
            mergedLogs.add(newLog);
            existingKeys.add(setKey);
          },
        );
      }
    }

    return mergedLogs;
  }

  void _createNewSession(WorkoutRoutine routine) async {
    await _repository.finalizeStaleSessions();
    
    _sessionId = _uuid.v4();
    
    final workoutSession = WorkoutSession(
      id: _sessionId,
      routineId: routine.id,
      routineName: routine.name,
      createdAt: DateTime.now(),
      notes: null,
      isCompleted: false,
    );

    final sessionResult = await _saveSessionUseCase(
      SaveSessionParams(session: workoutSession),
    );

    sessionResult.fold(
      (failure) {
        emit(
          ActiveWorkoutState.error(
            routine: routine.copyWith(exercises: List.from(routine.exercises)),
            setLogs: [],
            displayTitle: null,
            message: 'Failed to create session',
          ),
        );
        return;
      },
      (_) {},

    );
    
    final setLogs = <SetLog>[];

    for (final exercise in routine.exercises) {
      for (var i = 0; i < exercise.templateSets.length; i++) {
        final templateSet = exercise.templateSets[i];
        final setLog = SetLog(
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
        );
        setLogs.add(setLog);

        final saveResult = await _saveSetLogUseCase(
          SaveSetLogParams(log: setLog),
        );

        saveResult.fold(
          (failure) {},
          (_) {},
        );
      }
    }

    if (routine.exercises.isEmpty) {
      emit(
        ActiveWorkoutState.error(
          routine: routine.copyWith(exercises: List.from(routine.exercises)),
          setLogs: [],
          displayTitle: null,
          message: 'error.noExercises',
        ),
      );
      return;
    }

    emit(
      ActiveWorkoutState.tracking(
        routine: routine.copyWith(exercises: List.from(routine.exercises)),
        setLogs: setLogs,
        displayTitle: null,
      ),
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

  Future<String?> saveSetAsRoutineTarget(SetLog log) async {
    final currentState = state;

    return currentState.maybeWhen(
      tracking: (
        routine,
        setLogs,
        displayTitle,
        isViewingHistory,
        isSaving,
        isLoading,
        restTimerSeconds,
        totalRestTime,
        isResting,
      ) async {
        if (isViewingHistory) {
          return 'error.cannotUpdateHistoryTarget';
        }

        final exerciseIndex = routine.exercises.indexWhere(
          (exercise) => exercise.id == log.workoutExerciseId,
        );

        if (exerciseIndex == -1) {
          return 'error.targetExerciseNotFound';
        }

        final exercise = routine.exercises[exerciseIndex];
        final setIndex = log.setNumber - 1;

        if (setIndex < 0 || setIndex >= exercise.templateSets.length) {
          return 'error.targetSetNotFound';
        }

        final updatedSets = [...exercise.templateSets];
        final currentSet = updatedSets[setIndex];
        updatedSets[setIndex] = currentSet.copyWith(
          targetValue1: log.actualValue1,
          targetValue2: log.actualValue2,
        );

        final updatedExercises = [...routine.exercises];
        updatedExercises[exerciseIndex] = exercise.copyWith(
          templateSets: updatedSets,
        );

        final updatedRoutine = routine.copyWith(exercises: updatedExercises);
        final saveResult = await _repository.saveRoutine(updatedRoutine);

        return saveResult.fold(
          (failure) => _mapFailureToMessage(failure),
          (_) {
            emit(
              ActiveWorkoutState.tracking(
                routine: updatedRoutine,
                setLogs: setLogs,
                displayTitle: displayTitle,
                isViewingHistory: isViewingHistory,
                isSaving: isSaving,
                isLoading: isLoading,
                restTimerSeconds: restTimerSeconds,
                totalRestTime: totalRestTime,
                isResting: isResting,
              ),
            );
            return null;
          },
        );
      },
      orElse: () async => 'error.targetRoutineUnavailable',
    );
  }

  Future<void> finishWorkout() async {
    state.mapOrNull(
      tracking: (trackingState) async {
        if (trackingState.isViewingHistory) {
          return;
        }

        emit(
          ActiveWorkoutState.saving(
            routine: trackingState.routine,
            setLogs: trackingState.setLogs,
            displayTitle: trackingState.displayTitle,
            isViewingHistory: trackingState.isViewingHistory,
          ),
        );

        final workoutSession = WorkoutSession(
          id: _sessionId,
          routineId: trackingState.routine.id,
          routineName: trackingState.routine.name,
          createdAt: DateTime.now(),
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
                routine: trackingState.routine,
                setLogs: trackingState.setLogs,
                displayTitle: trackingState.displayTitle,
                isViewingHistory: trackingState.isViewingHistory,
                message: _mapFailureToMessage(failure),
              ),
            );
          },
          (_) {
            _restTimerService.stop();
            emit(
              ActiveWorkoutState.success(
                routine: trackingState.routine,
                setLogs: trackingState.setLogs,
                displayTitle: trackingState.displayTitle,
                isViewingHistory: true,
              ),
            );
          },
        );
      },
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
    _restTimerService.start(seconds);
  }

  void stopRestTimer() {
    _restTimerService.stop();
  }

  void add30Seconds() {
    _restTimerService.addSeconds(30);
  }
}
