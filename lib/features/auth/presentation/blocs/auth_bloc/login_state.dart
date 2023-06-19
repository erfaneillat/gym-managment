import 'package:equatable/equatable.dart';

abstract class AuthLoginState extends Equatable {
  const AuthLoginState();

  @override
  List<Object> get props => [];
}

class AuthLoginInitial extends AuthLoginState {}

class AuthLoginLoading extends AuthLoginState {}

class AuthLoginSuccess extends AuthLoginState {}

class AuthLoginFailure extends AuthLoginState {
  final String message;
  const AuthLoginFailure({required this.message});

  @override
  List<Object> get props => [message];
}
