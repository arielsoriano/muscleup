import '../entities/cloud_user.dart';

abstract class CloudAuthRepository {
  Stream<CloudUser?> watchAuthState();
  Future<CloudUser> signInAnonymously();
  Future<CloudUser> linkWithGoogle();
  Future<void> signOutCloud();
}
