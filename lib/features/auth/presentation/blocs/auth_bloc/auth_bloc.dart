import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:manage_gym/features/auth/domain/usecases/request_otp_use_case.dart';
import 'package:manage_gym/features/auth/presentation/blocs/auth_bloc/terms_status.dart';
import 'package:manage_gym/params/input_params.dart';

import 'login_state.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RequestOtpUseCase requestOtpUseCase;
  AuthBloc({required this.requestOtpUseCase})
      : super(AuthState(
            acceptTermsStatus: AcceptTermsStatus(),
            authLoginState: AuthLoginInitial())) {
    on<AuthCheckTerms>((event, emit) {
      emit(state.copyWith(
          acceptTermsStatus: AcceptTermsStatus(accepted: event.acceptedTerms)));
    });
    on<AuthLoginEvent>((event, emit) async {
      if (!state.acceptTermsStatus.accepted) {
        emit(state.copyWith(
            authLoginState:
                AuthLoginFailure(message: 'terms_conditions_error'.tr())));
        emit(state.copyWith(authLoginState: AuthLoginInitial()));
        return;
      }

      emit(state.copyWith(authLoginState: AuthLoginLoading()));
      final result = await requestOtpUseCase(event.phoneNumber);
      result.fold(
          (l) => emit(state.copyWith(
              authLoginState: AuthLoginFailure(message: l.message))),
          (r) => emit(state.copyWith(authLoginState: AuthLoginSuccess())));
    });
  }
}
