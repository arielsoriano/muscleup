import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/workout_repository.dart';

class DeleteSessionUseCase extends UseCase<void, DeleteSessionParams> {
  DeleteSessionUseCase(this.repository);

  final WorkoutRepository repository;

  @override
  Future<Either<Failure, void>> call(DeleteSessionParams params) {
    return repository.deleteSession(params.sessionId);
  }
}

class DeleteSessionParams extends Equatable {
  const DeleteSessionParams({required this.sessionId});

  final String sessionId;

  @override
  List<Object> get props => [sessionId];
}
