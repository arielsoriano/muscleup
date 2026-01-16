import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_entities.freezed.dart';

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
    String? unit1,
    String? unit2,
  }) = _WorkoutSet;
}
