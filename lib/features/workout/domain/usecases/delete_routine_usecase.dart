import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/workout_repository.dart';

class DeleteRoutineUseCase extends UseCase<void, DeleteRoutineParams> {
  DeleteRoutineUseCase(this.repository);

  final WorkoutRepository repository;

  @override
  Future<Either<Failure, void>> call(DeleteRoutineParams params) {
    return repository.deleteRoutine(params.id);
  }
}

class DeleteRoutineParams extends Equatable {
  const DeleteRoutineParams({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
