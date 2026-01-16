import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/workout_entities.dart';

part 'workout_state.freezed.dart';

@freezed
class WorkoutState with _$WorkoutState {
  const factory WorkoutState.initial() = WorkoutStateInitial;
  const factory WorkoutState.loading() = WorkoutStateLoading;
  const factory WorkoutState.success({
    required List<WorkoutRoutine> routines,
  }) = WorkoutStateSuccess;
  const factory WorkoutState.error({
    required String message,
  }) = WorkoutStateError;
}
