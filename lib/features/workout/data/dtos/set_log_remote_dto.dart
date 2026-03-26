import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/workout_entities.dart';
import 'remote_dto_utils.dart';

class SetLogRemoteDto {
  SetLogRemoteDto({
    required this.id,
    required this.sessionId,
    required this.workoutExerciseId,
    required this.setNumber,
    this.actualValue1,
    this.actualValue2,
    this.unit1,
    this.unit2,
    required this.isCompleted,
    required this.timestamp,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.remoteVersion,
  });

  factory SetLogRemoteDto.fromDomain(SetLog setLog) {
    final metadata = setLog.syncMetadata;
    return SetLogRemoteDto(
      id: setLog.id,
      sessionId: setLog.sessionId,
      workoutExerciseId: setLog.workoutExerciseId,
      setNumber: setLog.setNumber,
      actualValue1: setLog.actualValue1,
      actualValue2: setLog.actualValue2,
      unit1: setLog.unit1,
      unit2: setLog.unit2,
      isCompleted: setLog.isCompleted,
      timestamp: setLog.timestamp,
      updatedAt: metadata?.updatedAt ?? DateTime.now(),
      deletedAt: metadata?.deletedAt,
      syncStatus: metadata?.syncStatus ?? 'synced',
      remoteVersion: metadata?.remoteVersion ?? 0,
    );
  }

  factory SetLogRemoteDto.fromFirestore(Map<String, dynamic> map, String docId) {
    final now = DateTime.now();
    return SetLogRemoteDto(
      id: docId,
      sessionId: (map['sessionId'] as String?) ?? '',
      workoutExerciseId: (map['workoutExerciseId'] as String?) ?? '',
      setNumber: (map['setNumber'] as num?)?.toInt() ?? 0,
      actualValue1: (map['actualValue1'] as num?)?.toDouble(),
      actualValue2: (map['actualValue2'] as num?)?.toDouble(),
      unit1: parseWorkoutUnit(map['unit1']),
      unit2: parseWorkoutUnit(map['unit2']),
      isCompleted: (map['isCompleted'] as bool?) ?? false,
      timestamp: parseRemoteDateTime(map['timestamp'], fallback: now),
      updatedAt: parseRemoteDateTime(map['updatedAt'], fallback: now),
      deletedAt: parseNullableRemoteDateTime(map['deletedAt']),
      syncStatus: (map['syncStatus'] as String?) ?? 'synced',
      remoteVersion: (map['remoteVersion'] as num?)?.toInt() ?? 0,
    );
  }

  final String id;
  final String sessionId;
  final String workoutExerciseId;
  final int setNumber;
  final double? actualValue1;
  final double? actualValue2;
  final WorkoutUnit? unit1;
  final WorkoutUnit? unit2;
  final bool isCompleted;
  final DateTime timestamp;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  final int remoteVersion;

  SetLog toDomain() {
    return SetLog(
      id: id,
      sessionId: sessionId,
      workoutExerciseId: workoutExerciseId,
      setNumber: setNumber,
      actualValue1: actualValue1,
      actualValue2: actualValue2,
      unit1: unit1,
      unit2: unit2,
      isCompleted: isCompleted,
      timestamp: timestamp,
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
      'sessionId': sessionId,
      'workoutExerciseId': workoutExerciseId,
      'setNumber': setNumber,
      'actualValue1': actualValue1,
      'actualValue2': actualValue2,
      'unit1': workoutUnitToRemote(unit1),
      'unit2': workoutUnitToRemote(unit2),
      'isCompleted': isCompleted,
      'timestamp': Timestamp.fromDate(timestamp),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'deletedAt': deletedAt == null ? null : Timestamp.fromDate(deletedAt!),
      'syncStatus': syncStatus,
      'remoteVersion': remoteVersion,
    };
  }
}
