import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
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
    if (AppConstants.enableDebugLogging) {
      print('=== ACTIVE WORKOUT CUBIT LOAD INITIAL DATA ===');
      print('loadInitialData called');
      print('routineId: $_routineId');
      print('existingSessionId: $_existingSessionId');
    }
    
    emit(ActiveWorkoutState.loading(routine: state.routine));

    if (AppConstants.enableDebugLogging) {
      print('Step 1: Fetching routine from database...');
    }

    final routineResult = await _getRoutineByIdUseCase(
      GetRoutineByIdParams(id: _routineId),
    );

    final fullRoutineOrNull = await routineResult.fold(
      (failure) async {
        if (AppConstants.enableDebugLogging) {
          print('ERROR: Failed to load routine: $failure');
        }
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
        if (AppConstants.enableDebugLogging) {
          print('SUCCESS: Routine loaded: ${fetchedRoutine.name}');
          print('Routine ID: ${fetchedRoutine.id}');
          print('Exercises count: ${fetchedRoutine.exercises.length}');
          for (var exercise in fetchedRoutine.exercises) {
            print('  - Exercise: ${exercise.name}, sets: ${exercise.templateSets.length}');
          }
        }
        return fetchedRoutine;
      },
    );

    if (fullRoutineOrNull == null) {
      if (AppConstants.enableDebugLogging) {
        print('ERROR: Routine is null, aborting');
      }
      return;
    }

    final fullRoutine = fullRoutineOrNull;

    if (fullRoutine.exercises.isEmpty) {
      if (AppConstants.enableDebugLogging) {
        print('ERROR: Routine has no exercises');
      }
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
      if (AppConstants.enableDebugLogging) {
        print('Loading existing session: $_sessionId');
      }
      await _loadExistingSession(fullRoutine);
    } else {
      if (AppConstants.enableDebugLogging) {
        print('No existing session - calling _createNewSession');
      }
      _createNewSession(fullRoutine);
    }
  }

  Future<void> _loadExistingSession(WorkoutRoutine routine) async {
    if (AppConstants.enableDebugLogging) {
      print('Step 2: Loading existing session...');
      print('SessionId: $_sessionId');
    }

    final sessionResult = await _getSessionByIdUseCase(
      GetSessionByIdParams(sessionId: _sessionId),
    );

    final sessionOrNull = await sessionResult.fold(
      (failure) async {
        if (AppConstants.enableDebugLogging) {
          print('ERROR: Failed to load session: $failure');
        }
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
        if (AppConstants.enableDebugLogging) {
          print('SUCCESS: Session loaded: ${session.id}');
          print('Session routineId: ${session.routineId}');
          print('Session routineName: ${session.routineName}');
          print('Session isCompleted: ${session.isCompleted}');
        }
        return session;
      },
    );

    if (sessionOrNull == null) {
      if (AppConstants.enableDebugLogging) {
        print('ERROR: Session is null, aborting');
      }
      return;
    }

    final historicalSession = sessionOrNull;

    if (AppConstants.enableDebugLogging) {
      print('Step 3: Loading set logs for session...');
    }

    final result = await _getLogsForSessionUseCase(
      GetLogsForSessionParams(sessionId: _sessionId),
    );

    result.fold(
      (failure) {
        if (AppConstants.enableDebugLogging) {
          print('ERROR: Failed to load set logs: $failure');
        }
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
      (existingLogs) {
        if (AppConstants.enableDebugLogging) {
          print('SUCCESS: Set logs loaded: ${existingLogs.length}');
          if (existingLogs.isEmpty) {
            print('INFO: No set logs found yet - this is normal for new sessions');
          } else {
            for (var log in existingLogs) {
              print('  - SetLog: exerciseId=${log.workoutExerciseId}, setNumber=${log.setNumber}, completed=${log.isCompleted}');
            }
          }
        }

        if (AppConstants.enableDebugLogging) {
          print('Step 4: Building exercise state with logs...');
          print('Total exercises in routine: ${routine.exercises.length}');
        }

        final updatedExercises = routine.exercises.map((exercise) {
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

        if (AppConstants.enableDebugLogging) {
          print('Step 5: Emitting success state');
          print('Final exercises count: ${updatedRoutine.exercises.length}');
          print('Final set logs count: ${existingLogs.length}');
          print('Is viewing history: ${historicalSession.isCompleted}');
        }

        emit(
          ActiveWorkoutState.tracking(
            routine: updatedRoutine,
            setLogs: existingLogs,
            displayTitle: historicalSession.routineName,
            isViewingHistory: historicalSession.isCompleted,
          ),
        );
      },
    );
  }

  void _createNewSession(WorkoutRoutine routine) async {
    if (AppConstants.enableDebugLogging) {
      print('=== ACTIVE WORKOUT CUBIT CREATE NEW SESSION ===');
      print('_createNewSession called for routine: ${routine.name} (id=${routine.id})');
    }
    
    await _repository.finalizeStaleSessions();
    
    _sessionId = _uuid.v4();
    
    if (AppConstants.enableDebugLogging) {
      print('Generated new sessionId: $_sessionId');
      print('Creating session in database immediately');
    }
    
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
        if (AppConstants.enableDebugLogging) {
          print('ERROR: Session creation failed: $failure');
        }
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
      (_) {
        if (AppConstants.enableDebugLogging) {
          print('Session created successfully in database: $_sessionId');
        }
      },
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

        if (AppConstants.enableDebugLogging) {
          print('Saving SetLog to database: exercise=${exercise.name}, setNumber=${i + 1}');
        }

        final saveResult = await _saveSetLogUseCase(
          SaveSetLogParams(log: setLog),
        );

        saveResult.fold(
          (failure) {
            if (AppConstants.enableDebugLogging) {
              print('ERROR: Failed to save SetLog: $failure');
            }
          },
          (_) {
            if (AppConstants.enableDebugLogging) {
              print('SUCCESS: SetLog saved to database');
            }
          },
        );
      }
    }

    if (routine.exercises.isEmpty) {
      if (AppConstants.enableDebugLogging) {
        print('ERROR: Routine has no exercises');
      }
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

    if (AppConstants.enableDebugLogging) {
      print('Step 5: Emitting tracking state');
      print('Final exercises count: ${routine.exercises.length}');
      print('Final set logs count: ${setLogs.length}');
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
