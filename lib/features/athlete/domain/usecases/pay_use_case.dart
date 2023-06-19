import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/features/athlete/domain/repositories/athlete_repository.dart';

class PayUseCase extends UseCase<Nothing, String> {
  final AthleteRepository repository;
  PayUseCase({required this.repository});
  @override
  Future<Either<Failure, Nothing>> call(String param) async {
    return await repository.pay(param);
  }
}
