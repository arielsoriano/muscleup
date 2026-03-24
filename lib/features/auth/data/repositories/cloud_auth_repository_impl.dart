import '../../domain/entities/cloud_user.dart';
import '../../domain/repositories/cloud_auth_repository.dart';
import '../datasources/firebase_auth_data_source.dart';

class CloudAuthRepositoryImpl implements CloudAuthRepository {
  const CloudAuthRepositoryImpl(this._dataSource);

  final FirebaseAuthDataSource _dataSource;

  @override
  Stream<CloudUser?> watchAuthState() =>
      _dataSource.watchAuthStateChanges();

  @override
  Future<CloudUser> signInAnonymously() => _dataSource.signInAnonymously();

  @override
  Future<CloudUser> linkWithGoogle() => _dataSource.linkWithGoogle();

  @override
  Future<void> signOutCloud() => _dataSource.signOut();
}
