part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckTerms extends AuthEvent {
  final bool acceptedTerms;
  const AuthCheckTerms({this.acceptedTerms = false});
}

class AuthLoginEvent extends AuthEvent {
  final String phoneNumber;
  const AuthLoginEvent({required this.phoneNumber});
}
