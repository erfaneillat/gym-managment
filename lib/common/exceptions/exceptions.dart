import 'package:easy_localization/easy_localization.dart';

class Failure implements Exception {
  final String message;
  Failure({required this.message});
}

class UnExceptedFailure extends Failure {
  UnExceptedFailure() : super(message: 'unexpected_failure_message'.tr());
}

class UserNotFoundFailure extends Failure {
  UserNotFoundFailure() : super(message: 'user_not_found_error_message'.tr());
}

class WrongOtpFailure extends Failure {
  WrongOtpFailure() : super(message: 'wrong_otp_error_message'.tr());
}
