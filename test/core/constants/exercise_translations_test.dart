import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/core/constants/exercise_library.dart';
import 'package:muscleup/core/constants/exercise_names/exercise_name_translations.dart';
import 'package:muscleup/core/l10n/localized_text.dart';

/// Guards the translation tables against the failure they cannot report
/// themselves: a key that matches no exercise is silently ignored, and the
/// exercise stays in English forever with nothing in the logs to say why.
void main() {
  final canonicalNames =
      ExerciseLibrary.exercises.map((entry) => entry.canonicalName).toSet();

  test('every translation key names a real exercise', () {
    for (final table in exerciseNameTranslations.entries) {
      final unknownKeys =
          table.value.keys.where((key) => !canonicalNames.contains(key)).toList();

      expect(
        unknownKeys,
        isEmpty,
        reason: 'exercise_names_${table.key}.dart has keys that match no '
            'canonical exercise name. Keys must stay byte-identical to the '
            'English names in ExerciseLibrary.',
      );
    }
  });

  test('no translation table has blank values', () {
    for (final table in exerciseNameTranslations.entries) {
      final blankKeys =
          table.value.entries.where((e) => e.value.trim().isEmpty).map((e) => e.key);

      expect(blankKeys, isEmpty,
          reason: 'a blank value in exercise_names_${table.key}.dart silently '
              'falls back to English; remove the key instead.',);
    }
  });

  test('the catalog has no duplicate canonical names', () {
    expect(
      canonicalNames.length,
      ExerciseLibrary.exercises.length,
      reason: 'two entries sharing a canonical name would share translations '
          'and collide on their generated id',
    );
  });

  test('every exercise resolves a name in every supported language', () {
    final languageCodes = <String>{
      LocalizedText.baseLanguageCode,
      ...exerciseNameTranslations.keys,
    };

    for (final exercise in ExerciseLibrary.exercises) {
      for (final code in languageCodes) {
        expect(
          exercise.getLocalizedName(code),
          isNotEmpty,
          reason: '${exercise.canonicalName} renders blank in "$code"',
        );
      }
    }
  });

  test('Spanish is fully translated', () {
    // Spanish shipped before this refactor and was complete, so it doubles as
    // the reference table. A new language is allowed to be partial; this one
    // regressing would mean a key got lost in the move.
    final missing = canonicalNames
        .where((name) => !exerciseNamesEsKeys.contains(name))
        .toList();

    expect(missing, isEmpty);
  });
}

Set<String> get exerciseNamesEsKeys =>
    exerciseNameTranslations['es']?.keys.toSet() ?? <String>{};
