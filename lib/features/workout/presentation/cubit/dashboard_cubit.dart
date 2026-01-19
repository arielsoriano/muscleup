import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/usecases/delete_session_usecase.dart';
import '../../domain/usecases/watch_sessions_usecase.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required WatchSessionsUseCase watchSessionsUseCase,
    required DeleteSessionUseCase deleteSessionUseCase,
  })  : _watchSessionsUseCase = watchSessionsUseCase,
        _deleteSessionUseCase = deleteSessionUseCase,
        super(DashboardState.initial(selectedDate: DateTime.now())) {
    _initializeSessionsStream();
  }

  final WatchSessionsUseCase _watchSessionsUseCase;
  final DeleteSessionUseCase _deleteSessionUseCase;
  StreamSubscription? _sessionsSubscription;
  List<WorkoutSession> _allSessions = [];

  void _initializeSessionsStream() {
    emit(DashboardState.loading(
      selectedDate: state.selectedDate,
      sessions: state.sessions,
    ),);

    _sessionsSubscription = _watchSessionsUseCase(NoParams()).listen(
      (either) {
        either.fold(
          (failure) => emit(DashboardState.error(
            selectedDate: state.selectedDate,
            message: _mapFailureToMessage(failure),
            sessions: state.sessions,
          ),),
          (sessions) {
            _allSessions = sessions;
            final filteredSessions = _filterSessionsByDate(state.selectedDate);
            emit(DashboardState.success(
              selectedDate: state.selectedDate,
              sessions: filteredSessions,
            ),);
          },
        );
      },
    );
  }

  void selectDate(DateTime date) {
    final normalizedDate = _normalizeDate(date);
    final filteredSessions = _filterSessionsByDate(normalizedDate);
    
    emit(DashboardState.success(
      selectedDate: normalizedDate,
      sessions: filteredSessions,
    ),);
  }

  Future<void> deleteSession(String sessionId) async {
    final result = await _deleteSessionUseCase(
      DeleteSessionParams(sessionId: sessionId),
    );

    result.fold(
      (failure) => emit(DashboardState.error(
        selectedDate: state.selectedDate,
        message: _mapFailureToMessage(failure),
        sessions: state.sessions,
      ),),
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
    _sessionsSubscription?.cancel();
    return super.close();
  }
}
