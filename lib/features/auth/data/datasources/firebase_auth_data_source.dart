import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/cloud_user.dart';
import '../../../../core/utils/dev_logger.dart';

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
      appLog('Setting up authStateChanges stream');
      return _firebaseAuth.authStateChanges().map((user) {
        appLog('authStateChanges emitted: ${user?.uid ?? 'null'}');
        return _mapFirebaseUser(user);
      });
    } catch (e) {
      appLog('Error in watchAuthStateChanges: $e');
      return Stream.error(e);
    }
  }

  Future<CloudUser> signInAnonymously() async {
    appLog('signInAnonymously() called');
    final existing = _firebaseAuth.currentUser;
    if (existing != null) {
      appLog('signInAnonymously: existing user found: ${existing.uid}');
      return _mapFirebaseUser(existing)!;
    }

    appLog('signInAnonymously: creating new anonymous user');
    final result = await _firebaseAuth.signInAnonymously();
    appLog('signInAnonymously: created new anonymous user: ${result.user?.uid}');
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

    // On a restored session the top-level email/displayName can be empty even
    // though the Google provider still carries them, so fall back to the
    // provider profile to avoid showing a linked account with no email.
    var email = _nullIfEmpty(user.email);
    var displayName = _nullIfEmpty(user.displayName);
    var photoUrl = _nullIfEmpty(user.photoURL);

    bool hasGoogleProvider = false;
    for (final profile in user.providerData) {
      if (profile.providerId == 'google.com') {
        hasGoogleProvider = true;
        email ??= _nullIfEmpty(profile.email);
        displayName ??= _nullIfEmpty(profile.displayName);
        photoUrl ??= _nullIfEmpty(profile.photoURL);
      }
    }

    return CloudUser(
      uid: user.uid,
      isAnonymous: user.isAnonymous && !hasGoogleProvider,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }

  String? _nullIfEmpty(String? value) {
    if (value == null || value.isEmpty) return null;
    return value;
  }
}
