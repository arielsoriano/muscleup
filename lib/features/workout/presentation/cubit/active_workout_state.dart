import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/workout_entities.dart';

part 'active_workout_state.freezed.dart';

@freezed
class ActiveWorkoutState with _$ActiveWorkoutState {
  const factory ActiveWorkoutState.initial({
    required WorkoutRoutine routine,
    @Default([]) List<SetLog> setLogs,
    String? displayTitle,
    @Default(false) bool isViewingHistory,
    @Default(false) bool isSaving,
    @Default(false) bool isLoading,
    int? restTimerSeconds,
    int? totalRestTime,
    @Default(false) bool isResting,
  }) = ActiveWorkoutStateInitial;

  const factory ActiveWorkoutState.loading({
    required WorkoutRoutine routine,
    String? displayTitle,
    @Default(false) bool isViewingHistory,
    @Default(true) bool isLoading,
    int? restTimerSeconds,
    int? totalRestTime,
    @Default(false) bool isResting,
  }) = ActiveWorkoutStateLoading;

  const factory ActiveWorkoutState.tracking({
    required WorkoutRoutine routine,
    required List<SetLog> setLogs,
    String? displayTitle,
    @Default(false) bool isViewingHistory,
    @Default(false) bool isSaving,
    @Default(false) bool isLoading,
    int? restTimerSeconds,
    int? totalRestTime,
    @Default(false) bool isResting,
  }) = ActiveWorkoutStateTracking;

  const factory ActiveWorkoutState.saving({
    required WorkoutRoutine routine,
    required List<SetLog> setLogs,
    String? displayTitle,
    @Default(false) bool isViewingHistory,
    @Default(false) bool isLoading,
    int? restTimerSeconds,
    int? totalRestTime,
    @Default(false) bool isResting,
  }) = ActiveWorkoutStateSaving;

  const factory ActiveWorkoutState.success({
    required WorkoutRoutine routine,
    required List<SetLog> setLogs,
    String? displayTitle,
    @Default(false) bool isViewingHistory,
    @Default(false) bool isLoading,
    int? restTimerSeconds,
    int? totalRestTime,
    @Default(false) bool isResting,
  }) = ActiveWorkoutStateSuccess;

  const factory ActiveWorkoutState.error({
    required WorkoutRoutine routine,
    required List<SetLog> setLogs,
    required String message,
    String? displayTitle,
    @Default(false) bool isViewingHistory,
    @Default(false) bool isLoading,
    int? restTimerSeconds,
    int? totalRestTime,
    @Default(false) bool isResting,
  }) = ActiveWorkoutStateError;
}
