import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/exercise_library.dart';
import '../../domain/entities/workout_entities.dart';
import 'remote_dto_utils.dart';

class ExerciseRemoteDto {
  ExerciseRemoteDto({
    required this.id,
    required this.routineId,
    required this.name,
    this.canonicalName,
    required this.sortOrder,
    required this.restTimeSeconds,
    this.notes,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.remoteVersion,
  });

  factory ExerciseRemoteDto.fromDomain(WorkoutExercise exercise, String routineId) {
    final metadata = exercise.syncMetadata;
    return ExerciseRemoteDto(
      id: exercise.id,
      routineId: routineId,
      name: exercise.name,
      canonicalName: exercise.canonicalName,
      sortOrder: exercise.sortOrder,
      notes: exercise.notes,
      restTimeSeconds: exercise.restTimeSeconds,
      updatedAt: metadata?.updatedAt ?? DateTime.now(),
      deletedAt: metadata?.deletedAt,
      syncStatus: metadata?.syncStatus ?? 'synced',
      remoteVersion: metadata?.remoteVersion ?? 0,
    );
  }

  factory ExerciseRemoteDto.fromFirestore(Map<String, dynamic> map, String docId) {
    final now = DateTime.now();
    final name = (map['name'] as String?) ?? '';
    return ExerciseRemoteDto(
      id: docId,
      routineId: (map['routineId'] as String?) ?? '',
      name: name,
      // A document written before the link existed carries only the translated
      // text. Recovering the catalog entry from that text here means such a
      // routine starts following the reader's language as soon as it syncs,
      // instead of staying stuck in the language it was created in.
      canonicalName: (map['canonicalName'] as String?) ??
          ExerciseLibrary.canonicalNameFor(name),
      sortOrder: (map['sortOrder'] as num?)?.toInt() ?? 0,
      notes: map['notes'] as String?,
      restTimeSeconds: (map['restTimeSeconds'] as num?)?.toInt() ?? 0,
      updatedAt: parseRemoteDateTime(map['updatedAt'], fallback: now),
      deletedAt: parseNullableRemoteDateTime(map['deletedAt']),
      syncStatus: (map['syncStatus'] as String?) ?? 'synced',
      remoteVersion: (map['remoteVersion'] as num?)?.toInt() ?? 0,
    );
  }

  final String id;
  final String routineId;
  final String name;

  /// Canonical catalog name, or null for a user-created exercise. See
  /// [WorkoutExercise.canonicalName].
  final String? canonicalName;

  final int sortOrder;
  final String? notes;
  final int restTimeSeconds;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  final int remoteVersion;

  WorkoutExercise toDomain({List<WorkoutSet> templateSets = const []}) {
    return WorkoutExercise(
      id: id,
      name: name,
      canonicalName: canonicalName,
      sortOrder: sortOrder,
      notes: notes,
      restTimeSeconds: restTimeSeconds,
      templateSets: templateSets,
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
      'name': name,
      'canonicalName': canonicalName,
      'sortOrder': sortOrder,
      'notes': notes,
      'restTimeSeconds': restTimeSeconds,
      'updatedAt': Timestamp.fromDate(updatedAt),
      'deletedAt': deletedAt == null ? null : Timestamp.fromDate(deletedAt!),
      'syncStatus': syncStatus,
      'remoteVersion': remoteVersion,
    };
  }
}
