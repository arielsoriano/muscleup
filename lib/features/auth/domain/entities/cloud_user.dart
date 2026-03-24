import 'package:equatable/equatable.dart';

class CloudUser extends Equatable {
  const CloudUser({
    required this.uid,
    required this.isAnonymous,
    this.email,
    this.displayName,
    this.photoUrl,
  });

  final String uid;
  final bool isAnonymous;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  @override
  List<Object?> get props => [uid, isAnonymous, email, displayName, photoUrl];
}
