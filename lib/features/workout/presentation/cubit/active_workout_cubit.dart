import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/usecases/save_session_usecase.dart';
import '../../domain/usecases/save_set_log_usecase.dart';
import 'active_workout_state.dart';

class ActiveWorkoutCubit extends Cubit<ActiveWorkoutState> {
  ActiveWorkoutCubit({
    required WorkoutRoutine routine,
    required SaveSessionUseCase saveSessionUseCase,
    required SaveSetLogUseCase saveSetLogUseCase,
  })  : _saveSessionUseCase = saveSessionUseCase,
        _saveSetLogUseCase = saveSetLogUseCase,
        super(ActiveWorkoutState.initial(routine: routine)) {
    _initializeSetLogs();
  }

  final SaveSessionUseCase _saveSessionUseCase;
  final SaveSetLogUseCase _saveSetLogUseCase;
  final _uuid = const Uuid();
  late String _sessionId;

  void _initializeSetLogs() {
    _sessionId = _uuid.v4();
    final setLogs = <SetLog>[];

    for (final exercise in state.routine.exercises) {
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

    emit(ActiveWorkoutState.tracking(
      routine: state.routine,
      setLogs: setLogs,
    ),);
  }

  void updateSetLog(SetLog updatedLog) {
    final updatedLogs = state.setLogs.map((log) {
      return log.id == updatedLog.id ? updatedLog : log;
    }).toList();

    emit(ActiveWorkoutState.tracking(
      routine: state.routine,
      setLogs: updatedLogs,
    ),);
  }

  Future<void> finishWorkout() async {
    emit(ActiveWorkoutState.saving(
      routine: state.routine,
      setLogs: state.setLogs,
    ),);

    final session = WorkoutSession(
      id: _sessionId,
      routineId: state.routine.id,
      date: DateTime.now(),
      notes: null,
    );

    final sessionResult = await _saveSessionUseCase(
      SaveSessionParams(session: session),
    );

    await sessionResult.fold(
      (failure) async {
        emit(ActiveWorkoutState.error(
          routine: state.routine,
          setLogs: state.setLogs,
          message: _mapFailureToMessage(failure),
        ),);
      },
      (_) async {
        await _saveAllSetLogs();
      },
    );
  }

  Future<void> _saveAllSetLogs() async {
    final completedLogs = state.setLogs.where((log) => log.isCompleted).toList();

    for (final log in completedLogs) {
      final result = await _saveSetLogUseCase(
        SaveSetLogParams(log: log.copyWith(timestamp: DateTime.now())),
      );

      result.fold(
        (failure) {
          emit(ActiveWorkoutState.error(
            routine: state.routine,
            setLogs: state.setLogs,
            message: _mapFailureToMessage(failure),
          ),);
        },
        (_) {},
      );

      if (state is ActiveWorkoutStateError) {
        return;
      }
    }

    emit(ActiveWorkoutState.success(
      routine: state.routine,
      setLogs: state.setLogs,
    ),);
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
