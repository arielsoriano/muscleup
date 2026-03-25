import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/repositories/workout_repository.dart';
import '../datasources/local/workout_database.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  const WorkoutRepositoryImpl(this.database);

  final AppDatabase database;
  final Uuid _uuid = const Uuid();

  @override
  Stream<Either<Failure, List<WorkoutRoutine>>> watchRoutines() {
    try {
      return (database.select(database.routines)
        ..where((routine) => routine.isDeleted.equals(false))
        ..where((routine) => routine.deletedAt.isNull()))
          .watch()
          .asyncMap((routineDataList) async {
        try {
          final routines = <WorkoutRoutine>[];

          for (final routineData in routineDataList) {
            final exercises = await _fetchExercisesForRoutine(routineData.id);
            routines.add(_mapRoutineDataToEntity(routineData, exercises));
          }

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

                      final logs = logDataList
                          .map((logData) => _mapSetLogDataToEntity(logData))
                          .toList();
                      return Either<Failure, List<SetLog>>.right(logs);
                    } catch (e) {
                      return Either<Failure, List<SetLog>>.left(DatabaseFailure(e.toString()));
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
                      final exercises = data.map((exerciseData) {
                        return LibraryExerciseEntity(
                          id: exerciseData.id,
                          name: exerciseData.name,
                          nameEn: exerciseData.nameEn,
                          nameEs: exerciseData.nameEs,
                          isCustom: exerciseData.isCustom,
                          syncMetadata: _mapSyncMetadata(
                            updatedAt: exerciseData.updatedAt,
                            deletedAt: exerciseData.deletedAt,
                            syncStatus: exerciseData.syncStatus,
                            remoteVersion: exerciseData.remoteVersion,
                          ),
                        );
                      }).toList();
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
                      final id = _uuid.v4();
                      final localizedNameEn = nameEn ?? name;
                      final localizedNameEs = nameEs ?? name;

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
                      final lowerQuery = query.toLowerCase();

                      final filtered = allExercises.where((exercise) {
                        final searchName = languageCode == 'es'
                            ? exercise.nameEs.toLowerCase()
                            : exercise.nameEn.toLowerCase();
                        return searchName.contains(lowerQuery);
                      }).toList();

                      final exercises = filtered.map((exerciseData) {
                        return LibraryExerciseEntity(
                          id: exerciseData.id,
                          name: exerciseData.name,
                          nameEn: exerciseData.nameEn,
                          nameEs: exerciseData.nameEs,
                          isCustom: exerciseData.isCustom,
                          syncMetadata: _mapSyncMetadata(
                            updatedAt: exerciseData.updatedAt,
                            deletedAt: exerciseData.deletedAt,
                            syncStatus: exerciseData.syncStatus,
                            remoteVersion: exerciseData.remoteVersion,
                          ),
                        );
                      }).toList();

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
