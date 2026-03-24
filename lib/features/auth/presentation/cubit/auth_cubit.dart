import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cloud_user.dart';
import '../../domain/usecases/link_with_google_usecase.dart';
import '../../domain/usecases/sign_in_anonymously_usecase.dart';
import '../../domain/usecases/sign_out_cloud_usecase.dart';
import '../../domain/usecases/watch_auth_state_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required SignInAnonymouslyUseCase signInAnonymouslyUseCase,
    required LinkWithGoogleUseCase linkWithGoogleUseCase,
    required WatchAuthStateUseCase watchAuthStateUseCase,
    required SignOutCloudUseCase signOutCloudUseCase,
  })  : _signInAnonymously = signInAnonymouslyUseCase,
        _linkWithGoogle = linkWithGoogleUseCase,
        _watchAuthState = watchAuthStateUseCase,
        _signOutCloud = signOutCloudUseCase,
        super(const AuthInitializing()) {
    _bootstrap();
  }

  final SignInAnonymouslyUseCase _signInAnonymously;
  final LinkWithGoogleUseCase _linkWithGoogle;
  final WatchAuthStateUseCase _watchAuthState;
  final SignOutCloudUseCase _signOutCloud;

  StreamSubscription<CloudUser?>? _authSubscription;

  void _bootstrap() {
    try {
      _authSubscription = _watchAuthState().listen(
        _onAuthStateChanged,
        onError: (_) {
          if (!isClosed) emit(const AuthUnavailable());
        },
      );
    } catch (_) {
      emit(const AuthUnavailable());
    }
  }

  void _onAuthStateChanged(CloudUser? user) {
    if (state is AuthLoading) return;

    if (user == null) {
      _signInAnonymouslyNow();
      return;
    }

    _emitUserState(user);
  }

  Future<void> _signInAnonymouslyNow() async {
    if (state is AuthLoading) return;

    try {
      emit(const AuthLoading());
      final user = await _signInAnonymously();
      if (!isClosed) emit(AuthAnonymous(user));
    } catch (_) {
      if (!isClosed) emit(const AuthUnavailable());
    }
  }

  void _emitUserState(CloudUser user) {
    if (user.isAnonymous) {
      emit(AuthAnonymous(user));
    } else {
      emit(AuthLinkedWithGoogle(user));
    }
  }

  Future<void> linkWithGoogle() async {
    final currentState = state;
    if (currentState is! AuthAnonymous) return;

    final previousUser = currentState.user;
    emit(const AuthLoading());

    try {
      final user = await _linkWithGoogle();
      if (!isClosed) emit(AuthLinkedWithGoogle(user));
    } catch (_) {
      if (!isClosed) emit(AuthAnonymous(previousUser));
    }
  }

  Future<void> disconnectGoogle() async {
    try {
      await _signOutCloud();
    } catch (_) {}
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
