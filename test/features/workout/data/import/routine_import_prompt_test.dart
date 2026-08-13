import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/core/constants/exercise_library.dart';
import 'package:muscleup/features/workout/data/import/routine_import_parser.dart';
import 'package:muscleup/features/workout/data/import/routine_import_prompt.dart';

void main() {
  test('names the language the catalog is spelled in', () {
    final prompt = RoutineImportPrompt.build(
      languageCode: 'es',
      languageName: 'Español',
    );

    expect(prompt, contains('Español (es)'));
  });

  test('asks for the user\'s own words to be left untranslated', () {
    final prompt = RoutineImportPrompt.build(
      languageCode: 'es',
      languageName: 'Español',
    );

    // Asking for the whole reply "in Español" made assistants translate the
    // user's notes: "LUNES — Torso" came back as "Monday — Upper body" and
    // "Bicho muerto" as "Dead Bug".
    expect(prompt, contains('TRANSLATE NOTHING'));
    expect(prompt, contains('exactly as it appears in the notes'));
    expect(prompt, isNot(contains('Write every routine name')));
  });

  test('its example keeps the day label exactly as the notes wrote it', () {
    final prompt = RoutineImportPrompt.build(
      languageCode: 'en',
      languageName: 'English',
    );

    // The example is the strongest signal in the prompt, so it must not
    // quietly reword the label it was given.
    expect(prompt, contains('MONDAY — Upper\n'));
    expect(prompt, contains('"name":"MONDAY — Upper"'));
  });

  test('lists the catalog in the requested language', () {
    final prompt = RoutineImportPrompt.build(
      languageCode: 'de',
      languageName: 'Deutsch',
    );

    // Spelling the catalog out in the user's language is what lets the reply
    // come back with names the parser can link to catalog entries.
    expect(prompt, contains('Bankdrücken'));
    expect(prompt, contains('Kniebeuge'));
    expect(prompt, isNot(contains('Bench Press,')));
  });

  test('falls back to English for a language with no translations', () {
    final prompt = RoutineImportPrompt.build(
      languageCode: 'xx',
      languageName: 'XX',
    );

    for (final exercise in ExerciseLibrary.exercises) {
      expect(prompt, contains(exercise.canonicalName));
    }
  });

  test('ends with the header the user pastes their notes under', () {
    final prompt = RoutineImportPrompt.build(
      languageCode: 'en',
      languageName: 'English',
    );

    expect(prompt.trimRight(), endsWith(RoutineImportPrompt.notesHeader));
  });

  test('the example it shows is JSON the parser accepts', () {
    final prompt = RoutineImportPrompt.build(
      languageCode: 'en',
      languageName: 'English',
    );

    // The worked example is the strongest signal the assistant gets about the
    // shape to produce, so it has to be something the parser reads back.
    final example = prompt
        .split('\n')
        .firstWhere((line) => line.startsWith('{"routines"'));
    final result = RoutineImportParser().parse(example);

    expect(result.failure, isNull);
    expect(result.routines.single.name, 'MONDAY — Upper');
    expect(
      result.routines.single.exercises.map((exercise) => exercise.canonicalName),
      ['Incline Bench Press', 'Lat Pulldown'],
    );
  });
}
