import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/cloud_user.dart';

class FirebaseAuthDataSource {
  FirebaseAuthDataSource({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Stream<CloudUser?> watchAuthStateChanges() {
    try {
      return _firebaseAuth.authStateChanges().map(_mapFirebaseUser);
    } catch (e) {
      return Stream.error(e);
    }
  }

  Future<CloudUser> signInAnonymously() async {
    final result = await _firebaseAuth.signInAnonymously();
    return _mapFirebaseUser(result.user)!;
  }

  Future<CloudUser> linkWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('google_sign_in_cancelled');
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      final result = await _firebaseAuth.signInWithCredential(credential);
      return _mapFirebaseUser(result.user)!;
    }

    try {
      final result = await currentUser.linkWithCredential(credential);
      return _mapFirebaseUser(result.user)!;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'provider-already-linked') {
        return _mapFirebaseUser(_firebaseAuth.currentUser)!;
      }

      if (error.code == 'credential-already-in-use' ||
          error.code == 'account-exists-with-different-credential') {
        final result = await _firebaseAuth.signInWithCredential(credential);
        return _mapFirebaseUser(result.user)!;
      }

      throw Exception('google_link_failed:${error.code}:${error.message ?? ''}');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  CloudUser? _mapFirebaseUser(User? user) {
    if (user == null) return null;
    return CloudUser(
      uid: user.uid,
      isAnonymous: user.isAnonymous,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }
}
