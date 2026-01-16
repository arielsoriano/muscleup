import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/delete_routine_usecase.dart';
import '../../domain/usecases/watch_routines_usecase.dart';
import 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit({
    required WatchRoutinesUseCase watchRoutinesUseCase,
    required DeleteRoutineUseCase deleteRoutineUseCase,
  })  : _watchRoutinesUseCase = watchRoutinesUseCase,
        _deleteRoutineUseCase = deleteRoutineUseCase,
        super(const WorkoutState.initial()) {
    _initializeRoutinesStream();
  }

  final WatchRoutinesUseCase _watchRoutinesUseCase;
  final DeleteRoutineUseCase _deleteRoutineUseCase;
  StreamSubscription? _routinesSubscription;

  void _initializeRoutinesStream() {
    emit(const WorkoutState.loading());

    _routinesSubscription = _watchRoutinesUseCase(NoParams()).listen(
      (either) {
        either.fold(
          (failure) => emit(WorkoutState.error(message: _mapFailureToMessage(failure))),
          (routines) => emit(WorkoutState.success(routines: routines)),
        );
      },
    );
  }

  Future<void> deleteRoutine(String id) async {
    final currentState = state;
    
    if (currentState is! WorkoutStateSuccess) return;

    final result = await _deleteRoutineUseCase(DeleteRoutineParams(id: id));

    result.fold(
      (failure) => emit(WorkoutState.error(message: _mapFailureToMessage(failure))),
      (_) {},
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

  @override
  Future<void> close() {
    _routinesSubscription?.cancel();
    return super.close();
  }
}
