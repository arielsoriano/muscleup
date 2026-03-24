import '../entities/cloud_user.dart';
import '../repositories/cloud_auth_repository.dart';

class LinkWithGoogleUseCase {
  const LinkWithGoogleUseCase(this._repository);

  final CloudAuthRepository _repository;

  Future<CloudUser> call() => _repository.linkWithGoogle();
}
