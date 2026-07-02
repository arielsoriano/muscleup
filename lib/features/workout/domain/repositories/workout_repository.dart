import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/workout_entities.dart';

abstract class WorkoutRepository {
  Stream<Either<Failure, List<WorkoutRoutine>>> watchRoutines();

  Future<Either<Failure, WorkoutRoutine>> getRoutineById(String id);

  Future<Either<Failure, void>> saveRoutine(WorkoutRoutine routine);

  Future<Either<Failure, void>> deleteRoutine(String id);

  Future<Either<Failure, void>> updateRoutineOrder(
    List<WorkoutRoutine> routines,
  );

  Stream<Either<Failure, List<WorkoutSession>>> watchSessions();

  Future<Either<Failure, WorkoutSession>> getSessionById(String sessionId);

  Future<Either<Failure, WorkoutSession?>> getLatestActiveSessionForRoutine(
    String routineId,
  );

  Future<Either<Failure, void>> saveSession(WorkoutSession session);

  Future<Either<Failure, void>> deleteSession(String sessionId);

  Future<Either<Failure, void>> finalizeStaleSessions();

  Future<Either<Failure, void>> saveSetLog(SetLog log);

  Future<Either<Failure, List<SetLog>>> getLogsForSession(String sessionId);

  /// Returns the set logs from the most recent completed session of [routineId],
  /// excluding [excludeSessionId] (the session currently in progress).
  /// Used to show the "last time" reference during a workout.
  Future<Either<Failure, List<SetLog>>> getLastCompletedLogsForRoutine(
    String routineId, {
    required String excludeSessionId,
  });

  /// Returns the performance history for a given routine exercise across all
  /// completed sessions, most recent first. Used for the progression view.
  Future<Either<Failure, List<ExerciseHistoryEntry>>> getExerciseHistory(
    String workoutExerciseId,
  );

  Future<Either<Failure, List<LibraryExerciseEntity>>> getLibraryExercises();

  Future<Either<Failure, void>> saveLibraryExercise(String name, {String? nameEn, String? nameEs});

  Future<Either<Failure, void>> updateLibraryExercise(
    String id,
    String name, {
    String? nameEn,
    String? nameEs,
  });

  Future<Either<Failure, void>> deleteLibraryExercise(String id);

  Future<Either<Failure, List<LibraryExerciseEntity>>> searchLibraryExercises(String query, String languageCode);
}

/// One completed session's performance for a specific exercise.
class ExerciseHistoryEntry {
  ExerciseHistoryEntry({
    required this.sessionId,
    required this.date,
    required this.sets,
  });

  final String sessionId;
  final DateTime date;

  /// Logged sets for this exercise in this session, ordered by set number.
  final List<SetLog> sets;
}

class LibraryExerciseEntity {
  LibraryExerciseEntity({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.nameEs,
    required this.isCustom,
    this.syncMetadata,
  });

  final String id;
  final String name;
  final String nameEn;
  final String nameEs;
  final bool isCustom;
  final SyncMetadata? syncMetadata;

  String getLocalizedName(String languageCode) {
    return languageCode == 'es' ? nameEs : nameEn;
  }
}
