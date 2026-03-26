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
}
