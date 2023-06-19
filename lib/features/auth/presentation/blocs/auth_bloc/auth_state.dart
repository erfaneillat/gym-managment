part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AcceptTermsStatus acceptTermsStatus;
  final AuthLoginState authLoginState;
  const AuthState(
      {required this.acceptTermsStatus, required this.authLoginState});

  @override
  List<Object> get props => [acceptTermsStatus, authLoginState];

  AuthState copyWith(
      {AcceptTermsStatus? acceptTermsStatus, AuthLoginState? authLoginState}) {
    return AuthState(
        acceptTermsStatus: acceptTermsStatus ?? this.acceptTermsStatus,
        authLoginState: authLoginState ?? this.authLoginState);
  }
}
