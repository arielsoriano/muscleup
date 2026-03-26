import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../sync/sync_engine.dart';
import '../sync/sync_run_state.dart';

class TriggerManualSyncUseCase extends UseCase<SyncRunResult, NoParams> {
  TriggerManualSyncUseCase(this.syncEngine);

  final SyncEngine syncEngine;

  @override
  Future<Either<Failure, SyncRunResult>> call(NoParams params) async {
    final result = await syncEngine.triggerManualSync();
    if (result.success) {
      return Either<Failure, SyncRunResult>.right(result);
    }
    return Either<Failure, SyncRunResult>.left(
      DatabaseFailure(result.message ?? 'Sync failed'),
    );
  }
}
