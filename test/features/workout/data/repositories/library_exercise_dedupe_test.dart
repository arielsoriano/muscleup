import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:muscleup/core/l10n/localized_text.dart';
import 'package:muscleup/features/workout/data/datasources/local/workout_database.dart';
import 'package:muscleup/features/workout/data/repositories/workout_repository_impl.dart';

/// Reproduces the duplicated-exercise report from closed testing: a seeded
/// bilingual row and a legacy custom row that carries the Spanish name in every
/// language both render as "Elevaciones Laterales" in the picker.
void main() {
  late AppDatabase database;
  late WorkoutRepositoryImpl repository;

  setUp(() async {
    database = AppDatabase.forExecutor(NativeDatabase.memory());
    repository = WorkoutRepositoryImpl(database);
    // Touch the database so onCreate (and the library seed) runs.
    await database.select(database.libraryExercises).get();
  });

  tearDown(() async {
    await database.close();
  });

  /// The shape older builds wrote: the name the user saw, stored as if it were
  /// the name in every language.
  Future<void> insertLegacyCustomRow(String name) async {
    await database.into(database.libraryExercises).insert(
          LibraryExercisesCompanion.insert(
            id: 'legacy_${name.hashCode}',
            name: name,
            namesJson: Value(
              LocalizedText(<String, String>{'en': name, 'es': name}).encode(),
            ),
            isCustom: true,
            updatedAt: Value(DateTime.now()),
            syncStatus: const Value(SyncStatus.synced),
          ),
        );
  }

  test('collapses a legacy custom row onto the seeded bilingual row', () async {
    await insertLegacyCustomRow('Elevaciones Laterales');

    final result = await repository.getLibraryExercises();
    final exercises = result.fold((failure) => throw Exception(failure), (e) => e);

    final matches =
        exercises.where((e) => e.getLocalizedName('es') == 'Elevaciones Laterales');

    expect(matches.length, 1, reason: 'the picker must show one entry per name');
    // The seeded row wins, so the English name is not lost.
    expect(matches.single.getLocalizedName('en'), 'Lateral Raise');
  });

  test('collapses duplicates when searching too', () async {
    await insertLegacyCustomRow('Curl Martillo');

    final result = await repository.searchLibraryExercises('martillo', 'es');
    final exercises = result.fold((failure) => throw Exception(failure), (e) => e);

    expect(
      exercises.where((e) => e.getLocalizedName('es') == 'Curl Martillo').length,
      1,
    );
  });

  test('search by English name still finds the merged entry', () async {
    await insertLegacyCustomRow('Elevaciones Laterales');

    final result = await repository.searchLibraryExercises('lateral raise', 'en');
    final exercises = result.fold((failure) => throw Exception(failure), (e) => e);

    expect(exercises.map((e) => e.getLocalizedName('en')), contains('Lateral Raise'));
  });

  test('keeps genuinely different exercises apart', () async {
    final result = await repository.getLibraryExercises();
    final exercises = result.fold((failure) => throw Exception(failure), (e) => e);

    final names = exercises.map((e) => e.getLocalizedName('es')).toList();

    expect(names, contains('Elevaciones Laterales'));
    expect(names, contains('Elevaciones Frontales'));
    expect(names.toSet().length, names.length, reason: 'no duplicate names');
  });

  test('deleting a merged exercise removes every row behind it', () async {
    await insertLegacyCustomRow('Elevaciones Laterales');

    final before = await repository.getLibraryExercises();
    final visible = before
        .fold((failure) => throw Exception(failure), (e) => e)
        .firstWhere((e) => e.getLocalizedName('es') == 'Elevaciones Laterales');

    await repository.deleteLibraryExercise(visible.id);

    final after = await repository.getLibraryExercises();
    final remaining = after.fold((failure) => throw Exception(failure), (e) => e);

    expect(
      remaining.where((e) => e.getLocalizedName('es') == 'Elevaciones Laterales'),
      isEmpty,
      reason: 'the hidden twin must not resurface after a delete',
    );
  });

  test('a custom exercise with a brand new name is still listed', () async {
    await repository.saveLibraryExercise('Remo Invertido en Anillas');

    final result = await repository.getLibraryExercises();
    final exercises = result.fold((failure) => throw Exception(failure), (e) => e);

    expect(
      exercises.map((e) => e.getLocalizedName('es')),
      contains('Remo Invertido en Anillas'),
    );
  });
}
