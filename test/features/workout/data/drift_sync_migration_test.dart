import 'dart:io';

import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

import 'package:muscleup/core/l10n/localized_text.dart';
import 'package:muscleup/features/workout/data/datasources/local/workout_database.dart';
import 'package:muscleup/features/workout/data/repositories/workout_repository_impl.dart';
import 'package:muscleup/features/workout/domain/entities/workout_entities.dart';

void main() {
  group('Drift migration v1 to v2', () {
    test('migrates existing rows with sync metadata and outbox table', () async {
      final tempDirectory = await Directory.systemTemp.createTemp('muscleup_db_v1_');
      final databaseFile = File('${tempDirectory.path}/muscleup_test.db');

      final sqlite = sqlite3.open(databaseFile.path);
      sqlite.execute('PRAGMA foreign_keys = ON;');
      sqlite.execute('PRAGMA user_version = 1;');

      sqlite.execute('CREATE TABLE routines (id TEXT NOT NULL PRIMARY KEY, name TEXT NOT NULL, sort_order INTEGER NOT NULL, is_deleted INTEGER NOT NULL DEFAULT 0);');
      sqlite.execute('CREATE TABLE exercises (id TEXT NOT NULL PRIMARY KEY, routine_id TEXT NOT NULL REFERENCES routines(id) ON DELETE CASCADE, name TEXT NOT NULL, notes TEXT NULL, rest_time_seconds INTEGER NOT NULL, sort_order INTEGER NOT NULL);');
      sqlite.execute('CREATE TABLE sets (id TEXT NOT NULL PRIMARY KEY, exercise_id TEXT NOT NULL REFERENCES exercises(id) ON DELETE CASCADE, target_value1 REAL NULL, target_value2 REAL NULL, unit1 INTEGER NULL, unit2 INTEGER NULL, sort_order INTEGER NOT NULL);');
      sqlite.execute('CREATE TABLE sessions (id TEXT NOT NULL PRIMARY KEY, routine_id TEXT NOT NULL REFERENCES routines(id), routine_name TEXT NOT NULL, created_at INTEGER NOT NULL, notes TEXT NULL, is_completed INTEGER NOT NULL DEFAULT 1);');
      sqlite.execute('CREATE TABLE set_logs (id TEXT NOT NULL PRIMARY KEY, session_id TEXT NOT NULL REFERENCES sessions(id) ON DELETE CASCADE, workout_exercise_id TEXT NOT NULL, set_number INTEGER NOT NULL, actual_value1 REAL NULL, actual_value2 REAL NULL, unit1 INTEGER NULL, unit2 INTEGER NULL, is_completed INTEGER NOT NULL, timestamp INTEGER NOT NULL);');
      sqlite.execute('CREATE TABLE library_exercises (id TEXT NOT NULL PRIMARY KEY, name TEXT NOT NULL, name_en TEXT NOT NULL, name_es TEXT NOT NULL, is_custom INTEGER NOT NULL, category INTEGER NULL);');

      final nowEpochSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      sqlite.execute("INSERT INTO routines (id, name, sort_order, is_deleted) VALUES ('routine_1', 'Routine A', 0, 0);");
      sqlite.execute("INSERT INTO exercises (id, routine_id, name, notes, rest_time_seconds, sort_order) VALUES ('exercise_1', 'routine_1', 'Bench Press', NULL, 60, 0);");
      sqlite.execute("INSERT INTO sets (id, exercise_id, target_value1, target_value2, unit1, unit2, sort_order) VALUES ('set_1', 'exercise_1', 10, NULL, 0, NULL, 0);");
      sqlite.execute("INSERT INTO sessions (id, routine_id, routine_name, created_at, notes, is_completed) VALUES ('session_1', 'routine_1', 'Routine A', $nowEpochSeconds, NULL, 1);");
      sqlite.execute("INSERT INTO set_logs (id, session_id, workout_exercise_id, set_number, actual_value1, actual_value2, unit1, unit2, is_completed, timestamp) VALUES ('log_1', 'session_1', 'exercise_1', 1, 10, NULL, 0, NULL, 1, $nowEpochSeconds);");
      sqlite.execute("INSERT INTO library_exercises (id, name, name_en, name_es, is_custom, category) VALUES ('lib_1', 'Bench Press', 'Bench Press', 'Press de Banca', 0, 0);");

      sqlite.dispose();

      final database = AppDatabase.forExecutor(NativeDatabase(databaseFile));
      await database.customSelect('SELECT 1;').get();

      final outboxTable = await database.customSelect(
        'SELECT name FROM sqlite_master WHERE type = ? AND name = ?;',
        variables: [const Variable('table'), const Variable('outbox_changes')],
      ).get();
      expect(outboxTable.isNotEmpty, isTrue);

      final routineMetadata = await database.customSelect(
        'SELECT updated_at, deleted_at, sync_status, remote_version FROM routines WHERE id = ?;',
        variables: [const Variable('routine_1')],
      ).getSingle();

      expect(routineMetadata.read<int>('updated_at') > 0, isTrue);
      expect(routineMetadata.readNullable<int>('deleted_at'), isNull);
      expect(routineMetadata.read<int>('sync_status'), SyncStatus.synced.index);
      expect(routineMetadata.read<int>('remote_version'), 0);

      await database.close();
      await tempDirectory.delete(recursive: true);
    });
  });

  group('Drift migration v4 to v5', () {
    /// Builds a database in its v4 shape: exercise names still live in the
    /// name_en / name_es columns.
    Future<File> createV4Database(Directory directory) async {
      final databaseFile = File('${directory.path}/muscleup_test.db');

      final sqlite = sqlite3.open(databaseFile.path);
      sqlite.execute('PRAGMA user_version = 4;');

      sqlite.execute('CREATE TABLE routines (id TEXT NOT NULL PRIMARY KEY, name TEXT NOT NULL, sort_order INTEGER NOT NULL, is_deleted INTEGER NOT NULL DEFAULT 0, updated_at INTEGER, deleted_at INTEGER, sync_status INTEGER NOT NULL DEFAULT 0, remote_version INTEGER NOT NULL DEFAULT 0);');
      sqlite.execute('CREATE TABLE exercises (id TEXT NOT NULL PRIMARY KEY, routine_id TEXT NOT NULL REFERENCES routines(id) ON DELETE CASCADE, name TEXT NOT NULL, notes TEXT NULL, rest_time_seconds INTEGER NOT NULL, sort_order INTEGER NOT NULL, updated_at INTEGER, deleted_at INTEGER, sync_status INTEGER NOT NULL DEFAULT 0, remote_version INTEGER NOT NULL DEFAULT 0);');
      sqlite.execute('CREATE TABLE sets (id TEXT NOT NULL PRIMARY KEY, exercise_id TEXT NOT NULL REFERENCES exercises(id) ON DELETE CASCADE, target_value1 REAL NULL, target_value2 REAL NULL, unit1 INTEGER NULL, unit2 INTEGER NULL, sort_order INTEGER NOT NULL, updated_at INTEGER, deleted_at INTEGER, sync_status INTEGER NOT NULL DEFAULT 0, remote_version INTEGER NOT NULL DEFAULT 0);');
      sqlite.execute('CREATE TABLE sessions (id TEXT NOT NULL PRIMARY KEY, routine_id TEXT NOT NULL REFERENCES routines(id), routine_name TEXT NOT NULL, created_at INTEGER NOT NULL, notes TEXT NULL, is_completed INTEGER NOT NULL DEFAULT 1, updated_at INTEGER, deleted_at INTEGER, sync_status INTEGER NOT NULL DEFAULT 0, remote_version INTEGER NOT NULL DEFAULT 0);');
      sqlite.execute('CREATE TABLE set_logs (id TEXT NOT NULL PRIMARY KEY, session_id TEXT NOT NULL REFERENCES sessions(id) ON DELETE CASCADE, workout_exercise_id TEXT NOT NULL, set_number INTEGER NOT NULL, actual_value1 REAL NULL, actual_value2 REAL NULL, unit1 INTEGER NULL, unit2 INTEGER NULL, is_completed INTEGER NOT NULL, timestamp INTEGER NOT NULL, updated_at INTEGER, deleted_at INTEGER, sync_status INTEGER NOT NULL DEFAULT 0, remote_version INTEGER NOT NULL DEFAULT 0);');
      sqlite.execute('CREATE TABLE library_exercises (id TEXT NOT NULL PRIMARY KEY, name TEXT NOT NULL, name_en TEXT NOT NULL, name_es TEXT NOT NULL, is_custom INTEGER NOT NULL, category INTEGER NULL, updated_at INTEGER, deleted_at INTEGER, sync_status INTEGER NOT NULL DEFAULT 0, remote_version INTEGER NOT NULL DEFAULT 0);');
      sqlite.execute('CREATE TABLE outbox_changes (id TEXT NOT NULL PRIMARY KEY, entity_type TEXT NOT NULL, entity_id TEXT NOT NULL, operation TEXT NOT NULL, payload_json TEXT NOT NULL, created_at INTEGER NOT NULL, retry_count INTEGER NOT NULL DEFAULT 0, last_error TEXT NULL);');
      sqlite.execute('CREATE TABLE training_defaults (id INTEGER PRIMARY KEY CHECK(id = 1), default_rest_seconds INTEGER NOT NULL, default_repetitions INTEGER NOT NULL, default_weight REAL NOT NULL, auto_start_rest_timer_on_set_completed INTEGER NOT NULL DEFAULT 0, updated_at INTEGER NOT NULL);');

      sqlite.dispose();
      return databaseFile;
    }

    test('folds name_en and name_es into the names map', () async {
      final tempDirectory =
          await Directory.systemTemp.createTemp('muscleup_db_v4_');
      final databaseFile = await createV4Database(tempDirectory);

      final sqlite = sqlite3.open(databaseFile.path);
      // A seeded row, and a custom one whose name carries an apostrophe and an
      // accent — the characters that would break hand-built JSON.
      sqlite.execute("INSERT INTO library_exercises (id, name, name_en, name_es, is_custom, category, updated_at, sync_status, remote_version) VALUES ('lateral_raise', 'Lateral Raise', 'Lateral Raise', 'Elevaciones Laterales', 0, 2, 100, 1, 0);");
      sqlite.execute("INSERT INTO library_exercises (id, name, name_en, name_es, is_custom, category, updated_at, sync_status, remote_version) VALUES ('custom_1', 'Remo \"Pendlay\" à côté', 'Remo \"Pendlay\" à côté', 'Remo \"Pendlay\" à côté', 1, NULL, 100, 1, 0);");
      sqlite.dispose();

      final database = AppDatabase.forExecutor(NativeDatabase(databaseFile));
      await database.customSelect('SELECT 1;').get();

      final rows = await database.select(database.libraryExercises).get();

      final seeded = rows.firstWhere((row) => row.id == 'lateral_raise');
      final seededNames = LocalizedText.decode(seeded.namesJson);
      expect(seededNames.resolve('en'), 'Lateral Raise');
      expect(seededNames.resolve('es'), 'Elevaciones Laterales');

      final custom = rows.firstWhere((row) => row.id == 'custom_1');
      final customNames = LocalizedText.decode(custom.namesJson);
      expect(customNames.resolve('es'), 'Remo "Pendlay" à côté');

      // The legacy columns are gone, so nothing can write to them again.
      final columns =
          await database.customSelect('PRAGMA table_info(library_exercises)').get();
      final columnNames = columns.map((row) => row.read<String>('name')).toSet();
      expect(columnNames, contains('names_json'));
      expect(columnNames, isNot(contains('name_en')));
      expect(columnNames, isNot(contains('name_es')));

      await database.close();
      await tempDirectory.delete(recursive: true);
    });

    test('backfills translations shipped after the row was seeded', () async {
      final tempDirectory =
          await Directory.systemTemp.createTemp('muscleup_db_v4_backfill_');
      final databaseFile = await createV4Database(tempDirectory);

      final sqlite = sqlite3.open(databaseFile.path);
      // Simulates a device seeded before Spanish existed: English only.
      sqlite.execute("INSERT INTO library_exercises (id, name, name_en, name_es, is_custom, category, updated_at, sync_status, remote_version) VALUES ('deadlift', 'Deadlift', 'Deadlift', '', 0, 1, 100, 1, 0);");
      sqlite.dispose();

      final database = AppDatabase.forExecutor(NativeDatabase(databaseFile));
      await database.customSelect('SELECT 1;').get();

      final row = await (database.select(database.libraryExercises)
            ..where((r) => r.id.equals('deadlift')))
          .getSingle();

      // beforeOpen merges the current catalog into rows seeded by older builds,
      // which is how a newly shipped language reaches existing installs.
      expect(LocalizedText.decode(row.namesJson).resolve('es'), 'Peso Muerto');
      expect(row.syncStatus, SyncStatus.synced,
          reason: 'filling in a shipped translation is not a user edit',);

      await database.close();
      await tempDirectory.delete(recursive: true);
    });

    test('seeds exercises the catalog gained after the install', () async {
      final tempDirectory =
          await Directory.systemTemp.createTemp('muscleup_db_v4_newseed_');
      final databaseFile = await createV4Database(tempDirectory);

      final sqlite = sqlite3.open(databaseFile.path);
      // A device from a build whose catalog had none of today's additions. The
      // legacy id is deliberate: early builds did not derive it from the name.
      sqlite.execute("INSERT INTO library_exercises (id, name, name_en, name_es, is_custom, category, updated_at, sync_status, remote_version) VALUES ('lib_7', 'Bench Press', 'Bench Press', 'Press de Banca', 0, 0, 100, 1, 0);");
      sqlite.execute("INSERT INTO library_exercises (id, name, name_en, name_es, is_custom, category, updated_at, sync_status, remote_version) VALUES ('custom_face', 'Face Pull', 'Face Pull', 'Face Pull', 1, NULL, 100, 1, 0);");
      sqlite.dispose();

      final database = AppDatabase.forExecutor(NativeDatabase(databaseFile));
      await database.customSelect('SELECT 1;').get();

      final rows = await database.select(database.libraryExercises).get();
      Iterable<LibraryExerciseData> named(String name) =>
          rows.where((row) => row.name == name);

      // Seeding only ever ran in onCreate, so an exercise added to the catalog
      // later used to reach new installs and nobody else.
      expect(named('Cable Crunch'), hasLength(1));
      expect(named('Hack Squat'), hasLength(1));
      expect(
        LocalizedText.decode(named('Cable Crunch').single.namesJson)
            .resolve('es'),
        'Crunch en Polea',
      );

      // Matching is by name, not id, so a row seeded under a legacy id is not
      // duplicated by the entry it already represents.
      expect(named('Bench Press'), hasLength(1));
      expect(named('Bench Press').single.id, 'lib_7');

      // The user got there first with their own copy; leaving it alone keeps
      // one entry in the picker instead of two.
      expect(named('Face Pull'), hasLength(1));
      expect(named('Face Pull').single.isCustom, isTrue);

      await database.close();
      await tempDirectory.delete(recursive: true);
    });

    test('leaves a deleted exercise deleted', () async {
      final tempDirectory =
          await Directory.systemTemp.createTemp('muscleup_db_v4_deleted_');
      final databaseFile = await createV4Database(tempDirectory);

      final sqlite = sqlite3.open(databaseFile.path);
      sqlite.execute("INSERT INTO library_exercises (id, name, name_en, name_es, is_custom, category, updated_at, deleted_at, sync_status, remote_version) VALUES ('burpees', 'Burpees', 'Burpees', 'Burpees', 0, 7, 100, 200, 1, 0);");
      sqlite.dispose();

      final database = AppDatabase.forExecutor(NativeDatabase(databaseFile));
      await database.customSelect('SELECT 1;').get();

      final rows = await (database.select(database.libraryExercises)
            ..where((row) => row.name.equals('Burpees')))
          .get();

      // Re-seeding on every launch must not resurrect what the user removed.
      expect(rows, hasLength(1));
      expect(rows.single.deletedAt, isNotNull);

      await database.close();
      await tempDirectory.delete(recursive: true);
    });
  });

  group('Drift migration v5 to v6', () {
    test('links routine exercises back to the catalog they came from', () async {
      final tempDirectory =
          await Directory.systemTemp.createTemp('muscleup_db_v5_');
      final databaseFile = File('${tempDirectory.path}/muscleup_test.db');

      final sqlite = sqlite3.open(databaseFile.path);
      sqlite.execute('PRAGMA user_version = 5;');

      sqlite.execute('CREATE TABLE routines (id TEXT NOT NULL PRIMARY KEY, name TEXT NOT NULL, sort_order INTEGER NOT NULL, is_deleted INTEGER NOT NULL DEFAULT 0, updated_at INTEGER, deleted_at INTEGER, sync_status INTEGER NOT NULL DEFAULT 0, remote_version INTEGER NOT NULL DEFAULT 0);');
      sqlite.execute('CREATE TABLE exercises (id TEXT NOT NULL PRIMARY KEY, routine_id TEXT NOT NULL REFERENCES routines(id) ON DELETE CASCADE, name TEXT NOT NULL, notes TEXT NULL, rest_time_seconds INTEGER NOT NULL, sort_order INTEGER NOT NULL, updated_at INTEGER, deleted_at INTEGER, sync_status INTEGER NOT NULL DEFAULT 0, remote_version INTEGER NOT NULL DEFAULT 0);');
      sqlite.execute('CREATE TABLE sets (id TEXT NOT NULL PRIMARY KEY, exercise_id TEXT NOT NULL REFERENCES exercises(id) ON DELETE CASCADE, target_value1 REAL NULL, target_value2 REAL NULL, unit1 INTEGER NULL, unit2 INTEGER NULL, sort_order INTEGER NOT NULL, updated_at INTEGER, deleted_at INTEGER, sync_status INTEGER NOT NULL DEFAULT 0, remote_version INTEGER NOT NULL DEFAULT 0);');
      sqlite.execute('CREATE TABLE sessions (id TEXT NOT NULL PRIMARY KEY, routine_id TEXT NOT NULL REFERENCES routines(id), routine_name TEXT NOT NULL, created_at INTEGER NOT NULL, notes TEXT NULL, is_completed INTEGER NOT NULL DEFAULT 1, updated_at INTEGER, deleted_at INTEGER, sync_status INTEGER NOT NULL DEFAULT 0, remote_version INTEGER NOT NULL DEFAULT 0);');
      sqlite.execute('CREATE TABLE set_logs (id TEXT NOT NULL PRIMARY KEY, session_id TEXT NOT NULL REFERENCES sessions(id) ON DELETE CASCADE, workout_exercise_id TEXT NOT NULL, set_number INTEGER NOT NULL, actual_value1 REAL NULL, actual_value2 REAL NULL, unit1 INTEGER NULL, unit2 INTEGER NULL, is_completed INTEGER NOT NULL, timestamp INTEGER NOT NULL, updated_at INTEGER, deleted_at INTEGER, sync_status INTEGER NOT NULL DEFAULT 0, remote_version INTEGER NOT NULL DEFAULT 0);');
      sqlite.execute("CREATE TABLE library_exercises (id TEXT NOT NULL PRIMARY KEY, name TEXT NOT NULL, names_json TEXT NOT NULL DEFAULT '{}', is_custom INTEGER NOT NULL, category INTEGER NULL, updated_at INTEGER, deleted_at INTEGER, sync_status INTEGER NOT NULL DEFAULT 0, remote_version INTEGER NOT NULL DEFAULT 0);");
      sqlite.execute('CREATE TABLE outbox_changes (id TEXT NOT NULL PRIMARY KEY, entity_type TEXT NOT NULL, entity_id TEXT NOT NULL, operation TEXT NOT NULL, payload_json TEXT NOT NULL, created_at INTEGER NOT NULL, retry_count INTEGER NOT NULL DEFAULT 0, last_error TEXT NULL);');
      sqlite.execute('CREATE TABLE training_defaults (id INTEGER PRIMARY KEY CHECK(id = 1), default_rest_seconds INTEGER NOT NULL, default_repetitions INTEGER NOT NULL, default_weight REAL NOT NULL, auto_start_rest_timer_on_set_completed INTEGER NOT NULL DEFAULT 0, updated_at INTEGER NOT NULL);');

      // A routine built while the app was in Spanish: the exercise names were
      // stored as the translated text that happened to be on screen.
      sqlite.execute("INSERT INTO routines (id, name, sort_order, updated_at) VALUES ('r1', 'Día de Pierna', 0, 100);");
      sqlite.execute("INSERT INTO exercises (id, routine_id, name, rest_time_seconds, sort_order, updated_at) VALUES ('e1', 'r1', 'Sentadilla', 90, 0, 100);");
      sqlite.execute("INSERT INTO exercises (id, routine_id, name, rest_time_seconds, sort_order, updated_at) VALUES ('e2', 'r1', 'Peso Muerto Rumano', 90, 1, 100);");
      // One the user typed in themselves: not in the catalog in any language.
      sqlite.execute("INSERT INTO exercises (id, routine_id, name, rest_time_seconds, sort_order, updated_at) VALUES ('e3', 'r1', 'Remo invertido en anillas', 60, 2, 100);");
      sqlite.dispose();

      final database = AppDatabase.forExecutor(NativeDatabase(databaseFile));
      await database.customSelect('SELECT 1;').get();

      final rows = await database.select(database.exercises).get();
      final byId = {for (final row in rows) row.id: row};

      expect(byId['e1']!.canonicalName, 'Squat');
      expect(byId['e2']!.canonicalName, 'Romanian Deadlift');
      expect(byId['e3']!.canonicalName, isNull,
          reason: 'a user-created exercise has no catalog entry to link to',);

      // The stored text is left untouched; only the link is added.
      expect(byId['e1']!.name, 'Sentadilla');

      await database.close();
      await tempDirectory.delete(recursive: true);
    });
  });

  group('Outbox and tombstone behavior', () {
    late AppDatabase database;
    late WorkoutRepositoryImpl repository;

    setUp(() {
      database = AppDatabase.forExecutor(NativeDatabase.memory());
      repository = WorkoutRepositoryImpl(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('create update delete produce outbox events and tombstone', () async {
      const routine = WorkoutRoutine(
        id: 'routine_test',
        name: 'Push Day',
        sortOrder: 0,
        exercises: [
          WorkoutExercise(
            id: 'exercise_test',
            name: 'Bench Press',
            sortOrder: 0,
            notes: null,
            restTimeSeconds: 60,
            templateSets: [
              WorkoutSet(
                id: 'set_test',
                sortOrder: 0,
                targetValue1: 10,
                targetValue2: null,
                unit1: WorkoutUnit.repetitions,
                unit2: null,
              ),
            ],
          ),
        ],
      );

      final createResult = await repository.saveRoutine(routine);
      expect(
        createResult.isLeft,
        isFalse,
        reason: createResult.isLeft
            ? (createResult.left as dynamic).message.toString()
            : 'unexpected_right',
      );

      final createdOutboxRows = await (database.select(database.outboxChanges)
            ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]))
          .get();

      expect(createdOutboxRows.any((row) => row.entityType == 'routine' && row.operation == 'create'), isTrue);
      expect(createdOutboxRows.any((row) => row.entityType == 'exercise' && row.operation == 'create'), isTrue);
      expect(createdOutboxRows.any((row) => row.entityType == 'set' && row.operation == 'create'), isTrue);

      final updatedRoutine = routine.copyWith(name: 'Push Day Updated');
      final updateResult = await repository.saveRoutine(updatedRoutine);
      expect(
        updateResult.isLeft,
        isFalse,
        reason: updateResult.isLeft
            ? (updateResult.left as dynamic).message.toString()
            : 'unexpected_right',
      );

      final updatedOutboxRows = await database.select(database.outboxChanges).get();
      expect(updatedOutboxRows.any((row) => row.entityType == 'routine' && row.operation == 'update'), isTrue);

      final deleteResult = await repository.deleteRoutine(routine.id);
      expect(
        deleteResult.isLeft,
        isFalse,
        reason: deleteResult.isLeft
            ? (deleteResult.left as dynamic).message.toString()
            : 'unexpected_right',
      );

      final deletedRoutine = await (database.select(database.routines)
            ..where((row) => row.id.equals(routine.id)))
          .getSingle();

      expect(deletedRoutine.deletedAt, isNotNull);
      expect(deletedRoutine.syncStatus, SyncStatus.pending);

      final deletedOutboxRows = await database.select(database.outboxChanges).get();
      expect(deletedOutboxRows.any((row) => row.entityType == 'routine' && row.operation == 'delete'), isTrue);
    });

    test('current schema can be reopened without sync metadata loss', () async {
      final tempDirectory = await Directory.systemTemp.createTemp('muscleup_db_v2_');
      final databaseFile = File('${tempDirectory.path}/muscleup_v2_reopen.db');

      final firstOpen = AppDatabase.forExecutor(NativeDatabase(databaseFile));
      final initialTimestamp = DateTime(2025, 1, 1, 8, 30);

      await firstOpen.into(firstOpen.routines).insert(
            RoutinesCompanion.insert(
              id: 'routine_reopen',
              name: 'Reopen Routine',
              sortOrder: 0,
              isDeleted: const Value(false),
              updatedAt: Value(initialTimestamp),
              deletedAt: const Value(null),
              syncStatus: const Value(SyncStatus.pending),
              remoteVersion: const Value(2),
            ),
          );

      await firstOpen.close();

      final secondOpen = AppDatabase.forExecutor(NativeDatabase(databaseFile));
      final reopenedRoutine = await (secondOpen.select(secondOpen.routines)
            ..where((row) => row.id.equals('routine_reopen')))
          .getSingle();

      expect(reopenedRoutine.updatedAt, initialTimestamp);
      expect(reopenedRoutine.deletedAt, isNull);
      expect(reopenedRoutine.syncStatus, SyncStatus.pending);
      expect(reopenedRoutine.remoteVersion, 2);

      await secondOpen.close();
      await tempDirectory.delete(recursive: true);
    });
  });
}
