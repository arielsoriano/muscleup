import 'dart:async';
import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/error/exceptions.dart';
import '../../dtos/exercise_remote_dto.dart';
import '../../dtos/library_exercise_remote_dto.dart';
import '../../dtos/routine_remote_dto.dart';
import '../../dtos/session_remote_dto.dart';
import '../../dtos/set_log_remote_dto.dart';
import '../../dtos/set_remote_dto.dart';
import '../../../domain/entities/workout_entities.dart';
import '../../../domain/repositories/workout_repository.dart';
import 'workout_remote_data_source.dart';

class FirestoreWorkoutRemoteDataSource implements WorkoutRemoteDataSource {
  FirestoreWorkoutRemoteDataSource(
    this._firestore, {
    Duration operationTimeout = const Duration(seconds: 15),
  }) : _operationTimeout = operationTimeout;

  final FirebaseFirestore _firestore;
  final Duration _operationTimeout;

  CollectionReference<Map<String, dynamic>> _collection(String uid, String name) {
    return _firestore.collection('users').doc(uid).collection(name);
  }

  @override
  Future<void> upsertRoutine(String uid, WorkoutRoutine routine) async {
    final dto = RoutineRemoteDto.fromDomain(routine);
    await _upsert(uid, 'routines', dto.id, dto.toFirestore());
  }

  @override
  Future<void> upsertExercise(String uid, WorkoutExercise exercise, String routineId) async {
    final dto = ExerciseRemoteDto.fromDomain(exercise, routineId);
    await _upsert(uid, 'exercises', dto.id, dto.toFirestore());
  }

  @override
  Future<void> upsertSet(String uid, WorkoutSet workoutSet, String exerciseId) async {
    final dto = SetRemoteDto.fromDomain(workoutSet, exerciseId);
    await _upsert(uid, 'sets', dto.id, dto.toFirestore());
  }

  @override
  Future<void> upsertSession(String uid, WorkoutSession session) async {
    final dto = SessionRemoteDto.fromDomain(session);
    await _upsert(uid, 'sessions', dto.id, dto.toFirestore());
  }

  @override
  Future<void> upsertSetLog(String uid, SetLog setLog) async {
    final dto = SetLogRemoteDto.fromDomain(setLog);
    await _upsert(uid, 'setLogs', dto.id, dto.toFirestore());
  }

  @override
  Future<void> upsertLibraryExercise(String uid, LibraryExerciseEntity libraryExercise) async {
    final dto = LibraryExerciseRemoteDto.fromDomain(libraryExercise);
    await _upsert(uid, 'libraryExercises', dto.id, dto.toFirestore());
  }

  @override
  Future<void> markRoutineDeleted(String uid, String routineId) async {
    await _markDeleted(uid, 'routines', routineId);
  }

  @override
  Future<void> markExerciseDeleted(String uid, String exerciseId) async {
    await _markDeleted(uid, 'exercises', exerciseId);
  }

  @override
  Future<void> markSetDeleted(String uid, String setId) async {
    await _markDeleted(uid, 'sets', setId);
  }

  @override
  Future<void> markSessionDeleted(String uid, String sessionId) async {
    await _markDeleted(uid, 'sessions', sessionId);
  }

  @override
  Future<void> markSetLogDeleted(String uid, String setLogId) async {
    await _markDeleted(uid, 'setLogs', setLogId);
  }

  @override
  Future<void> markLibraryExerciseDeleted(String uid, String exerciseId) async {
    await _markDeleted(uid, 'libraryExercises', exerciseId);
  }

  @override
  Future<List<RoutineRemoteDto>> fetchRoutinesUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int pageSize = 500,
  }) async {
    final docs = await _fetchUpdatedSince(uid, 'routines', updatedSince, pageSize: pageSize);
    return docs
        .map((doc) => RoutineRemoteDto.fromFirestore(doc.data(), doc.id))
        .toList(growable: false);
  }

  @override
  Future<List<ExerciseRemoteDto>> fetchExercisesUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int pageSize = 500,
  }) async {
    final docs = await _fetchUpdatedSince(uid, 'exercises', updatedSince, pageSize: pageSize);
    return docs
        .map((doc) => ExerciseRemoteDto.fromFirestore(doc.data(), doc.id))
        .toList(growable: false);
  }

  @override
  Future<List<SetRemoteDto>> fetchSetsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int pageSize = 500,
  }) async {
    final docs = await _fetchUpdatedSince(uid, 'sets', updatedSince, pageSize: pageSize);
    return docs
        .map((doc) => SetRemoteDto.fromFirestore(doc.data(), doc.id))
        .toList(growable: false);
  }

  @override
  Future<List<SessionRemoteDto>> fetchSessionsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int pageSize = 500,
  }) async {
    final docs = await _fetchUpdatedSince(uid, 'sessions', updatedSince, pageSize: pageSize);
    return docs
        .map((doc) => SessionRemoteDto.fromFirestore(doc.data(), doc.id))
        .toList(growable: false);
  }

  @override
  Future<List<SetLogRemoteDto>> fetchSetLogsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int pageSize = 500,
  }) async {
    final docs = await _fetchUpdatedSince(uid, 'setLogs', updatedSince, pageSize: pageSize);
    return docs
        .map((doc) => SetLogRemoteDto.fromFirestore(doc.data(), doc.id))
        .toList(growable: false);
  }

  @override
  Future<List<LibraryExerciseRemoteDto>> fetchLibraryExercisesUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int pageSize = 500,
  }) async {
    final docs = await _fetchUpdatedSince(uid, 'libraryExercises', updatedSince, pageSize: pageSize);
    return docs
        .map((doc) => LibraryExerciseRemoteDto.fromFirestore(doc.data(), doc.id))
        .toList(growable: false);
  }

  @override
  Future<void> upsertTrainingDefaults(
    String uid, {
    required int? defaultRestSeconds,
    required int? defaultRepetitions,
    required double? defaultWeight,
    required bool autoStartRestTimerOnSetCompleted,
    required DateTime updatedAt,
  }) async {
    final data = <String, dynamic>{
      'defaultRestSeconds': defaultRestSeconds,
      'defaultRepetitions': defaultRepetitions,
      'defaultWeight': defaultWeight,
      'autoStartRestTimerOnSetCompleted': autoStartRestTimerOnSetCompleted,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };

    try {
      await _collection(uid, 'appSettings')
          .doc('trainingDefaults')
          .set(data, SetOptions(merge: true))
          .timeout(_operationTimeout);
    } on FirebaseException catch (error) {
      _logFirebaseError('upsertTrainingDefaults', 'appSettings', error, id: 'trainingDefaults');
      throw DatabaseException(_firebaseErrorMessage(error, 'appSettings/trainingDefaults'));
    } on TimeoutException {
      throw const DatabaseException(
        'Firestore timeout on appSettings during upsertTrainingDefaults',
      );
    } catch (error) {
      if (kDebugMode) {
        developer.log(
          'Unexpected Firestore upsertTrainingDefaults error: $error',
          name: 'workout.remote',
        );
      }
      throw const DatabaseException(
        'Unexpected Firestore error while upserting training defaults',
      );
    }
  }

  @override
  Future<Map<String, dynamic>?> fetchTrainingDefaults(String uid) async {
    try {
      final doc = await _collection(uid, 'appSettings')
          .doc('trainingDefaults')
          .get()
          .timeout(_operationTimeout);

      if (!doc.exists) {
        return null;
      }

      final data = doc.data();
      if (data == null) {
        return null;
      }

      final updatedAtRaw = data['updatedAt'];
      final updatedAt = updatedAtRaw is Timestamp
          ? updatedAtRaw.toDate()
          : DateTime.now();

      return <String, dynamic>{
        'defaultRestSeconds': data['defaultRestSeconds'] as int?,
        'defaultRepetitions': data['defaultRepetitions'] as int?,
        'defaultWeight': (data['defaultWeight'] as num?)?.toDouble(),
        'autoStartRestTimerOnSetCompleted':
            data['autoStartRestTimerOnSetCompleted'] as bool? ?? false,
        'updatedAt': updatedAt,
      };
    } on FirebaseException catch (error) {
      _logFirebaseError('fetchTrainingDefaults', 'appSettings', error, id: 'trainingDefaults');
      throw DatabaseException(_firebaseErrorMessage(error, 'appSettings/trainingDefaults'));
    } on TimeoutException {
      throw const DatabaseException(
        'Firestore timeout on appSettings during fetchTrainingDefaults',
      );
    } catch (error) {
      if (kDebugMode) {
        developer.log(
          'Unexpected Firestore fetchTrainingDefaults error: $error',
          name: 'workout.remote',
        );
      }
      throw const DatabaseException(
        'Unexpected Firestore error while fetching training defaults',
      );
    }
  }

  @override
  Future<void> commitBatch(String uid, List<RemoteWriteOp> operations) async {
    if (operations.isEmpty) {
      return;
    }

    // Firestore allows up to 500 writes per batch; stay comfortably under it.
    const chunkSize = 450;

    try {
      for (var start = 0; start < operations.length; start += chunkSize) {
        final end = start + chunkSize < operations.length
            ? start + chunkSize
            : operations.length;
        final batch = _firestore.batch();

        for (final op in operations.sublist(start, end)) {
          final resolved = _resolveWriteOp(op);
          batch.set(
            _collection(uid, resolved.collection).doc(resolved.docId),
            resolved.data,
            SetOptions(merge: true),
          );
        }

        await batch.commit().timeout(_operationTimeout);
      }
    } on FirebaseException catch (error) {
      _logFirebaseError('commitBatch', 'batch', error);
      throw DatabaseException(_firebaseErrorMessage(error, 'batch'));
    } on TimeoutException {
      throw const DatabaseException('Firestore timeout during batch commit');
    } catch (error) {
      if (kDebugMode) {
        developer.log(
          'Unexpected Firestore batch commit error: $error',
          name: 'workout.remote',
        );
      }
      throw const DatabaseException('Unexpected Firestore error during batch commit');
    }
  }

  _ResolvedWrite _resolveWriteOp(RemoteWriteOp op) {
    switch (op) {
      case UpsertRoutineOp(:final routine):
        return _ResolvedWrite(
          'routines',
          routine.id,
          RoutineRemoteDto.fromDomain(routine).toFirestore(),
        );
      case UpsertExerciseOp(:final exercise, :final routineId):
        return _ResolvedWrite(
          'exercises',
          exercise.id,
          ExerciseRemoteDto.fromDomain(exercise, routineId).toFirestore(),
        );
      case UpsertSetOp(:final workoutSet, :final exerciseId):
        return _ResolvedWrite(
          'sets',
          workoutSet.id,
          SetRemoteDto.fromDomain(workoutSet, exerciseId).toFirestore(),
        );
      case UpsertSessionOp(:final session):
        return _ResolvedWrite(
          'sessions',
          session.id,
          SessionRemoteDto.fromDomain(session).toFirestore(),
        );
      case UpsertSetLogOp(:final setLog):
        return _ResolvedWrite(
          'setLogs',
          setLog.id,
          SetLogRemoteDto.fromDomain(setLog).toFirestore(),
        );
      case UpsertLibraryExerciseOp(:final libraryExercise):
        return _ResolvedWrite(
          'libraryExercises',
          libraryExercise.id,
          LibraryExerciseRemoteDto.fromDomain(libraryExercise).toFirestore(),
        );
      case DeleteRemoteOp(:final entityType, :final entityId):
        return _ResolvedWrite(
          _collectionForEntityType(entityType),
          entityId,
          _deleteMarkerData(),
        );
    }
  }

  String _collectionForEntityType(String entityType) {
    switch (entityType) {
      case 'routine':
        return 'routines';
      case 'exercise':
        return 'exercises';
      case 'set':
        return 'sets';
      case 'session':
        return 'sessions';
      case 'setLog':
        return 'setLogs';
      case 'libraryExercise':
        return 'libraryExercises';
      default:
        return entityType;
    }
  }

  Map<String, dynamic> _deleteMarkerData() {
    final now = DateTime.now();
    return <String, dynamic>{
      'updatedAt': Timestamp.fromDate(now),
      'deletedAt': Timestamp.fromDate(now),
      'syncStatus': 'synced',
      'remoteVersion': FieldValue.increment(1),
    };
  }

  Future<void> _upsert(
    String uid,
    String collection,
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await _collection(uid, collection)
          .doc(id)
          .set(data, SetOptions(merge: true))
          .timeout(_operationTimeout);
    } on FirebaseException catch (error) {
      _logFirebaseError('upsert', collection, error, id: id);
      throw DatabaseException(_firebaseErrorMessage(error, collection));
    } on TimeoutException {
      throw DatabaseException('Firestore timeout on $collection during upsert');
    } catch (error) {
      if (kDebugMode) {
        developer.log(
          'Unexpected Firestore upsert error for $collection/$id: $error',
          name: 'workout.remote',
        );
      }
      throw DatabaseException('Unexpected Firestore error while upserting $collection');
    }
  }

  Future<void> _markDeleted(String uid, String collection, String id) async {
    final now = DateTime.now();
    final data = <String, dynamic>{
      'updatedAt': Timestamp.fromDate(now),
      'deletedAt': Timestamp.fromDate(now),
      'syncStatus': 'synced',
      'remoteVersion': FieldValue.increment(1),
    };

    try {
      await _collection(uid, collection)
          .doc(id)
          .set(data, SetOptions(merge: true))
          .timeout(_operationTimeout);
    } on FirebaseException catch (error) {
      _logFirebaseError('markDeleted', collection, error, id: id);
      throw DatabaseException(_firebaseErrorMessage(error, collection));
    } on TimeoutException {
      throw DatabaseException('Firestore timeout on $collection during markDeleted');
    } catch (error) {
      if (kDebugMode) {
        developer.log(
          'Unexpected Firestore delete marker error for $collection/$id: $error',
          name: 'workout.remote',
        );
      }
      throw DatabaseException('Unexpected Firestore error while marking $collection deleted');
    }
  }

  /// How far the page is allowed to grow while trying to get past a group of
  /// documents that all share one updatedAt. Far above any real group: a single
  /// save stamps its timestamp on one routine and everything under it, which
  /// the import parser itself caps at 120 exercises of 40 sets.
  static const int _maxPageSize = 10000;

  /// Reads every document of [collection] changed after [updatedSince] — all of
  /// them, paging until the collection is exhausted.
  ///
  /// The paging is the delicate part, because updatedAt is not unique.
  /// saveRoutine stamps a single DateTime.now() on a routine and on every
  /// exercise and set under it, so one save writes dozens of documents sharing
  /// one timestamp to the millisecond.
  ///
  /// This used to resume each page at `updatedAt > last one I saw`. Whenever a
  /// page boundary fell inside such a group, the rest of that group was skipped
  /// — and skipped for good, because the sync checkpoint then advanced past it
  /// as well. That is what restored a routine with some of its sets, or with
  /// none of them, after a reinstall.
  ///
  /// So each page after the first resumes *inclusively*, at `>= the last
  /// timestamp of the previous page`, and the overlap it re-reads is discarded
  /// by id. A page that turns out to be entirely documents already seen means
  /// one group is larger than the page itself, and advancing at all would step
  /// over the remainder — so the page grows instead of moving.
  ///
  /// A document cursor would be the tidier way to say this, but only Firestore
  /// itself implements cursors faithfully enough to rely on; this stays on
  /// plain range queries so it behaves the same in tests.
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> _fetchUpdatedSince(
    String uid,
    String collection,
    DateTime? updatedSince, {
    required int pageSize,
  }) async {
    try {
      final collectionReference = _collection(uid, collection);
      final docs = <QueryDocumentSnapshot<Map<String, dynamic>>>[];
      final seenIds = <String>{};

      // Exclusive while it holds the caller's checkpoint — work already synced
      // must not come back — and inclusive once it is a page boundary.
      Timestamp? boundary =
          updatedSince == null ? null : Timestamp.fromDate(updatedSince);
      var boundaryIsInclusive = false;
      var currentPageSize = pageSize;

      while (true) {
        Query<Map<String, dynamic>> query =
            collectionReference.orderBy('updatedAt');

        if (boundary != null) {
          query = boundaryIsInclusive
              ? query.where('updatedAt', isGreaterThanOrEqualTo: boundary)
              : query.where('updatedAt', isGreaterThan: boundary);
        }

        final snapshot =
            await query.limit(currentPageSize).get().timeout(_operationTimeout);
        final page = snapshot.docs;

        var addedFromThisPage = 0;
        for (final doc in page) {
          if (seenIds.add(doc.id)) {
            docs.add(doc);
            addedFromThisPage++;
          }
        }

        // A short page is the end of the collection, whatever else happened.
        if (page.length < currentPageSize) {
          return docs;
        }

        if (addedFromThisPage == 0) {
          if (currentPageSize >= _maxPageSize) {
            return docs;
          }
          final grown = currentPageSize * 2;
          currentPageSize = grown > _maxPageSize ? _maxPageSize : grown;
          continue;
        }

        final lastUpdatedAt = page.last.data()['updatedAt'];
        if (lastUpdatedAt is! Timestamp) {
          return docs;
        }

        boundary = lastUpdatedAt;
        boundaryIsInclusive = true;
      }
    } on FirebaseException catch (error) {
      _logFirebaseError('fetchUpdatedSince', collection, error);
      throw DatabaseException(_firebaseErrorMessage(error, collection));
    } on TimeoutException {
      throw DatabaseException('Firestore timeout on $collection during fetchUpdatedSince');
    } catch (error) {
      if (kDebugMode) {
        developer.log(
          'Unexpected Firestore fetch error for $collection: $error',
          name: 'workout.remote',
        );
      }
      throw DatabaseException('Unexpected Firestore error while fetching $collection');
    }
  }

  String _firebaseErrorMessage(FirebaseException error, String collection) {
    final details = error.message == null ? '' : ': ${error.message}';
    return 'Firestore ${error.code} on $collection$details';
  }

  void _logFirebaseError(
    String operation,
    String collection,
    FirebaseException error, {
    String? id,
  }) {
    final target = id == null ? collection : '$collection/$id';
    if (kDebugMode) {
      developer.log(
        'Firestore $operation failed on $target: ${error.code}',
        name: 'workout.remote',
        error: error,
      );
    }
  }
}

class _ResolvedWrite {
  const _ResolvedWrite(this.collection, this.docId, this.data);

  final String collection;
  final String docId;
  final Map<String, dynamic> data;
}

class NoopWorkoutRemoteDataSource implements WorkoutRemoteDataSource {
  @override
  Future<void> commitBatch(String uid, List<RemoteWriteOp> operations) =>
      _notConfigured();

  @override
  Future<void> upsertRoutine(String uid, WorkoutRoutine routine) => _notConfigured();

  @override
  Future<void> upsertExercise(String uid, WorkoutExercise exercise, String routineId) =>
      _notConfigured();

  @override
  Future<void> upsertSet(String uid, WorkoutSet workoutSet, String exerciseId) => _notConfigured();

  @override
  Future<void> upsertSession(String uid, WorkoutSession session) => _notConfigured();

  @override
  Future<void> upsertSetLog(String uid, SetLog setLog) => _notConfigured();

  @override
  Future<void> upsertLibraryExercise(String uid, LibraryExerciseEntity libraryExercise) =>
      _notConfigured();

  @override
  Future<void> markRoutineDeleted(String uid, String routineId) => _notConfigured();

  @override
  Future<void> markExerciseDeleted(String uid, String exerciseId) => _notConfigured();

  @override
  Future<void> markSetDeleted(String uid, String setId) => _notConfigured();

  @override
  Future<void> markSessionDeleted(String uid, String sessionId) => _notConfigured();

  @override
  Future<void> markSetLogDeleted(String uid, String setLogId) => _notConfigured();

  @override
  Future<void> markLibraryExerciseDeleted(String uid, String exerciseId) => _notConfigured();

  @override
  Future<List<RoutineRemoteDto>> fetchRoutinesUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int pageSize = 500,
  }) {
    return _notConfigured();
  }

  @override
  Future<List<ExerciseRemoteDto>> fetchExercisesUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int pageSize = 500,
  }) {
    return _notConfigured();
  }

  @override
  Future<List<SetRemoteDto>> fetchSetsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int pageSize = 500,
  }) {
    return _notConfigured();
  }

  @override
  Future<List<SessionRemoteDto>> fetchSessionsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int pageSize = 500,
  }) {
    return _notConfigured();
  }

  @override
  Future<List<SetLogRemoteDto>> fetchSetLogsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int pageSize = 500,
  }) {
    return _notConfigured();
  }

  @override
  Future<List<LibraryExerciseRemoteDto>> fetchLibraryExercisesUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int pageSize = 500,
  }) {
    return _notConfigured();
  }

  @override
  Future<void> upsertTrainingDefaults(
    String uid, {
    required int? defaultRestSeconds,
    required int? defaultRepetitions,
    required double? defaultWeight,
    required bool autoStartRestTimerOnSetCompleted,
    required DateTime updatedAt,
  }) {
    return _notConfigured();
  }

  @override
  Future<Map<String, dynamic>?> fetchTrainingDefaults(String uid) {
    return _notConfigured();
  }

  Future<T> _notConfigured<T>() {
    return Future<T>.error(const DatabaseException('Firestore not configured'));
  }
}
