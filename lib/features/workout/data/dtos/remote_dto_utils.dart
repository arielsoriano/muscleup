import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/workout_entities.dart';

DateTime parseRemoteDateTime(dynamic value, {required DateTime fallback}) {
  if (value is Timestamp) {
    return value.toDate();
  }
  if (value is DateTime) {
    return value;
  }
  if (value is int) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }
  return fallback;
}

DateTime? parseNullableRemoteDateTime(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is Timestamp) {
    return value.toDate();
  }
  if (value is DateTime) {
    return value;
  }
  if (value is int) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }
  return null;
}

WorkoutUnit? parseWorkoutUnit(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is String) {
    for (final unit in WorkoutUnit.values) {
      if (unit.name == value) {
        return unit;
      }
    }
  }
  return null;
}

String? workoutUnitToRemote(WorkoutUnit? unit) {
  return unit?.name;
}

Map<String, dynamic> syncMetadataToRemoteMap(SyncMetadata? metadata) {
  final now = DateTime.now();
  return <String, dynamic>{
    'updatedAt': Timestamp.fromDate(metadata?.updatedAt ?? now),
    'deletedAt': metadata?.deletedAt == null
        ? null
        : Timestamp.fromDate(metadata!.deletedAt!),
    'syncStatus': metadata?.syncStatus ?? 'synced',
    'remoteVersion': metadata?.remoteVersion ?? 0,
  };
}

SyncMetadata parseSyncMetadata(Map<String, dynamic> map) {
  final now = DateTime.now();
  return SyncMetadata(
    updatedAt: parseRemoteDateTime(map['updatedAt'], fallback: now),
    deletedAt: parseNullableRemoteDateTime(map['deletedAt']),
    syncStatus: (map['syncStatus'] as String?) ?? 'synced',
    remoteVersion: (map['remoteVersion'] as num?)?.toInt() ?? 0,
  );
}
