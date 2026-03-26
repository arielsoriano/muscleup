import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/workout_repository.dart';
import 'remote_dto_utils.dart';

class LibraryExerciseRemoteDto {
  LibraryExerciseRemoteDto({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.nameEs,
    required this.isCustom,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.remoteVersion,
  });

  factory LibraryExerciseRemoteDto.fromDomain(LibraryExerciseEntity exercise) {
    final metadata = exercise.syncMetadata;
    return LibraryExerciseRemoteDto(
      id: exercise.id,
      name: exercise.name,
      nameEn: exercise.nameEn,
      nameEs: exercise.nameEs,
      isCustom: exercise.isCustom,
      updatedAt: metadata?.updatedAt ?? DateTime.now(),
      deletedAt: metadata?.deletedAt,
      syncStatus: metadata?.syncStatus ?? 'synced',
      remoteVersion: metadata?.remoteVersion ?? 0,
    );
  }

  factory LibraryExerciseRemoteDto.fromFirestore(
    Map<String, dynamic> map,
    String docId,
  ) {
    final now = DateTime.now();
    return LibraryExerciseRemoteDto(
      id: docId,
      name: (map['name'] as String?) ?? '',
      nameEn: (map['nameEn'] as String?) ?? '',
      nameEs: (map['nameEs'] as String?) ?? '',
      isCustom: (map['isCustom'] as bool?) ?? true,
      updatedAt: parseRemoteDateTime(map['updatedAt'], fallback: now),
      deletedAt: parseNullableRemoteDateTime(map['deletedAt']),
      syncStatus: (map['syncStatus'] as String?) ?? 'synced',
      remoteVersion: (map['remoteVersion'] as num?)?.toInt() ?? 0,
    );
  }

  final String id;
  final String name;
  final String nameEn;
  final String nameEs;
  final bool isCustom;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  final int remoteVersion;

  LibraryExerciseEntity toDomain() {
    return LibraryExerciseEntity(
      id: id,
      name: name,
      nameEn: nameEn,
      nameEs: nameEs,
      isCustom: isCustom,
      syncMetadata: parseSyncMetadata(<String, dynamic>{
        'updatedAt': Timestamp.fromDate(updatedAt),
        'deletedAt': deletedAt == null ? null : Timestamp.fromDate(deletedAt!),
        'syncStatus': syncStatus,
        'remoteVersion': remoteVersion,
      }),
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'name': name,
      'nameEn': nameEn,
      'nameEs': nameEs,
      'isCustom': isCustom,
      'updatedAt': Timestamp.fromDate(updatedAt),
      'deletedAt': deletedAt == null ? null : Timestamp.fromDate(deletedAt!),
      'syncStatus': syncStatus,
      'remoteVersion': remoteVersion,
    };
  }
}
