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
  TextColumn get routineId =>
      text().references(Routines, #id, onDelete: KeyAction.cascade)();
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
  TextColumn get exerciseId =>
      text().references(Exercises, #id, onDelete: KeyAction.cascade)();
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
  TextColumn get sessionId =>
      text().references(Sessions, #id, onDelete: KeyAction.cascade)();
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

@DataClassName('LibraryExerciseData')
class LibraryExercises extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameEs => text()();
  BoolColumn get isCustom => boolean()();
  IntColumn get category => intEnum<ExerciseCategory>().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

enum ExerciseCategory {
  chest,
  back,
  shoulders,
  arms,
  legs,
  core,
  cardio,
  fullBody,
}

@DriftDatabase(
    tables: [Routines, Exercises, Sets, Sessions, SetLogs, LibraryExercises])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => AppConstants.databaseVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedLibraryExercises();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(libraryExercises);
          await _seedLibraryExercises();
        }
      },
    );
  }

  Future<void> _seedLibraryExercises() async {
    final exercises = [
      ('Bench Press', 'Press de Banca', ExerciseCategory.chest),
      ('Incline Bench Press', 'Press Inclinado', ExerciseCategory.chest),
      ('Decline Bench Press', 'Press Declinado', ExerciseCategory.chest),
      ('Dumbbell Fly', 'Aperturas con Mancuernas', ExerciseCategory.chest),
      ('Push-ups', 'Flexiones', ExerciseCategory.chest),
      ('Chest Dips', 'Fondos en Paralelas', ExerciseCategory.chest),
      ('Pull-up', 'Dominadas', ExerciseCategory.back),
      ('Chin-up', 'Dominadas Supinas', ExerciseCategory.back),
      ('Barbell Row', 'Remo con Barra', ExerciseCategory.back),
      ('Dumbbell Row', 'Remo con Mancuerna', ExerciseCategory.back),
      ('Lat Pulldown', 'Jalón al Pecho', ExerciseCategory.back),
      ('Deadlift', 'Peso Muerto', ExerciseCategory.back),
      ('T-Bar Row', 'Remo en T', ExerciseCategory.back),
      ('Overhead Press', 'Press Militar', ExerciseCategory.shoulders),
      ('Lateral Raise', 'Elevaciones Laterales', ExerciseCategory.shoulders),
      ('Front Raise', 'Elevaciones Frontales', ExerciseCategory.shoulders),
      ('Rear Delt Fly', 'Aperturas Posteriores', ExerciseCategory.shoulders),
      ('Arnold Press', 'Press Arnold', ExerciseCategory.shoulders),
      ('Shrugs', 'Encogimientos', ExerciseCategory.shoulders),
      ('Barbell Curl', 'Curl con Barra', ExerciseCategory.arms),
      ('Dumbbell Curl', 'Curl con Mancuerna', ExerciseCategory.arms),
      ('Hammer Curl', 'Curl Martillo', ExerciseCategory.arms),
      ('Preacher Curl', 'Curl en Banco Scott', ExerciseCategory.arms),
      (
        'Triceps Pushdown',
        'Extensión de Tríceps en Polea',
        ExerciseCategory.arms
      ),
      (
        'Overhead Triceps Extension',
        'Extensión de Tríceps sobre Cabeza',
        ExerciseCategory.arms
      ),
      ('Triceps Dips', 'Fondos de Tríceps', ExerciseCategory.arms),
      ('Close-Grip Bench Press', 'Press Cerrado', ExerciseCategory.arms),
      ('Squat', 'Sentadilla', ExerciseCategory.legs),
      ('Front Squat', 'Sentadilla Frontal', ExerciseCategory.legs),
      ('Leg Press', 'Prensa de Piernas', ExerciseCategory.legs),
      ('Leg Extension', 'Extensión de Cuádriceps', ExerciseCategory.legs),
      ('Leg Curl', 'Curl Femoral', ExerciseCategory.legs),
      ('Romanian Deadlift', 'Peso Muerto Rumano', ExerciseCategory.legs),
      ('Lunges', 'Zancadas', ExerciseCategory.legs),
      ('Bulgarian Split Squat', 'Sentadilla Búlgara', ExerciseCategory.legs),
      ('Calf Raise', 'Elevación de Talones', ExerciseCategory.legs),
      ('Hip Thrust', 'Empuje de Cadera', ExerciseCategory.legs),
      ('Plank', 'Plancha', ExerciseCategory.core),
      ('Crunches', 'Abdominales', ExerciseCategory.core),
      ('Russian Twist', 'Giro Ruso', ExerciseCategory.core),
      ('Leg Raise', 'Elevación de Piernas', ExerciseCategory.core),
      ('Mountain Climbers', 'Escaladores', ExerciseCategory.core),
      ('Bicycle Crunches', 'Abdominales Bicicleta', ExerciseCategory.core),
      ('Running', 'Correr', ExerciseCategory.cardio),
      ('Cycling', 'Ciclismo', ExerciseCategory.cardio),
      ('Rowing', 'Remo', ExerciseCategory.cardio),
      ('Jump Rope', 'Saltar la Cuerda', ExerciseCategory.cardio),
      ('Burpees', 'Burpees', ExerciseCategory.fullBody),
      ('Thrusters', 'Thrusters', ExerciseCategory.fullBody),
      ('Clean and Jerk', 'Cargada y Envión', ExerciseCategory.fullBody),
      ('Snatch', 'Arrancada', ExerciseCategory.fullBody),
    ];

    for (final exercise in exercises) {
      final id = exercise.$1.toLowerCase().replaceAll(' ', '_');
      await into(libraryExercises).insert(
        LibraryExercisesCompanion.insert(
          id: id,
          name: exercise.$1,
          nameEn: exercise.$1,
          nameEs: exercise.$2,
          isCustom: false,
          category: Value(exercise.$3),
        ),
        mode: InsertMode.insertOrIgnore,
      );
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final databaseFolder = await getApplicationDocumentsDirectory();
    final databaseFile =
        File(path.join(databaseFolder.path, AppConstants.databaseName));
    return NativeDatabase(databaseFile);
  });
}
