import 'package:shared_preferences/shared_preferences.dart';

class SyncCheckpointStore {
  SyncCheckpointStore(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  DateTime? getCheckpoint({required String uid, required String entityType}) {
    final epochMilliseconds = sharedPreferences.getInt(
      _checkpointKey(uid: uid, entityType: entityType),
    );
    if (epochMilliseconds == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(epochMilliseconds);
  }

  Future<void> setCheckpoint({
    required String uid,
    required String entityType,
    required DateTime checkpoint,
  }) async {
    await sharedPreferences.setInt(
      _checkpointKey(uid: uid, entityType: entityType),
      checkpoint.millisecondsSinceEpoch,
    );
  }

  String _checkpointKey({required String uid, required String entityType}) {
    return 'sync_checkpoint_${uid}_$entityType';
  }

  /// Forgets every checkpoint, so the next sync pulls the account's whole
  /// history again instead of only what changed since the last cycle.
  ///
  /// Safe to run at any time: a full pull is idempotent. Everything it brings
  /// down goes through SyncConflictPolicy against the local row, so newer local
  /// work still wins and nothing already present is duplicated. It only costs
  /// one larger read.
  Future<void> clearAllCheckpoints() async {
    // The repair marker shares the prefix, and clearing it here would make
    // every launch look like a fresh install due for another full pull.
    final keys = sharedPreferences
        .getKeys()
        .where(
          (key) =>
              key.startsWith(_checkpointKeyPrefix) && key != _repairVersionKey,
        )
        .toList(growable: false);

    for (final key in keys) {
      await sharedPreferences.remove(key);
    }
  }

  /// Drops checkpoints left behind by the versions that paged the pull by
  /// `updatedAt > last seen`.
  ///
  /// That paging skipped documents whenever a page boundary fell inside a group
  /// sharing one timestamp, and then moved the checkpoint past them — so an
  /// install that pulled incompletely stays incomplete for good, because it
  /// believes it is already up to date. Fixing the paging alone would not
  /// recover those installs; they have to be told to ask again, once.
  ///
  /// Runs at most once per install, guarded by [_repairVersionKey].
  Future<bool> repairCheckpointsIfNeeded() async {
    final applied = sharedPreferences.getInt(_repairVersionKey) ?? 0;
    if (applied >= _currentRepairVersion) {
      return false;
    }

    await clearAllCheckpoints();
    await sharedPreferences.setInt(_repairVersionKey, _currentRepairVersion);
    return true;
  }

  static const String _checkpointKeyPrefix = 'sync_checkpoint_';
  static const String _repairVersionKey = 'sync_checkpoint_repair_version';

  /// Bump to force every existing install to re-pull once more.
  static const int _currentRepairVersion = 1;
}
