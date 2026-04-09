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
    int limit = 500,
  }) async {
    final docs = await _fetchUpdatedSince(uid, 'routines', updatedSince, limit: limit);
    return docs
        .map((doc) => RoutineRemoteDto.fromFirestore(doc.data(), doc.id))
        .toList(growable: false);
  }

  @override
  Future<List<ExerciseRemoteDto>> fetchExercisesUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) async {
    final docs = await _fetchUpdatedSince(uid, 'exercises', updatedSince, limit: limit);
    return docs
        .map((doc) => ExerciseRemoteDto.fromFirestore(doc.data(), doc.id))
        .toList(growable: false);
  }

  @override
  Future<List<SetRemoteDto>> fetchSetsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) async {
    final docs = await _fetchUpdatedSince(uid, 'sets', updatedSince, limit: limit);
    return docs
        .map((doc) => SetRemoteDto.fromFirestore(doc.data(), doc.id))
        .toList(growable: false);
  }

  @override
  Future<List<SessionRemoteDto>> fetchSessionsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) async {
    final docs = await _fetchUpdatedSince(uid, 'sessions', updatedSince, limit: limit);
    return docs
        .map((doc) => SessionRemoteDto.fromFirestore(doc.data(), doc.id))
        .toList(growable: false);
  }

  @override
  Future<List<SetLogRemoteDto>> fetchSetLogsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) async {
    final docs = await _fetchUpdatedSince(uid, 'setLogs', updatedSince, limit: limit);
    return docs
        .map((doc) => SetLogRemoteDto.fromFirestore(doc.data(), doc.id))
        .toList(growable: false);
  }

  @override
  Future<List<LibraryExerciseRemoteDto>> fetchLibraryExercisesUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) async {
    final docs = await _fetchUpdatedSince(uid, 'libraryExercises', updatedSince, limit: limit);
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
    required DateTime updatedAt,
  }) async {
    final data = <String, dynamic>{
      'defaultRestSeconds': defaultRestSeconds,
      'defaultRepetitions': defaultRepetitions,
      'defaultWeight': defaultWeight,
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

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> _fetchUpdatedSince(
    String uid,
    String collection,
    DateTime? updatedSince, {
    required int limit,
  }) async {
    try {
      Query<Map<String, dynamic>> query =
          _collection(uid, collection).orderBy('updatedAt').limit(limit);

      if (updatedSince != null) {
        query = query.where('updatedAt', isGreaterThan: Timestamp.fromDate(updatedSince));
      }

      final snapshot = await query.get().timeout(_operationTimeout);
      return snapshot.docs;
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

class NoopWorkoutRemoteDataSource implements WorkoutRemoteDataSource {
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
    int limit = 500,
  }) {
    return _notConfigured();
  }

  @override
  Future<List<ExerciseRemoteDto>> fetchExercisesUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) {
    return _notConfigured();
  }

  @override
  Future<List<SetRemoteDto>> fetchSetsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) {
    return _notConfigured();
  }

  @override
  Future<List<SessionRemoteDto>> fetchSessionsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) {
    return _notConfigured();
  }

  @override
  Future<List<SetLogRemoteDto>> fetchSetLogsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) {
    return _notConfigured();
  }

  @override
  Future<List<LibraryExerciseRemoteDto>> fetchLibraryExercisesUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) {
    return _notConfigured();
  }

  @override
  Future<void> upsertTrainingDefaults(
    String uid, {
    required int? defaultRestSeconds,
    required int? defaultRepetitions,
    required double? defaultWeight,
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
