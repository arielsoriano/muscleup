import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/features/workout/data/export/routine_export_serializer.dart';
import 'package:muscleup/features/workout/data/import/routine_import_parser.dart';
import 'package:muscleup/features/workout/domain/entities/workout_entities.dart';

/// The export is only worth having if what comes out goes back in. Every test
/// here runs the serializer's output through the real import parser and
/// compares the routines that come back with the ones that went in.
void main() {
  const serializer = RoutineExportSerializer();
  final parser = RoutineImportParser();

  WorkoutSet buildSet({
    required int sortOrder,
    double? value1,
    double? value2,
    WorkoutUnit? unit1 = WorkoutUnit.kilograms,
    WorkoutUnit? unit2 = WorkoutUnit.repetitions,
  }) {
    return WorkoutSet(
      id: 'set-$sortOrder',
      sortOrder: sortOrder,
      targetValue1: value1,
      targetValue2: value2,
      unit1: unit1,
      unit2: unit2,
    );
  }

  group('RoutineExportSerializer', () {
    test('a routine survives export and re-import unchanged', () {
      final routines = <WorkoutRoutine>[
        WorkoutRoutine(
          id: 'routine-1',
          name: 'LUNES — Torso',
          sortOrder: 0,
          exercises: [
            WorkoutExercise(
              id: 'exercise-1',
              name: 'Bench Press',
              canonicalName: 'Bench Press',
              sortOrder: 0,
              notes: 'Wide grip',
              restTimeSeconds: 90,
              templateSets: [
                buildSet(sortOrder: 0, value1: 60, value2: 10),
                buildSet(sortOrder: 1, value1: 65, value2: 8),
                buildSet(sortOrder: 2, value1: 70, value2: 6),
              ],
            ),
            WorkoutExercise(
              id: 'exercise-2',
              name: 'Sentadilla del abuelo',
              sortOrder: 1,
              restTimeSeconds: 0,
              templateSets: [
                buildSet(sortOrder: 0, value2: 12),
                buildSet(sortOrder: 1, value2: 12),
              ],
            ),
          ],
        ),
      ];

      final json = serializer.serialize(routines, languageCode: 'en');
      final result = parser.parse(json);

      expect(result.isSuccess, isTrue);
      expect(result.routines, hasLength(1));

      final imported = result.routines.single;
      expect(imported.name, 'LUNES — Torso');
      expect(imported.exercises, hasLength(2));

      final bench = imported.exercises.first;
      expect(bench.name, 'Bench Press');
      expect(bench.canonicalName, 'Bench Press');
      expect(bench.notes, 'Wide grip');
      expect(bench.restTimeSeconds, 90);
      expect(
        bench.templateSets.map((set) => (set.targetValue1, set.targetValue2)),
        [(60.0, 10.0), (65.0, 8.0), (70.0, 6.0)],
      );

      // An exercise the user typed in keeps their own wording and stays
      // unlinked from the catalog.
      final custom = imported.exercises[1];
      expect(custom.name, 'Sentadilla del abuelo');
      expect(custom.canonicalName, isNull);
      expect(custom.templateSets, hasLength(2));
      expect(custom.templateSets.first.targetValue1, isNull);
      expect(custom.templateSets.first.targetValue2, 12.0);
    });

    test('identical sets collapse to a count and expand back to the same sets', () {
      final routines = <WorkoutRoutine>[
        WorkoutRoutine(
          id: 'routine-1',
          name: 'Push',
          sortOrder: 0,
          exercises: [
            WorkoutExercise(
              id: 'exercise-1',
              name: 'Squat',
              canonicalName: 'Squat',
              sortOrder: 0,
              restTimeSeconds: 120,
              templateSets: [
                for (var index = 0; index < 4; index++)
                  buildSet(sortOrder: index, value1: 100, value2: 5),
              ],
            ),
          ],
        ),
      ];

      final encoded = serializer.toJson(routines, languageCode: 'en');
      final exercise = ((encoded['routines']! as List).single
          as Map<String, Object?>)['exercises']! as List;
      final squat = exercise.single as Map<String, Object?>;

      // The compact shape the import instructions document, and integers rather
      // than 100.0 / 5.0.
      expect(squat['sets'], 4);
      expect(squat['weight'], 100);
      expect(squat['weightUnit'], 'kg');
      expect(squat['reps'], 5);

      final result = parser.parse(jsonEncode(encoded));
      final imported = result.routines.single.exercises.single;
      expect(imported.templateSets, hasLength(4));
      expect(
        imported.templateSets.every(
          (set) => set.targetValue1 == 100.0 && set.targetValue2 == 5.0,
        ),
        isTrue,
      );
    });

    test('non-repetition units survive the round trip', () {
      final routines = <WorkoutRoutine>[
        WorkoutRoutine(
          id: 'routine-1',
          name: 'Conditioning',
          sortOrder: 0,
          exercises: [
            WorkoutExercise(
              id: 'exercise-1',
              name: 'Plank',
              canonicalName: 'Plank',
              sortOrder: 0,
              restTimeSeconds: 30,
              templateSets: [
                buildSet(
                  sortOrder: 0,
                  value2: 45,
                  unit1: null,
                  unit2: WorkoutUnit.seconds,
                ),
              ],
            ),
            WorkoutExercise(
              id: 'exercise-2',
              name: 'Running',
              canonicalName: 'Running',
              sortOrder: 1,
              restTimeSeconds: 0,
              templateSets: [
                buildSet(
                  sortOrder: 0,
                  value2: 5,
                  unit1: null,
                  unit2: WorkoutUnit.kilometers,
                ),
              ],
            ),
            // Units with no keyword of their own fall back to the generic
            // value/unit pair rather than being silently turned into reps.
            WorkoutExercise(
              id: 'exercise-3',
              name: 'Stationary Bike',
              canonicalName: 'Stationary Bike',
              sortOrder: 2,
              restTimeSeconds: 0,
              templateSets: [
                buildSet(
                  sortOrder: 0,
                  value1: 8,
                  value2: 20,
                  unit1: WorkoutUnit.level,
                  unit2: WorkoutUnit.minutes,
                ),
              ],
            ),
          ],
        ),
      ];

      final json = serializer.serialize(routines, languageCode: 'en');
      final imported = parser.parse(json).routines.single;

      final plank = imported.exercises[0].templateSets.single;
      expect(plank.targetValue2, 45.0);
      expect(plank.unit2, WorkoutUnit.seconds);

      final running = imported.exercises[1].templateSets.single;
      expect(running.targetValue2, 5.0);
      expect(running.unit2, WorkoutUnit.kilometers);

      final bike = imported.exercises[2].templateSets.single;
      expect(bike.targetValue1, 8.0);
      expect(bike.unit1, WorkoutUnit.level);
      expect(bike.targetValue2, 20.0);
      expect(bike.unit2, WorkoutUnit.minutes);
    });

    test('a routine exported in one language re-imports linked in another', () {
      // The catalog link is what makes this work: the name goes out in Spanish,
      // comes back matched to its canonical English key, and then renders in
      // whatever language the importing app is set to.
      final routines = <WorkoutRoutine>[
        WorkoutRoutine(
          id: 'routine-1',
          name: 'Torso',
          sortOrder: 0,
          exercises: [
            WorkoutExercise(
              id: 'exercise-1',
              name: 'Bench Press',
              canonicalName: 'Bench Press',
              sortOrder: 0,
              restTimeSeconds: 60,
              templateSets: [buildSet(sortOrder: 0, value1: 50, value2: 10)],
            ),
          ],
        ),
      ];

      final spanish = serializer.serialize(routines, languageCode: 'es');
      expect(spanish, contains('Press de Banca'));

      final imported = parser.parse(spanish).routines.single.exercises.single;
      expect(imported.canonicalName, 'Bench Press');
      expect(imported.displayName('de'), isNot('Press de Banca'));
      expect(imported.displayName('en'), 'Bench Press');
    });

    test('nothing to export produces an empty routine list, not broken JSON', () {
      final json = serializer.serialize(const [], languageCode: 'en');
      expect(jsonDecode(json), <String, Object?>{'routines': <Object?>[]});
    });
  });
}
