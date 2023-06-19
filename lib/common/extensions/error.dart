import 'package:manage_gym/common/exceptions/exceptions.dart';

extension ErrorCodeExt on String {
  void toFailure() {
    switch (this) {
      case 'UNEXPECTED_ERROR':
        throw UnExceptedFailure();
      case 'USER_NOT_FOUND':
        throw UserNotFoundFailure();
      case 'WRONG_OTP':
        throw WrongOtpFailure();
      default:
        throw UnExceptedFailure();
    }
  }
}
