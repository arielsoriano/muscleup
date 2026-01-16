import '../../../../core/error/failures.dart';
import '../../../../core/usecases/stream_usecase.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/workout_entities.dart';
import '../repositories/workout_repository.dart';

class WatchSessionsUseCase
    extends StreamUseCase<List<WorkoutSession>, NoParams> {
  WatchSessionsUseCase(this.repository);

  final WorkoutRepository repository;

  @override
  Stream<Either<Failure, List<WorkoutSession>>> call(NoParams params) {
    return repository.watchSessions();
  }
}
