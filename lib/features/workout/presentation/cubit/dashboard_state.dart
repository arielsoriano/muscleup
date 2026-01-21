import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/workout_entities.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial({
    required DateTime selectedDate,
    @Default([]) List<WorkoutSession> sessions,
    @Default([]) List<WorkoutSession> recentActiveSessions,
  }) = DashboardStateInitial;

  const factory DashboardState.loading({
    required DateTime selectedDate,
    @Default([]) List<WorkoutSession> sessions,
    @Default([]) List<WorkoutSession> recentActiveSessions,
  }) = DashboardStateLoading;

  const factory DashboardState.success({
    required DateTime selectedDate,
    required List<WorkoutSession> sessions,
    @Default([]) List<WorkoutSession> recentActiveSessions,
  }) = DashboardStateSuccess;

  const factory DashboardState.error({
    required DateTime selectedDate,
    required String message,
    @Default([]) List<WorkoutSession> sessions,
    @Default([]) List<WorkoutSession> recentActiveSessions,
  }) = DashboardStateError;
}
