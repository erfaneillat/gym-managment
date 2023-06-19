import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:manage_gym/features/auth/domain/repositories/auth_repository.dart';

import '../../../../common/usecases/usecase.dart';

class RequestOtpUseCase extends UseCase<Nothing, String> {
  final AuthRepository repository;
  RequestOtpUseCase({required this.repository});
  @override
  Future<Either<Failure, Nothing>> call(String param) async {
    return repository.requestOtp(param);
  }
}
