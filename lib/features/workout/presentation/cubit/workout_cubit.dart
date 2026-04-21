import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/delete_routine_usecase.dart';
import '../../domain/usecases/update_routine_order_usecase.dart';
import '../../domain/usecases/watch_routines_usecase.dart';
import '../../domain/entities/workout_entities.dart';
import 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit({
    required WatchRoutinesUseCase watchRoutinesUseCase,
    required DeleteRoutineUseCase deleteRoutineUseCase,
    required UpdateRoutineOrderUseCase updateRoutineOrderUseCase,
  })  : _watchRoutinesUseCase = watchRoutinesUseCase,
        _deleteRoutineUseCase = deleteRoutineUseCase,
        _updateRoutineOrderUseCase = updateRoutineOrderUseCase,
        super(const WorkoutState.initial()) {
    _initializeRoutinesStream();
  }

  final WatchRoutinesUseCase _watchRoutinesUseCase;
  final DeleteRoutineUseCase _deleteRoutineUseCase;
  final UpdateRoutineOrderUseCase _updateRoutineOrderUseCase;
  StreamSubscription? _routinesSubscription;
  bool _isFirstEmission = true;
  Timer? _emptyDebounceTimer;

  void _initializeRoutinesStream() {
    emit(const WorkoutState.loading());

    _routinesSubscription = _watchRoutinesUseCase(NoParams()).listen(
      (either) {
        either.fold(
          (failure) => emit(WorkoutState.error(message: _mapFailureToMessage(failure))),
          (routines) {
            _emptyDebounceTimer?.cancel();
            if (_isFirstEmission && routines.isEmpty) {
              // DB is empty — sync is likely still in progress.
              // Stay in loading and wait for data or a timeout.
              _emptyDebounceTimer = Timer(const Duration(seconds: 5), () {
                _isFirstEmission = false;
                emit(WorkoutState.success(routines: routines));
              });
            } else {
              _isFirstEmission = false;
              emit(WorkoutState.success(routines: routines));
            }
          },
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

  Future<void> updateRoutineOrder(List<WorkoutRoutine> routines) async {
    final normalized = List<WorkoutRoutine>.generate(
      routines.length,
      (index) => routines[index].copyWith(sortOrder: index),
    );

    final result = await _updateRoutineOrderUseCase(
      UpdateRoutineOrderParams(routines: normalized),
    );

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
    _emptyDebounceTimer?.cancel();
    return super.close();
  }
}
