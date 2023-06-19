import 'package:dartz/dartz.dart';
import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:manage_gym/features/gym/domain/entities/gym_entity.dart';
import 'package:manage_gym/features/gym/domain/entities/income_entity.dart';
import 'package:manage_gym/params/input_params.dart';

import '../../../../common/usecases/usecase.dart';

abstract class GymRepository {
  Future<Either<Failure, Nothing>> signUp(SignUpInputParams params);
  Future<Either<Failure, Nothing>> updateGym(SignUpInputParams params);
  Future<Either<Failure, GymEntity>> gymInfo();
  Future<Either<Failure, List<IncomeEntity>>> incomes();
}
