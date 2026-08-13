import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/repositories/workout_repository.dart';
import '../../domain/sync/sync_engine.dart';
import '../datasources/local/workout_database.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  WorkoutRepositoryImpl(
    this.database, {
    SyncEngine? syncEngine,
  }) : _syncEngine = syncEngine;

  final AppDatabase database;
  final SyncEngine? _syncEngine;
  final Uuid _uuid = const Uuid();
  Timer? _syncDebounceTimer;

  @override
  Stream<Either<Failure, List<WorkoutRoutine>>> watchRoutines() {
    try {
      // Watch a joined projection so updates in exercises/sets also refresh routines.
      return database
          .customSelect(
            '''
            SELECT r.id
            FROM routines r
            LEFT JOIN exercises e
              ON e.routine_id = r.id
             AND e.deleted_at IS NULL
            LEFT JOIN sets s
              ON s.exercise_id = e.id
             AND s.deleted_at IS NULL
            WHERE r.is_deleted = 0
              AND r.deleted_at IS NULL
            GROUP BY r.id
            ORDER BY r.sort_order ASC
            ''',
            readsFrom: {
              database.routines,
              database.exercises,
              database.sets,
            },
          )
          .watch()
          .asyncMap((_) async {
        try {
          final routines = await _loadActiveRoutinesWithExercises();

          return Either<Failure, List<WorkoutRoutine>>.right(routines);
        } catch (e) {
          return Either<Failure, List<WorkoutRoutine>>.left(
            DatabaseFailure(e.toString()),
          );
        }
      });
    } catch (e) {
      return Stream.value(
        Either<Failure, List<WorkoutRoutine>>.left(
          DatabaseFailure(e.toString()),
        ),
      );
    }
  }

  Future<List<WorkoutRoutine>> _loadActiveRoutinesWithExercises() async {
    final routineDataList = await (database.select(database.routines)
          ..where((routine) => routine.isDeleted.equals(false))
          ..where((routine) => routine.deletedAt.isNull())
          ..orderBy([(routine) => OrderingTerm.asc(routine.sortOrder)]))
        .get();

    final routines = <WorkoutRoutine>[];

    for (final routineData in routineDataList) {
      final exercises = await _fetchExercisesForRoutine(routineData.id);
      routines.add(_mapRoutineDataToEntity(routineData, exercises));
    }

    return routines;
  }

  @override
  Future<Either<Failure, WorkoutRoutine>> getRoutineById(String id) async {
    try {
      final routineData = await (database.select(database.routines)
        ..where((routine) => routine.id.equals(id))
        ..where((routine) => routine.deletedAt.isNull()))
          .getSingleOrNull();

      if (routineData == null) {
        return const Either<Failure, WorkoutRoutine>.left(
          DatabaseFailure('Routine not found'),
        );
      }

      final exercises = await _fetchExercisesForRoutine(id);
      return Either<Failure, WorkoutRoutine>.right(
        _mapRoutineDataToEntity(routineData, exercises),
      );
    } catch (e) {
      return Either<Failure, WorkoutRoutine>.left(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, void>> saveRoutine(WorkoutRoutine routine) async {
    try {
      await database.transaction(() async {
        final now = DateTime.now();
        final existingRoutine = await (database.select(database.routines)
              ..where((row) => row.id.equals(routine.id)))
            .getSingleOrNull();

        await database.into(database.routines).insertOnConflictUpdate(
              RoutinesCompanion.insert(
                id: routine.id,
                name: routine.name,
                sortOrder: routine.sortOrder,
                isDeleted: const Value(false),
                updatedAt: Value(now),
                deletedAt: const Value(null),
                syncStatus: const Value(SyncStatus.pending),
                remoteVersion: const Value(0),
              ),
            );

        await _enqueueOutboxChange(
          entityType: 'routine',
          entityId: routine.id,
          operation: existingRoutine == null ? 'create' : 'update',
          payload: {
            'id': routine.id,
            'name': routine.name,
            'sortOrder': routine.sortOrder,
          },
          createdAt: now,
        );

        final existingExercises = await (database.select(database.exercises)
              ..where((exercise) => exercise.routineId.equals(routine.id)))
            .get();

        final existingExerciseById = {
          for (final exercise in existingExercises) exercise.id: exercise,
        };

        final activeExerciseIds = existingExercises
            .where((exercise) => exercise.deletedAt == null)
            .map((exercise) => exercise.id)
            .toSet();

        final newExerciseIds = routine.exercises.map((e) => e.id).toSet();

        final exercisesToDelete = activeExerciseIds.difference(newExerciseIds);

        for (final exerciseId in exercisesToDelete) {
          await (database.update(database.exercises)
                ..where((exercise) => exercise.id.equals(exerciseId)))
              .write(
            ExercisesCompanion(
              updatedAt: Value(now),
              deletedAt: Value(now),
              syncStatus: const Value(SyncStatus.pending),
              remoteVersion: const Value(0),
            ),
          );

          await _enqueueOutboxChange(
            entityType: 'exercise',
            entityId: exerciseId,
            operation: 'delete',
            payload: {'id': exerciseId, 'routineId': routine.id},
            createdAt: now,
          );

          final activeSetsForDeletedExercise = await (database.select(database.sets)
                ..where((set) => set.exerciseId.equals(exerciseId))
                ..where((set) => set.deletedAt.isNull()))
              .get();

          for (final setRow in activeSetsForDeletedExercise) {
            await (database.update(database.sets)
                  ..where((set) => set.id.equals(setRow.id)))
                .write(
              SetsCompanion(
                updatedAt: Value(now),
                deletedAt: Value(now),
                syncStatus: const Value(SyncStatus.pending),
                remoteVersion: const Value(0),
              ),
            );

            await _enqueueOutboxChange(
              entityType: 'set',
              entityId: setRow.id,
              operation: 'delete',
              payload: {'id': setRow.id, 'exerciseId': exerciseId},
              createdAt: now,
            );
          }
        }

        for (final exercise in routine.exercises) {
          final existingExercise = existingExerciseById[exercise.id];

          await database.into(database.exercises).insertOnConflictUpdate(
                ExercisesCompanion.insert(
                  id: exercise.id,
                  routineId: routine.id,
                  name: exercise.name,
                  notes: Value(exercise.notes),
                  restTimeSeconds: exercise.restTimeSeconds,
                  sortOrder: exercise.sortOrder,
                  updatedAt: Value(now),
                  deletedAt: const Value(null),
                  syncStatus: const Value(SyncStatus.pending),
                  remoteVersion: const Value(0),
                ),
              );

          await _enqueueOutboxChange(
            entityType: 'exercise',
            entityId: exercise.id,
            operation: existingExercise == null ? 'create' : 'update',
            payload: {
              'id': exercise.id,
              'routineId': routine.id,
              'name': exercise.name,
              'notes': exercise.notes,
              'restTimeSeconds': exercise.restTimeSeconds,
              'sortOrder': exercise.sortOrder,
            },
            createdAt: now,
          );

          final existingSets = await (database.select(database.sets)
                ..where((set) => set.exerciseId.equals(exercise.id)))
              .get();

          final existingSetById = {
            for (final setRow in existingSets) setRow.id: setRow,
          };

          final activeSetIds = existingSets
              .where((setRow) => setRow.deletedAt == null)
              .map((setRow) => setRow.id)
              .toSet();

          final newSetIds = exercise.templateSets.map((s) => s.id).toSet();

          final setsToDelete = activeSetIds.difference(newSetIds);

          for (final setId in setsToDelete) {
            await (database.update(database.sets)
                  ..where((set) => set.id.equals(setId)))
                .write(
              SetsCompanion(
                updatedAt: Value(now),
                deletedAt: Value(now),
                syncStatus: const Value(SyncStatus.pending),
                remoteVersion: const Value(0),
              ),
            );

            await _enqueueOutboxChange(
              entityType: 'set',
              entityId: setId,
              operation: 'delete',
              payload: {'id': setId, 'exerciseId': exercise.id},
              createdAt: now,
            );
          }

          for (final set in exercise.templateSets) {
            final existingSet = existingSetById[set.id];

            await database.into(database.sets).insertOnConflictUpdate(
                  SetsCompanion.insert(
                    id: set.id,
                    exerciseId: exercise.id,
                    targetValue1: Value(set.targetValue1),
                    targetValue2: Value(set.targetValue2),
                    unit1: Value(set.unit1),
                    unit2: Value(set.unit2),
                    sortOrder: set.sortOrder,
                    updatedAt: Value(now),
                    deletedAt: const Value(null),
                    syncStatus: const Value(SyncStatus.pending),
                    remoteVersion: const Value(0),
                  ),
                );

            await _enqueueOutboxChange(
              entityType: 'set',
              entityId: set.id,
              operation: existingSet == null ? 'create' : 'update',
              payload: {
                'id': set.id,
                'exerciseId': exercise.id,
                'targetValue1': set.targetValue1,
                'targetValue2': set.targetValue2,
                'unit1': set.unit1?.name,
                'unit2': set.unit2?.name,
                'sortOrder': set.sortOrder,
              },
              createdAt: now,
            );
          }
        }
      });

      _scheduleAutoSync();

      return const Either<Failure, void>.right(null);
    } catch (e) {
      return Either<Failure, void>.left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRoutine(String id) async {
    try {
      final now = DateTime.now();
      await (database.update(database.routines)
            ..where((routine) => routine.id.equals(id)))
          .write(
        RoutinesCompanion(
          isDeleted: const Value(true),
          updatedAt: Value(now),
          deletedAt: Value(now),
          syncStatus: const Value(SyncStatus.pending),
          remoteVersion: const Value(0),
        ),
      );

      await _enqueueOutboxChange(
        entityType: 'routine',
        entityId: id,
        operation: 'delete',
        payload: {'id': id},
        createdAt: now,
      );

      _scheduleAutoSync();

      return const Either<Failure, void>.right(null);
    } catch (e) {
      return Either<Failure, void>.left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateRoutineOrder(
    List<WorkoutRoutine> routines,
  ) async {
    try {
      await database.transaction(() async {
        final now = DateTime.now();
        for (final routine in routines) {
          await (database.update(database.routines)
                ..where((row) => row.id.equals(routine.id)))
              .write(
            RoutinesCompanion(
              name: Value(routine.name),
              sortOrder: Value(routine.sortOrder),
              updatedAt: Value(now),
              syncStatus: const Value(SyncStatus.pending),
              remoteVersion: const Value(0),
            ),
          );

          await _enqueueOutboxChange(
            entityType: 'routine',
            entityId: routine.id,
            operation: 'update',
            payload: {
              'id': routine.id,
              'name': routine.name,
              'sortOrder': routine.sortOrder,
            },
            createdAt: now,
          );
        }
      });

      _scheduleAutoSync();

      return const Either<Failure, void>.right(null);
    } catch (e) {
      return Either<Failure, void>.left(DatabaseFailure(e.toString()));
    }
  }

                  @override
                  Stream<Either<Failure, List<WorkoutSession>>> watchSessions() {
                    try {
                      return (database.select(database.sessions)
                            ..where((session) => session.deletedAt.isNull()))
                          .watch()
                          .map((sessionDataList) {
                        try {
                          final sessions = sessionDataList
                              .map((sessionData) => _mapSessionDataToEntity(sessionData))
                              .toList();

                          return Either<Failure, List<WorkoutSession>>.right(sessions);
                        } catch (e) {
                          return Either<Failure, List<WorkoutSession>>.left(
                            DatabaseFailure(e.toString()),
                          );
                        }
                      });
                    } catch (e) {
                      return Stream.value(
                        Either<Failure, List<WorkoutSession>>.left(
                          DatabaseFailure(e.toString()),
                        ),
                      );
                    }
                  }

                  @override
                  Future<Either<Failure, WorkoutSession>> getSessionById(
                    String sessionId,
                  ) async {
                    try {
                      final sessionData = await (database.select(database.sessions)
                            ..where((session) => session.id.equals(sessionId))
                            ..where((session) => session.deletedAt.isNull()))
                          .getSingleOrNull();

                      if (sessionData == null) {
                        return const Either<Failure, WorkoutSession>.left(
                          DatabaseFailure('Session not found'),
                        );
                      }

                      return Either<Failure, WorkoutSession>.right(
                        _mapSessionDataToEntity(sessionData),
                      );
                    } catch (e) {
                      return Either<Failure, WorkoutSession>.left(
                        DatabaseFailure(e.toString()),
                      );
                    }
                  }

                  @override
                  Future<Either<Failure, WorkoutSession?>> getLatestActiveSessionForRoutine(
                    String routineId,
                  ) async {
                    try {
                      final twelveHoursAgo = DateTime.now().subtract(
                        const Duration(hours: 12),
                      );

                      final sessionData = await (database.select(database.sessions)
                            ..where((session) => session.routineId.equals(routineId))
                            ..where((session) => session.deletedAt.isNull())
                            ..where((session) => session.isCompleted.equals(false))
                            ..where(
                              (session) =>
                                  session.createdAt.isBiggerOrEqualValue(twelveHoursAgo),
                            )
                            ..orderBy([(session) => OrderingTerm.desc(session.createdAt)])
                            ..limit(1))
                          .getSingleOrNull();

                      return Either<Failure, WorkoutSession?>.right(
                        sessionData == null ? null : _mapSessionDataToEntity(sessionData),
                      );
                    } catch (e) {
                      return Either<Failure, WorkoutSession?>.left(
                        DatabaseFailure(e.toString()),
                      );
                    }
                  }

                  @override
                  Future<Either<Failure, void>> saveSession(WorkoutSession session) async {
                    try {
                      final now = DateTime.now();
                      final existing = await (database.select(database.sessions)
                            ..where((row) => row.id.equals(session.id)))
                          .getSingleOrNull();

                      await database.into(database.sessions).insertOnConflictUpdate(
                            SessionsCompanion.insert(
                              id: session.id,
                              routineId: session.routineId,
                              routineName: session.routineName,
                              createdAt: session.createdAt,
                              notes: Value(session.notes),
                              isCompleted: Value(session.isCompleted),
                              updatedAt: Value(now),
                              deletedAt: const Value(null),
                              syncStatus: const Value(SyncStatus.pending),
                              remoteVersion: const Value(0),
                            ),
                          );


                      await _enqueueOutboxChange(
                        entityType: 'session',
                        entityId: session.id,
                        operation: existing == null ? 'create' : 'update',
                        payload: {
                          'id': session.id,
                          'routineId': session.routineId,
                          'routineName': session.routineName,
                          'createdAt': session.createdAt.toIso8601String(),
                          'notes': session.notes,
                          'isCompleted': session.isCompleted,
                        },
                        createdAt: now,
                      );

                      _scheduleAutoSync();

                      return const Either<Failure, void>.right(null);
                    } catch (e) {
                      return Either<Failure, void>.left(DatabaseFailure(e.toString()));
                    }
                  }

                  @override
                  Future<Either<Failure, void>> deleteSession(String sessionId) async {
                    try {
                      final now = DateTime.now();
                      await (database.update(database.sessions)
                            ..where((session) => session.id.equals(sessionId)))
                          .write(
                        SessionsCompanion(
                          updatedAt: Value(now),
                          deletedAt: Value(now),
                          syncStatus: const Value(SyncStatus.pending),
                          remoteVersion: const Value(0),
                        ),
                      );

                      await _enqueueOutboxChange(
                        entityType: 'session',
                        entityId: sessionId,
                        operation: 'delete',
                        payload: {'id': sessionId},
                        createdAt: now,
                      );

                      _scheduleAutoSync();

                      return const Either<Failure, void>.right(null);
                    } catch (e) {
                      return Either<Failure, void>.left(DatabaseFailure(e.toString()));
                    }
                  }

                  @override
                  Future<Either<Failure, void>> finalizeStaleSessions() async {
                    try {
                      final twelveHoursAgo = DateTime.now().subtract(
                        const Duration(hours: 12),
                      );
                      final now = DateTime.now();

                      final staleSessionRows = await (database.select(database.sessions)
                            ..where((session) => session.deletedAt.isNull())
                            ..where((session) => session.isCompleted.equals(false))
                            ..where(
                              (session) => session.createdAt.isSmallerThanValue(twelveHoursAgo),
                            ))
                          .get();

                      for (final staleSessionRow in staleSessionRows) {
                        await (database.update(database.sessions)
                              ..where((session) => session.id.equals(staleSessionRow.id)))
                            .write(
                          SessionsCompanion(
                            isCompleted: const Value(true),
                            updatedAt: Value(now),
                            syncStatus: const Value(SyncStatus.pending),
                            remoteVersion: const Value(0),
                          ),
                        );

                        await _enqueueOutboxChange(
                          entityType: 'session',
                          entityId: staleSessionRow.id,
                          operation: 'update',
                          payload: {
                            'id': staleSessionRow.id,
                            'isCompleted': true,
                          },
                          createdAt: now,
                        );
                      }

                      if (staleSessionRows.isNotEmpty) {
                        _scheduleAutoSync();
                      }

                      return const Either<Failure, void>.right(null);
                    } catch (e) {
                      return Either<Failure, void>.left(DatabaseFailure(e.toString()));
                    }
                  }

                  @override
                  Future<Either<Failure, void>> saveSetLog(SetLog log) async {
                    try {
                      final now = DateTime.now();
                      final existing = await (database.select(database.setLogs)
                            ..where((row) => row.id.equals(log.id)))
                          .getSingleOrNull();

                      await database.into(database.setLogs).insertOnConflictUpdate(
                            SetLogsCompanion.insert(
                              id: log.id,
                              sessionId: log.sessionId,
                              workoutExerciseId: log.workoutExerciseId,
                              setNumber: log.setNumber,
                              actualValue1: Value(log.actualValue1),
                              actualValue2: Value(log.actualValue2),
                              unit1: Value(log.unit1),
                              unit2: Value(log.unit2),
                              isCompleted: log.isCompleted,
                              timestamp: log.timestamp,
                              updatedAt: Value(now),
                              deletedAt: const Value(null),
                              syncStatus: const Value(SyncStatus.pending),
                              remoteVersion: const Value(0),
                            ),
                          );

                      await _enqueueOutboxChange(
                        entityType: 'setLog',
                        entityId: log.id,
                        operation: existing == null ? 'create' : 'update',
                        payload: {
                          'id': log.id,
                          'sessionId': log.sessionId,
                          'workoutExerciseId': log.workoutExerciseId,
                          'setNumber': log.setNumber,
                          'actualValue1': log.actualValue1,
                          'actualValue2': log.actualValue2,
                          'unit1': log.unit1?.name,
                          'unit2': log.unit2?.name,
                          'isCompleted': log.isCompleted,
                          'timestamp': log.timestamp.toIso8601String(),
                        },
                        createdAt: now,
                      );

                      _scheduleAutoSync();

                      return const Either<Failure, void>.right(null);
                    } catch (e) {
                      return Either<Failure, void>.left(DatabaseFailure(e.toString()));
                    }
                  }

                  @override
                  Future<Either<Failure, List<SetLog>>> getLogsForSession(
                    String sessionId,
                  ) async {
                    try {
                      final logDataList = await (database.select(database.setLogs)
                            ..where((log) => log.sessionId.equals(sessionId))
                            ..where((log) => log.deletedAt.isNull()))
                          .get();

                      // Deduplicate by (workoutExerciseId, setNumber).
                      // Duplicates exist in Firebase from earlier bugs.
                      // Keep the first occurrence (oldest / original).
                      final seen = <String, SetLogData>{};
                      for (final log in logDataList) {
                        final key = '${log.workoutExerciseId}:${log.setNumber}';
                        if (!seen.containsKey(key)) {
                          seen[key] = log;
                        }
                      }
                      final dedupedList = seen.values.toList();

                      final logs = dedupedList
                          .map((logData) => _mapSetLogDataToEntity(logData))
                          .toList();
                      return Either<Failure, List<SetLog>>.right(logs);
                    } catch (e) {
                      return Either<Failure, List<SetLog>>.left(DatabaseFailure(e.toString()));
                    }
                  }

                  @override
                  Future<Either<Failure, List<SetLog>>> getLastCompletedLogsForRoutine(
                    String routineId, {
                    required String excludeSessionId,
                  }) async {
                    try {
                      final lastSession = await (database.select(database.sessions)
                            ..where((session) => session.routineId.equals(routineId))
                            ..where((session) => session.deletedAt.isNull())
                            ..where((session) => session.isCompleted.equals(true))
                            ..where((session) => session.id.equals(excludeSessionId).not())
                            ..orderBy([(session) => OrderingTerm.desc(session.createdAt)])
                            ..limit(1))
                          .getSingleOrNull();

                      if (lastSession == null) {
                        return const Either<Failure, List<SetLog>>.right(<SetLog>[]);
                      }

                      return getLogsForSession(lastSession.id);
                    } catch (e) {
                      return Either<Failure, List<SetLog>>.left(DatabaseFailure(e.toString()));
                    }
                  }

                  @override
                  Future<Either<Failure, List<ExerciseHistoryEntry>>> getExerciseHistory(
                    String workoutExerciseId,
                  ) async {
                    try {
                      final logDataList = await (database.select(database.setLogs)
                            ..where((log) => log.workoutExerciseId.equals(workoutExerciseId))
                            ..where((log) => log.deletedAt.isNull()))
                          .get();

                      if (logDataList.isEmpty) {
                        return const Either<Failure, List<ExerciseHistoryEntry>>.right(
                          <ExerciseHistoryEntry>[],
                        );
                      }

                      final sessionIds =
                          logDataList.map((log) => log.sessionId).toSet().toList();

                      final sessionRows = await (database.select(database.sessions)
                            ..where((session) => session.id.isIn(sessionIds))
                            ..where((session) => session.deletedAt.isNull())
                            ..where((session) => session.isCompleted.equals(true)))
                          .get();

                      final sessionDateById = {
                        for (final session in sessionRows) session.id: session.createdAt,
                      };

                      // Group logs by session, keeping only completed sessions.
                      final logsBySession = <String, List<SetLogData>>{};
                      for (final log in logDataList) {
                        if (!sessionDateById.containsKey(log.sessionId)) {
                          continue;
                        }
                        logsBySession.putIfAbsent(log.sessionId, () => []).add(log);
                      }

                      final entries = <ExerciseHistoryEntry>[];
                      logsBySession.forEach((sessionId, logs) {
                        // Deduplicate by set number, then order.
                        final seen = <int, SetLogData>{};
                        for (final log in logs) {
                          seen.putIfAbsent(log.setNumber, () => log);
                        }
                        final orderedSets = seen.values.toList()
                          ..sort((a, b) => a.setNumber.compareTo(b.setNumber));

                        entries.add(
                          ExerciseHistoryEntry(
                            sessionId: sessionId,
                            date: sessionDateById[sessionId]!,
                            sets: orderedSets
                                .map((log) => _mapSetLogDataToEntity(log))
                                .toList(),
                          ),
                        );
                      });

                      entries.sort((a, b) => b.date.compareTo(a.date));

                      return Either<Failure, List<ExerciseHistoryEntry>>.right(entries);
                    } catch (e) {
                      return Either<Failure, List<ExerciseHistoryEntry>>.left(
                        DatabaseFailure(e.toString()),
                      );
                    }
                  }

                  Future<List<WorkoutExercise>> _fetchExercisesForRoutine(
                    String routineId,
                  ) async {
                    final exerciseDataList = await (database.select(database.exercises)
                          ..where((exercise) => exercise.routineId.equals(routineId))
                          ..where((exercise) => exercise.deletedAt.isNull())
                          ..orderBy([(exercise) => OrderingTerm.asc(exercise.sortOrder)]))
                        .get();

                    final exercises = <WorkoutExercise>[];

                    for (final exerciseData in exerciseDataList) {
                      final setDataList = await (database.select(database.sets)
                            ..where((set) => set.exerciseId.equals(exerciseData.id))
                            ..where((set) => set.deletedAt.isNull())
                            ..orderBy([(set) => OrderingTerm.asc(set.sortOrder)]))
                          .get();

                      final templateSets =
                          setDataList.map((setData) => _mapSetDataToEntity(setData)).toList();

                      exercises.add(_mapExerciseDataToEntity(exerciseData, templateSets));
                    }

                    return exercises;
                  }

                  WorkoutRoutine _mapRoutineDataToEntity(
                    RoutineData data,
                    List<WorkoutExercise> exercises,
                  ) {
                    return WorkoutRoutine(
                      id: data.id,
                      name: data.name,
                      sortOrder: data.sortOrder,
                      exercises: exercises,
                      syncMetadata: _mapSyncMetadata(
                        updatedAt: data.updatedAt,
                        deletedAt: data.deletedAt,
                        syncStatus: data.syncStatus,
                        remoteVersion: data.remoteVersion,
                      ),
                    );
                  }

                  WorkoutExercise _mapExerciseDataToEntity(
                    ExerciseData data,
                    List<WorkoutSet> templateSets,
                  ) {
                    return WorkoutExercise(
                      id: data.id,
                      name: data.name,
                      sortOrder: data.sortOrder,
                      notes: data.notes,
                      restTimeSeconds: data.restTimeSeconds,
                      templateSets: templateSets,
                      syncMetadata: _mapSyncMetadata(
                        updatedAt: data.updatedAt,
                        deletedAt: data.deletedAt,
                        syncStatus: data.syncStatus,
                        remoteVersion: data.remoteVersion,
                      ),
                    );
                  }

                  WorkoutSet _mapSetDataToEntity(SetData data) {
                    return WorkoutSet(
                      id: data.id,
                      sortOrder: data.sortOrder,
                      targetValue1: data.targetValue1,
                      targetValue2: data.targetValue2,
                      unit1: data.unit1,
                      unit2: data.unit2,
                      syncMetadata: _mapSyncMetadata(
                        updatedAt: data.updatedAt,
                        deletedAt: data.deletedAt,
                        syncStatus: data.syncStatus,
                        remoteVersion: data.remoteVersion,
                      ),
                    );
                  }

                  WorkoutSession _mapSessionDataToEntity(SessionData data) {
                    return WorkoutSession(
                      id: data.id,
                      routineId: data.routineId,
                      routineName: data.routineName,
                      createdAt: data.createdAt,
                      notes: data.notes,
                      isCompleted: data.isCompleted,
                      syncMetadata: _mapSyncMetadata(
                        updatedAt: data.updatedAt,
                        deletedAt: data.deletedAt,
                        syncStatus: data.syncStatus,
                        remoteVersion: data.remoteVersion,
                      ),
                    );
                  }

                  SetLog _mapSetLogDataToEntity(SetLogData data) {
                    return SetLog(
                      id: data.id,
                      sessionId: data.sessionId,
                      workoutExerciseId: data.workoutExerciseId,
                      setNumber: data.setNumber,
                      actualValue1: data.actualValue1,
                      actualValue2: data.actualValue2,
                      unit1: data.unit1,
                      unit2: data.unit2,
                      isCompleted: data.isCompleted,
                      timestamp: data.timestamp,
                      syncMetadata: _mapSyncMetadata(
                        updatedAt: data.updatedAt,
                        deletedAt: data.deletedAt,
                        syncStatus: data.syncStatus,
                        remoteVersion: data.remoteVersion,
                      ),
                    );
                  }

                  @override
                  Future<Either<Failure, List<LibraryExerciseEntity>>>
                      getLibraryExercises() async {
                    try {
                      final data = await (database.select(database.libraryExercises)
                            ..where((exercise) => exercise.deletedAt.isNull()))
                          .get();
                      final exercises = _mapAndDedupeLibraryExercises(data);
                      return Either<Failure, List<LibraryExerciseEntity>>.right(exercises);
                    } catch (e) {
                      return Either<Failure, List<LibraryExerciseEntity>>.left(
                        DatabaseFailure(e.toString()),
                      );
                    }
                  }

                  @override
                  Future<Either<Failure, void>> saveLibraryExercise(
                    String name, {
                    String? nameEn,
                    String? nameEs,
                  }) async {
                    try {
                      final now = DateTime.now();
                      final localizedNameEn = nameEn ?? name;
                      final localizedNameEs = nameEs ?? name;

                      final existingExercises = await (database.select(
                        database.libraryExercises,
                      )
                            ..where((exercise) => exercise.deletedAt.isNull()))
                          .get();

                      final normalizedName = _normalizeLibraryExerciseName(name);
                      final existingExercise = existingExercises.where((exercise) {
                        return _normalizeLibraryExerciseName(exercise.name) ==
                                normalizedName ||
                            _normalizeLibraryExerciseName(exercise.nameEn) ==
                                normalizedName ||
                            _normalizeLibraryExerciseName(exercise.nameEs) ==
                                normalizedName;
                      }).firstOrNull;

                      if (existingExercise != null) {
                        return const Either<Failure, void>.right(null);
                      }

                      final id = _uuid.v4();

                      await database.into(database.libraryExercises).insert(
                            LibraryExercisesCompanion.insert(
                              id: id,
                              name: name,
                              nameEn: localizedNameEn,
                              nameEs: localizedNameEs,
                              isCustom: true,
                              category: const Value(null),
                              updatedAt: Value(now),
                              deletedAt: const Value(null),
                              syncStatus: const Value(SyncStatus.pending),
                              remoteVersion: const Value(0),
                            ),
                            mode: InsertMode.insertOrIgnore,
                          );

                      await _enqueueOutboxChange(
                        entityType: 'libraryExercise',
                        entityId: id,
                        operation: 'create',
                        payload: {
                          'id': id,
                          'name': name,
                          'nameEn': localizedNameEn,
                          'nameEs': localizedNameEs,
                          'isCustom': true,
                        },
                        createdAt: now,
                      );

                      _scheduleAutoSync();

                      return const Either<Failure, void>.right(null);
                    } catch (e) {
                      return Either<Failure, void>.left(DatabaseFailure(e.toString()));
                    }
                  }

                  @override
                  Future<Either<Failure, void>> updateLibraryExercise(
                    String id,
                    String name, {
                    String? nameEn,
                    String? nameEs,
                  }) async {
                    try {
                      final now = DateTime.now();
                      final localizedNameEn = nameEn ?? name;
                      final localizedNameEs = nameEs ?? name;

                      await (database.update(database.libraryExercises)
                            ..where((exercise) => exercise.id.equals(id)))
                          .write(
                        LibraryExercisesCompanion(
                          name: Value(name),
                          nameEn: Value(localizedNameEn),
                          nameEs: Value(localizedNameEs),
                          updatedAt: Value(now),
                          deletedAt: const Value(null),
                          syncStatus: const Value(SyncStatus.pending),
                          remoteVersion: const Value(0),
                        ),
                      );

                      await _enqueueOutboxChange(
                        entityType: 'libraryExercise',
                        entityId: id,
                        operation: 'update',
                        payload: {
                          'id': id,
                          'name': name,
                          'nameEn': localizedNameEn,
                          'nameEs': localizedNameEs,
                        },
                        createdAt: now,
                      );

                      _scheduleAutoSync();

                      return const Either<Failure, void>.right(null);
                    } catch (e) {
                      return Either<Failure, void>.left(DatabaseFailure(e.toString()));
                    }
                  }

                  @override
                  Future<Either<Failure, void>> deleteLibraryExercise(String id) async {
                    try {
                      final now = DateTime.now();

                      final activeRows = await (database.select(
                        database.libraryExercises,
                      )
                            ..where((exercise) => exercise.deletedAt.isNull()))
                          .get();

                      // The list shows one entry per name group, so deleting that
                      // entry has to remove every row behind it. Otherwise a merged
                      // duplicate would resurface as soon as its twin disappears.
                      final group = _groupLibraryExercisesByName(activeRows)
                          .where((rows) => rows.any((row) => row.id == id))
                          .firstOrNull;

                      final idsToDelete =
                          group?.map((row) => row.id).toList() ?? <String>[id];

                      for (final exerciseId in idsToDelete) {
                        await (database.update(database.libraryExercises)
                              ..where((exercise) => exercise.id.equals(exerciseId)))
                            .write(
                          LibraryExercisesCompanion(
                            updatedAt: Value(now),
                            deletedAt: Value(now),
                            syncStatus: const Value(SyncStatus.pending),
                            remoteVersion: const Value(0),
                          ),
                        );

                        await _enqueueOutboxChange(
                          entityType: 'libraryExercise',
                          entityId: exerciseId,
                          operation: 'delete',
                          payload: {'id': exerciseId},
                          createdAt: now,
                        );
                      }

                      _scheduleAutoSync();

                      return const Either<Failure, void>.right(null);
                    } catch (e) {
                      return Either<Failure, void>.left(DatabaseFailure(e.toString()));
                    }
                  }

                  @override
                  Future<Either<Failure, List<LibraryExerciseEntity>>> searchLibraryExercises(
                    String query,
                    String languageCode,
                  ) async {
                    try {
                      final allExercises = await (database.select(database.libraryExercises)
                            ..where((exercise) => exercise.deletedAt.isNull()))
                          .get();
                      final lowerQuery = query.trim().toLowerCase();

                      // Merge first, then match on the name the picker will actually
                      // render, so a hit on a duplicate row cannot surface it as a
                      // separate result.
                      final exercises = _mapAndDedupeLibraryExercises(allExercises)
                          .where(
                            (exercise) => exercise
                                .getLocalizedName(languageCode)
                                .toLowerCase()
                                .contains(lowerQuery),
                          )
                          .toList();

                      return Either<Failure, List<LibraryExerciseEntity>>.right(exercises);
                    } catch (e) {
                      return Either<Failure, List<LibraryExerciseEntity>>.left(
                        DatabaseFailure(e.toString()),
                      );
                    }
                  }

                  Future<void> _enqueueOutboxChange({
                    required String entityType,
                    required String entityId,
                    required String operation,
                    required Map<String, dynamic> payload,
                    required DateTime createdAt,
                  }) async {
                    await database.into(database.outboxChanges).insert(
                          OutboxChangesCompanion.insert(
                            id: _uuid.v4(),
                            entityType: entityType,
                            entityId: entityId,
                            operation: operation,
                            payloadJson: jsonEncode(payload),
                            createdAt: createdAt,
                          ),
                        );
                  }

                  /// Returns one entity per exercise, merging rows that describe the
                  /// same movement.
                  ///
                  /// Older builds created a custom row every time an exercise was
                  /// added to a routine, storing the localized name in all three name
                  /// columns. Such a row overlaps the seeded catalog entry on a single
                  /// field only — "Elevaciones Laterales" three times, against
                  /// "Lateral Raise"/"Lateral Raise"/"Elevaciones Laterales" — so
                  /// keying the dedupe on the whole name triple left both rows visible
                  /// and the picker showed the exercise twice.
                  List<LibraryExerciseEntity> _mapAndDedupeLibraryExercises(
                    List<LibraryExerciseData> rows,
                  ) {
                    final entities = _groupLibraryExercisesByName(rows)
                        .map(_pickLibraryExerciseRepresentative)
                        .map(_mapLibraryExerciseDataToEntity)
                        .toList()
                      ..sort(
                        (a, b) =>
                            a.nameEs.toLowerCase().compareTo(b.nameEs.toLowerCase()),
                      );

                    return entities;
                  }

                  /// Buckets rows that share at least one name, in any language. Rows
                  /// link transitively: if A shares a name with B and B with C, all
                  /// three name the same exercise and collapse into one entry.
                  List<List<LibraryExerciseData>> _groupLibraryExercisesByName(
                    List<LibraryExerciseData> rows,
                  ) {
                    // Union-find over row positions, joined through shared names.
                    final parent = List<int>.generate(rows.length, (index) => index);

                    int findRoot(int index) {
                      var current = index;
                      while (parent[current] != current) {
                        parent[current] = parent[parent[current]];
                        current = parent[current];
                      }
                      return current;
                    }

                    void union(int a, int b) {
                      final rootA = findRoot(a);
                      final rootB = findRoot(b);
                      if (rootA != rootB) {
                        parent[rootB] = rootA;
                      }
                    }

                    final firstRowByName = <String, int>{};
                    for (var index = 0; index < rows.length; index++) {
                      for (final key in _libraryExerciseNameKeys(rows[index])) {
                        final owner = firstRowByName[key];
                        if (owner == null) {
                          firstRowByName[key] = index;
                        } else {
                          union(owner, index);
                        }
                      }
                    }

                    final groupsByRoot = <int, List<LibraryExerciseData>>{};
                    for (var index = 0; index < rows.length; index++) {
                      groupsByRoot
                          .putIfAbsent(findRoot(index), () => <LibraryExerciseData>[])
                          .add(rows[index]);
                    }

                    return groupsByRoot.values.toList();
                  }

                  /// Picks the row that stands for a group: the seeded catalog entry
                  /// when there is one, because it is the only row carrying both
                  /// translations, otherwise the most recently updated row.
                  LibraryExerciseData _pickLibraryExerciseRepresentative(
                    List<LibraryExerciseData> group,
                  ) {
                    final sorted = [...group]..sort((a, b) {
                        if (a.isCustom != b.isCustom) {
                          return a.isCustom ? 1 : -1;
                        }
                        return b.updatedAt.compareTo(a.updatedAt);
                      });

                    return sorted.first;
                  }

                  Set<String> _libraryExerciseNameKeys(LibraryExerciseData row) {
                    return <String>{
                      _normalizeLibraryExerciseName(row.name),
                      _normalizeLibraryExerciseName(row.nameEn),
                      _normalizeLibraryExerciseName(row.nameEs),
                    }..removeWhere((key) => key.isEmpty);
                  }

                  LibraryExerciseEntity _mapLibraryExerciseDataToEntity(
                    LibraryExerciseData row,
                  ) {
                    return LibraryExerciseEntity(
                      id: row.id,
                      name: row.name,
                      nameEn: row.nameEn,
                      nameEs: row.nameEs,
                      isCustom: row.isCustom,
                      syncMetadata: _mapSyncMetadata(
                        updatedAt: row.updatedAt,
                        deletedAt: row.deletedAt,
                        syncStatus: row.syncStatus,
                        remoteVersion: row.remoteVersion,
                      ),
                    );
                  }

                  String _normalizeLibraryExerciseName(String value) {
                    return value.trim().toLowerCase();
                  }

                  void _scheduleAutoSync() {
                    final syncEngine = _syncEngine;
                    if (syncEngine == null) {
                      return;
                    }

                    _syncDebounceTimer?.cancel();
                    _syncDebounceTimer = Timer(
                      const Duration(milliseconds: 700),
                      () {
                        unawaited(syncEngine.triggerManualSync());
                      },
                    );
                  }

                  SyncMetadata _mapSyncMetadata({
                    required DateTime updatedAt,
                    required DateTime? deletedAt,
                    required SyncStatus syncStatus,
                    required int remoteVersion,
                  }) {
                    return SyncMetadata(
                      updatedAt: updatedAt,
                      deletedAt: deletedAt,
                      syncStatus: syncStatus.name,
                      remoteVersion: remoteVersion,
                    );
                  }
                }
