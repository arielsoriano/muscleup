import '../repositories/cloud_auth_repository.dart';

class SignOutCloudUseCase {
  const SignOutCloudUseCase(this._repository);

  final CloudAuthRepository _repository;

  Future<void> call() => _repository.signOutCloud();
}
