import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/workout_entities.dart';
import 'remote_dto_utils.dart';

class RoutineRemoteDto {
  RoutineRemoteDto({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.remoteVersion,
  });

  factory RoutineRemoteDto.fromDomain(WorkoutRoutine routine) {
    final metadata = routine.syncMetadata;
    return RoutineRemoteDto(
      id: routine.id,
      name: routine.name,
      sortOrder: routine.sortOrder,
      updatedAt: metadata?.updatedAt ?? DateTime.now(),
      deletedAt: metadata?.deletedAt,
      syncStatus: metadata?.syncStatus ?? 'synced',
      remoteVersion: metadata?.remoteVersion ?? 0,
    );
  }

  factory RoutineRemoteDto.fromFirestore(
    Map<String, dynamic> map,
    String docId,
  ) {
    final now = DateTime.now();
    return RoutineRemoteDto(
      id: docId,
      name: (map['name'] as String?) ?? '',
      sortOrder: (map['sortOrder'] as num?)?.toInt() ?? 0,
      updatedAt: parseRemoteDateTime(map['updatedAt'], fallback: now),
      deletedAt: parseNullableRemoteDateTime(map['deletedAt']),
      syncStatus: (map['syncStatus'] as String?) ?? 'synced',
      remoteVersion: (map['remoteVersion'] as num?)?.toInt() ?? 0,
    );
  }

  final String id;
  final String name;
  final int sortOrder;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  final int remoteVersion;

  WorkoutRoutine toDomain({List<WorkoutExercise> exercises = const []}) {
    return WorkoutRoutine(
      id: id,
      name: name,
      sortOrder: sortOrder,
      exercises: exercises,
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
      'name': name,
      'sortOrder': sortOrder,
      'updatedAt': Timestamp.fromDate(updatedAt),
      'deletedAt': deletedAt == null ? null : Timestamp.fromDate(deletedAt!),
      'syncStatus': syncStatus,
      'remoteVersion': remoteVersion,
    };
  }
}
