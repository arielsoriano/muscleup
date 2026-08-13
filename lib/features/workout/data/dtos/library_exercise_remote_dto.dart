import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/l10n/localized_text.dart';
import '../../domain/repositories/workout_repository.dart';
import 'remote_dto_utils.dart';

class LibraryExerciseRemoteDto {
  LibraryExerciseRemoteDto({
    required this.id,
    required this.name,
    required this.names,
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
      names: exercise.names,
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
    final name = (map['name'] as String?) ?? '';
    return LibraryExerciseRemoteDto(
      id: docId,
      name: name,
      names: _readNames(map, fallback: name),
      isCustom: (map['isCustom'] as bool?) ?? true,
      updatedAt: parseRemoteDateTime(map['updatedAt'], fallback: now),
      deletedAt: parseNullableRemoteDateTime(map['deletedAt']),
      syncStatus: (map['syncStatus'] as String?) ?? 'synced',
      remoteVersion: (map['remoteVersion'] as num?)?.toInt() ?? 0,
    );
  }

  static LocalizedText _readNames(
    Map<String, dynamic> map, {
    required String fallback,
  }) {
    final names = map['names'];
    if (names is Map) {
      final parsed = LocalizedText.fromDynamicMap(names, fallback: fallback);
      if (parsed.isNotEmpty) {
        return parsed;
      }
    }

    return LocalizedText.single(fallback);
  }

  final String id;
  final String name;
  final LocalizedText names;
  final bool isCustom;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  final int remoteVersion;

  LibraryExerciseEntity toDomain() {
    return LibraryExerciseEntity(
      id: id,
      name: name,
      names: names,
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
      'names': names.toMap(),
      'isCustom': isCustom,
      'updatedAt': Timestamp.fromDate(updatedAt),
      'deletedAt': deletedAt == null ? null : Timestamp.fromDate(deletedAt!),
      'syncStatus': syncStatus,
      'remoteVersion': remoteVersion,
    };
  }
}
