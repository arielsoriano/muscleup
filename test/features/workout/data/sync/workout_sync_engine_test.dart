import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/features/auth/domain/entities/cloud_user.dart';
import 'package:muscleup/features/auth/domain/repositories/cloud_auth_repository.dart';
import 'package:muscleup/features/workout/data/datasources/local/workout_database.dart';
import 'package:muscleup/features/workout/data/datasources/remote/workout_remote_data_source.dart';
import 'package:muscleup/features/workout/data/dtos/exercise_remote_dto.dart';
import 'package:muscleup/features/workout/data/dtos/library_exercise_remote_dto.dart';
import 'package:muscleup/features/workout/data/dtos/routine_remote_dto.dart';
import 'package:muscleup/features/workout/data/dtos/session_remote_dto.dart';
import 'package:muscleup/features/workout/data/dtos/set_log_remote_dto.dart';
import 'package:muscleup/features/workout/data/dtos/set_remote_dto.dart';
import 'package:muscleup/features/workout/data/sync/sync_checkpoint_store.dart';
import 'package:muscleup/features/workout/data/sync/workout_sync_engine.dart';
import 'package:muscleup/features/workout/domain/entities/workout_entities.dart';
import 'package:muscleup/features/workout/domain/repositories/workout_repository.dart';
import 'package:muscleup/features/workout/domain/sync/sync_run_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('WorkoutSyncEngine', () {
    late AppDatabase database;
    late _FakeCloudAuthRepository fakeCloudAuthRepository;
    late _ProgrammableWorkoutRemoteDataSource programmableWorkoutRemoteDataSource;
    late SyncCheckpointStore syncCheckpointStore;
    late WorkoutSyncEngine workoutSyncEngine;
    late List<Duration> sleepDurations;

    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      final sharedPreferences = await SharedPreferences.getInstance();

      database = AppDatabase.forExecutor(NativeDatabase.memory());
      fakeCloudAuthRepository = _FakeCloudAuthRepository();
      programmableWorkoutRemoteDataSource = _ProgrammableWorkoutRemoteDataSource();
      syncCheckpointStore = SyncCheckpointStore(sharedPreferences);
      sleepDurations = <Duration>[];

      workoutSyncEngine = WorkoutSyncEngine(
        database: database,
        workoutRemoteDataSource: programmableWorkoutRemoteDataSource,
        cloudAuthRepository: fakeCloudAuthRepository,
        syncCheckpointStore: syncCheckpointStore,
        pushBatchSize: 10,
        syncSleep: (duration) async {
          sleepDurations.add(duration);
        },
      );

      await workoutSyncEngine.startAutoSync();
      fakeCloudAuthRepository.emitUser(
        const CloudUser(uid: 'uid-1', isAnonymous: true),
      );
      await Future<void>.delayed(Duration.zero);
    });

    tearDown(() async {
      await workoutSyncEngine.dispose();
      await database.close();
      await fakeCloudAuthRepository.dispose();
    });

    test('push processes outbox in createdAt order and clears successful events', () async {
      final now = DateTime(2025, 1, 1, 10, 0);

      await database.into(database.routines).insert(
            RoutinesCompanion.insert(
              id: 'routine-a',
              name: 'A',
              sortOrder: 0,
              isDeleted: const Value(false),
              updatedAt: Value(now),
              deletedAt: const Value(null),
              syncStatus: const Value(SyncStatus.pending),
              remoteVersion: const Value(0),
            ),
          );

      await database.into(database.routines).insert(
            RoutinesCompanion.insert(
              id: 'routine-b',
              name: 'B',
              sortOrder: 1,
              isDeleted: const Value(false),
              updatedAt: Value(now.add(const Duration(minutes: 1))),
              deletedAt: const Value(null),
              syncStatus: const Value(SyncStatus.pending),
              remoteVersion: const Value(0),
            ),
          );

      await database.into(database.outboxChanges).insert(
            OutboxChangesCompanion.insert(
              id: 'event-1',
              entityType: 'routine',
              entityId: 'routine-a',
              operation: 'update',
              payloadJson: '{}',
              createdAt: now,
            ),
          );

      await database.into(database.outboxChanges).insert(
            OutboxChangesCompanion.insert(
              id: 'event-2',
              entityType: 'routine',
              entityId: 'routine-b',
              operation: 'update',
              payloadJson: '{}',
              createdAt: now.add(const Duration(seconds: 1)),
            ),
          );

      final result = await workoutSyncEngine.triggerManualSync();

      final remainingOutbox = await database.select(database.outboxChanges).get();
      final updatedRows = await (database.select(database.routines)
            ..where((tbl) => tbl.id.isIn(const <String>['routine-a', 'routine-b'])))
          .get();

      expect(result.success, isTrue);
      expect(programmableWorkoutRemoteDataSource.pushOrder, <String>['routine-a', 'routine-b']);
      expect(remainingOutbox, isEmpty);
      expect(updatedRows.every((row) => row.syncStatus == SyncStatus.synced), isTrue);
    });

    test('push failure increments retryCount and keeps outbox pending', () async {
      final now = DateTime(2025, 1, 1, 10, 0);
      programmableWorkoutRemoteDataSource.failForRoutineId = 'routine-fail';

      await database.into(database.routines).insert(
            RoutinesCompanion.insert(
              id: 'routine-fail',
              name: 'Failing Routine',
              sortOrder: 0,
              isDeleted: const Value(false),
              updatedAt: Value(now),
              deletedAt: const Value(null),
              syncStatus: const Value(SyncStatus.pending),
              remoteVersion: const Value(0),
            ),
          );

      await database.into(database.outboxChanges).insert(
            OutboxChangesCompanion.insert(
              id: 'event-fail',
              entityType: 'routine',
              entityId: 'routine-fail',
              operation: 'update',
              payloadJson: '{}',
              createdAt: now,
            ),
          );

      final result = await workoutSyncEngine.triggerManualSync();

      final remaining = await (database.select(database.outboxChanges)
            ..where((tbl) => tbl.id.equals('event-fail')))
          .getSingle();

      expect(result.success, isTrue);
      expect(remaining.retryCount, 1);
      expect(remaining.lastError, isNotNull);
      expect(sleepDurations, isNotEmpty);
    });

    test('permanent push error reaches retry cap and stops requeue backoff', () async {
      final now = DateTime(2025, 1, 1, 10, 0);
      programmableWorkoutRemoteDataSource.failForRoutineId = 'routine-permanent';
      programmableWorkoutRemoteDataSource.failWithPermanentError = true;

      await database.into(database.routines).insert(
            RoutinesCompanion.insert(
              id: 'routine-permanent',
              name: 'Permanent Failure Routine',
              sortOrder: 0,
              isDeleted: const Value(false),
              updatedAt: Value(now),
              deletedAt: const Value(null),
              syncStatus: const Value(SyncStatus.pending),
              remoteVersion: const Value(0),
            ),
          );

      await database.into(database.outboxChanges).insert(
            OutboxChangesCompanion.insert(
              id: 'event-permanent',
              entityType: 'routine',
              entityId: 'routine-permanent',
              operation: 'update',
              payloadJson: '{}',
              createdAt: now,
            ),
          );

      final result = await workoutSyncEngine.triggerManualSync();

      final remaining = await (database.select(database.outboxChanges)
            ..where((tbl) => tbl.id.equals('event-permanent')))
          .getSingle();

      expect(result.success, isTrue);
      expect(remaining.retryCount, 5);
      expect(sleepDurations, isEmpty);
    });

    test('pull applies incremental changes and advances checkpoint', () async {
      final firstTimestamp = DateTime(2025, 1, 1, 9, 0);
      final secondTimestamp = DateTime(2025, 1, 1, 9, 1);

      programmableWorkoutRemoteDataSource.routinePullHandler = (DateTime? checkpoint) {
        if (checkpoint == null) {
          return <RoutineRemoteDto>[
            RoutineRemoteDto(
              id: 'routine-1',
              name: 'First',
              sortOrder: 0,
              updatedAt: firstTimestamp,
              deletedAt: null,
              syncStatus: 'synced',
              remoteVersion: 1,
            ),
          ];
        }

        if (checkpoint.isBefore(secondTimestamp)) {
          return <RoutineRemoteDto>[
            RoutineRemoteDto(
              id: 'routine-1',
              name: 'Second',
              sortOrder: 0,
              updatedAt: secondTimestamp,
              deletedAt: null,
              syncStatus: 'synced',
              remoteVersion: 2,
            ),
          ];
        }

        return <RoutineRemoteDto>[];
      };

      final firstRun = await workoutSyncEngine.triggerManualSync();
      final secondRun = await workoutSyncEngine.triggerManualSync();

      final localRoutine = await (database.select(database.routines)
            ..where((tbl) => tbl.id.equals('routine-1')))
          .getSingle();

      final checkpoint = syncCheckpointStore.getCheckpoint(
        uid: 'uid-1',
        entityType: 'routine',
      );

      expect(firstRun.success, isTrue);
      expect(secondRun.success, isTrue);
      expect(localRoutine.name, 'Second');
      expect(checkpoint, secondTimestamp);
    });

    test('does not run two sync cycles concurrently', () async {
      final now = DateTime(2025, 1, 1, 10, 0);

      await database.into(database.routines).insert(
            RoutinesCompanion.insert(
              id: 'routine-serial',
              name: 'Serial',
              sortOrder: 0,
              isDeleted: const Value(false),
              updatedAt: Value(now),
              deletedAt: const Value(null),
              syncStatus: const Value(SyncStatus.pending),
              remoteVersion: const Value(0),
            ),
          );

      await database.into(database.outboxChanges).insert(
            OutboxChangesCompanion.insert(
              id: 'event-serial',
              entityType: 'routine',
              entityId: 'routine-serial',
              operation: 'update',
              payloadJson: '{}',
              createdAt: now,
            ),
          );

      programmableWorkoutRemoteDataSource.routineDelay = const Duration(milliseconds: 150);

      await Future.wait(<Future<SyncRunResult>>[
        workoutSyncEngine.triggerManualSync(),
        workoutSyncEngine.triggerManualSync(),
      ]);

      expect(programmableWorkoutRemoteDataSource.maxConcurrentPushCalls, 1);
    });
  });
}

class _FakeCloudAuthRepository implements CloudAuthRepository {
  final StreamController<CloudUser?> _controller = StreamController<CloudUser?>.broadcast();

  @override
  Stream<CloudUser?> watchAuthState() => _controller.stream;

  @override
  Future<CloudUser> signInAnonymously() {
    throw UnimplementedError();
  }

  @override
  Future<CloudUser> linkWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<void> signOutCloud() {
    throw UnimplementedError();
  }

  void emitUser(CloudUser? user) {
    _controller.add(user);
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}

class _ProgrammableWorkoutRemoteDataSource implements WorkoutRemoteDataSource {
  String? failForRoutineId;
  bool failWithPermanentError = false;
  Duration routineDelay = Duration.zero;

  int _concurrentPushCalls = 0;
  int maxConcurrentPushCalls = 0;

  final List<String> pushOrder = <String>[];
  List<RoutineRemoteDto> Function(DateTime? checkpoint)? routinePullHandler;

  @override
  Future<void> upsertRoutine(String uid, WorkoutRoutine routine) async {
    _concurrentPushCalls += 1;
    if (_concurrentPushCalls > maxConcurrentPushCalls) {
      maxConcurrentPushCalls = _concurrentPushCalls;
    }

    try {
      if (routineDelay > Duration.zero) {
        await Future<void>.delayed(routineDelay);
      }
      if (failForRoutineId == routine.id) {
        if (failWithPermanentError) {
          throw Exception('permission-denied forced routine push failure');
        }
        throw Exception('Forced routine push failure');
      }
      pushOrder.add(routine.id);
    } finally {
      _concurrentPushCalls -= 1;
    }
  }

  @override
  Future<List<RoutineRemoteDto>> fetchRoutinesUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) async {
    final handler = routinePullHandler;
    if (handler == null) {
      return <RoutineRemoteDto>[];
    }
    return handler(updatedSince);
  }

  @override
  Future<void> upsertExercise(String uid, WorkoutExercise exercise, String routineId) async {}

  @override
  Future<void> upsertSet(String uid, WorkoutSet workoutSet, String exerciseId) async {}

  @override
  Future<void> upsertSession(String uid, WorkoutSession session) async {}

  @override
  Future<void> upsertSetLog(String uid, SetLog setLog) async {}

  @override
  Future<void> upsertLibraryExercise(String uid, LibraryExerciseEntity libraryExercise) async {}

  @override
  Future<void> markRoutineDeleted(String uid, String routineId) async {
    pushOrder.add(routineId);
  }

  @override
  Future<void> markExerciseDeleted(String uid, String exerciseId) async {}

  @override
  Future<void> markSetDeleted(String uid, String setId) async {}

  @override
  Future<void> markSessionDeleted(String uid, String sessionId) async {}

  @override
  Future<void> markSetLogDeleted(String uid, String setLogId) async {}

  @override
  Future<void> markLibraryExerciseDeleted(String uid, String exerciseId) async {}

  @override
  Future<List<ExerciseRemoteDto>> fetchExercisesUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) async {
    return <ExerciseRemoteDto>[];
  }

  @override
  Future<List<SetRemoteDto>> fetchSetsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) async {
    return <SetRemoteDto>[];
  }

  @override
  Future<List<SessionRemoteDto>> fetchSessionsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) async {
    return <SessionRemoteDto>[];
  }

  @override
  Future<List<SetLogRemoteDto>> fetchSetLogsUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) async {
    return <SetLogRemoteDto>[];
  }

  @override
  Future<List<LibraryExerciseRemoteDto>> fetchLibraryExercisesUpdatedSince(
    String uid,
    DateTime? updatedSince, {
    int limit = 500,
  }) async {
    return <LibraryExerciseRemoteDto>[];
  }

  @override
  Future<void> upsertTrainingDefaults(
    String uid, {
    required int? defaultRestSeconds,
    required int? defaultRepetitions,
    required double? defaultWeight,
    required bool autoStartRestTimerOnSetCompleted,
    required DateTime updatedAt,
  }) async {}

  @override
  Future<Map<String, dynamic>?> fetchTrainingDefaults(String uid) async {
    return null;
  }
}
