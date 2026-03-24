import 'package:equatable/equatable.dart';

import '../../domain/entities/cloud_user.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitializing extends AuthState {
  const AuthInitializing();

  @override
  List<Object?> get props => [];
}

final class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object?> get props => [];
}

final class AuthAnonymous extends AuthState {
  const AuthAnonymous(this.user);

  final CloudUser user;

  @override
  List<Object?> get props => [user];
}

final class AuthLinkedWithGoogle extends AuthState {
  const AuthLinkedWithGoogle(this.user);

  final CloudUser user;

  @override
  List<Object?> get props => [user];
}

final class AuthError extends AuthState {
  const AuthError({required this.message, this.fallbackUser});

  final String message;
  final CloudUser? fallbackUser;

  @override
  List<Object?> get props => [message, fallbackUser];
}

final class AuthUnavailable extends AuthState {
  const AuthUnavailable();

  @override
  List<Object?> get props => [];
}
