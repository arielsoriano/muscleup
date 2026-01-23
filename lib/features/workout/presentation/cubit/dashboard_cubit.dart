import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/usecases/delete_session_usecase.dart';
import '../../domain/usecases/watch_routines_usecase.dart';
import '../../domain/usecases/watch_sessions_usecase.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required WatchRoutinesUseCase watchRoutinesUseCase,
    required WatchSessionsUseCase watchSessionsUseCase,
    required DeleteSessionUseCase deleteSessionUseCase,
  })  : _watchRoutinesUseCase = watchRoutinesUseCase,
        _watchSessionsUseCase = watchSessionsUseCase,
        _deleteSessionUseCase = deleteSessionUseCase,
        super(DashboardState.initial(selectedDate: DateTime.now())) {
    _init();
  }

  final WatchRoutinesUseCase _watchRoutinesUseCase;
  final WatchSessionsUseCase _watchSessionsUseCase;
  final DeleteSessionUseCase _deleteSessionUseCase;
  StreamSubscription? _routinesSubscription;
  StreamSubscription? _sessionsSubscription;
  List<WorkoutSession> _allSessions = [];

  void _init() {
    emit(
      DashboardState.loading(
        selectedDate: state.selectedDate,
        sessions: state.sessions,
        activeSessions: state.activeSessions,
        completedSessions: state.completedSessions,
        routines: state.routines,
      ),
    );

    // Watch routines stream
    _routinesSubscription = _watchRoutinesUseCase(NoParams()).listen(
      (either) {
        either.fold(
          (failure) => emit(
            DashboardState.error(
              selectedDate: state.selectedDate,
              message: _mapFailureToMessage(failure),
              sessions: state.sessions,
              activeSessions: state.activeSessions,
              completedSessions: state.completedSessions,
              routines: state.routines,
            ),
          ),
          (routines) {
            emit(
              DashboardState.success(
                selectedDate: state.selectedDate,
                sessions: state.sessions,
                activeSessions: state.activeSessions,
                completedSessions: state.completedSessions,
                routines: routines,
              ),
            );
          },
        );
      },
    );

    // Watch sessions stream
    _sessionsSubscription = _watchSessionsUseCase(NoParams()).listen(
      (either) {
        either.fold(
          (failure) => emit(
            DashboardState.error(
              selectedDate: state.selectedDate,
              message: _mapFailureToMessage(failure),
              sessions: state.sessions,
              activeSessions: state.activeSessions,
              completedSessions: state.completedSessions,
              routines: state.routines,
            ),
          ),
          (sessions) {
            _allSessions = sessions;
            final twelveHoursAgo = DateTime.now().subtract(const Duration(hours: 12));
            final activeSessions = sessions
                .where((s) => !s.isCompleted && s.date.isAfter(twelveHoursAgo))
                .toList();
            final filteredSessions = _filterSessionsByDate(state.selectedDate);
            final completedSessions = _filterCompletedSessionsByDate(state.selectedDate);
            emit(
              DashboardState.success(
                selectedDate: state.selectedDate,
                sessions: filteredSessions,
                activeSessions: activeSessions,
                completedSessions: completedSessions,
                routines: state.routines,
              ),
            );
          },
        );
      },
    );
  }

  void selectDate(DateTime date) {
    final normalizedDate = _normalizeDate(date);
    final filteredSessions = _filterSessionsByDate(normalizedDate);
    final completedSessions = _filterCompletedSessionsByDate(normalizedDate);

    emit(
      DashboardState.success(
        selectedDate: normalizedDate,
        sessions: filteredSessions,
        activeSessions: state.activeSessions,
        completedSessions: completedSessions,
        routines: state.routines,
      ),
    );
  }

  Future<void> deleteSession(String sessionId) async {
    final result = await _deleteSessionUseCase(
      DeleteSessionParams(sessionId: sessionId),
    );

    result.fold(
      (failure) => emit(
        DashboardState.error(
          selectedDate: state.selectedDate,
          message: _mapFailureToMessage(failure),
          sessions: state.sessions,
          activeSessions: state.activeSessions,
          completedSessions: state.completedSessions,
          routines: state.routines,
        ),
      ),
      (_) {},
    );
  }

  List<WorkoutSession> _filterSessionsByDate(DateTime date) {
    final normalizedDate = _normalizeDate(date);
    return _allSessions.where((session) {
      final sessionDate = _normalizeDate(session.date);
      return sessionDate.isAtSameMomentAs(normalizedDate);
    }).toList();
  }

  List<WorkoutSession> _filterCompletedSessionsByDate(DateTime date) {
    final normalizedDate = _normalizeDate(date);
    return _allSessions.where((session) {
      final sessionDate = _normalizeDate(session.date);
      return sessionDate.isAtSameMomentAs(normalizedDate) && session.isCompleted;
    }).toList();
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
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
    _sessionsSubscription?.cancel();
    return super.close();
  }
}
