import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/workout_entities.dart';

part 'routine_form_state.freezed.dart';

@freezed
class RoutineFormState with _$RoutineFormState {
  const factory RoutineFormState.editing({
    required WorkoutRoutine routine,
    required bool isNew,
    @Default(false) bool isSaving,
  }) = RoutineFormStateEditing;

  const factory RoutineFormState.saving({
    required WorkoutRoutine routine,
    required bool isNew,
  }) = RoutineFormStateSaving;

  const factory RoutineFormState.success({
    required WorkoutRoutine routine,
  }) = RoutineFormStateSuccess;

  const factory RoutineFormState.error({
    required WorkoutRoutine routine,
    required bool isNew,
    required String message,
  }) = RoutineFormStateError;
}

extension RoutineFormStateX on RoutineFormState {
  bool get isNew => when(
        editing: (_, isNew, __) => isNew,
        saving: (_, isNew) => isNew,
        success: (_) => false,
        error: (_, isNew, __) => isNew,
      );
}
