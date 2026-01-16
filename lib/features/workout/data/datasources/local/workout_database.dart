import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../domain/entities/workout_entities.dart';

part 'workout_database.g.dart';

@DataClassName('RoutineData')
class Routines extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ExerciseData')
class Exercises extends Table {
  TextColumn get id => text()();
  TextColumn get routineId => text().references(Routines, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get notes => text().nullable()();
  IntColumn get restTimeSeconds => integer()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SetData')
class Sets extends Table {
  TextColumn get id => text()();
  TextColumn get exerciseId => text().references(Exercises, #id, onDelete: KeyAction.cascade)();
  RealColumn get targetValue1 => real().nullable()();
  RealColumn get targetValue2 => real().nullable()();
  IntColumn get unit1 => intEnum<WorkoutUnit>().nullable()();
  IntColumn get unit2 => intEnum<WorkoutUnit>().nullable()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SessionData')
class Sessions extends Table {
  TextColumn get id => text()();
  TextColumn get routineId => text().references(Routines, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SetLogData')
class SetLogs extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text().references(Sessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get workoutExerciseId => text()();
  IntColumn get setNumber => integer()();
  RealColumn get actualValue1 => real().nullable()();
  RealColumn get actualValue2 => real().nullable()();
  IntColumn get unit1 => intEnum<WorkoutUnit>().nullable()();
  IntColumn get unit2 => intEnum<WorkoutUnit>().nullable()();
  BoolColumn get isCompleted => boolean()();
  DateTimeColumn get timestamp => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [Routines, Exercises, Sets, Sessions, SetLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => AppConstants.databaseVersion;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final databaseFolder = await getApplicationDocumentsDirectory();
    final databaseFile = File(path.join(databaseFolder.path, AppConstants.databaseName));
    return NativeDatabase(databaseFile);
  });
}
