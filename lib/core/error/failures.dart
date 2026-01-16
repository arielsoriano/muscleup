import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object> get props => [];
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
