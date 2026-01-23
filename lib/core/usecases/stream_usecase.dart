import '../error/failures.dart';
import 'usecase.dart';

abstract class StreamUseCase<T, Params> {
  Stream<Either<Failure, T>> call(Params params);
}
