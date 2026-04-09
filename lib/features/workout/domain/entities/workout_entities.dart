import 'package:freezed_annotation/freezed_annotation.dart';

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
    required String name,
    required int sortOrder,
    String? notes,
    required int restTimeSeconds,
    required List<WorkoutSet> templateSets,
    SyncMetadata? syncMetadata,
  }) = _WorkoutExercise;
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
