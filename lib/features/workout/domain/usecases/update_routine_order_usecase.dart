import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/workout_entities.dart';
import '../repositories/workout_repository.dart';

class UpdateRoutineOrderUseCase
    extends UseCase<void, UpdateRoutineOrderParams> {
  UpdateRoutineOrderUseCase(this.repository);

  final WorkoutRepository repository;

  @override
  Future<Either<Failure, void>> call(UpdateRoutineOrderParams params) {
    return repository.updateRoutineOrder(params.routines);
  }
}

class UpdateRoutineOrderParams extends Equatable {
  const UpdateRoutineOrderParams({required this.routines});

  final List<WorkoutRoutine> routines;

  @override
  List<Object> get props => [routines];
}
