import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/usecases/get_logs_for_session_usecase.dart';
import '../../domain/usecases/get_routine_by_id_usecase.dart';
import '../../domain/usecases/save_session_usecase.dart';
import '../../domain/usecases/save_set_log_usecase.dart';
import 'active_workout_state.dart';

class ActiveWorkoutCubit extends Cubit<ActiveWorkoutState> {
  ActiveWorkoutCubit({
    required String routineId,
    required WorkoutRoutine routine,
    required GetRoutineByIdUseCase getRoutineByIdUseCase,
    required SaveSessionUseCase saveSessionUseCase,
    required SaveSetLogUseCase saveSetLogUseCase,
    required GetLogsForSessionUseCase getLogsForSessionUseCase,
    String? sessionId,
  })  : _routineId = routineId,
        _getRoutineByIdUseCase = getRoutineByIdUseCase,
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
  final GetRoutineByIdUseCase _getRoutineByIdUseCase;
  final SaveSessionUseCase _saveSessionUseCase;
  final SaveSetLogUseCase _saveSetLogUseCase;
  final GetLogsForSessionUseCase _getLogsForSessionUseCase;
  final String? _existingSessionId;
  final _uuid = const Uuid();
  late final String _sessionId;

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
          message: 'Routine has no exercises',
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
    final result = await _getLogsForSessionUseCase(
      GetLogsForSessionParams(sessionId: _sessionId),
    );

    result.fold(
      (failure) {
        emit(
          ActiveWorkoutState.error(
            routine: routine.copyWith(exercises: List.from(routine.exercises)),
            setLogs: [],
            message: _mapFailureToMessage(failure),
            isLoading: false,
          ),
        );
      },
      (existingLogs) {
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

        if (updatedRoutine.exercises.isEmpty) {
          emit(
            ActiveWorkoutState.error(
              routine: updatedRoutine,
              setLogs: [],
              message: 'No exercises found in routine',
              isLoading: false,
            ),
          );
          return;
        }

        emit(
          ActiveWorkoutState.tracking(
            routine: updatedRoutine,
            setLogs: existingLogs,
            isLoading: false,
          ),
        );
      },
    );
  }

  void _createNewSession(WorkoutRoutine routine) {
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
          message: 'No exercises found in routine',
          isLoading: false,
        ),
      );
      return;
    }

    emit(
      ActiveWorkoutState.tracking(
        routine: routine.copyWith(exercises: List.from(routine.exercises)),
        setLogs: setLogs,
        isLoading: false,
      ),
    );
  }

  void updateSetLog(SetLog updatedLog) {
    state.maybeWhen(
      tracking: (routine, setLogs, _, __) {
        final updatedLogs = setLogs.map((log) {
          return log.id == updatedLog.id ? updatedLog : log;
        }).toList();

        emit(
          ActiveWorkoutState.tracking(
            routine: routine,
            setLogs: updatedLogs,
          ),
        );
      },
      orElse: () {},
    );
  }

  Future<void> finishWorkout() async {
    state.maybeWhen(
      tracking: (routine, setLogs, _, __) async {
        emit(
          ActiveWorkoutState.saving(
            routine: routine,
            setLogs: setLogs,
          ),
        );

        final session = WorkoutSession(
          id: _sessionId,
          routineId: routine.id,
          routineName: routine.name,
          date: DateTime.now(),
          notes: null,
        );

        final sessionResult = await _saveSessionUseCase(
          SaveSessionParams(session: session),
        );

        await sessionResult.fold(
          (failure) async {
            emit(
              ActiveWorkoutState.error(
                routine: routine,
                setLogs: setLogs,
                message: _mapFailureToMessage(failure),
              ),
            );
          },
          (_) async {
            await _saveAllSetLogs(routine, setLogs);
          },
        );
      },
      orElse: () {},
    );
  }

  Future<void> _saveAllSetLogs(
    WorkoutRoutine routine,
    List<SetLog> setLogs,
  ) async {
    for (final log in setLogs) {
      final result = await _saveSetLogUseCase(
        SaveSetLogParams(log: log.copyWith(timestamp: DateTime.now())),
      );

      result.fold(
        (failure) {
          emit(
            ActiveWorkoutState.error(
              routine: routine,
              setLogs: setLogs,
              message: _mapFailureToMessage(failure),
            ),
          );
        },
        (_) {},
      );

      if (state is ActiveWorkoutStateError) {
        return;
      }
    }

    emit(
      ActiveWorkoutState.success(
        routine: routine,
        setLogs: setLogs,
      ),
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
}
