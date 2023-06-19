import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:manage_gym/features/gym/domain/entities/income_entity.dart';

import '../../../../common/usecases/usecase.dart';
import '../repositories/gym_repository.dart';

class GetIncomesUseCase extends UseCase<List<IncomeEntity>, Nothing> {
  final GymRepository repository;

  GetIncomesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<IncomeEntity>>> call(Nothing param) async {
    return await repository.incomes();
  }
}
