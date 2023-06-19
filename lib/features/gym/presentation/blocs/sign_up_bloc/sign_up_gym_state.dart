part of 'sign_up_gym_bloc.dart';

abstract class SignUpGymState extends Equatable {
  const SignUpGymState();

  @override
  List<Object> get props => [];
}

class SignUpGymInitial extends SignUpGymState {}

class SignUpGymLoading extends SignUpGymState {}

class SignUpGymSuccess extends SignUpGymState {}

class SignUpGymFailure extends SignUpGymState {
  final String message;
  const SignUpGymFailure({required this.message});

  @override
  List<Object> get props => [message];
}
