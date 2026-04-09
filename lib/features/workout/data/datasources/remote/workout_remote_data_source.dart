import '../../dtos/exercise_remote_dto.dart';
import '../../dtos/library_exercise_remote_dto.dart';
import '../../dtos/routine_remote_dto.dart';
import '../../dtos/session_remote_dto.dart';
import '../../dtos/set_log_remote_dto.dart';
import '../../dtos/set_remote_dto.dart';
import '../../../domain/entities/workout_entities.dart';
import '../../../domain/repositories/workout_repository.dart';

abstract class WorkoutRemoteDataSource {
  Future<void> upsertRoutine(String uid, WorkoutRoutine routine);
  Future<void> upsertExercise(String uid, WorkoutExercise exercise, String routineId);
  Future<void> upsertSet(String uid, WorkoutSet workoutSet, String exerciseId);
  Future<void> upsertSession(String uid, WorkoutSession session);
  Future<void> upsertSetLog(String uid, SetLog setLog);
  Future<void> upsertLibraryExercise(String uid, LibraryExerciseEntity libraryExercise);

  Future<void> markRoutineDeleted(String uid, String routineId);
  Future<void> markExerciseDeleted(String uid, String exerciseId);
  Future<void> markSetDeleted(String uid, String setId);
  Future<void> markSessionDeleted(String uid, String sessionId);
  Future<void> markSetLogDeleted(String uid, String setLogId);
  Future<void> markLibraryExerciseDeleted(String uid, String exerciseId);

  Future<List<RoutineRemoteDto>> fetchRoutinesUpdatedSince(String uid, DateTime? updatedSince, {int limit = 500});
  Future<List<ExerciseRemoteDto>> fetchExercisesUpdatedSince(String uid, DateTime? updatedSince, {int limit = 500});
  Future<List<SetRemoteDto>> fetchSetsUpdatedSince(String uid, DateTime? updatedSince, {int limit = 500});
  Future<List<SessionRemoteDto>> fetchSessionsUpdatedSince(String uid, DateTime? updatedSince, {int limit = 500});
  Future<List<SetLogRemoteDto>> fetchSetLogsUpdatedSince(String uid, DateTime? updatedSince, {int limit = 500});
  Future<List<LibraryExerciseRemoteDto>> fetchLibraryExercisesUpdatedSince(String uid, DateTime? updatedSince, {int limit = 500});

  Future<void> upsertTrainingDefaults(
    String uid, {
    required int? defaultRestSeconds,
    required int? defaultRepetitions,
    required double? defaultWeight,
    required DateTime updatedAt,
  });

  Future<Map<String, dynamic>?> fetchTrainingDefaults(String uid);
}
