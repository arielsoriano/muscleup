import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/workout_entities.dart';
import '../repositories/workout_repository.dart';

class SaveRoutineUseCase extends UseCase<void, SaveRoutineParams> {
  SaveRoutineUseCase(this.repository);

  final WorkoutRepository repository;

  @override
  Future<Either<Failure, void>> call(SaveRoutineParams params) {
    return repository.saveRoutine(params.routine);
  }
}

class SaveRoutineParams extends Equatable {
  const SaveRoutineParams({required this.routine});

  final WorkoutRoutine routine;

  @override
  List<Object> get props => [routine];
}
