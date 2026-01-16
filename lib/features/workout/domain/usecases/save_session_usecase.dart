import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/workout_entities.dart';
import '../repositories/workout_repository.dart';

class SaveSessionUseCase extends UseCase<void, SaveSessionParams> {
  SaveSessionUseCase(this.repository);

  final WorkoutRepository repository;

  @override
  Future<Either<Failure, void>> call(SaveSessionParams params) {
    return repository.saveSession(params.session);
  }
}

class SaveSessionParams extends Equatable {
  const SaveSessionParams({required this.session});

  final WorkoutSession session;

  @override
  List<Object> get props => [session];
}
