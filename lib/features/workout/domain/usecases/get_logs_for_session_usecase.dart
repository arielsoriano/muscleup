import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/workout_entities.dart';
import '../repositories/workout_repository.dart';

class GetLogsForSessionUseCase
    extends UseCase<List<SetLog>, GetLogsForSessionParams> {
  GetLogsForSessionUseCase(this.repository);

  final WorkoutRepository repository;

  @override
  Future<Either<Failure, List<SetLog>>> call(GetLogsForSessionParams params) {
    return repository.getLogsForSession(params.sessionId);
  }
}

class GetLogsForSessionParams extends Equatable {
  const GetLogsForSessionParams({required this.sessionId});

  final String sessionId;

  @override
  List<Object> get props => [sessionId];
}
