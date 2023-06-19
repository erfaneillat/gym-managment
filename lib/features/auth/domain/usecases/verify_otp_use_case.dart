import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/features/auth/domain/repositories/auth_repository.dart';
import 'package:manage_gym/params/input_params.dart';

import '../../../../params/return_params.dart';

class VerifyOtpUseCase
    extends UseCase<VerifyOtpReturnParams, VerifyOtpInputParams> {
  final AuthRepository repository;
  VerifyOtpUseCase({required this.repository});
  @override
  Future<Either<Failure, VerifyOtpReturnParams>> call(
      VerifyOtpInputParams param) async {
    return await repository.verifyOtp(param);
  }
}
