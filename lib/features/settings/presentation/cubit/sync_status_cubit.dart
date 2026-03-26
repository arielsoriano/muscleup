import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../workout/domain/sync/sync_engine.dart';
import '../../../workout/domain/sync/sync_run_state.dart';

class SyncStatusState {
  const SyncStatusState({
    required this.isSyncing,
    required this.lastRunMetrics,
    required this.lastErrorMessage,
  });

  factory SyncStatusState.initial() {
    return const SyncStatusState(
      isSyncing: false,
      lastRunMetrics: null,
      lastErrorMessage: null,
    );
  }

  final bool isSyncing;
  final SyncRunMetrics? lastRunMetrics;
  final String? lastErrorMessage;

  SyncStatusState copyWith({
    bool? isSyncing,
    SyncRunMetrics? lastRunMetrics,
    String? lastErrorMessage,
    bool clearErrorMessage = false,
  }) {
    return SyncStatusState(
      isSyncing: isSyncing ?? this.isSyncing,
      lastRunMetrics: lastRunMetrics ?? this.lastRunMetrics,
      lastErrorMessage: clearErrorMessage
          ? null
          : (lastErrorMessage ?? this.lastErrorMessage),
    );
  }
}

class SyncStatusCubit extends Cubit<SyncStatusState> {
  SyncStatusCubit(this._syncEngine) : super(SyncStatusState.initial()) {
    _syncSubscription = _syncEngine.stateStream.listen(_handleSyncStateChange);
  }

  final SyncEngine _syncEngine;
  StreamSubscription<SyncRunState>? _syncSubscription;

  Future<void> syncNow() async {
    if (state.isSyncing) {
      return;
    }

    final syncRunResult = await _syncEngine.triggerManualSync();
    if (!syncRunResult.success && syncRunResult.message != null) {
      emit(state.copyWith(
        isSyncing: false,
        lastRunMetrics: syncRunResult.metrics,
        lastErrorMessage: syncRunResult.message,
      ),);
    }
  }

  void _handleSyncStateChange(SyncRunState syncRunState) {
    switch (syncRunState) {
      case SyncIdle():
        emit(state.copyWith(isSyncing: false));
        return;
      case Syncing():
        emit(state.copyWith(isSyncing: true, clearErrorMessage: true));
        return;
      case SyncSuccess(metrics: final metrics):
        emit(state.copyWith(
          isSyncing: false,
          lastRunMetrics: metrics,
          clearErrorMessage: true,
        ),);
        return;
      case SyncError(message: final message, metrics: final metrics):
        emit(state.copyWith(
          isSyncing: false,
          lastRunMetrics: metrics,
          lastErrorMessage: message,
        ),);
        return;
    }
  }

  @override
  Future<void> close() async {
    await _syncSubscription?.cancel();
    return super.close();
  }
}
