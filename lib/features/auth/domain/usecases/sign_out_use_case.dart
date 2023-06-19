import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase extends UseCase<Nothing, Nothing> {
  final AuthRepository repository;
  SignOutUseCase({required this.repository});
  @override
  Future<Either<Failure, Nothing>> call(Nothing param) async {
    return await repository.signOut();
  }
}
