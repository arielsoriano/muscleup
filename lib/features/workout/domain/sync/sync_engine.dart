import 'sync_run_state.dart';

abstract class SyncEngine {
  Stream<SyncRunState> get stateStream;

  Future<SyncRunResult> triggerManualSync();

  Future<void> startAutoSync();

  Future<void> notifyConnectivityRestored();
}
