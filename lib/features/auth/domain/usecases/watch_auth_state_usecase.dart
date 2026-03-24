import '../entities/cloud_user.dart';
import '../repositories/cloud_auth_repository.dart';

class WatchAuthStateUseCase {
  const WatchAuthStateUseCase(this._repository);

  final CloudAuthRepository _repository;

  Stream<CloudUser?> call() => _repository.watchAuthState();
}
