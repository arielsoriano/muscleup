import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/workout_entities.dart';
import 'remote_dto_utils.dart';

class SetRemoteDto {
  SetRemoteDto({
    required this.id,
    required this.exerciseId,
    required this.sortOrder,
    this.targetValue1,
    this.targetValue2,
    this.unit1,
    this.unit2,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.remoteVersion,
  });

  factory SetRemoteDto.fromDomain(WorkoutSet workoutSet, String exerciseId) {
    final metadata = workoutSet.syncMetadata;
    return SetRemoteDto(
      id: workoutSet.id,
      exerciseId: exerciseId,
      sortOrder: workoutSet.sortOrder,
      targetValue1: workoutSet.targetValue1,
      targetValue2: workoutSet.targetValue2,
      unit1: workoutSet.unit1,
      unit2: workoutSet.unit2,
      updatedAt: metadata?.updatedAt ?? DateTime.now(),
      deletedAt: metadata?.deletedAt,
      syncStatus: metadata?.syncStatus ?? 'synced',
      remoteVersion: metadata?.remoteVersion ?? 0,
    );
  }

  factory SetRemoteDto.fromFirestore(Map<String, dynamic> map, String docId) {
    final now = DateTime.now();
    return SetRemoteDto(
      id: docId,
      exerciseId: (map['exerciseId'] as String?) ?? '',
      sortOrder: (map['sortOrder'] as num?)?.toInt() ?? 0,
      targetValue1: (map['targetValue1'] as num?)?.toDouble(),
      targetValue2: (map['targetValue2'] as num?)?.toDouble(),
      unit1: parseWorkoutUnit(map['unit1']),
      unit2: parseWorkoutUnit(map['unit2']),
      updatedAt: parseRemoteDateTime(map['updatedAt'], fallback: now),
      deletedAt: parseNullableRemoteDateTime(map['deletedAt']),
      syncStatus: (map['syncStatus'] as String?) ?? 'synced',
      remoteVersion: (map['remoteVersion'] as num?)?.toInt() ?? 0,
    );
  }

  final String id;
  final String exerciseId;
  final int sortOrder;
  final double? targetValue1;
  final double? targetValue2;
  final WorkoutUnit? unit1;
  final WorkoutUnit? unit2;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  final int remoteVersion;

  WorkoutSet toDomain() {
    return WorkoutSet(
      id: id,
      sortOrder: sortOrder,
      targetValue1: targetValue1,
      targetValue2: targetValue2,
      unit1: unit1,
      unit2: unit2,
      syncMetadata: SyncMetadata(
        updatedAt: updatedAt,
        deletedAt: deletedAt,
        syncStatus: syncStatus,
        remoteVersion: remoteVersion,
      ),
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'exerciseId': exerciseId,
      'sortOrder': sortOrder,
      'targetValue1': targetValue1,
      'targetValue2': targetValue2,
      'unit1': workoutUnitToRemote(unit1),
      'unit2': workoutUnitToRemote(unit2),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'deletedAt': deletedAt == null ? null : Timestamp.fromDate(deletedAt!),
      'syncStatus': syncStatus,
      'remoteVersion': remoteVersion,
    };
  }
}
