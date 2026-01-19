import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
 import '../../domain/entities/workout_entities.dart';
import '../../domain/repositories/workout_repository.dart';
import '../datasources/local/workout_database.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  WorkoutRepositoryImpl(this.database);

  final AppDatabase database;

  @override
  Stream<Either<Failure, List<WorkoutRoutine>>> watchRoutines() {
    try {
      return (database.select(database.routines)
            ..where((routine) => routine.isDeleted.equals(false)))
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
            ..where((routine) => routine.id.equals(id)))
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
        await database.into(database.routines).insertOnConflictUpdate(
              RoutinesCompanion.insert(
                id: routine.id,
                name: routine.name,
                sortOrder: routine.sortOrder,
                isDeleted: const Value(false),
              ),
            );

        await (database.delete(database.exercises)
              ..where((exercise) => exercise.routineId.equals(routine.id)))
            .go();

        for (final exercise in routine.exercises) {
          await database.into(database.exercises).insert(
                ExercisesCompanion.insert(
                  id: exercise.id,
                  routineId: routine.id,
                  name: exercise.name,
                  notes: Value(exercise.notes),
                  restTimeSeconds: exercise.restTimeSeconds,
                  sortOrder: exercise.sortOrder,
                ),
              );

          for (final set in exercise.templateSets) {
            await database.into(database.sets).insert(
                  SetsCompanion.insert(
                    id: set.id,
                    exerciseId: exercise.id,
                    targetValue1: Value(set.targetValue1),
                    targetValue2: Value(set.targetValue2),
                    unit1: Value(set.unit1),
                    unit2: Value(set.unit2),
                    sortOrder: set.sortOrder,
                  ),
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
      await (database.update(database.routines)
            ..where((routine) => routine.id.equals(id)))
          .write(const RoutinesCompanion(
        isDeleted: Value(true),
      ),);
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
        for (final routine in routines) {
          await database.update(database.routines).replace(
                RoutinesCompanion.insert(
                  id: routine.id,
                  name: routine.name,
                  sortOrder: routine.sortOrder,
                ),
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
      return database.select(database.sessions).watch().map((sessionDataList) {
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
  Future<Either<Failure, void>> saveSession(WorkoutSession session) async {
    try {
      await database.into(database.sessions).insertOnConflictUpdate(
            SessionsCompanion.insert(
              id: session.id,
              routineId: session.routineId,
              routineName: session.routineName,
              date: session.date,
              notes: Value(session.notes),
            ),
          );
      return const Either<Failure, void>.right(null);
    } catch (e) {
      return Either<Failure, void>.left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSession(String sessionId) async {
    try {
      await (database.delete(database.sessions)
            ..where((session) => session.id.equals(sessionId)))
          .go();
      return const Either<Failure, void>.right(null);
    } catch (e) {
      return Either<Failure, void>.left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveSetLog(SetLog log) async {
    try {
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
            ),
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
            ..where((log) => log.sessionId.equals(sessionId)))
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
          ..orderBy([(exercise) => OrderingTerm.asc(exercise.sortOrder)]))
        .get();

    final exercises = <WorkoutExercise>[];

    for (final exerciseData in exerciseDataList) {
      final setDataList = await (database.select(database.sets)
            ..where((set) => set.exerciseId.equals(exerciseData.id))
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
    );
  }

  WorkoutSession _mapSessionDataToEntity(SessionData data) {
    return WorkoutSession(
      id: data.id,
      routineId: data.routineId,
      routineName: data.routineName,
      date: data.date,
      notes: data.notes,
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
    );
  }

  @override
  Future<Either<Failure, List<LibraryExerciseEntity>>> getLibraryExercises() async {
    try {
      final data = await database.select(database.libraryExercises).get();
      final exercises = data.map((exerciseData) {
        return LibraryExerciseEntity(
          id: exerciseData.id,
          name: exerciseData.name,
          nameEn: exerciseData.nameEn,
          nameEs: exerciseData.nameEs,
          isCustom: exerciseData.isCustom,
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
      final id = const Uuid().v4();
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
            ),
            mode: InsertMode.insertOrIgnore,
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
      final allExercises = await database.select(database.libraryExercises).get();
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
        );
      }).toList();

      return Either<Failure, List<LibraryExerciseEntity>>.right(exercises);
    } catch (e) {
      return Either<Failure, List<LibraryExerciseEntity>>.left(
        DatabaseFailure(e.toString()),
      );
    }
  }
}
