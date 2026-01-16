import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/workout_entities.dart';
import '../repositories/workout_repository.dart';

class GetRoutineByIdUseCase extends UseCase<WorkoutRoutine, GetRoutineByIdParams> {
  GetRoutineByIdUseCase(this.repository);

  final WorkoutRepository repository;

  @override
  Future<Either<Failure, WorkoutRoutine>> call(GetRoutineByIdParams params) {
    return repository.getRoutineById(params.id);
  }
}

class GetRoutineByIdParams extends Equatable {
  const GetRoutineByIdParams({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
