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

  Future<Either<Failure, void>> saveSession(WorkoutSession session);

  Future<Either<Failure, void>> saveSetLog(SetLog log);

  Future<Either<Failure, List<SetLog>>> getLogsForSession(String sessionId);

  Future<Either<Failure, List<LibraryExerciseEntity>>> getLibraryExercises();

  Future<Either<Failure, void>> saveLibraryExercise(String name, {String? nameEn, String? nameEs});

  Future<Either<Failure, List<LibraryExerciseEntity>>> searchLibraryExercises(String query, String languageCode);
}

class LibraryExerciseEntity {
  LibraryExerciseEntity({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.nameEs,
    required this.isCustom,
  });

  final String id;
  final String name;
  final String nameEn;
  final String nameEs;
  final bool isCustom;

  String getLocalizedName(String languageCode) {
    return languageCode == 'es' ? nameEs : nameEn;
  }
}
