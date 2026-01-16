import '../../../../core/error/failures.dart';
import '../../../../core/usecases/stream_usecase.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/workout_entities.dart';
import '../repositories/workout_repository.dart';

class WatchRoutinesUseCase
    extends StreamUseCase<List<WorkoutRoutine>, NoParams> {
  WatchRoutinesUseCase(this.repository);

  final WorkoutRepository repository;

  @override
  Stream<Either<Failure, List<WorkoutRoutine>>> call(NoParams params) {
    return repository.watchRoutines();
  }
}
