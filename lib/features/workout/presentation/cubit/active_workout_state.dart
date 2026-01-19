import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/workout_entities.dart';

part 'active_workout_state.freezed.dart';

@freezed
class ActiveWorkoutState with _$ActiveWorkoutState {
  const factory ActiveWorkoutState.initial({
    required WorkoutRoutine routine,
    @Default([]) List<SetLog> setLogs,
    @Default(false) bool isSaving,
    @Default(false) bool isLoading,
  }) = ActiveWorkoutStateInitial;

  const factory ActiveWorkoutState.loading({
    required WorkoutRoutine routine,
    @Default(true) bool isLoading,
  }) = ActiveWorkoutStateLoading;

  const factory ActiveWorkoutState.tracking({
    required WorkoutRoutine routine,
    required List<SetLog> setLogs,
    @Default(false) bool isSaving,
    @Default(false) bool isLoading,
  }) = ActiveWorkoutStateTracking;

  const factory ActiveWorkoutState.saving({
    required WorkoutRoutine routine,
    required List<SetLog> setLogs,
    @Default(false) bool isLoading,
  }) = ActiveWorkoutStateSaving;

  const factory ActiveWorkoutState.success({
    required WorkoutRoutine routine,
    required List<SetLog> setLogs,
    @Default(false) bool isLoading,
  }) = ActiveWorkoutStateSuccess;

  const factory ActiveWorkoutState.error({
    required WorkoutRoutine routine,
    required List<SetLog> setLogs,
    required String message,
    @Default(false) bool isLoading,
  }) = ActiveWorkoutStateError;
}
