import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../domain/entities/workout_entities.dart';

part 'workout_database.g.dart';

enum SyncStatus {
  pending,
  synced,
  failed,
}

@DataClassName('RoutineData')
class Routines extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get sortOrder => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get syncStatus =>
      intEnum<SyncStatus>().withDefault(Constant(SyncStatus.synced.index))();
  IntColumn get remoteVersion => integer().withDefault(const Constant(0))();

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
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get syncStatus =>
      intEnum<SyncStatus>().withDefault(Constant(SyncStatus.synced.index))();
  IntColumn get remoteVersion => integer().withDefault(const Constant(0))();

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
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get syncStatus =>
      intEnum<SyncStatus>().withDefault(Constant(SyncStatus.synced.index))();
  IntColumn get remoteVersion => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SessionData')
class Sessions extends Table {
  TextColumn get id => text()();
  TextColumn get routineId => text().references(Routines, #id)();
  TextColumn get routineName => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get syncStatus =>
      intEnum<SyncStatus>().withDefault(Constant(SyncStatus.synced.index))();
  IntColumn get remoteVersion => integer().withDefault(const Constant(0))();

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
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get syncStatus =>
      intEnum<SyncStatus>().withDefault(Constant(SyncStatus.synced.index))();
  IntColumn get remoteVersion => integer().withDefault(const Constant(0))();

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
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get syncStatus =>
      intEnum<SyncStatus>().withDefault(Constant(SyncStatus.synced.index))();
  IntColumn get remoteVersion => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('OutboxChangeData')
class OutboxChanges extends Table {
  TextColumn get id => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get operation => text()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();

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

@DriftDatabase(tables: [
  Routines,
  Exercises,
  Sets,
  Sessions,
  SetLogs,
  LibraryExercises,
  OutboxChanges,
],)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : this._(_openConnection());

  AppDatabase.forExecutor(QueryExecutor executor) : this._(executor);

  AppDatabase._(super.executor);

  @override
  int get schemaVersion => AppConstants.databaseVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _createSyncIndexes();
        await _createTrainingDefaultsTable();
        await _seedTrainingDefaults();
        await _seedLibraryExercises();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await _migrateV1ToV2(m);
        }
        if (from < 3) {
          await _migrateV2ToV3();
        }
        if (from < 4) {
          await _migrateV3ToV4();
        }
      },
    );
  }

  Future<void> _migrateV3ToV4() async {
    await customStatement(
      'ALTER TABLE training_defaults ADD COLUMN auto_start_rest_timer_on_set_completed INTEGER NOT NULL DEFAULT 0',
    );
  }

  Future<void> _migrateV2ToV3() async {
    await _createTrainingDefaultsTable();
    await _seedTrainingDefaults();
  }

  Future<void> _migrateV1ToV2(Migrator m) async {
    await _addSyncColumns('routines');
    await _addSyncColumns('exercises');
    await _addSyncColumns('sets');
    await _addSyncColumns('sessions');
    await _addSyncColumns('set_logs');
    await _addSyncColumns('library_exercises');

    await m.createTable(outboxChanges);
    await _createSyncIndexes();

    final nowEpochSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final synced = SyncStatus.synced.index;

    await customStatement(
      'UPDATE routines SET updated_at = ?, deleted_at = NULL, sync_status = ?, remote_version = 0',
      [nowEpochSeconds, synced],
    );
    await customStatement(
      'UPDATE exercises SET updated_at = ?, deleted_at = NULL, sync_status = ?, remote_version = 0',
      [nowEpochSeconds, synced],
    );
    await customStatement(
      'UPDATE sets SET updated_at = ?, deleted_at = NULL, sync_status = ?, remote_version = 0',
      [nowEpochSeconds, synced],
    );
    await customStatement(
      'UPDATE sessions SET updated_at = ?, deleted_at = NULL, sync_status = ?, remote_version = 0',
      [nowEpochSeconds, synced],
    );
    await customStatement(
      'UPDATE set_logs SET updated_at = ?, deleted_at = NULL, sync_status = ?, remote_version = 0',
      [nowEpochSeconds, synced],
    );
    await customStatement(
      'UPDATE library_exercises SET updated_at = ?, deleted_at = NULL, sync_status = ?, remote_version = 0',
      [nowEpochSeconds, synced],
    );
  }

  Future<void> _addSyncColumns(String tableName) async {
    await customStatement('ALTER TABLE $tableName ADD COLUMN updated_at INTEGER');
    await customStatement('ALTER TABLE $tableName ADD COLUMN deleted_at INTEGER');
    await customStatement(
      'ALTER TABLE $tableName ADD COLUMN sync_status INTEGER NOT NULL DEFAULT 0',
    );
    await customStatement(
      'ALTER TABLE $tableName ADD COLUMN remote_version INTEGER NOT NULL DEFAULT 0',
    );
  }

  Future<void> _createSyncIndexes() async {
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_library_exercises_deleted_at ON library_exercises(deleted_at)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_outbox_created_at ON outbox_changes(created_at)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_outbox_entity_type_entity_id ON outbox_changes(entity_type, entity_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_outbox_retry_count ON outbox_changes(retry_count)',
    );
  }

  Future<void> _createTrainingDefaultsTable() async {
    await customStatement(
      '''
      CREATE TABLE IF NOT EXISTS training_defaults (
        id INTEGER PRIMARY KEY CHECK(id = 1),
        default_rest_seconds INTEGER NOT NULL,
        default_repetitions INTEGER NOT NULL,
        default_weight REAL NOT NULL,
        auto_start_rest_timer_on_set_completed INTEGER NOT NULL DEFAULT 0,
        updated_at INTEGER NOT NULL
      )
      ''',
    );
  }

  Future<void> _seedTrainingDefaults() async {
    const seededEpoch = 0;
    await customStatement(
      '''
      INSERT OR IGNORE INTO training_defaults (
        id,
        default_rest_seconds,
        default_repetitions,
        default_weight,
        auto_start_rest_timer_on_set_completed,
        updated_at
      ) VALUES (1, 120, 12, -1.0, 0, ?)
      ''',
      [seededEpoch],
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
          updatedAt: Value(DateTime.now()),
          syncStatus: const Value(SyncStatus.synced),
          remoteVersion: const Value(0),
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
