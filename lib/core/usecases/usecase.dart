import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class Either<L, R> {
  const Either.left(L left)
      : _left = left,
        _right = null;

  const Either.right(R right)
      : _left = null,
        _right = right;

  final L? _left;
  final R? _right;

  bool get isLeft => _left != null;
  bool get isRight => _right != null;

  L get left => _left!;
  R get right => _right!;

  T fold<T>(T Function(L left) leftFunc, T Function(R right) rightFunc) {
    if (isLeft) {
      return leftFunc(_left as L);
    } else {
      return rightFunc(_right as R);
    }
  }
}
