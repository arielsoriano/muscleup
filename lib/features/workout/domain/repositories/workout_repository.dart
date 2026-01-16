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
}
