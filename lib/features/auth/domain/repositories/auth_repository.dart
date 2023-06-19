import 'package:dartz/dartz.dart';
import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/params/input_params.dart';

import '../../../../params/return_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, Nothing>> requestOtp(String phoneNumber);
  Future<Either<Failure, VerifyOtpReturnParams>> verifyOtp(
      VerifyOtpInputParams params);
  Future<String> currentUserId();
  Future<Either<Failure, Nothing>> signOut();
}
