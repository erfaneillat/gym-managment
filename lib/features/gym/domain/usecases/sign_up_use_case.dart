import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/features/gym/domain/repositories/gym_repository.dart';
import 'package:manage_gym/params/input_params.dart';

class SignUpUseCase extends UseCase<Nothing, SignUpInputParams> {
  final GymRepository repository;

  SignUpUseCase({required this.repository});
  @override
  Future<Either<Failure, Nothing>> call(SignUpInputParams param) async {
    return await repository.signUp(param);
  }
}
