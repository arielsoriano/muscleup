import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/exercise_library.dart';
import '../../../../../core/l10n/localized_text.dart';
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

  /// The catalog entry this exercise came from, as its canonical English name,
  /// or null for an exercise the user typed in themselves. The displayed name
  /// is resolved from this, so a routine reads in the language the app is
  /// currently set to rather than the one it was built in.
  TextColumn get canonicalName => text().nullable()();

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

  /// The canonical name, language-independent, used to identify the exercise.
  TextColumn get name => text()();

  /// Every translated name, as a JSON object keyed by language code. Adding a
  /// language adds keys here instead of columns to this table.
  TextColumn get namesJson => text().withDefault(const Constant('{}'))();

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
        if (from < 5) {
          await _migrateV4ToV5(m);
        }
        if (from < 6) {
          await _migrateV5ToV6();
        }
      },
      beforeOpen: (details) async {
        await syncSeededExerciseCatalog();
      },
    );
  }

  /// Links routine exercises back to the catalog entry they came from.
  ///
  /// Until now a routine stored only the translated text that was on screen
  /// when the exercise was added, so a routine built in Spanish stayed in
  /// Spanish no matter what language the app was switched to. Existing rows are
  /// matched against every known translation of the catalog, which recovers the
  /// link for routines that were built before this column existed.
  Future<void> _migrateV5ToV6() async {
    await customStatement(
      'ALTER TABLE exercises ADD COLUMN canonical_name TEXT NULL',
    );

    final rows =
        await customSelect('SELECT id, name FROM exercises').get();

    for (final row in rows) {
      final canonical =
          ExerciseLibrary.canonicalNameFor(row.read<String>('name'));
      // No match means the user typed this exercise in themselves. It keeps its
      // own name and canonical_name stays null.
      if (canonical == null) {
        continue;
      }

      await customStatement(
        'UPDATE exercises SET canonical_name = ? WHERE id = ?',
        [canonical, row.read<String>('id')],
      );
    }
  }

  /// Replaces the fixed `name_en` / `name_es` columns with a single JSON map of
  /// translations, so future languages need no further schema change.
  Future<void> _migrateV4ToV5(Migrator m) async {
    await customStatement(
      "ALTER TABLE library_exercises ADD COLUMN names_json TEXT NOT NULL DEFAULT '{}'",
    );

    // Backfilled in Dart rather than with SQL string concatenation: exercise
    // names contain quotes and accents that would need escaping by hand, and
    // jsonEncode already gets that right.
    final legacyRows = await customSelect(
      'SELECT id, name_en, name_es FROM library_exercises',
    ).get();

    for (final row in legacyRows) {
      final names = <String, String>{};
      final nameEn = row.read<String?>('name_en')?.trim();
      final nameEs = row.read<String?>('name_es')?.trim();
      if (nameEn != null && nameEn.isNotEmpty) {
        names['en'] = nameEn;
      }
      if (nameEs != null && nameEs.isNotEmpty) {
        names['es'] = nameEs;
      }

      await customStatement(
        'UPDATE library_exercises SET names_json = ? WHERE id = ?',
        [jsonEncode(names), row.read<String>('id')],
      );
    }

    // Recreates the table from the current Dart schema, which no longer
    // declares name_en / name_es, and copies the columns both versions share.
    // Going through TableMigration instead of DROP COLUMN keeps this working on
    // the older SQLite builds still shipping on some Android devices.
    // ignore: experimental_member_use
    await m.alterTable(TableMigration(libraryExercises));
  }

  Future<void> _migrateV3ToV4() async {
    // Guarded because the column may already be there: a database coming from
    // v2 runs _migrateV2ToV3 first, and that creates training_defaults from
    // _createTrainingDefaultsTable, which already declares this column. Adding
    // it unconditionally threw "duplicate column name" and left the database
    // unopenable for anyone upgrading from v1 or v2.
    if (await _columnExists('training_defaults',
        'auto_start_rest_timer_on_set_completed',)) {
      return;
    }

    await customStatement(
      'ALTER TABLE training_defaults ADD COLUMN auto_start_rest_timer_on_set_completed INTEGER NOT NULL DEFAULT 0',
    );
  }

  Future<bool> _columnExists(String tableName, String columnName) async {
    final columns =
        await customSelect('PRAGMA table_info($tableName)').get();
    return columns.any((row) => row.read<String>('name') == columnName);
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

  /// Seeds the catalog from [ExerciseLibrary], the single place the exercise
  /// list and its translations are defined.
  Future<void> _seedLibraryExercises() async {
    for (final exercise in ExerciseLibrary.exercises) {
      await _insertSeededExercise(exercise);
    }
  }

  Future<void> _insertSeededExercise(ExerciseLibraryEntry exercise) {
    return into(libraryExercises).insert(
      LibraryExercisesCompanion.insert(
        id: exercise.id,
        name: exercise.canonicalName,
        namesJson: Value(exercise.names.encode()),
        isCustom: false,
        category: Value(exercise.category),
        updatedAt: Value(DateTime.now()),
        syncStatus: const Value(SyncStatus.synced),
        remoteVersion: const Value(0),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }

  /// Brings the stored catalog in line with the one this build ships.
  ///
  /// Two things drift apart between releases, and neither can be repaired at
  /// install time, so this runs on every launch:
  ///
  /// - **Translations.** A device seeded before a language existed carries only
  ///   the languages of that build, so stored names are merged with the current
  ///   catalog. The merge only fills in languages that are missing, which
  ///   leaves an exercise the user renamed alone.
  /// - **Whole exercises.** Seeding runs in `onCreate` only, so an exercise
  ///   added to the catalog in a later release used to reach new installs and
  ///   stay invisible to everyone who already had the app.
  ///
  /// Presence is decided by name rather than by id, in any language: early
  /// builds generated ids differently, and a row the user deleted has to stay
  /// deleted. So a name already stored — under any id, seeded or custom,
  /// deleted or not — is left exactly as it is.
  Future<void> syncSeededExerciseCatalog() async {
    final rows = await select(libraryExercises).get();

    final storedNames = <String>{};
    for (final row in rows) {
      storedNames.add(row.name.trim().toLowerCase());
      final names = LocalizedText.decode(row.namesJson, fallback: row.name);
      for (final name in names.values) {
        storedNames.add(name.trim().toLowerCase());
      }
    }

    for (final entry in ExerciseLibrary.exercises) {
      final isStored = entry.names.values
          .any((name) => storedNames.contains(name.trim().toLowerCase()));
      if (!isStored) {
        await _insertSeededExercise(entry);
      }
    }

    final catalogByName = <String, ExerciseLibraryEntry>{
      for (final entry in ExerciseLibrary.exercises)
        entry.canonicalName.toLowerCase(): entry,
    };

    for (final row in rows) {
      if (row.isCustom) {
        continue;
      }

      final entry = catalogByName[row.name.toLowerCase()];
      if (entry == null) {
        continue;
      }

      final stored = LocalizedText.decode(row.namesJson, fallback: row.name);
      final merged = entry.names.mergedWith(stored);
      if (merged == stored) {
        continue;
      }

      // Deliberately does not touch updatedAt or syncStatus: filling in a
      // translation we shipped is not a user edit and must not enqueue a sync.
      await (update(libraryExercises)..where((r) => r.id.equals(row.id)))
          .write(LibraryExercisesCompanion(namesJson: Value(merged.encode())));
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
