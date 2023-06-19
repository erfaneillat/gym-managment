import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manage_gym/features/gym/domain/usecases/sign_up_use_case.dart';
import 'package:manage_gym/features/gym/domain/usecases/update_gym_use_case.dart';
import 'package:manage_gym/params/input_params.dart';

part 'sign_up_gym_event.dart';
part 'sign_up_gym_state.dart';

class SignUpGymBloc extends Bloc<SignUpGymEvents, SignUpGymState> {
  final SignUpUseCase signUpUseCase;
  final UpdateGymUseCase updateGymUseCase;

  SignUpGymBloc({required this.signUpUseCase, required this.updateGymUseCase})
      : super(SignUpGymInitial()) {
    on<SignUpGymEvent>((event, emit) async {
      emit(SignUpGymLoading());
      final result = event.isUpdate
          ? await updateGymUseCase(event.params)
          : await signUpUseCase(event.params);
      result.fold((l) => emit(SignUpGymFailure(message: l.message)),
          (r) => emit(SignUpGymSuccess()));
    });
  }
}
