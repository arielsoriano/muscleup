import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/workout_entities.dart';
import '../repositories/workout_repository.dart';

class GetSessionByIdUseCase
    implements UseCase<WorkoutSession, GetSessionByIdParams> {
  GetSessionByIdUseCase(this.repository);

  final WorkoutRepository repository;

  @override
  Future<Either<Failure, WorkoutSession>> call(
    GetSessionByIdParams params,
  ) async {
    return repository.getSessionById(params.sessionId);
  }
}

class GetSessionByIdParams {
  GetSessionByIdParams({required this.sessionId});

  final String sessionId;
}
