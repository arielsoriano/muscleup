import '../../dtos/exercise_remote_dto.dart';
import '../../dtos/library_exercise_remote_dto.dart';
import '../../dtos/routine_remote_dto.dart';
import '../../dtos/session_remote_dto.dart';
import '../../dtos/set_log_remote_dto.dart';
import '../../dtos/set_remote_dto.dart';
import '../../../domain/entities/workout_entities.dart';
import '../../../domain/repositories/workout_repository.dart';

/// A single write intent for a batched push, expressed in domain terms so the
/// sync engine never needs to know about Firestore collections or types.
sealed class RemoteWriteOp {
  const RemoteWriteOp();
}

class UpsertRoutineOp extends RemoteWriteOp {
  const UpsertRoutineOp(this.routine);
  final WorkoutRoutine routine;
}

class UpsertExerciseOp extends RemoteWriteOp {
  const UpsertExerciseOp(this.exercise, this.routineId);
  final WorkoutExercise exercise;
  final String routineId;
}

class UpsertSetOp extends RemoteWriteOp {
  const UpsertSetOp(this.workoutSet, this.exerciseId);
  final WorkoutSet workoutSet;
  final String exerciseId;
}

class UpsertSessionOp extends RemoteWriteOp {
  const UpsertSessionOp(this.session);
  final WorkoutSession session;
}

class UpsertSetLogOp extends RemoteWriteOp {
  const UpsertSetLogOp(this.setLog);
  final SetLog setLog;
}

class UpsertLibraryExerciseOp extends RemoteWriteOp {
  const UpsertLibraryExerciseOp(this.libraryExercise);
  final LibraryExerciseEntity libraryExercise;
}

class DeleteRemoteOp extends RemoteWriteOp {
  const DeleteRemoteOp({required this.entityType, required this.entityId});
  final String entityType;
  final String entityId;
}

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

  /// Commits many writes in as few network round-trips as possible
  /// (Firestore batched writes). Throws if the commit fails so the caller can
  /// fall back to per-item processing.
  Future<void> commitBatch(String uid, List<RemoteWriteOp> operations);

  /// Every document of this type changed since [updatedSince], not just the
  /// first page of them.
  ///
  /// [pageSize] is how many are read per round trip, never a cap on the result:
  /// the implementation keeps paging until the collection is exhausted. It has
  /// to, because a cap would be indistinguishable from "nothing more to sync"
  /// to the caller, and the documents past it would never be asked for again.
  Future<List<RoutineRemoteDto>> fetchRoutinesUpdatedSince(String uid, DateTime? updatedSince, {int pageSize = 500});
  Future<List<ExerciseRemoteDto>> fetchExercisesUpdatedSince(String uid, DateTime? updatedSince, {int pageSize = 500});
  Future<List<SetRemoteDto>> fetchSetsUpdatedSince(String uid, DateTime? updatedSince, {int pageSize = 500});
  Future<List<SessionRemoteDto>> fetchSessionsUpdatedSince(String uid, DateTime? updatedSince, {int pageSize = 500});
  Future<List<SetLogRemoteDto>> fetchSetLogsUpdatedSince(String uid, DateTime? updatedSince, {int pageSize = 500});
  Future<List<LibraryExerciseRemoteDto>> fetchLibraryExercisesUpdatedSince(String uid, DateTime? updatedSince, {int pageSize = 500});

  Future<void> upsertTrainingDefaults(
    String uid, {
    required int? defaultRestSeconds,
    required int? defaultRepetitions,
    required double? defaultWeight,
    required bool autoStartRestTimerOnSetCompleted,
    required DateTime updatedAt,
  });

  Future<Map<String, dynamic>?> fetchTrainingDefaults(String uid);
}
