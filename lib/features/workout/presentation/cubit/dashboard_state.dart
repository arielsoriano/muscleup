import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/workout_entities.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial({
    required DateTime selectedDate,
    @Default([]) List<WorkoutSession> sessions,
    @Default([]) List<WorkoutSession> activeSessions,
    @Default([]) List<WorkoutSession> completedSessions,
    @Default([]) List<WorkoutRoutine> routines,
  }) = DashboardStateInitial;

  const factory DashboardState.loading({
    required DateTime selectedDate,
    @Default([]) List<WorkoutSession> sessions,
    @Default([]) List<WorkoutSession> activeSessions,
    @Default([]) List<WorkoutSession> completedSessions,
    @Default([]) List<WorkoutRoutine> routines,
  }) = DashboardStateLoading;

  const factory DashboardState.success({
    required DateTime selectedDate,
    required List<WorkoutSession> sessions,
    @Default([]) List<WorkoutSession> activeSessions,
    @Default([]) List<WorkoutSession> completedSessions,
    @Default([]) List<WorkoutRoutine> routines,
  }) = DashboardStateSuccess;

  const factory DashboardState.error({
    required DateTime selectedDate,
    required String message,
    @Default([]) List<WorkoutSession> sessions,
    @Default([]) List<WorkoutSession> activeSessions,
    @Default([]) List<WorkoutSession> completedSessions,
    @Default([]) List<WorkoutRoutine> routines,
  }) = DashboardStateError;
}
