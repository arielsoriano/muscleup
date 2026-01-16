import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/usecases/save_routine_usecase.dart';
import 'routine_form_state.dart';

class RoutineFormCubit extends Cubit<RoutineFormState> {
  RoutineFormCubit({
    WorkoutRoutine? routine,
    required SaveRoutineUseCase saveRoutineUseCase,
  })  : _saveRoutineUseCase = saveRoutineUseCase,
        super(
          RoutineFormState.editing(
            routine: routine ??
                WorkoutRoutine(
                  id: const Uuid().v4(),
                  name: 'New Routine',
                  sortOrder: 0,
                  exercises: [],
                ),
            isNew: routine == null,
          ),
        );

  final SaveRoutineUseCase _saveRoutineUseCase;
  final _uuid = const Uuid();

  void updateName(String name) {
    final currentRoutine = state.routine;
    emit(
      RoutineFormState.editing(
        routine: currentRoutine.copyWith(name: name),
        isNew: state.isNew,
      ),
    );
  }

  void addExercise(String exerciseName) {
    final currentRoutine = state.routine;
    final newExercise = WorkoutExercise(
      id: _uuid.v4(),
      name: exerciseName,
      sortOrder: currentRoutine.exercises.length,
      notes: null,
      restTimeSeconds: 60,
      templateSets: [],
    );

    emit(
      RoutineFormState.editing(
        routine: currentRoutine.copyWith(
          exercises: [...currentRoutine.exercises, newExercise],
        ),
        isNew: state.isNew,
      ),
    );
  }

  void removeExercise(String exerciseId) {
    final currentRoutine = state.routine;
    final updatedExercises = currentRoutine.exercises
        .where((exercise) => exercise.id != exerciseId)
        .toList();

    final reorderedExercises = _reorderList(updatedExercises);

    emit(
      RoutineFormState.editing(
        routine: currentRoutine.copyWith(exercises: reorderedExercises),
        isNew: state.isNew,
      ),
    );
  }

  void updateExercise(String exerciseId, {String? name, String? notes, int? restTimeSeconds}) {
    final currentRoutine = state.routine;
    final updatedExercises = currentRoutine.exercises.map((exercise) {
      if (exercise.id == exerciseId) {
        return exercise.copyWith(
          name: name ?? exercise.name,
          notes: notes ?? exercise.notes,
          restTimeSeconds: restTimeSeconds ?? exercise.restTimeSeconds,
        );
      }
      return exercise;
    }).toList();

    emit(
      RoutineFormState.editing(
        routine: currentRoutine.copyWith(exercises: updatedExercises),
        isNew: state.isNew,
      ),
    );
  }

  void addSet(String exerciseId) {
    final currentRoutine = state.routine;
    final updatedExercises = currentRoutine.exercises.map((exercise) {
      if (exercise.id == exerciseId) {
        final newSet = WorkoutSet(
          id: _uuid.v4(),
          sortOrder: exercise.templateSets.length,
          targetValue1: 0,
          targetValue2: 0,
          unit1: WorkoutUnit.kilograms,
          unit2: WorkoutUnit.repetitions,
        );
        return exercise.copyWith(
          templateSets: [...exercise.templateSets, newSet],
        );
      }
      return exercise;
    }).toList();

    emit(
      RoutineFormState.editing(
        routine: currentRoutine.copyWith(exercises: updatedExercises),
        isNew: state.isNew,
      ),
    );
  }

  void removeSet(String exerciseId, String setId) {
    final currentRoutine = state.routine;
    final updatedExercises = currentRoutine.exercises.map((exercise) {
      if (exercise.id == exerciseId) {
        final updatedSets = exercise.templateSets
            .where((set) => set.id != setId)
            .toList();
        final reorderedSets = _reorderList(updatedSets);
        return exercise.copyWith(templateSets: reorderedSets);
      }
      return exercise;
    }).toList();

    emit(
      RoutineFormState.editing(
        routine: currentRoutine.copyWith(exercises: updatedExercises),
        isNew: state.isNew,
      ),
    );
  }

  void updateSetValues({
    required String exerciseId,
    required String setId,
    double? targetValue1,
    double? targetValue2,
    WorkoutUnit? unit1,
    WorkoutUnit? unit2,
  }) {
    final currentRoutine = state.routine;
    final updatedExercises = currentRoutine.exercises.map((exercise) {
      if (exercise.id == exerciseId) {
        final updatedSets = exercise.templateSets.map((set) {
          if (set.id == setId) {
            return set.copyWith(
              targetValue1: targetValue1 ?? set.targetValue1,
              targetValue2: targetValue2 ?? set.targetValue2,
              unit1: unit1 ?? set.unit1,
              unit2: unit2 ?? set.unit2,
            );
          }
          return set;
        }).toList();
        return exercise.copyWith(templateSets: updatedSets);
      }
      return exercise;
    }).toList();

    emit(
      RoutineFormState.editing(
        routine: currentRoutine.copyWith(exercises: updatedExercises),
        isNew: state.isNew,
      ),
    );
  }

  Future<void> saveRoutine() async {
    emit(
      RoutineFormState.saving(
        routine: state.routine,
        isNew: state.isNew,
      ),
    );

    final result = await _saveRoutineUseCase(
      SaveRoutineParams(routine: state.routine),
    );

    result.fold(
      (failure) {
        emit(
          RoutineFormState.error(
            routine: state.routine,
            isNew: state.isNew,
            message: _mapFailureToMessage(failure),
          ),
        );
      },
      (_) {
        emit(
          RoutineFormState.success(
            routine: state.routine,
          ),
        );
      },
    );
  }

  List<T> _reorderList<T>(List<T> items) {
    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      
      if (item is WorkoutExercise) {
        return item.copyWith(sortOrder: index) as T;
      } else if (item is WorkoutSet) {
        return item.copyWith(sortOrder: index) as T;
      }
      return item;
    }).toList();
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
