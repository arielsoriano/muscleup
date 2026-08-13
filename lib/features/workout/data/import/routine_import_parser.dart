import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../../../../core/constants/exercise_library.dart';
import '../../domain/entities/workout_entities.dart';

/// Why the pasted text could not be turned into routines at all.
///
/// Anything less than fatal is reported as a [RoutineImportNotice] instead, so
/// a paste with one bad day still imports the rest.
enum RoutineImportFailure {
  emptyInput,
  invalidJson,
  noRoutines,
}

enum RoutineImportNoticeKind {
  /// A day with a name but nothing to do — a rest day, most often.
  routineWithoutExercises,

  /// Entries that carried no usable name at all.
  skippedRoutines,

  /// Exercises dropped from an otherwise valid routine.
  skippedExercises,

  /// The name is already taken by a routine the user has. Importing anyway is
  /// deliberate: overwriting what is already there would be worse.
  duplicateRoutineName,
}

class RoutineImportNotice {
  const RoutineImportNotice(this.kind, {this.subject = '', this.count = 0});

  final RoutineImportNoticeKind kind;
  final String subject;
  final int count;
}

/// The values an imported set falls back to when the pasted text is silent
/// about repetitions or rest — the user's own training defaults, so an imported
/// exercise looks like a hand-added one.
///
/// There is deliberately no default weight. Adding an exercise by hand puts the
/// default load in a field the user is already looking at and corrects; an
/// import of two dozen exercises would instead bury two dozen invented targets,
/// which then surface mid-workout as "45 kg" on a calf raise. A load the notes
/// never mentioned is left empty.
class RoutineImportDefaults {
  const RoutineImportDefaults({
    this.restSeconds = 0,
    this.repetitions,
  });

  final int restSeconds;
  final int? repetitions;
}

class RoutineImportResult {
  const RoutineImportResult({
    this.failure,
    this.routines = const <WorkoutRoutine>[],
    this.notices = const <RoutineImportNotice>[],
  });

  const RoutineImportResult.failed(RoutineImportFailure failure)
      : this(failure: failure);

  final RoutineImportFailure? failure;
  final List<WorkoutRoutine> routines;
  final List<RoutineImportNotice> notices;

  bool get isSuccess => failure == null && routines.isNotEmpty;

  int get exerciseCount =>
      routines.fold(0, (total, routine) => total + routine.exercises.length);
}

/// Turns the JSON an assistant produced from someone's training notes into
/// routines ready to be saved.
///
/// The input is text a person copied out of a chat window, not an API response:
/// it arrives wrapped in code fences, prefaced with "Here you go!", with
/// numbers as strings and units spelled a dozen ways. Every one of those is
/// recovered rather than rejected — a parse error means the user has to go back
/// to the chat and try again, which is the whole friction this feature exists
/// to remove.
class RoutineImportParser {
  RoutineImportParser({Uuid uuid = const Uuid()}) : _uuid = uuid;

  final Uuid _uuid;

  /// Caps that keep a pathological paste from locking up the UI or the
  /// database. They are far above any real training plan.
  static const int _maxRoutines = 60;
  static const int _maxExercisesPerRoutine = 120;
  static const int _maxSetsPerExercise = 40;
  static const int _maxNameLength = 120;
  static const int _maxNotesLength = 1000;
  static const double _maxWeight = 5000;
  static const double _maxSecondaryValue = 100000;
  static const int _maxRestSeconds = 7200;

  RoutineImportResult parse(
    String source, {
    RoutineImportDefaults defaults = const RoutineImportDefaults(),
    Set<String> existingRoutineNames = const <String>{},
    int startSortOrder = 0,
  }) {
    if (source.trim().isEmpty) {
      return const RoutineImportResult.failed(RoutineImportFailure.emptyInput);
    }

    final decoded = _decode(source);
    if (decoded == null) {
      return const RoutineImportResult.failed(RoutineImportFailure.invalidJson);
    }

    final rawRoutines = _rootRoutines(decoded);
    if (rawRoutines == null) {
      return const RoutineImportResult.failed(RoutineImportFailure.noRoutines);
    }

    final notices = <RoutineImportNotice>[];
    final routines = <WorkoutRoutine>[];
    final takenNames = <String>{
      for (final name in existingRoutineNames) name.trim().toLowerCase(),
    };
    var skippedRoutines = 0;

    if (rawRoutines.length > _maxRoutines) {
      skippedRoutines += rawRoutines.length - _maxRoutines;
    }

    for (final raw in rawRoutines.take(_maxRoutines)) {
      if (raw is! Map) {
        skippedRoutines++;
        continue;
      }

      final name = _text(
        _pick(raw, const ['name', 'routine', 'title', 'day', 'nombre']),
        maxLength: _maxNameLength,
      );
      if (name == null) {
        skippedRoutines++;
        continue;
      }

      final rawExercises =
          _pick(raw, const ['exercises', 'items', 'ejercicios']);
      final exerciseList = rawExercises is List ? rawExercises : const [];
      if (exerciseList.isEmpty) {
        notices.add(
          RoutineImportNotice(
            RoutineImportNoticeKind.routineWithoutExercises,
            subject: name,
          ),
        );
        continue;
      }

      var skippedExercises = 0;
      if (exerciseList.length > _maxExercisesPerRoutine) {
        skippedExercises += exerciseList.length - _maxExercisesPerRoutine;
      }

      final exercises = <WorkoutExercise>[];
      for (final rawExercise in exerciseList.take(_maxExercisesPerRoutine)) {
        final exercise = _parseExercise(
          rawExercise,
          sortOrder: exercises.length,
          defaults: defaults,
        );
        if (exercise == null) {
          skippedExercises++;
          continue;
        }
        exercises.add(exercise);
      }

      if (skippedExercises > 0) {
        notices.add(
          RoutineImportNotice(
            RoutineImportNoticeKind.skippedExercises,
            subject: name,
            count: skippedExercises,
          ),
        );
      }

      if (exercises.isEmpty) {
        notices.add(
          RoutineImportNotice(
            RoutineImportNoticeKind.routineWithoutExercises,
            subject: name,
          ),
        );
        continue;
      }

      if (!takenNames.add(name.trim().toLowerCase())) {
        notices.add(
          RoutineImportNotice(
            RoutineImportNoticeKind.duplicateRoutineName,
            subject: name,
          ),
        );
      }

      routines.add(
        WorkoutRoutine(
          id: _uuid.v4(),
          name: name,
          sortOrder: startSortOrder + routines.length,
          exercises: exercises,
        ),
      );
    }

    if (skippedRoutines > 0) {
      notices.add(
        RoutineImportNotice(
          RoutineImportNoticeKind.skippedRoutines,
          count: skippedRoutines,
        ),
      );
    }

    if (routines.isEmpty) {
      return RoutineImportResult(
        failure: RoutineImportFailure.noRoutines,
        notices: notices,
      );
    }

    return RoutineImportResult(routines: routines, notices: notices);
  }

  WorkoutExercise? _parseExercise(
    Object? raw, {
    required int sortOrder,
    required RoutineImportDefaults defaults,
  }) {
    // A bare string is a legitimate shorthand — it is exactly what someone's
    // notes look like when they list exercise names and nothing else.
    if (raw is String) {
      final name = _text(raw, maxLength: _maxNameLength);
      if (name == null) return null;
      return _buildExercise(
        name: name,
        sortOrder: sortOrder,
        notes: null,
        restSeconds: defaults.restSeconds,
        sets: [_defaultSet(defaults, sortOrder: 0)],
      );
    }

    if (raw is! Map) return null;

    final name = _text(
      _pick(raw, const ['name', 'exercise', 'nombre', 'ejercicio']),
      maxLength: _maxNameLength,
    );
    if (name == null) return null;

    const restKeys = <String>[
      'restSeconds',
      'rest',
      'restTimeSeconds',
      'rest_seconds',
      'descanso',
    ];
    final restSeconds =
        _int(_pick(raw, restKeys))?.clamp(0, _maxRestSeconds) ??
            defaults.restSeconds;

    return _buildExercise(
      name: name,
      sortOrder: sortOrder,
      notes: _text(
        _pick(raw, const ['notes', 'note', 'notas', 'nota']),
        maxLength: _maxNotesLength,
      ),
      restSeconds: restSeconds,
      sets: _parseSets(raw, defaults: defaults),
    );
  }

  WorkoutExercise _buildExercise({
    required String name,
    required int sortOrder,
    required String? notes,
    required int restSeconds,
    required List<WorkoutSet> sets,
  }) {
    return WorkoutExercise(
      id: _uuid.v4(),
      name: name,
      // Recovering the catalog link is what makes an imported routine
      // language-portable: a plan pasted in Spanish still reads in German.
      // A name that is not in the catalog stays as the user wrote it.
      canonicalName: ExerciseLibrary.canonicalNameFor(name),
      sortOrder: sortOrder,
      notes: notes,
      restTimeSeconds: restSeconds,
      templateSets: sets,
    );
  }

  /// Reads the set targets, accepting both shapes an assistant produces:
  /// `"sets": 4` with the targets alongside it, and `"sets": [{...}, {...}]`
  /// when the sets differ from each other.
  List<WorkoutSet> _parseSets(
    Map<Object?, Object?> exercise, {
    required RoutineImportDefaults defaults,
  }) {
    final rawSets = _pick(exercise, const ['sets', 'setCount', 'series']);

    if (rawSets is List) {
      final sets = <WorkoutSet>[];
      for (final rawSet in rawSets.take(_maxSetsPerExercise)) {
        sets.add(
          _parseSet(
            rawSet is Map ? rawSet : const {},
            fallback: exercise,
            defaults: defaults,
            sortOrder: sets.length,
          ),
        );
      }
      if (sets.isNotEmpty) return sets;
    }

    final count =
        (_int(rawSets) ?? 1).clamp(1, _maxSetsPerExercise).toInt();

    // Every set of a uniform exercise carries the same targets, but each still
    // gets its own id: they are independently editable once imported.
    return List<WorkoutSet>.generate(
      count,
      (index) => _parseSet(
        const {},
        fallback: exercise,
        defaults: defaults,
        sortOrder: index,
      ),
    );
  }

  WorkoutSet _parseSet(
    Map<Object?, Object?> set, {
    required Map<Object?, Object?> fallback,
    required RoutineImportDefaults defaults,
    required int sortOrder,
  }) {
    final (value2, unit2) = _secondaryTarget(set, fallback, defaults);
    final (value1, unit1) = _primaryTarget(set, fallback);

    return WorkoutSet(
      id: _uuid.v4(),
      sortOrder: sortOrder,
      targetValue1: value1,
      targetValue2: value2,
      unit1: unit1,
      unit2: unit2,
    );
  }

  /// The load, which is only ever what the notes actually said. See
  /// [RoutineImportDefaults] for why nothing is filled in here.
  (double?, WorkoutUnit) _primaryTarget(
    Map<Object?, Object?> set,
    Map<Object?, Object?> fallback,
  ) {
    final value = _double(_pick(set, const ['value1', 'weight', 'peso'])) ??
        _double(_pick(fallback, const ['value1', 'weight', 'peso']));
    final unit = _unit(_pick(set, const ['unit1', 'weightUnit', 'weight_unit'])) ??
        _unit(_pick(fallback, const ['unit1', 'weightUnit', 'weight_unit']));

    return (
      value?.clamp(0, _maxWeight).toDouble(),
      unit ?? WorkoutUnit.kilograms,
    );
  }

  (double?, WorkoutUnit) _secondaryTarget(
    Map<Object?, Object?> set,
    Map<Object?, Object?> fallback,
    RoutineImportDefaults defaults,
  ) {
    // Ordered by how specific the key is: an explicit unit beats a keyword,
    // and a keyword beats the user's default repetitions.
    for (final source in [set, fallback]) {
      final generic = _double(_pick(source, const ['value2']));
      if (generic != null) {
        return (
          generic.clamp(0, _maxSecondaryValue).toDouble(),
          _unit(_pick(source, const ['unit2'])) ?? WorkoutUnit.repetitions,
        );
      }

      for (final candidate in const <(List<String>, WorkoutUnit)>[
        (['reps', 'repetitions', 'repeticiones'], WorkoutUnit.repetitions),
        (['seconds', 'secs', 'segundos'], WorkoutUnit.seconds),
        (['minutes', 'mins', 'minutos'], WorkoutUnit.minutes),
        (['kilometers', 'km'], WorkoutUnit.kilometers),
        (['meters', 'metros'], WorkoutUnit.meters),
      ]) {
        final value = _double(_pick(source, candidate.$1));
        if (value != null) {
          return (value.clamp(0, _maxSecondaryValue).toDouble(), candidate.$2);
        }
      }
    }

    return (defaults.repetitions?.toDouble(), WorkoutUnit.repetitions);
  }

  WorkoutSet _defaultSet(RoutineImportDefaults defaults, {required int sortOrder}) {
    return WorkoutSet(
      id: _uuid.v4(),
      sortOrder: sortOrder,
      targetValue1: null,
      targetValue2: defaults.repetitions?.toDouble(),
      unit1: WorkoutUnit.kilograms,
      unit2: WorkoutUnit.repetitions,
    );
  }

  // --- Decoding ------------------------------------------------------------

  /// Matches a fenced block, with or without a language tag. Assistants wrap
  /// JSON in one almost every time, and a fence is not valid JSON.
  static final RegExp _fencePattern =
      RegExp(r'```[a-zA-Z]*[ \t]*\r?\n?([\s\S]*?)```');

  Object? _decode(String source) {
    for (final candidate in _decodeCandidates(source)) {
      try {
        final decoded = jsonDecode(candidate);
        if (decoded is Map || decoded is List) {
          return decoded;
        }
      } on FormatException {
        continue;
      }
    }
    return null;
  }

  /// The text to try decoding, in order of confidence: as pasted, then the
  /// contents of each code fence, then each self-contained brace-balanced
  /// region — which is what rescues a paste with "Sure, here's your plan:" in
  /// front of it, or one where the assistant showed a small snippet before the
  /// real answer.
  Iterable<String> _decodeCandidates(String source) {
    final trimmed = source.trim();
    final candidates = <String>[trimmed];

    for (final match in _fencePattern.allMatches(trimmed)) {
      final inner = match.group(1)?.trim();
      if (inner != null && inner.isNotEmpty) {
        candidates.add(inner);
      }
    }

    // Longest first: when a reply holds more than one JSON block, the biggest
    // one is the plan and the smaller ones are illustrations of it.
    candidates.addAll(
      _balancedRegions(trimmed)
        ..sort((a, b) => b.length.compareTo(a.length)),
    );

    return candidates;
  }

  /// Every top-level `{...}` or `[...]` region in [source], brace-matched so a
  /// bracket inside a string value cannot end a region early.
  List<String> _balancedRegions(String source) {
    final regions = <String>[];
    var depth = 0;
    var start = -1;
    var inString = false;
    var escaped = false;

    for (var index = 0; index < source.length; index++) {
      final char = source[index];

      if (inString) {
        if (escaped) {
          escaped = false;
        } else if (char == r'\') {
          escaped = true;
        } else if (char == '"') {
          inString = false;
        }
        continue;
      }

      switch (char) {
        case '"':
          inString = true;
        case '{':
        case '[':
          if (depth == 0) start = index;
          depth++;
        case '}':
        case ']':
          if (depth == 0) break;
          depth--;
          if (depth == 0 && start >= 0) {
            regions.add(source.substring(start, index + 1));
            start = -1;
          }
      }
    }

    return regions;
  }

  List<Object?>? _rootRoutines(Object? decoded) {
    if (decoded is List) return decoded;
    if (decoded is! Map) return null;

    final routines = _pick(decoded, const ['routines', 'rutinas', 'workouts']);
    if (routines is List) return routines;

    // A single routine, unwrapped — the shape you get when the notes described
    // one day only.
    if (_pick(decoded, const ['exercises', 'items', 'ejercicios']) != null) {
      return [decoded];
    }

    return null;
  }

  // --- Field reading -------------------------------------------------------

  /// Reads the first present key out of [keys], matching case-insensitively so
  /// `restSeconds`, `restseconds` and `RestSeconds` all land.
  Object? _pick(Map<Object?, Object?> source, List<String> keys) {
    for (final key in keys) {
      if (source.containsKey(key)) {
        final value = source[key];
        if (value != null) return value;
      }
    }

    final normalized = <String, Object?>{};
    for (final entry in source.entries) {
      final key = entry.key;
      if (key is String && entry.value != null) {
        normalized[key.toLowerCase().replaceAll('_', '')] = entry.value;
      }
    }

    for (final key in keys) {
      final value = normalized[key.toLowerCase().replaceAll('_', '')];
      if (value != null) return value;
    }

    return null;
  }

  String? _text(Object? value, {required int maxLength}) {
    if (value == null) return null;
    final text = value is String ? value : value.toString();
    final collapsed = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (collapsed.isEmpty) return null;
    return collapsed.length > maxLength
        ? collapsed.substring(0, maxLength).trim()
        : collapsed;
  }

  /// Reads a number that may have arrived as a string with its unit attached
  /// ("22.5 kg", "90s") or with a decimal comma. A range such as "8-12" keeps
  /// its first number, which is the conservative target.
  double? _double(Object? value) {
    if (value is num) {
      final asDouble = value.toDouble();
      return asDouble.isFinite ? asDouble : null;
    }
    if (value is bool) return null;
    if (value is! String) return null;

    final match = RegExp(r'-?\d+(?:[.,]\d+)?').firstMatch(value);
    if (match == null) return null;
    return double.tryParse(match.group(0)!.replaceAll(',', '.'));
  }

  int? _int(Object? value) => _double(value)?.round();

  static const Map<String, WorkoutUnit> _unitAliases = <String, WorkoutUnit>{
    'kg': WorkoutUnit.kilograms,
    'kgs': WorkoutUnit.kilograms,
    'kilo': WorkoutUnit.kilograms,
    'kilos': WorkoutUnit.kilograms,
    'kilogram': WorkoutUnit.kilograms,
    'kilograms': WorkoutUnit.kilograms,
    'lb': WorkoutUnit.pounds,
    'lbs': WorkoutUnit.pounds,
    'pound': WorkoutUnit.pounds,
    'pounds': WorkoutUnit.pounds,
    'libra': WorkoutUnit.pounds,
    'libras': WorkoutUnit.pounds,
    'rep': WorkoutUnit.repetitions,
    'reps': WorkoutUnit.repetitions,
    'repetition': WorkoutUnit.repetitions,
    'repetitions': WorkoutUnit.repetitions,
    'repeticiones': WorkoutUnit.repetitions,
    's': WorkoutUnit.seconds,
    'sec': WorkoutUnit.seconds,
    'secs': WorkoutUnit.seconds,
    'second': WorkoutUnit.seconds,
    'seconds': WorkoutUnit.seconds,
    'segundos': WorkoutUnit.seconds,
    'min': WorkoutUnit.minutes,
    'mins': WorkoutUnit.minutes,
    'minute': WorkoutUnit.minutes,
    'minutes': WorkoutUnit.minutes,
    'minutos': WorkoutUnit.minutes,
    'km': WorkoutUnit.kilometers,
    'kilometer': WorkoutUnit.kilometers,
    'kilometers': WorkoutUnit.kilometers,
    'kilometre': WorkoutUnit.kilometers,
    'kilometres': WorkoutUnit.kilometers,
    'm': WorkoutUnit.meters,
    'meter': WorkoutUnit.meters,
    'meters': WorkoutUnit.meters,
    'metre': WorkoutUnit.meters,
    'metres': WorkoutUnit.meters,
    'metros': WorkoutUnit.meters,
    'none': WorkoutUnit.none,
    'level': WorkoutUnit.level,
    'incline': WorkoutUnit.incline,
  };

  WorkoutUnit? _unit(Object? value) {
    if (value is! String) return null;
    return _unitAliases[value.trim().toLowerCase()];
  }
}
