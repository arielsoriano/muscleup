import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../auth/domain/entities/cloud_user.dart';
import '../../../auth/domain/repositories/cloud_auth_repository.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/repositories/workout_repository.dart';
import '../../domain/sync/sync_engine.dart';
import '../../domain/sync/sync_run_state.dart';
import '../datasources/local/workout_database.dart';
import '../datasources/remote/workout_remote_data_source.dart';
import '../dtos/exercise_remote_dto.dart';
import '../dtos/library_exercise_remote_dto.dart';
import '../dtos/routine_remote_dto.dart';
import '../dtos/session_remote_dto.dart';
import '../dtos/set_log_remote_dto.dart';
import '../dtos/set_remote_dto.dart';
import 'sync_checkpoint_store.dart';
import 'sync_conflict_policy.dart';

typedef SyncSleep = Future<void> Function(Duration duration);

class WorkoutSyncEngine implements SyncEngine {
  WorkoutSyncEngine({
    required AppDatabase database,
    required WorkoutRemoteDataSource workoutRemoteDataSource,
    required CloudAuthRepository cloudAuthRepository,
    required SyncCheckpointStore syncCheckpointStore,
    SyncConflictPolicy? syncConflictPolicy,
    Duration pushBaseBackoff = const Duration(seconds: 1),
    Duration pushMaxBackoff = const Duration(seconds: 30),
    int pushBatchSize = 25,
    int maxRetryCount = 5,
    SyncSleep? syncSleep,
  })  : _database = database,
        _workoutRemoteDataSource = workoutRemoteDataSource,
        _cloudAuthRepository = cloudAuthRepository,
        _syncCheckpointStore = syncCheckpointStore,
        _syncConflictPolicy = syncConflictPolicy ?? SyncConflictPolicy(),
        _pushBaseBackoff = pushBaseBackoff,
        _pushMaxBackoff = pushMaxBackoff,
        _pushBatchSize = pushBatchSize,
        _maxRetryCount = maxRetryCount,
        _syncSleep = syncSleep ?? _defaultSyncSleep {
    _stateController.add(const SyncIdle());
  }

  final AppDatabase _database;
  final WorkoutRemoteDataSource _workoutRemoteDataSource;
  final CloudAuthRepository _cloudAuthRepository;
  final SyncCheckpointStore _syncCheckpointStore;
  final SyncConflictPolicy _syncConflictPolicy;
  final Duration _pushBaseBackoff;
  final Duration _pushMaxBackoff;
  final int _pushBatchSize;
  final int _maxRetryCount;
  final SyncSleep _syncSleep;
  final StreamController<SyncRunState> _stateController =
      StreamController<SyncRunState>.broadcast();

  StreamSubscription<CloudUser?>? _authSubscription;

  String? _activeUid;
  bool _isSyncing = false;
  bool _pendingRun = false;

  @override
  Stream<SyncRunState> get stateStream => _stateController.stream;

  @override
  Future<void> startAutoSync() async {
    if (_authSubscription != null) {
      return;
    }

    _authSubscription = _cloudAuthRepository.watchAuthState().listen((CloudUser? user) {
      if (user == null || user.isAnonymous) {
        _activeUid = null;
        return;
      }

      _activeUid = user.uid;
      unawaited(triggerManualSync());
    });
  }

  @override
  Future<void> notifyConnectivityRestored() async {
    await triggerManualSync();
  }

  @override
  Future<SyncRunResult> triggerManualSync() async {
    final uid = _activeUid;
    if (uid == null || uid.isEmpty) {
      return const SyncRunResult(
        success: false,
        message: 'Cloud sync requires a linked Google account',
      );
    }

    if (_isSyncing) {
      _pendingRun = true;
      return const SyncRunResult(success: true, message: 'Sync queued');
    }

    _isSyncing = true;
    SyncRunResult latestResult = const SyncRunResult(success: true);

    try {
      do {
        _pendingRun = false;
        final executionUid = _activeUid;
        if (executionUid == null || executionUid.isEmpty) {
          latestResult = const SyncRunResult(
            success: false,
            message: 'No authenticated uid available for sync',
          );
          break;
        }
        latestResult = await _runSingleSyncCycle(executionUid);
      } while (_pendingRun);
    } finally {
      _isSyncing = false;
      if (!_stateController.isClosed) {
        _stateController.add(const SyncIdle());
      }
    }

    return latestResult;
  }

  Future<SyncRunResult> _runSingleSyncCycle(String uid) async {
    final startedAt = DateTime.now();
    if (!_stateController.isClosed) {
      _stateController.add(Syncing(startedAt: startedAt));
    }

    final mutableMetrics = _MutableSyncMetrics(startedAt: startedAt);

    try {
      _ensureUidStable(uid);
      await _pushPendingOutbox(uid, mutableMetrics);
      _ensureUidStable(uid);
      await _pullIncremental(uid, mutableMetrics);

      final endedAt = DateTime.now();
      final metrics = mutableMetrics.toFinalMetrics(endedAt: endedAt);
      if (!_stateController.isClosed) {
        _stateController.add(SyncSuccess(metrics: metrics));
      }
      return SyncRunResult(success: true, metrics: metrics);
    } catch (error) {
      mutableMetrics.failedCount += 1;
      final endedAt = DateTime.now();
      final metrics = mutableMetrics.toFinalMetrics(endedAt: endedAt);
      final message = 'Sync cycle failed: $error';
      if (!_stateController.isClosed) {
        _stateController.add(SyncError(message: message, metrics: metrics));
      }
      return SyncRunResult(success: false, metrics: metrics, message: message);
    }
  }

  Future<void> _pushPendingOutbox(String uid, _MutableSyncMetrics mutableMetrics) async {
    while (true) {
      _ensureUidStable(uid);
      final pendingChanges = await (_database.select(_database.outboxChanges)
            ..where((tbl) => tbl.retryCount.isSmallerThanValue(_maxRetryCount))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)])
            ..limit(_pushBatchSize))
          .get();

      if (pendingChanges.isEmpty) {
        return;
      }

      bool shouldStopCurrentCycle = false;

      for (final change in pendingChanges) {
        try {
          _ensureOutboxOwner(uid, change);
          await _processOutboxChange(uid, change);
          await _markEntitySynced(entityType: change.entityType, entityId: change.entityId);
          await (_database.delete(_database.outboxChanges)
                ..where((tbl) => tbl.id.equals(change.id)))
              .go();
          mutableMetrics.pushedCount += 1;
        } catch (error) {
          mutableMetrics.failedCount += 1;
          final nextRetryCount = change.retryCount + 1;
          final failureKind = _classifySyncFailure(error);
          final cappedRetryCount = failureKind == _SyncFailureKind.permanent
              ? _maxRetryCount
              : nextRetryCount;

          await (_database.update(_database.outboxChanges)
                ..where((tbl) => tbl.id.equals(change.id)))
              .write(
            OutboxChangesCompanion(
              retryCount: Value(cappedRetryCount),
              lastError: Value(error.toString()),
            ),
          );

          if (failureKind == _SyncFailureKind.transient && cappedRetryCount < _maxRetryCount) {
            final backoff = _computeBackoff(cappedRetryCount);
            await _syncSleep(backoff);
            shouldStopCurrentCycle = true;
            break;
          }
        }
      }

      if (shouldStopCurrentCycle) {
        return;
      }
    }
  }

  Future<void> _processOutboxChange(String uid, OutboxChangeData change) async {
    switch (change.entityType) {
      case 'routine':
        await _processRoutineOutbox(uid, change);
        return;
      case 'exercise':
        await _processExerciseOutbox(uid, change);
        return;
      case 'set':
        await _processSetOutbox(uid, change);
        return;
      case 'session':
        await _processSessionOutbox(uid, change);
        return;
      case 'setLog':
        await _processSetLogOutbox(uid, change);
        return;
      case 'libraryExercise':
        await _processLibraryExerciseOutbox(uid, change);
        return;
      default:
        return;
    }
  }

  Future<void> _processRoutineOutbox(String uid, OutboxChangeData change) async {
    final localRow = await (_database.select(_database.routines)
          ..where((tbl) => tbl.id.equals(change.entityId)))
        .getSingleOrNull();

    if (change.operation == 'delete' || localRow?.deletedAt != null || localRow?.isDeleted == true) {
      await _workoutRemoteDataSource.markRoutineDeleted(uid, change.entityId);
      return;
    }

    if (localRow == null) {
      return;
    }

    final localEntity = WorkoutRoutine(
      id: localRow.id,
      name: localRow.name,
      sortOrder: localRow.sortOrder,
      exercises: const <WorkoutExercise>[],
      syncMetadata: SyncMetadata(
        updatedAt: localRow.updatedAt,
        deletedAt: localRow.deletedAt,
        syncStatus: localRow.syncStatus.name,
        remoteVersion: localRow.remoteVersion,
      ),
    );

    await _workoutRemoteDataSource.upsertRoutine(uid, localEntity);
  }

  Future<void> _processExerciseOutbox(String uid, OutboxChangeData change) async {
    final localRow = await (_database.select(_database.exercises)
          ..where((tbl) => tbl.id.equals(change.entityId)))
        .getSingleOrNull();

    if (change.operation == 'delete' || localRow?.deletedAt != null) {
      await _workoutRemoteDataSource.markExerciseDeleted(uid, change.entityId);
      return;
    }

    if (localRow == null) {
      return;
    }

    final localEntity = WorkoutExercise(
      id: localRow.id,
      name: localRow.name,
      sortOrder: localRow.sortOrder,
      notes: localRow.notes,
      restTimeSeconds: localRow.restTimeSeconds,
      templateSets: const <WorkoutSet>[],
      syncMetadata: SyncMetadata(
        updatedAt: localRow.updatedAt,
        deletedAt: localRow.deletedAt,
        syncStatus: localRow.syncStatus.name,
        remoteVersion: localRow.remoteVersion,
      ),
    );

    await _workoutRemoteDataSource.upsertExercise(uid, localEntity, localRow.routineId);
  }

  Future<void> _processSetOutbox(String uid, OutboxChangeData change) async {
    final localRow = await (_database.select(_database.sets)
          ..where((tbl) => tbl.id.equals(change.entityId)))
        .getSingleOrNull();

    if (change.operation == 'delete' || localRow?.deletedAt != null) {
      await _workoutRemoteDataSource.markSetDeleted(uid, change.entityId);
      return;
    }

    if (localRow == null) {
      return;
    }

    final localEntity = WorkoutSet(
      id: localRow.id,
      sortOrder: localRow.sortOrder,
      targetValue1: localRow.targetValue1,
      targetValue2: localRow.targetValue2,
      unit1: localRow.unit1,
      unit2: localRow.unit2,
      syncMetadata: SyncMetadata(
        updatedAt: localRow.updatedAt,
        deletedAt: localRow.deletedAt,
        syncStatus: localRow.syncStatus.name,
        remoteVersion: localRow.remoteVersion,
      ),
    );

    await _workoutRemoteDataSource.upsertSet(uid, localEntity, localRow.exerciseId);
  }

  Future<void> _processSessionOutbox(String uid, OutboxChangeData change) async {
    final localRow = await (_database.select(_database.sessions)
          ..where((tbl) => tbl.id.equals(change.entityId)))
        .getSingleOrNull();

    if (change.operation == 'delete' || localRow?.deletedAt != null) {
      await _workoutRemoteDataSource.markSessionDeleted(uid, change.entityId);
      return;
    }

    if (localRow == null) {
      return;
    }

    final localEntity = WorkoutSession(
      id: localRow.id,
      routineId: localRow.routineId,
      routineName: localRow.routineName,
      createdAt: localRow.createdAt,
      notes: localRow.notes,
      isCompleted: localRow.isCompleted,
      syncMetadata: SyncMetadata(
        updatedAt: localRow.updatedAt,
        deletedAt: localRow.deletedAt,
        syncStatus: localRow.syncStatus.name,
        remoteVersion: localRow.remoteVersion,
      ),
    );

    await _workoutRemoteDataSource.upsertSession(uid, localEntity);
  }

  Future<void> _processSetLogOutbox(String uid, OutboxChangeData change) async {
    final localRow = await (_database.select(_database.setLogs)
          ..where((tbl) => tbl.id.equals(change.entityId)))
        .getSingleOrNull();

    if (change.operation == 'delete' || localRow?.deletedAt != null) {
      await _workoutRemoteDataSource.markSetLogDeleted(uid, change.entityId);
      return;
    }

    if (localRow == null) {
      return;
    }

    final localEntity = SetLog(
      id: localRow.id,
      sessionId: localRow.sessionId,
      workoutExerciseId: localRow.workoutExerciseId,
      setNumber: localRow.setNumber,
      actualValue1: localRow.actualValue1,
      actualValue2: localRow.actualValue2,
      unit1: localRow.unit1,
      unit2: localRow.unit2,
      isCompleted: localRow.isCompleted,
      timestamp: localRow.timestamp,
      syncMetadata: SyncMetadata(
        updatedAt: localRow.updatedAt,
        deletedAt: localRow.deletedAt,
        syncStatus: localRow.syncStatus.name,
        remoteVersion: localRow.remoteVersion,
      ),
    );

    await _workoutRemoteDataSource.upsertSetLog(uid, localEntity);
  }

  Future<void> _processLibraryExerciseOutbox(String uid, OutboxChangeData change) async {
    final localRow = await (_database.select(_database.libraryExercises)
          ..where((tbl) => tbl.id.equals(change.entityId)))
        .getSingleOrNull();

    if (change.operation == 'delete' || localRow?.deletedAt != null) {
      await _workoutRemoteDataSource.markLibraryExerciseDeleted(uid, change.entityId);
      return;
    }

    if (localRow == null) {
      return;
    }

    final localEntity = LibraryExerciseEntity(
      id: localRow.id,
      name: localRow.name,
      nameEn: localRow.nameEn,
      nameEs: localRow.nameEs,
      isCustom: localRow.isCustom,
      syncMetadata: SyncMetadata(
        updatedAt: localRow.updatedAt,
        deletedAt: localRow.deletedAt,
        syncStatus: localRow.syncStatus.name,
        remoteVersion: localRow.remoteVersion,
      ),
    );

    await _workoutRemoteDataSource.upsertLibraryExercise(uid, localEntity);
  }

  Future<void> _markEntitySynced({
    required String entityType,
    required String entityId,
  }) async {
    switch (entityType) {
      case 'routine':
        final row = await (_database.select(_database.routines)
              ..where((tbl) => tbl.id.equals(entityId)))
            .getSingleOrNull();
        if (row != null) {
          await (_database.update(_database.routines)
                ..where((tbl) => tbl.id.equals(entityId)))
              .write(
            RoutinesCompanion(
              syncStatus: const Value(SyncStatus.synced),
              remoteVersion: Value(row.remoteVersion + 1),
            ),
          );
        }
        return;
      case 'exercise':
        final row = await (_database.select(_database.exercises)
              ..where((tbl) => tbl.id.equals(entityId)))
            .getSingleOrNull();
        if (row != null) {
          await (_database.update(_database.exercises)
                ..where((tbl) => tbl.id.equals(entityId)))
              .write(
            ExercisesCompanion(
              syncStatus: const Value(SyncStatus.synced),
              remoteVersion: Value(row.remoteVersion + 1),
            ),
          );
        }
        return;
      case 'set':
        final row = await (_database.select(_database.sets)
              ..where((tbl) => tbl.id.equals(entityId)))
            .getSingleOrNull();
        if (row != null) {
          await (_database.update(_database.sets)
                ..where((tbl) => tbl.id.equals(entityId)))
              .write(
            SetsCompanion(
              syncStatus: const Value(SyncStatus.synced),
              remoteVersion: Value(row.remoteVersion + 1),
            ),
          );
        }
        return;
      case 'session':
        final row = await (_database.select(_database.sessions)
              ..where((tbl) => tbl.id.equals(entityId)))
            .getSingleOrNull();
        if (row != null) {
          await (_database.update(_database.sessions)
                ..where((tbl) => tbl.id.equals(entityId)))
              .write(
            SessionsCompanion(
              syncStatus: const Value(SyncStatus.synced),
              remoteVersion: Value(row.remoteVersion + 1),
            ),
          );
        }
        return;
      case 'setLog':
        final row = await (_database.select(_database.setLogs)
              ..where((tbl) => tbl.id.equals(entityId)))
            .getSingleOrNull();
        if (row != null) {
          await (_database.update(_database.setLogs)
                ..where((tbl) => tbl.id.equals(entityId)))
              .write(
            SetLogsCompanion(
              syncStatus: const Value(SyncStatus.synced),
              remoteVersion: Value(row.remoteVersion + 1),
            ),
          );
        }
        return;
      case 'libraryExercise':
        final row = await (_database.select(_database.libraryExercises)
              ..where((tbl) => tbl.id.equals(entityId)))
            .getSingleOrNull();
        if (row != null) {
          await (_database.update(_database.libraryExercises)
                ..where((tbl) => tbl.id.equals(entityId)))
              .write(
            LibraryExercisesCompanion(
              syncStatus: const Value(SyncStatus.synced),
              remoteVersion: Value(row.remoteVersion + 1),
            ),
          );
        }
        return;
      default:
        return;
    }
  }

  Duration _computeBackoff(int retryCount) {
    final exponent = retryCount < 0 ? 0 : retryCount;
    final rawMilliseconds = _pushBaseBackoff.inMilliseconds * (1 << exponent.clamp(0, 8));
    if (rawMilliseconds >= _pushMaxBackoff.inMilliseconds) {
      return _pushMaxBackoff;
    }
    return Duration(milliseconds: rawMilliseconds);
  }

  _SyncFailureKind _classifySyncFailure(Object error) {
    final message = error.toString().toLowerCase();

    const permanentMarkers = <String>[
      'permission-denied',
      'unauthenticated',
      'invalid-argument',
      'failed-precondition',
      'not-found',
      'owner-mismatch',
      'cross-user',
      'not configured',
    ];

    for (final marker in permanentMarkers) {
      if (message.contains(marker)) {
        return _SyncFailureKind.permanent;
      }
    }

    return _SyncFailureKind.transient;
  }

  void _ensureUidStable(String expectedUid) {
    if (_activeUid != expectedUid) {
      throw StateError('cross-user sync protection triggered');
    }
  }

  void _ensureOutboxOwner(String uid, OutboxChangeData outboxChangeData) {
    final payloadMap = decodeOutboxPayload(outboxChangeData);
    final payloadOwnerId = payloadMap['ownerId'];
    if (payloadOwnerId is String && payloadOwnerId.isNotEmpty && payloadOwnerId != uid) {
      throw StateError('owner-mismatch between outbox payload and authenticated uid');
    }
  }

  Future<void> _pullIncremental(String uid, _MutableSyncMetrics mutableMetrics) async {
    // ── Phase 1: fetch every entity type from Firebase (network-only, no DB) ──
    // For each entity type, paginate until we get fewer than batchSize results.

    final routineDtos = <RoutineRemoteDto>[];
    {
      DateTime? checkpoint =
          _syncCheckpointStore.getCheckpoint(uid: uid, entityType: 'routine');
      while (true) {
        final batch = await _workoutRemoteDataSource.fetchRoutinesUpdatedSince(
          uid, checkpoint, limit: _pushBatchSize,
        );
        if (batch.isEmpty) break;
        routineDtos.addAll(batch);
        if (batch.length < _pushBatchSize) break;
        checkpoint = _maxRoutineUpdatedAt(batch);
      }
    }

    final exerciseDtos = <ExerciseRemoteDto>[];
    {
      DateTime? checkpoint =
          _syncCheckpointStore.getCheckpoint(uid: uid, entityType: 'exercise');
      while (true) {
        final batch = await _workoutRemoteDataSource.fetchExercisesUpdatedSince(
          uid, checkpoint, limit: _pushBatchSize,
        );
        if (batch.isEmpty) break;
        exerciseDtos.addAll(batch);
        if (batch.length < _pushBatchSize) break;
        checkpoint = _maxExerciseUpdatedAt(batch);
      }
    }

    final setDtos = <SetRemoteDto>[];
    {
      DateTime? checkpoint =
          _syncCheckpointStore.getCheckpoint(uid: uid, entityType: 'set');
      while (true) {
        final batch = await _workoutRemoteDataSource.fetchSetsUpdatedSince(
          uid, checkpoint, limit: _pushBatchSize,
        );
        if (batch.isEmpty) break;
        setDtos.addAll(batch);
        if (batch.length < _pushBatchSize) break;
        checkpoint = _maxSetUpdatedAt(batch);
      }
    }

    final sessionDtos = <SessionRemoteDto>[];
    {
      DateTime? checkpoint =
          _syncCheckpointStore.getCheckpoint(uid: uid, entityType: 'session');
      while (true) {
        final batch = await _workoutRemoteDataSource.fetchSessionsUpdatedSince(
          uid, checkpoint, limit: _pushBatchSize,
        );
        if (batch.isEmpty) break;
        sessionDtos.addAll(batch);
        if (batch.length < _pushBatchSize) break;
        checkpoint = _maxSessionUpdatedAt(batch);
      }
    }

    final setLogDtos = <SetLogRemoteDto>[];
    {
      DateTime? checkpoint =
          _syncCheckpointStore.getCheckpoint(uid: uid, entityType: 'setLog');
      while (true) {
        final batch = await _workoutRemoteDataSource.fetchSetLogsUpdatedSince(
          uid, checkpoint, limit: _pushBatchSize,
        );
        if (batch.isEmpty) break;
        setLogDtos.addAll(batch);
        if (batch.length < _pushBatchSize) break;
        checkpoint = _maxSetLogUpdatedAt(batch);
      }
    }

    final libraryExerciseDtos = <LibraryExerciseRemoteDto>[];
    {
      DateTime? checkpoint =
          _syncCheckpointStore.getCheckpoint(uid: uid, entityType: 'libraryExercise');
      while (true) {
        final batch =
            await _workoutRemoteDataSource.fetchLibraryExercisesUpdatedSince(
          uid, checkpoint, limit: _pushBatchSize,
        );
        if (batch.isEmpty) break;
        libraryExerciseDtos.addAll(batch);
        if (batch.length < _pushBatchSize) break;
        checkpoint = _maxLibraryExerciseUpdatedAt(batch);
      }
    }

    // ── Phase 2: apply all fetched data in a single flat DB transaction ──
    await _database.transaction(() async {
      await _applyPulledRoutines(routineDtos, mutableMetrics);
      await _applyPulledExercises(exerciseDtos, mutableMetrics);
      await _applyPulledSets(setDtos, mutableMetrics);
      await _applyPulledSessions(sessionDtos, mutableMetrics);
      await _applyPulledSetLogs(setLogDtos, mutableMetrics);
      await _applyPulledLibraryExercises(libraryExerciseDtos, mutableMetrics);
    });

    // ── Phase 3: persist checkpoints only after a successful commit ──
    if (routineDtos.isNotEmpty) {
      await _syncCheckpointStore.setCheckpoint(
        uid: uid, entityType: 'routine',
        checkpoint: _maxRoutineUpdatedAt(routineDtos),
      );
    }
    if (exerciseDtos.isNotEmpty) {
      await _syncCheckpointStore.setCheckpoint(
        uid: uid, entityType: 'exercise',
        checkpoint: _maxExerciseUpdatedAt(exerciseDtos),
      );
    }
    if (setDtos.isNotEmpty) {
      await _syncCheckpointStore.setCheckpoint(
        uid: uid, entityType: 'set',
        checkpoint: _maxSetUpdatedAt(setDtos),
      );
    }
    if (sessionDtos.isNotEmpty) {
      await _syncCheckpointStore.setCheckpoint(
        uid: uid, entityType: 'session',
        checkpoint: _maxSessionUpdatedAt(sessionDtos),
      );
    }
    if (setLogDtos.isNotEmpty) {
      await _syncCheckpointStore.setCheckpoint(
        uid: uid, entityType: 'setLog',
        checkpoint: _maxSetLogUpdatedAt(setLogDtos),
      );
    }
    if (libraryExerciseDtos.isNotEmpty) {
      await _syncCheckpointStore.setCheckpoint(
        uid: uid, entityType: 'libraryExercise',
        checkpoint: _maxLibraryExerciseUpdatedAt(libraryExerciseDtos),
      );
    }
  }

  Future<void> _applyPulledRoutines(
    List<RoutineRemoteDto> remoteDtos,
    _MutableSyncMetrics mutableMetrics,
  ) async {
    for (final dto in remoteDtos) {
      final localRow = await (_database.select(_database.routines)
            ..where((tbl) => tbl.id.equals(dto.id)))
          .getSingleOrNull();

      if (localRow == null) {
        if (dto.deletedAt == null) {
          await _database.into(_database.routines).insertOnConflictUpdate(
                RoutinesCompanion.insert(
                  id: dto.id,
                  name: dto.name,
                  sortOrder: dto.sortOrder,
                  isDeleted: const Value(false),
                  updatedAt: Value(dto.updatedAt),
                  deletedAt: Value(dto.deletedAt),
                  syncStatus: const Value(SyncStatus.synced),
                  remoteVersion: Value(dto.remoteVersion),
                ),
              );
          mutableMetrics.pulledCount += 1;
        }
        continue;
      }

      if (_syncConflictPolicy.isConflict(
        localUpdatedAt: localRow.updatedAt,
        localDeletedAt: localRow.deletedAt,
        remoteUpdatedAt: dto.updatedAt,
        remoteDeletedAt: dto.deletedAt,
      )) {
        mutableMetrics.conflictsResolvedCount += 1;
      }

      final winner = _syncConflictPolicy.resolve(
        localUpdatedAt: localRow.updatedAt,
        localDeletedAt: localRow.deletedAt,
        remoteUpdatedAt: dto.updatedAt,
        remoteDeletedAt: dto.deletedAt,
      );

      if (winner == SyncConflictWinner.remote) {
        await (_database.update(_database.routines)
              ..where((tbl) => tbl.id.equals(dto.id)))
            .write(
          RoutinesCompanion(
            name: Value(dto.name),
            sortOrder: Value(dto.sortOrder),
            isDeleted: Value(dto.deletedAt != null),
            updatedAt: Value(dto.updatedAt),
            deletedAt: Value(dto.deletedAt),
            syncStatus: const Value(SyncStatus.synced),
            remoteVersion: Value(dto.remoteVersion),
          ),
        );
        mutableMetrics.pulledCount += 1;
      }
    }
  }

  Future<void> _applyPulledExercises(
    List<ExerciseRemoteDto> remoteDtos,
    _MutableSyncMetrics mutableMetrics,
  ) async {
    for (final dto in remoteDtos) {
      final localRow = await (_database.select(_database.exercises)
            ..where((tbl) => tbl.id.equals(dto.id)))
          .getSingleOrNull();

      if (localRow == null) {
        if (dto.deletedAt == null) {
          await _database.into(_database.exercises).insertOnConflictUpdate(
                ExercisesCompanion.insert(
                  id: dto.id,
                  routineId: dto.routineId,
                  name: dto.name,
                  notes: Value(dto.notes),
                  restTimeSeconds: dto.restTimeSeconds,
                  sortOrder: dto.sortOrder,
                  updatedAt: Value(dto.updatedAt),
                  deletedAt: Value(dto.deletedAt),
                  syncStatus: const Value(SyncStatus.synced),
                  remoteVersion: Value(dto.remoteVersion),
                ),
              );
          mutableMetrics.pulledCount += 1;
        }
        continue;
      }

      if (_syncConflictPolicy.isConflict(
        localUpdatedAt: localRow.updatedAt,
        localDeletedAt: localRow.deletedAt,
        remoteUpdatedAt: dto.updatedAt,
        remoteDeletedAt: dto.deletedAt,
      )) {
        mutableMetrics.conflictsResolvedCount += 1;
      }

      final winner = _syncConflictPolicy.resolve(
        localUpdatedAt: localRow.updatedAt,
        localDeletedAt: localRow.deletedAt,
        remoteUpdatedAt: dto.updatedAt,
        remoteDeletedAt: dto.deletedAt,
      );

      if (winner == SyncConflictWinner.remote) {
        await (_database.update(_database.exercises)
              ..where((tbl) => tbl.id.equals(dto.id)))
            .write(
          ExercisesCompanion(
            routineId: Value(dto.routineId),
            name: Value(dto.name),
            notes: Value(dto.notes),
            restTimeSeconds: Value(dto.restTimeSeconds),
            sortOrder: Value(dto.sortOrder),
            updatedAt: Value(dto.updatedAt),
            deletedAt: Value(dto.deletedAt),
            syncStatus: const Value(SyncStatus.synced),
            remoteVersion: Value(dto.remoteVersion),
          ),
        );
        mutableMetrics.pulledCount += 1;
      }
    }
  }

  Future<void> _applyPulledSets(
    List<SetRemoteDto> remoteDtos,
    _MutableSyncMetrics mutableMetrics,
  ) async {
    for (final dto in remoteDtos) {
      final localRow = await (_database.select(_database.sets)
            ..where((tbl) => tbl.id.equals(dto.id)))
          .getSingleOrNull();

      if (localRow == null) {
        if (dto.deletedAt == null) {
          await _database.into(_database.sets).insertOnConflictUpdate(
                SetsCompanion.insert(
                  id: dto.id,
                  exerciseId: dto.exerciseId,
                  targetValue1: Value(dto.targetValue1),
                  targetValue2: Value(dto.targetValue2),
                  unit1: Value(dto.unit1),
                  unit2: Value(dto.unit2),
                  sortOrder: dto.sortOrder,
                  updatedAt: Value(dto.updatedAt),
                  deletedAt: Value(dto.deletedAt),
                  syncStatus: const Value(SyncStatus.synced),
                  remoteVersion: Value(dto.remoteVersion),
                ),
              );
          mutableMetrics.pulledCount += 1;
        }
        continue;
      }

      if (_syncConflictPolicy.isConflict(
        localUpdatedAt: localRow.updatedAt,
        localDeletedAt: localRow.deletedAt,
        remoteUpdatedAt: dto.updatedAt,
        remoteDeletedAt: dto.deletedAt,
      )) {
        mutableMetrics.conflictsResolvedCount += 1;
      }

      final winner = _syncConflictPolicy.resolve(
        localUpdatedAt: localRow.updatedAt,
        localDeletedAt: localRow.deletedAt,
        remoteUpdatedAt: dto.updatedAt,
        remoteDeletedAt: dto.deletedAt,
      );

      if (winner == SyncConflictWinner.remote) {
        await (_database.update(_database.sets)
              ..where((tbl) => tbl.id.equals(dto.id)))
            .write(
          SetsCompanion(
            exerciseId: Value(dto.exerciseId),
            targetValue1: Value(dto.targetValue1),
            targetValue2: Value(dto.targetValue2),
            unit1: Value(dto.unit1),
            unit2: Value(dto.unit2),
            sortOrder: Value(dto.sortOrder),
            updatedAt: Value(dto.updatedAt),
            deletedAt: Value(dto.deletedAt),
            syncStatus: const Value(SyncStatus.synced),
            remoteVersion: Value(dto.remoteVersion),
          ),
        );
        mutableMetrics.pulledCount += 1;
      }
    }
  }

  Future<void> _applyPulledSessions(
    List<SessionRemoteDto> remoteDtos,
    _MutableSyncMetrics mutableMetrics,
  ) async {
    for (final dto in remoteDtos) {
      final localRow = await (_database.select(_database.sessions)
            ..where((tbl) => tbl.id.equals(dto.id)))
          .getSingleOrNull();

      if (localRow == null) {
        if (dto.deletedAt == null) {
          await _database.into(_database.sessions).insertOnConflictUpdate(
                SessionsCompanion.insert(
                  id: dto.id,
                  routineId: dto.routineId,
                  routineName: dto.routineName,
                  createdAt: dto.createdAt,
                  notes: Value(dto.notes),
                  isCompleted: Value(dto.isCompleted),
                  updatedAt: Value(dto.updatedAt),
                  deletedAt: Value(dto.deletedAt),
                  syncStatus: const Value(SyncStatus.synced),
                  remoteVersion: Value(dto.remoteVersion),
                ),
              );
          mutableMetrics.pulledCount += 1;
        }
        continue;
      }

      if (_syncConflictPolicy.isConflict(
        localUpdatedAt: localRow.updatedAt,
        localDeletedAt: localRow.deletedAt,
        remoteUpdatedAt: dto.updatedAt,
        remoteDeletedAt: dto.deletedAt,
      )) {
        mutableMetrics.conflictsResolvedCount += 1;
      }

      final winner = _syncConflictPolicy.resolve(
        localUpdatedAt: localRow.updatedAt,
        localDeletedAt: localRow.deletedAt,
        remoteUpdatedAt: dto.updatedAt,
        remoteDeletedAt: dto.deletedAt,
      );

      if (winner == SyncConflictWinner.remote) {
        await (_database.update(_database.sessions)
              ..where((tbl) => tbl.id.equals(dto.id)))
            .write(
          SessionsCompanion(
            routineId: Value(dto.routineId),
            routineName: Value(dto.routineName),
            createdAt: Value(dto.createdAt),
            notes: Value(dto.notes),
            isCompleted: Value(dto.isCompleted),
            updatedAt: Value(dto.updatedAt),
            deletedAt: Value(dto.deletedAt),
            syncStatus: const Value(SyncStatus.synced),
            remoteVersion: Value(dto.remoteVersion),
          ),
        );
        mutableMetrics.pulledCount += 1;
      }
    }
  }

  Future<void> _applyPulledSetLogs(
    List<SetLogRemoteDto> remoteDtos,
    _MutableSyncMetrics mutableMetrics,
  ) async {
    for (final dto in remoteDtos) {
      final localRow = await (_database.select(_database.setLogs)
            ..where((tbl) => tbl.id.equals(dto.id)))
          .getSingleOrNull();

      if (localRow == null) {
        if (dto.deletedAt == null) {
          await _database.into(_database.setLogs).insertOnConflictUpdate(
                SetLogsCompanion.insert(
                  id: dto.id,
                  sessionId: dto.sessionId,
                  workoutExerciseId: dto.workoutExerciseId,
                  setNumber: dto.setNumber,
                  actualValue1: Value(dto.actualValue1),
                  actualValue2: Value(dto.actualValue2),
                  unit1: Value(dto.unit1),
                  unit2: Value(dto.unit2),
                  isCompleted: dto.isCompleted,
                  timestamp: dto.timestamp,
                  updatedAt: Value(dto.updatedAt),
                  deletedAt: Value(dto.deletedAt),
                  syncStatus: const Value(SyncStatus.synced),
                  remoteVersion: Value(dto.remoteVersion),
                ),
              );
          mutableMetrics.pulledCount += 1;
        }
        continue;
      }

      if (_syncConflictPolicy.isConflict(
        localUpdatedAt: localRow.updatedAt,
        localDeletedAt: localRow.deletedAt,
        remoteUpdatedAt: dto.updatedAt,
        remoteDeletedAt: dto.deletedAt,
      )) {
        mutableMetrics.conflictsResolvedCount += 1;
      }

      final winner = _syncConflictPolicy.resolve(
        localUpdatedAt: localRow.updatedAt,
        localDeletedAt: localRow.deletedAt,
        remoteUpdatedAt: dto.updatedAt,
        remoteDeletedAt: dto.deletedAt,
      );

      if (winner == SyncConflictWinner.remote) {
        await (_database.update(_database.setLogs)
              ..where((tbl) => tbl.id.equals(dto.id)))
            .write(
          SetLogsCompanion(
            sessionId: Value(dto.sessionId),
            workoutExerciseId: Value(dto.workoutExerciseId),
            setNumber: Value(dto.setNumber),
            actualValue1: Value(dto.actualValue1),
            actualValue2: Value(dto.actualValue2),
            unit1: Value(dto.unit1),
            unit2: Value(dto.unit2),
            isCompleted: Value(dto.isCompleted),
            timestamp: Value(dto.timestamp),
            updatedAt: Value(dto.updatedAt),
            deletedAt: Value(dto.deletedAt),
            syncStatus: const Value(SyncStatus.synced),
            remoteVersion: Value(dto.remoteVersion),
          ),
        );
        mutableMetrics.pulledCount += 1;
      }
    }
  }

  Future<void> _applyPulledLibraryExercises(
    List<LibraryExerciseRemoteDto> remoteDtos,
    _MutableSyncMetrics mutableMetrics,
  ) async {
    for (final dto in remoteDtos) {
      final localRow = await (_database.select(_database.libraryExercises)
            ..where((tbl) => tbl.id.equals(dto.id)))
          .getSingleOrNull();

      if (localRow == null) {
        if (dto.deletedAt == null) {
          await _database.into(_database.libraryExercises).insertOnConflictUpdate(
                LibraryExercisesCompanion.insert(
                  id: dto.id,
                  name: dto.name,
                  nameEn: dto.nameEn,
                  nameEs: dto.nameEs,
                  isCustom: dto.isCustom,
                  category: const Value(null),
                  updatedAt: Value(dto.updatedAt),
                  deletedAt: Value(dto.deletedAt),
                  syncStatus: const Value(SyncStatus.synced),
                  remoteVersion: Value(dto.remoteVersion),
                ),
              );
          mutableMetrics.pulledCount += 1;
        }
        continue;
      }

      if (_syncConflictPolicy.isConflict(
        localUpdatedAt: localRow.updatedAt,
        localDeletedAt: localRow.deletedAt,
        remoteUpdatedAt: dto.updatedAt,
        remoteDeletedAt: dto.deletedAt,
      )) {
        mutableMetrics.conflictsResolvedCount += 1;
      }

      final winner = _syncConflictPolicy.resolve(
        localUpdatedAt: localRow.updatedAt,
        localDeletedAt: localRow.deletedAt,
        remoteUpdatedAt: dto.updatedAt,
        remoteDeletedAt: dto.deletedAt,
      );

      if (winner == SyncConflictWinner.remote) {
        await (_database.update(_database.libraryExercises)
              ..where((tbl) => tbl.id.equals(dto.id)))
            .write(
          LibraryExercisesCompanion(
            name: Value(dto.name),
            nameEn: Value(dto.nameEn),
            nameEs: Value(dto.nameEs),
            isCustom: Value(dto.isCustom),
            updatedAt: Value(dto.updatedAt),
            deletedAt: Value(dto.deletedAt),
            syncStatus: const Value(SyncStatus.synced),
            remoteVersion: Value(dto.remoteVersion),
          ),
        );
        mutableMetrics.pulledCount += 1;
      }
    }
  }

  DateTime _maxRoutineUpdatedAt(List<RoutineRemoteDto> remoteDtos) {
    var latest = remoteDtos.first.updatedAt;
    for (final dto in remoteDtos.skip(1)) {
      if (dto.updatedAt.isAfter(latest)) {
        latest = dto.updatedAt;
      }
    }
    return latest;
  }

  DateTime _maxExerciseUpdatedAt(List<ExerciseRemoteDto> remoteDtos) {
    var latest = remoteDtos.first.updatedAt;
    for (final dto in remoteDtos.skip(1)) {
      if (dto.updatedAt.isAfter(latest)) {
        latest = dto.updatedAt;
      }
    }
    return latest;
  }

  DateTime _maxSetUpdatedAt(List<SetRemoteDto> remoteDtos) {
    var latest = remoteDtos.first.updatedAt;
    for (final dto in remoteDtos.skip(1)) {
      if (dto.updatedAt.isAfter(latest)) {
        latest = dto.updatedAt;
      }
    }
    return latest;
  }

  DateTime _maxSessionUpdatedAt(List<SessionRemoteDto> remoteDtos) {
    var latest = remoteDtos.first.updatedAt;
    for (final dto in remoteDtos.skip(1)) {
      if (dto.updatedAt.isAfter(latest)) {
        latest = dto.updatedAt;
      }
    }
    return latest;
  }

  DateTime _maxSetLogUpdatedAt(List<SetLogRemoteDto> remoteDtos) {
    var latest = remoteDtos.first.updatedAt;
    for (final dto in remoteDtos.skip(1)) {
      if (dto.updatedAt.isAfter(latest)) {
        latest = dto.updatedAt;
      }
    }
    return latest;
  }

  DateTime _maxLibraryExerciseUpdatedAt(List<LibraryExerciseRemoteDto> remoteDtos) {
    var latest = remoteDtos.first.updatedAt;
    for (final dto in remoteDtos.skip(1)) {
      if (dto.updatedAt.isAfter(latest)) {
        latest = dto.updatedAt;
      }
    }
    return latest;
  }

  static Future<void> _defaultSyncSleep(Duration duration) async {
    await Future<void>.delayed(duration);
  }

  Future<void> dispose() async {
    await _authSubscription?.cancel();
    await _stateController.close();
  }

  Map<String, dynamic> decodeOutboxPayload(OutboxChangeData outboxChangeData) {
    return jsonDecode(outboxChangeData.payloadJson) as Map<String, dynamic>;
  }
}

enum _SyncFailureKind {
  transient,
  permanent,
}

class _MutableSyncMetrics {
  _MutableSyncMetrics({required this.startedAt});

  final DateTime startedAt;

  int pushedCount = 0;
  int pulledCount = 0;
  int conflictsResolvedCount = 0;
  int failedCount = 0;

  SyncRunMetrics toFinalMetrics({required DateTime endedAt}) {
    return SyncRunMetrics(
      pushedCount: pushedCount,
      pulledCount: pulledCount,
      conflictsResolvedCount: conflictsResolvedCount,
      failedCount: failedCount,
      startedAt: startedAt,
      endedAt: endedAt,
    );
  }
}
