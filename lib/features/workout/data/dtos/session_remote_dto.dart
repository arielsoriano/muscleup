import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/workout_entities.dart';
import 'remote_dto_utils.dart';

class SessionRemoteDto {
  SessionRemoteDto({
    required this.id,
    required this.routineId,
    required this.routineName,
    required this.createdAt,
    this.notes,
    required this.isCompleted,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.remoteVersion,
  });

  factory SessionRemoteDto.fromDomain(WorkoutSession session) {
    final metadata = session.syncMetadata;
    return SessionRemoteDto(
      id: session.id,
      routineId: session.routineId,
      routineName: session.routineName,
      createdAt: session.createdAt,
      notes: session.notes,
      isCompleted: session.isCompleted,
      updatedAt: metadata?.updatedAt ?? DateTime.now(),
      deletedAt: metadata?.deletedAt,
      syncStatus: metadata?.syncStatus ?? 'synced',
      remoteVersion: metadata?.remoteVersion ?? 0,
    );
  }

  factory SessionRemoteDto.fromFirestore(Map<String, dynamic> map, String docId) {
    final now = DateTime.now();
    return SessionRemoteDto(
      id: docId,
      routineId: (map['routineId'] as String?) ?? '',
      routineName: (map['routineName'] as String?) ?? '',
      createdAt: parseRemoteDateTime(map['createdAt'], fallback: now),
      notes: map['notes'] as String?,
      isCompleted: (map['isCompleted'] as bool?) ?? true,
      updatedAt: parseRemoteDateTime(map['updatedAt'], fallback: now),
      deletedAt: parseNullableRemoteDateTime(map['deletedAt']),
      syncStatus: (map['syncStatus'] as String?) ?? 'synced',
      remoteVersion: (map['remoteVersion'] as num?)?.toInt() ?? 0,
    );
  }

  final String id;
  final String routineId;
  final String routineName;
  final DateTime createdAt;
  final String? notes;
  final bool isCompleted;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  final int remoteVersion;

  WorkoutSession toDomain() {
    return WorkoutSession(
      id: id,
      routineId: routineId,
      routineName: routineName,
      createdAt: createdAt,
      notes: notes,
      isCompleted: isCompleted,
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
      'routineId': routineId,
      'routineName': routineName,
      'createdAt': Timestamp.fromDate(createdAt),
      'notes': notes,
      'isCompleted': isCompleted,
      'updatedAt': Timestamp.fromDate(updatedAt),
      'deletedAt': deletedAt == null ? null : Timestamp.fromDate(deletedAt!),
      'syncStatus': syncStatus,
      'remoteVersion': remoteVersion,
    };
  }
}
