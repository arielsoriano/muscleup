import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/features/workout/data/import/routine_import_parser.dart';
import 'package:muscleup/features/workout/domain/entities/workout_entities.dart';

void main() {
  late RoutineImportParser parser;

  setUp(() {
    parser = RoutineImportParser();
  });

  const defaults = RoutineImportDefaults(restSeconds: 60, repetitions: 12);

  group('shape tolerance', () {
    test('reads a plain routines object', () {
      final result = parser.parse('''
{"routines":[{"name":"Monday","exercises":[{"name":"Bench Press","sets":3,"reps":10}]}]}
''');

      expect(result.failure, isNull);
      expect(result.routines, hasLength(1));
      expect(result.routines.single.name, 'Monday');
      expect(result.routines.single.exercises.single.templateSets, hasLength(3));
    });

    test('unwraps a fenced code block with prose around it', () {
      final result = parser.parse('''
Sure! Here is your plan:

```json
{"routines":[{"name":"Monday","exercises":[{"name":"Squat","sets":2,"reps":5}]}]}
```

Let me know if you want changes.
''');

      expect(result.routines, hasLength(1));
      expect(result.routines.single.exercises.single.name, 'Squat');
    });

    test('recovers JSON preceded by prose and no code fence', () {
      final result = parser.parse(
        'Here you go: {"routines":[{"name":"Legs","exercises":["Squat"]}]}',
      );

      expect(result.routines.single.name, 'Legs');
    });

    test('picks the plan when the reply also shows a smaller snippet', () {
      final result = parser.parse('''
For example a set looks like {"weight": 20, "reps": 12}. Your full plan:

{"routines":[{"name":"Monday","exercises":[{"name":"Squat","sets":3,"reps":5}]}]}
''');

      expect(result.routines.single.name, 'Monday');
    });

    test('is not thrown off by a brace inside a note', () {
      final result = parser.parse(
        '{"routines":[{"name":"A","exercises":[{"name":"Squat","notes":"grip } wide"}]}]}',
      );

      expect(result.routines.single.exercises.single.notes, 'grip } wide');
    });

    test('accepts a bare list of routines', () {
      final result = parser.parse(
        '[{"name":"Push","exercises":[{"name":"Bench Press"}]}]',
      );

      expect(result.routines, hasLength(1));
    });

    test('accepts a single unwrapped routine', () {
      final result = parser.parse(
        '{"name":"Full body","exercises":[{"name":"Deadlift"}]}',
      );

      expect(result.routines.single.name, 'Full body');
    });

    test('accepts an exercise given as a bare string', () {
      final result = parser.parse(
        '{"routines":[{"name":"Monday","exercises":["Pull-up","Plank"]}]}',
        defaults: defaults,
      );

      final exercises = result.routines.single.exercises;
      expect(exercises.map((exercise) => exercise.name), ['Pull-up', 'Plank']);
      expect(exercises.first.templateSets, hasLength(1));
      expect(exercises.first.restTimeSeconds, 60);
    });

    test('matches keys case-insensitively and ignores underscores', () {
      final result = parser.parse(
        '{"Routines":[{"NAME":"Monday","exercises":[{"name":"Squat","rest_seconds":90}]}]}',
      );

      expect(result.routines.single.exercises.single.restTimeSeconds, 90);
    });
  });

  group('failures', () {
    test('reports empty input', () {
      expect(
        parser.parse('   ').failure,
        RoutineImportFailure.emptyInput,
      );
    });

    test('reports text that is not JSON', () {
      expect(
        parser.parse('LUNES — Torso\n1. Press inclinado').failure,
        RoutineImportFailure.invalidJson,
      );
    });

    test('reports JSON without routines', () {
      expect(
        parser.parse('{"plan":"none"}').failure,
        RoutineImportFailure.noRoutines,
      );
    });

    test('reports a paste where every routine was skipped', () {
      final result = parser.parse('{"routines":[{"name":"Wednesday"}]}');

      expect(result.failure, RoutineImportFailure.noRoutines);
      expect(
        result.notices.single.kind,
        RoutineImportNoticeKind.routineWithoutExercises,
      );
    });
  });

  group('set targets', () {
    test('repeats uniform targets across the set count', () {
      final result = parser.parse('''
{"routines":[{"name":"Monday","exercises":[
  {"name":"Bench Press","sets":3,"reps":8,"weight":60,"weightUnit":"kg"}
]}]}
''');

      final sets = result.routines.single.exercises.single.templateSets;
      expect(sets, hasLength(3));
      expect(sets.map((set) => set.targetValue1), everyElement(60.0));
      expect(sets.map((set) => set.targetValue2), everyElement(8.0));
      expect(sets.first.unit1, WorkoutUnit.kilograms);
      expect(sets.first.unit2, WorkoutUnit.repetitions);
      expect(sets.map((set) => set.sortOrder), [0, 1, 2]);
      expect(sets.map((set) => set.id).toSet(), hasLength(3));
    });

    test('reads a per-set list with different targets', () {
      final result = parser.parse('''
{"routines":[{"name":"Monday","exercises":[
  {"name":"Squat","sets":[{"weight":40,"reps":12},{"weight":50,"reps":10}]}
]}]}
''');

      final sets = result.routines.single.exercises.single.templateSets;
      expect(sets.map((set) => set.targetValue1), [40.0, 50.0]);
      expect(sets.map((set) => set.targetValue2), [12.0, 10.0]);
    });

    test('inherits exercise-level targets into a partial set list', () {
      final result = parser.parse('''
{"routines":[{"name":"Monday","exercises":[
  {"name":"Squat","reps":10,"weight":45,"sets":[{"weight":55},{}]}
]}]}
''');

      final sets = result.routines.single.exercises.single.templateSets;
      expect(sets.map((set) => set.targetValue1), [55.0, 45.0]);
      expect(sets.map((set) => set.targetValue2), everyElement(10.0));
    });

    test('converts pounds', () {
      final result = parser.parse(
        '{"routines":[{"name":"A","exercises":[{"name":"Bench Press","weight":135,"weightUnit":"lbs"}]}]}',
      );

      expect(
        result.routines.single.exercises.single.templateSets.single.unit1,
        WorkoutUnit.pounds,
      );
    });

    test('uses seconds instead of repetitions for a timed exercise', () {
      final result = parser.parse(
        '{"routines":[{"name":"A","exercises":[{"name":"Plank","sets":3,"seconds":45}]}]}',
        defaults: defaults,
      );

      final set = result.routines.single.exercises.single.templateSets.first;
      expect(set.targetValue2, 45.0);
      expect(set.unit2, WorkoutUnit.seconds);
      expect(set.targetValue1, isNull);
    });

    test('leaves an unstated load empty and fills in the usual reps', () {
      final result = parser.parse(
        '{"routines":[{"name":"A","exercises":[{"name":"Squat","sets":2}]}]}',
        defaults: defaults,
      );

      final set = result.routines.single.exercises.single.templateSets.first;
      // A guessed load would surface mid-workout as a target the user never
      // set; repetitions and rest are generic enough to default.
      expect(set.targetValue1, isNull);
      expect(set.targetValue2, 12.0);
      expect(result.routines.single.exercises.single.restTimeSeconds, 60);
    });

    test('reads cardio distances and durations', () {
      final result = parser.parse('''
{"routines":[{"name":"Cardio","exercises":[
  {"name":"Running","sets":1,"minutes":30},
  {"name":"Cycling","sets":1,"km":15}
]}]}
''');

      final exercises = result.routines.single.exercises;
      expect(exercises.first.templateSets.single.unit2, WorkoutUnit.minutes);
      expect(exercises.first.templateSets.single.targetValue2, 30.0);
      expect(exercises.last.templateSets.single.unit2, WorkoutUnit.kilometers);
      expect(exercises.last.templateSets.single.targetValue2, 15.0);
    });

    test('accepts the generic value and unit escape hatch', () {
      final result = parser.parse('''
{"routines":[{"name":"A","exercises":[
  {"name":"Treadmill","sets":1,"value1":8,"unit1":"level","value2":20,"unit2":"minutes"}
]}]}
''');

      final set = result.routines.single.exercises.single.templateSets.single;
      expect(set.targetValue1, 8.0);
      expect(set.unit1, WorkoutUnit.level);
      expect(set.targetValue2, 20.0);
      expect(set.unit2, WorkoutUnit.minutes);
    });

    test('reads numbers that arrived as strings, with units or commas', () {
      final result = parser.parse('''
{"routines":[{"name":"A","exercises":[
  {"name":"Squat","sets":"3","reps":"8-12","weight":"22,5 kg","rest":"90s"}
]}]}
''');

      final exercise = result.routines.single.exercises.single;
      expect(exercise.templateSets, hasLength(3));
      expect(exercise.templateSets.first.targetValue2, 8.0);
      expect(exercise.templateSets.first.targetValue1, 22.5);
      expect(exercise.restTimeSeconds, 90);
    });

    test('clamps absurd values instead of storing them', () {
      final result = parser.parse('''
{"routines":[{"name":"A","exercises":[
  {"name":"Squat","sets":9999,"reps":10,"weight":999999,"restSeconds":999999}
]}]}
''');

      final exercise = result.routines.single.exercises.single;
      expect(exercise.templateSets.length, lessThanOrEqualTo(40));
      expect(exercise.templateSets.first.targetValue1, 5000.0);
      expect(exercise.restTimeSeconds, 7200);
    });
  });

  group('catalog linking', () {
    test('links a name written in another language to its catalog entry', () {
      final result = parser.parse(
        '{"routines":[{"name":"Lunes","exercises":[{"name":"Press de banca"}]}]}',
      );

      final exercise = result.routines.single.exercises.single;
      expect(exercise.canonicalName, 'Bench Press');
      // The pasted text is kept as the stored name; the display name comes from
      // the catalog, so the routine reads correctly in any language.
      expect(exercise.name, 'Press de banca');
      expect(exercise.displayName('de'), 'Bankdrücken');
      expect(exercise.displayName('en'), 'Bench Press');
    });

    test('leaves an exercise the user invented unlinked', () {
      final result = parser.parse(
        '{"routines":[{"name":"A","exercises":[{"name":"Sillón de cuádriceps invertido"}]}]}',
      );

      final exercise = result.routines.single.exercises.single;
      expect(exercise.canonicalName, isNull);
      expect(exercise.displayName('de'), 'Sillón de cuádriceps invertido');
    });
  });

  group('notices', () {
    test('skips a rest day and says so', () {
      final result = parser.parse('''
{"routines":[
  {"name":"Monday","exercises":[{"name":"Squat"}]},
  {"name":"Wednesday — Rest","exercises":[]}
]}
''');

      expect(result.routines, hasLength(1));
      final notice = result.notices.single;
      expect(notice.kind, RoutineImportNoticeKind.routineWithoutExercises);
      expect(notice.subject, 'Wednesday — Rest');
    });

    test('counts nameless routines and exercises', () {
      final result = parser.parse('''
{"routines":[
  {"exercises":[{"name":"Squat"}]},
  {"name":"Monday","exercises":[{"name":"Squat"},{"reps":10},{"name":"  "}]}
]}
''');

      expect(result.routines, hasLength(1));
      expect(result.routines.single.exercises, hasLength(1));

      final skippedRoutines = result.notices.firstWhere(
        (notice) => notice.kind == RoutineImportNoticeKind.skippedRoutines,
      );
      expect(skippedRoutines.count, 1);

      final skippedExercises = result.notices.firstWhere(
        (notice) => notice.kind == RoutineImportNoticeKind.skippedExercises,
      );
      expect(skippedExercises.count, 2);
      expect(skippedExercises.subject, 'Monday');
    });

    test('warns about a name the user already has but still imports it', () {
      final result = parser.parse(
        '{"routines":[{"name":"lunes","exercises":[{"name":"Squat"}]}]}',
        existingRoutineNames: const {'Lunes'},
      );

      expect(result.routines, hasLength(1));
      expect(
        result.notices.single.kind,
        RoutineImportNoticeKind.duplicateRoutineName,
      );
    });

    test('warns about a name repeated inside the same paste', () {
      final result = parser.parse('''
{"routines":[
  {"name":"Monday","exercises":[{"name":"Squat"}]},
  {"name":"Monday","exercises":[{"name":"Deadlift"}]}
]}
''');

      expect(result.routines, hasLength(2));
      expect(
        result.notices.single.kind,
        RoutineImportNoticeKind.duplicateRoutineName,
      );
    });
  });

  group('ordering and identity', () {
    test('appends routines after the ones the user already has', () {
      final result = parser.parse('''
{"routines":[
  {"name":"A","exercises":[{"name":"Squat"}]},
  {"name":"B","exercises":[{"name":"Deadlift"}]}
]}
''',
        startSortOrder: 5,
      );

      expect(result.routines.map((routine) => routine.sortOrder), [5, 6]);
    });

    test('numbers exercises in the order they were written', () {
      final result = parser.parse('''
{"routines":[{"name":"A","exercises":[
  {"name":"Squat"},{"name":"Leg Press"},{"name":"Leg Curl"}
]}]}
''');

      expect(
        result.routines.single.exercises.map((exercise) => exercise.sortOrder),
        [0, 1, 2],
      );
    });

    test('gives every routine, exercise and set a distinct id', () {
      final result = parser.parse('''
{"routines":[
  {"name":"A","exercises":[{"name":"Squat","sets":2},{"name":"Leg Press","sets":2}]},
  {"name":"B","exercises":[{"name":"Deadlift","sets":2}]}
]}
''');

      final ids = <String>[
        for (final routine in result.routines) ...[
          routine.id,
          for (final exercise in routine.exercises) ...[
            exercise.id,
            for (final set in exercise.templateSets) set.id,
          ],
        ],
      ];

      expect(ids.toSet(), hasLength(ids.length));
    });
  });

  group('notes', () {
    test('keeps the note the assistant separated out', () {
      final result = parser.parse('''
{"routines":[{"name":"A","exercises":[
  {"name":"Lunges","reps":12,"notes":"12 per leg"}
]}]}
''');

      expect(result.routines.single.exercises.single.notes, '12 per leg');
    });

    test('collapses whitespace and leaves an empty note null', () {
      final result = parser.parse('''
{"routines":[{"name":"A","exercises":[
  {"name":"  Leg   Press  ","notes":"   "}
]}]}
''');

      final exercise = result.routines.single.exercises.single;
      expect(exercise.name, 'Leg Press');
      expect(exercise.notes, isNull);
    });
  });

  test('imports the whole plan from a realistic assistant reply', () {
    final result = parser.parse('''
```json
{
  "routines": [
    {
      "name": "LUNES — Torso",
      "exercises": [
        {"name": "Press inclinado con mancuernas", "sets": 4, "reps": 10, "weight": 22.5, "restSeconds": 90},
        {"name": "Jalón al pecho", "sets": 4, "reps": 12},
        {"name": "Elevaciones laterales con mancuernas", "sets": 3, "reps": 15, "weight": 8}
      ]
    },
    {
      "name": "MARTES — Piernas",
      "exercises": [
        {"name": "Prensa de piernas", "sets": 4, "reps": 12},
        {"name": "Step-up con mancuernas", "sets": 3, "reps": 12, "notes": "12 por pierna"},
        {"name": "Bicho muerto", "sets": 3, "reps": 12, "notes": "12 por lado"}
      ]
    },
    {"name": "MIÉRCOLES — Descanso", "exercises": []}
  ]
}
```
''',
      defaults: defaults,
    );

    expect(result.failure, isNull);
    expect(result.routines, hasLength(2));
    expect(result.exerciseCount, 6);
    expect(
      result.notices.single.kind,
      RoutineImportNoticeKind.routineWithoutExercises,
    );

    final legs = result.routines.last;
    expect(legs.name, 'MARTES — Piernas');
    expect(legs.exercises[1].notes, '12 por pierna');
    // Not in the catalog, so it keeps the Spanish text and no link.
    expect(legs.exercises[1].canonicalName, isNull);

    final pulldown = result.routines.first.exercises[1];
    expect(pulldown.canonicalName, 'Lat Pulldown');
    expect(pulldown.templateSets, hasLength(4));
    // No weight in the notes for this one, so it arrives empty.
    expect(pulldown.templateSets.first.targetValue1, isNull);
    expect(pulldown.templateSets.first.targetValue2, 12.0);
    // No rest in the notes either, so the user's default applies.
    expect(pulldown.restTimeSeconds, 60);
  });
}
