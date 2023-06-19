import 'package:manage_gym/common/extensions/future.dart';
import 'package:manage_gym/common/usecases/usecase.dart';

import 'package:manage_gym/common/exceptions/exceptions.dart';

import 'package:dartz/dartz.dart';
import 'package:manage_gym/features/auth/data/data_source/auth_data_source.dart';
import 'package:manage_gym/params/input_params.dart';

import '../../../../params/return_params.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;
  AuthRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, Nothing>> requestOtp(String phoneNumber) async {
    return await dataSource.requestOtp(phoneNumber).toEither();
  }

  @override
  Future<Either<Failure, VerifyOtpReturnParams>> verifyOtp(
      VerifyOtpInputParams params) async {
    return await dataSource.verifyOtp(params).toEither();
  }

  @override
  Future<String> currentUserId() async {
    return await dataSource.currentUserId();
  }

  @override
  Future<Either<Failure, Nothing>> signOut() async {
    return await dataSource.signOut().toEither();
  }
}
