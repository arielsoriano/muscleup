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
}

@freezed
class WorkoutRoutine with _$WorkoutRoutine {
  const factory WorkoutRoutine({
    required String id,
    required String name,
    required int sortOrder,
    required List<WorkoutExercise> exercises,
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
  }) = _WorkoutSet;
}

@freezed
class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    required String routineId,
    required DateTime date,
    String? notes,
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
  }) = _SetLog;
}
