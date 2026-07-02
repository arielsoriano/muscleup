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
  Timer? _anonymousSignInTimer;
  static const Duration _anonymousAuthTimeout = Duration(seconds: 15);
  static const Duration _googleLinkTimeout = Duration(seconds: 45);

  // On cold start Firebase can briefly report "no user" before it finishes
  // restoring the persisted session. Wait this long before creating an
  // anonymous account, so we don't clobber a session that is still loading.
  static const Duration _restoreGracePeriod = Duration(seconds: 2);

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
    if (user != null) {
      // A real session arrived (restored or freshly linked); cancel any pending
      // anonymous sign-in so it can't overwrite this session.
      _anonymousSignInTimer?.cancel();
      if (state is AuthLoading) return;
      _emitUserState(user);
      return;
    }

    if (state is AuthLoading) return;

    // Defer the anonymous sign-in: if a persisted session is still being
    // restored it will arrive within the grace period and cancel this.
    _anonymousSignInTimer?.cancel();
    _anonymousSignInTimer = Timer(_restoreGracePeriod, () {
      if (!isClosed) _signInAnonymouslyNow();
    });
  }

  Future<void> _signInAnonymouslyNow() async {
    if (state is AuthLoading) return;

    try {
      emit(const AuthLoading());
      final user = await _signInAnonymously().timeout(_anonymousAuthTimeout);
      // The data source may return an already-restored (possibly Google-linked)
      // session instead of creating a new anonymous one, so emit the state that
      // matches the actual user rather than assuming anonymous.
      if (!isClosed) _emitUserState(user);
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
    final previousUser = switch (currentState) {
      AuthAnonymous(user: final user) => user,
      AuthError(fallbackUser: final user?) => user,
      _ => null,
    };

    if (previousUser == null) return;
    emit(const AuthLoading());

    try {
      final user = await _linkWithGoogle().timeout(_googleLinkTimeout);
      if (!isClosed) emit(AuthLinkedWithGoogle(user));
    } on TimeoutException {
      _emitAuthErrorAndRecover(
        message: 'auth_google_sign_in_timeout',
        fallbackUser: previousUser,
      );
    } catch (error) {
      if (_isGoogleCancellation(error)) {
        if (!isClosed) emit(AuthAnonymous(previousUser));
        return;
      }
      _emitAuthErrorAndRecover(
        message: _normalizeAuthError(error),
        fallbackUser: previousUser,
      );
    }
  }

  void _emitAuthErrorAndRecover({
    required String message,
    required CloudUser fallbackUser,
  }) {
    if (isClosed) return;

    emit(
      AuthError(
        message: message,
        fallbackUser: fallbackUser,
      ),
    );
    emit(AuthAnonymous(fallbackUser));
  }

  String _normalizeAuthError(Object error) {
    final rawError = error.toString();
    final normalizedError = rawError.toLowerCase();

    if (normalizedError.contains('platformexception(sign_infailed') &&
        (normalizedError.contains(': 10:') ||
            normalizedError.contains('developer_error'))) {
      return 'auth_google_sign_in_configuration_error';
    }

    return rawError;
  }

  bool _isGoogleCancellation(Object error) {
    final normalizedError = error.toString().toLowerCase();
    return normalizedError.contains('google_sign_in_cancelled') ||
        normalizedError.contains('canceled') ||
        normalizedError.contains('cancelled');
  }

  Future<void> disconnectGoogle() async {
    try {
      await _signOutCloud();
    } catch (_) {}
  }

  @override
  Future<void> close() {
    _anonymousSignInTimer?.cancel();
    _authSubscription?.cancel();
    return super.close();
  }
}
