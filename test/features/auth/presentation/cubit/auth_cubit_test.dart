import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/features/auth/domain/entities/cloud_user.dart';
import 'package:muscleup/features/auth/domain/repositories/cloud_auth_repository.dart';
import 'package:muscleup/features/auth/domain/usecases/link_with_google_usecase.dart';
import 'package:muscleup/features/auth/domain/usecases/sign_in_anonymously_usecase.dart';
import 'package:muscleup/features/auth/domain/usecases/sign_out_cloud_usecase.dart';
import 'package:muscleup/features/auth/domain/usecases/watch_auth_state_usecase.dart';
import 'package:muscleup/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:muscleup/features/auth/presentation/cubit/auth_state.dart';

void main() {
  group('AuthCubit', () {
    late _FakeCloudAuthRepository fakeCloudAuthRepository;
    late AuthCubit authCubit;

    setUp(() {
      fakeCloudAuthRepository = _FakeCloudAuthRepository();
      authCubit = AuthCubit(
        signInAnonymouslyUseCase: SignInAnonymouslyUseCase(fakeCloudAuthRepository),
        linkWithGoogleUseCase: LinkWithGoogleUseCase(fakeCloudAuthRepository),
        watchAuthStateUseCase: WatchAuthStateUseCase(fakeCloudAuthRepository),
        signOutCloudUseCase: SignOutCloudUseCase(fakeCloudAuthRepository),
      );
    });

    tearDown(() async {
      await authCubit.close();
      await fakeCloudAuthRepository.dispose();
    });

    test('bootstrap signs in anonymously when auth stream emits null', () async {
      fakeCloudAuthRepository.authStreamController.add(null);
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);

      expect(authCubit.state, isA<AuthAnonymous>());
      expect(fakeCloudAuthRepository.signInAnonymouslyCalls, 1);
    });

    test('linkWithGoogle success transitions from anonymous to linked', () async {
      fakeCloudAuthRepository.authStreamController.add(
        const CloudUser(uid: 'anon-1', isAnonymous: true),
      );
      await Future<void>.delayed(Duration.zero);

      await authCubit.linkWithGoogle();

      expect(authCubit.state, isA<AuthLinkedWithGoogle>());
      expect(fakeCloudAuthRepository.linkWithGoogleCalls, 1);
    });

    test('linkWithGoogle cancelled keeps anonymous session', () async {
      const anonymousUser = CloudUser(uid: 'anon-1', isAnonymous: true);
      fakeCloudAuthRepository.authStreamController.add(anonymousUser);
      fakeCloudAuthRepository.shouldThrowCancellation = true;
      await Future<void>.delayed(Duration.zero);

      await authCubit.linkWithGoogle();

      expect(authCubit.state, isA<AuthAnonymous>());
      final state = authCubit.state as AuthAnonymous;
      expect(state.user.uid, anonymousUser.uid);
    });
  });
}

class _FakeCloudAuthRepository implements CloudAuthRepository {
  final StreamController<CloudUser?> authStreamController =
      StreamController<CloudUser?>.broadcast();

  int signInAnonymouslyCalls = 0;
  int linkWithGoogleCalls = 0;
  bool shouldThrowCancellation = false;

  @override
  Stream<CloudUser?> watchAuthState() => authStreamController.stream;

  @override
  Future<CloudUser> signInAnonymously() async {
    signInAnonymouslyCalls += 1;
    return const CloudUser(uid: 'anon-generated', isAnonymous: true);
  }

  @override
  Future<CloudUser> linkWithGoogle() async {
    linkWithGoogleCalls += 1;
    if (shouldThrowCancellation) {
      throw Exception('google_sign_in_cancelled');
    }
    return const CloudUser(
      uid: 'google-uid',
      isAnonymous: false,
      email: 'test@example.com',
      displayName: 'Test User',
    );
  }

  @override
  Future<void> signOutCloud() async {}

  Future<void> dispose() async {
    await authStreamController.close();
  }
}
