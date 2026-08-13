import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/core/constants/exercise_library.dart';
import 'package:muscleup/features/workout/domain/entities/workout_entities.dart';

WorkoutExercise exercise({required String name, String? canonicalName}) {
  return WorkoutExercise(
    id: 'e1',
    name: name,
    canonicalName: canonicalName,
    sortOrder: 0,
    restTimeSeconds: 60,
    templateSets: const <WorkoutSet>[],
  );
}

void main() {
  group('catalog exercises follow the app language', () {
    test('a routine built in Spanish reads in English', () {
      // Exactly the reported case: the routine stored the Spanish text, but the
      // link to the catalog entry is what decides what gets shown.
      final lateralRaise = exercise(
        name: 'Elevaciones Laterales',
        canonicalName: 'Lateral Raise',
      );

      expect(lateralRaise.displayName('en'), 'Lateral Raise');
      expect(lateralRaise.displayName('es'), 'Elevaciones Laterales');
      expect(lateralRaise.displayName('de'), 'Seitheben');
      expect(lateralRaise.displayName('ru'), 'Махи гантелями в стороны');
    });

    test('an untranslated language falls back instead of going blank', () {
      final squat = exercise(name: 'Squat', canonicalName: 'Squat');

      expect(squat.displayName('ja'), isNotEmpty);
    });

    test('a regional locale resolves against its base language', () {
      final squat = exercise(name: 'Squat', canonicalName: 'Squat');

      expect(squat.displayName('pt_BR'), 'Agachamento Livre');
    });
  });

  group('user-created exercises keep the name they were given', () {
    test('a custom exercise is not translated', () {
      final custom = exercise(name: 'Remo invertido en anillas');

      expect(custom.displayName('en'), 'Remo invertido en anillas');
      expect(custom.displayName('de'), 'Remo invertido en anillas');
    });

    test('a canonical name that is no longer in the catalog falls back', () {
      // Defensive: if an exercise were ever dropped from the catalog, the
      // stored text still has to render rather than leaving a blank row.
      final orphan = exercise(name: 'Some Old Lift', canonicalName: 'Removed Lift');

      expect(orphan.displayName('en'), 'Some Old Lift');
    });
  });

  group('reverse lookup', () {
    test('recognises a catalog name written in any language', () {
      expect(ExerciseLibrary.canonicalNameFor('Elevaciones Laterales'), 'Lateral Raise');
      expect(ExerciseLibrary.canonicalNameFor('Seitheben'), 'Lateral Raise');
      expect(ExerciseLibrary.canonicalNameFor('Peso Muerto'), 'Deadlift');
      expect(ExerciseLibrary.canonicalNameFor('Martwy ciąg'), 'Deadlift');
      expect(ExerciseLibrary.canonicalNameFor('Lat Pulldown'), 'Lat Pulldown');
    });

    test('ignores case and surrounding whitespace', () {
      expect(ExerciseLibrary.canonicalNameFor('  peso muerto  '), 'Deadlift');
    });

    test('returns null for a name the catalog does not have', () {
      expect(ExerciseLibrary.canonicalNameFor('Remo invertido en anillas'), isNull);
      expect(ExerciseLibrary.canonicalNameFor(''), isNull);
    });
  });
}
