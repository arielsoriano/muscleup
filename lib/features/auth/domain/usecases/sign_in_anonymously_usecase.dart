import '../entities/cloud_user.dart';
import '../repositories/cloud_auth_repository.dart';

class SignInAnonymouslyUseCase {
  const SignInAnonymouslyUseCase(this._repository);

  final CloudAuthRepository _repository;

  Future<CloudUser> call() => _repository.signInAnonymously();
}
