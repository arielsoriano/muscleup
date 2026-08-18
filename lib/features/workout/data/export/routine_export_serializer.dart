import 'dart:convert';

import '../../domain/entities/workout_entities.dart';

/// Turns the user's routines back into the JSON the import screen accepts.
///
/// Export and import are deliberately the same format, not two formats that
/// happen to look alike: the output of this class is fed straight back through
/// [RoutineImportParser] by `routine_export_round_trip_test.dart`, so the file
/// a user saves is one they can always paste back in — including into a fresh
/// install, which is the whole point of having it.
///
/// Two things the format cannot carry, both inherent to it rather than to this
/// class:
///
/// - Session history. The shape describes routines only; logged workouts have
///   no place in it. Cloud sync is what carries those.
/// - A set with no repetition target comes back with the importing user's
///   default repetitions instead of staying empty, because an absent field
///   means "use my default" on the way in. Weights are unaffected: the import
///   never invents a load.
class RoutineExportSerializer {
  const RoutineExportSerializer();

  /// Indented on purpose. This lands in a text field the user reads, scrolls
  /// and pastes into a file — the few extra bytes buy the ability to see at a
  /// glance that the export really did capture everything.
  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  String serialize(
    List<WorkoutRoutine> routines, {
    required String languageCode,
  }) {
    return _encoder.convert(toJson(routines, languageCode: languageCode));
  }

  Map<String, Object?> toJson(
    List<WorkoutRoutine> routines, {
    required String languageCode,
  }) {
    final ordered = [...routines]
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    return <String, Object?>{
      'routines': [
        for (final routine in ordered) _routine(routine, languageCode),
      ],
    };
  }

  Map<String, Object?> _routine(WorkoutRoutine routine, String languageCode) {
    final ordered = [...routine.exercises]
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    return <String, Object?>{
      'name': routine.name,
      'exercises': [
        for (final exercise in ordered) _exercise(exercise, languageCode),
      ],
    };
  }

  Map<String, Object?> _exercise(WorkoutExercise exercise, String languageCode) {
    final json = <String, Object?>{
      // The name as the user currently sees it, not the raw stored `name`.
      // The catalog link is not written out as a field: the import recovers it
      // with ExerciseLibrary.canonicalNameFor, which recognises a catalog
      // exercise by its name in any of the shipped languages. So a routine
      // exported in Spanish still links up when imported into an app set to
      // German, and keeps following the reader's language afterwards.
      'name': exercise.displayName(languageCode),
    };

    final notes = exercise.notes?.trim();
    if (notes != null && notes.isNotEmpty) {
      json['notes'] = notes;
    }

    if (exercise.restTimeSeconds > 0) {
      json['restSeconds'] = exercise.restTimeSeconds;
    }

    final sets = [...exercise.templateSets]
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    if (sets.isEmpty) {
      // The import gives an exercise at least one set regardless, so saying
      // "one set, no targets" is the honest way to write this out.
      json['sets'] = 1;
      return json;
    }

    // When every set carries the same targets — which is most of the time —
    // collapse to the compact "sets: 4, reps: 10, weight: 60" shape rather than
    // repeating four identical objects. It reads the way the import
    // instructions describe it, and parses back to the same thing.
    if (_allTargetsMatch(sets)) {
      json['sets'] = sets.length;
      json.addAll(_targets(sets.first));
      return json;
    }

    json['sets'] = [for (final set in sets) _targets(set)];
    return json;
  }

  bool _allTargetsMatch(List<WorkoutSet> sets) {
    final first = sets.first;
    return sets.every(
      (set) =>
          set.targetValue1 == first.targetValue1 &&
          set.targetValue2 == first.targetValue2 &&
          set.unit1 == first.unit1 &&
          set.unit2 == first.unit2,
    );
  }

  /// The load and the repetition target for one set.
  ///
  /// Both prefer the named keys the import instructions document (`weight`,
  /// `reps`, `seconds`, ...) and fall back to the generic `value1`/`unit1`
  /// pair for units that have no keyword of their own — `level` and `incline`
  /// on a machine, for instance. The generic pair round-trips just as exactly;
  /// it is only less pleasant to read.
  Map<String, Object?> _targets(WorkoutSet set) {
    final json = <String, Object?>{};

    final value1 = set.targetValue1;
    if (value1 != null) {
      final weightUnit = _weightUnitAlias(set.unit1);
      if (weightUnit != null) {
        json['weight'] = _number(value1);
        json['weightUnit'] = weightUnit;
      } else {
        json['value1'] = _number(value1);
        if (set.unit1 != null) {
          json['unit1'] = set.unit1!.name;
        }
      }
    }

    final value2 = set.targetValue2;
    if (value2 != null) {
      final keyword = _secondaryKeyword(set.unit2);
      if (keyword != null) {
        json[keyword] = _number(value2);
      } else {
        json['value2'] = _number(value2);
        if (set.unit2 != null) {
          json['unit2'] = set.unit2!.name;
        }
      }
    }

    return json;
  }

  String? _weightUnitAlias(WorkoutUnit? unit) {
    return switch (unit) {
      WorkoutUnit.kilograms => 'kg',
      WorkoutUnit.pounds => 'lb',
      _ => null,
    };
  }

  String? _secondaryKeyword(WorkoutUnit? unit) {
    return switch (unit) {
      WorkoutUnit.repetitions => 'reps',
      WorkoutUnit.seconds => 'seconds',
      WorkoutUnit.minutes => 'minutes',
      WorkoutUnit.kilometers => 'km',
      WorkoutUnit.meters => 'meters',
      _ => null,
    };
  }

  /// Whole numbers go out as integers so a routine of 4x10 at 60 kg does not
  /// read as "4x10.0 at 60.0".
  Object _number(double value) {
    return value == value.roundToDouble() && value.abs() < 1e15
        ? value.toInt()
        : value;
  }
}
