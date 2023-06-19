part of 'sign_up_gym_bloc.dart';

abstract class SignUpGymEvents extends Equatable {
  const SignUpGymEvents();

  @override
  List<Object> get props => [];
}

class SignUpGymEvent extends SignUpGymEvents {
  final SignUpInputParams params;
  final bool isUpdate;

  const SignUpGymEvent({required this.params, this.isUpdate = false});
}
