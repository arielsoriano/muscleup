import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/workout_entities.dart';
import '../repositories/workout_repository.dart';

class SaveSetLogUseCase extends UseCase<void, SaveSetLogParams> {
  SaveSetLogUseCase(this.repository);

  final WorkoutRepository repository;

  @override
  Future<Either<Failure, void>> call(SaveSetLogParams params) {
    return repository.saveSetLog(params.log);
  }
}

class SaveSetLogParams extends Equatable {
  const SaveSetLogParams({required this.log});

  final SetLog log;

  @override
  List<Object> get props => [log];
}
