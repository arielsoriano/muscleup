import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/features/workout/data/sync/sync_checkpoint_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SyncCheckpointStore', () {
    late SharedPreferences sharedPreferences;
    late SyncCheckpointStore store;

    Future<void> build([Map<String, Object> initial = const {}]) async {
      SharedPreferences.setMockInitialValues(initial);
      sharedPreferences = await SharedPreferences.getInstance();
      store = SyncCheckpointStore(sharedPreferences);
    }

    setUp(() => build());

    test('round-trips a checkpoint per uid and entity type', () async {
      final checkpoint = DateTime(2025, 1, 1, 10);
      await store.setCheckpoint(
        uid: 'uid-1',
        entityType: 'set',
        checkpoint: checkpoint,
      );

      expect(store.getCheckpoint(uid: 'uid-1', entityType: 'set'), checkpoint);
      expect(store.getCheckpoint(uid: 'uid-1', entityType: 'routine'), isNull);
      expect(store.getCheckpoint(uid: 'uid-2', entityType: 'set'), isNull);
    });

    test('clearing forgets every checkpoint but keeps the repair marker',
        () async {
      await store.setCheckpoint(
        uid: 'uid-1',
        entityType: 'set',
        checkpoint: DateTime(2025, 1, 1),
      );
      await store.setCheckpoint(
        uid: 'uid-1',
        entityType: 'routine',
        checkpoint: DateTime(2025, 1, 1),
      );
      await store.repairCheckpointsIfNeeded();

      await store.setCheckpoint(
        uid: 'uid-1',
        entityType: 'set',
        checkpoint: DateTime(2025, 2, 1),
      );
      await store.clearAllCheckpoints();

      expect(store.getCheckpoint(uid: 'uid-1', entityType: 'set'), isNull);
      // The marker survived, so no second repair is queued up.
      expect(await store.repairCheckpointsIfNeeded(), isFalse);
    });

    test('an install carrying old checkpoints is made to re-pull once',
        () async {
      // What an install updated from a version with the broken pull paging
      // looks like: checkpoints present, no repair marker.
      await build(<String, Object>{
        'sync_checkpoint_uid-1_set': DateTime(2025, 1, 1).millisecondsSinceEpoch,
        'sync_checkpoint_uid-1_exercise':
            DateTime(2025, 1, 1).millisecondsSinceEpoch,
      });

      expect(await store.repairCheckpointsIfNeeded(), isTrue);
      expect(store.getCheckpoint(uid: 'uid-1', entityType: 'set'), isNull);
      expect(store.getCheckpoint(uid: 'uid-1', entityType: 'exercise'), isNull);

      // Only once: a relaunch must not throw away checkpoints earned since.
      await store.setCheckpoint(
        uid: 'uid-1',
        entityType: 'set',
        checkpoint: DateTime(2025, 3, 1),
      );
      expect(await store.repairCheckpointsIfNeeded(), isFalse);
      expect(
        store.getCheckpoint(uid: 'uid-1', entityType: 'set'),
        DateTime(2025, 3, 1),
      );
    });
  });
}
