import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/exercise_library.dart';

part 'workout_entities.freezed.dart';

enum WorkoutUnit {
  kilograms,
  pounds,
  repetitions,
  seconds,
  minutes,
  kilometers,
  meters,
  none,
  level,
  incline,
}

@freezed
class SyncMetadata with _$SyncMetadata {
  const factory SyncMetadata({
    required DateTime updatedAt,
    DateTime? deletedAt,
    required String syncStatus,
    required int remoteVersion,
  }) = _SyncMetadata;
}

@freezed
class WorkoutRoutine with _$WorkoutRoutine {
  const factory WorkoutRoutine({
    required String id,
    required String name,
    required int sortOrder,
    required List<WorkoutExercise> exercises,
    SyncMetadata? syncMetadata,
  }) = _WorkoutRoutine;
}

@freezed
class WorkoutExercise with _$WorkoutExercise {
  const factory WorkoutExercise({
    required String id,

    /// The name as it was stored. For a catalog exercise this is whatever
    /// language it was added in; [WorkoutExerciseNaming.displayName] is what
    /// should be shown instead.
    required String name,
    required int sortOrder,
    String? notes,
    required int restTimeSeconds,
    required List<WorkoutSet> templateSets,

    /// The catalog entry this exercise came from, as its canonical English
    /// name, or null when the user typed the exercise in themselves.
    ///
    /// Storing the link rather than the translated text is what lets a routine
    /// built in one language read correctly in another: the name is resolved
    /// against the catalog every time it is shown, instead of being frozen at
    /// the moment the exercise was added.
    String? canonicalName,
    SyncMetadata? syncMetadata,
  }) = _WorkoutExercise;
}

extension WorkoutExerciseNaming on WorkoutExercise {
  /// The name to show the user, in [languageCode].
  ///
  /// Catalog exercises follow the app's language. Exercises the user created
  /// keep the name they typed, in the language they typed it — there is no
  /// translation for them to follow.
  String displayName(String languageCode) {
    final canonical = canonicalName;
    if (canonical == null) {
      return name;
    }

    // Looked up rather than resolved blindly: a canonical name that is no
    // longer in the catalog would otherwise render as the raw English key, and
    // the text the user actually saw when they built the routine is the better
    // thing to show.
    final entry = ExerciseLibrary.entryFor(canonical);
    if (entry == null) {
      return name;
    }

    final resolved = entry.names.resolve(languageCode);
    return resolved.isEmpty ? name : resolved;
  }
}

@freezed
class WorkoutSet with _$WorkoutSet {
  const factory WorkoutSet({
    required String id,
    required int sortOrder,
    double? targetValue1,
    double? targetValue2,
    WorkoutUnit? unit1,
    WorkoutUnit? unit2,
    SyncMetadata? syncMetadata,
  }) = _WorkoutSet;
}

@freezed
class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    required String routineId,
    required String routineName,
    required DateTime createdAt,
    String? notes,
    required bool isCompleted,
    SyncMetadata? syncMetadata,
  }) = _WorkoutSession;
}

@freezed
class SetLog with _$SetLog {
  const factory SetLog({
    required String id,
    required String sessionId,
    required String workoutExerciseId,
    required int setNumber,
    double? actualValue1,
    double? actualValue2,
    WorkoutUnit? unit1,
    WorkoutUnit? unit2,
    required bool isCompleted,
    required DateTime timestamp,
    SyncMetadata? syncMetadata,
  }) = _SetLog;
}
