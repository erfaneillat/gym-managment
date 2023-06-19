import 'package:manage_gym/common/extensions/future.dart';
import 'package:manage_gym/features/gym/data/data_source/gym_data_source.dart';
import 'package:manage_gym/features/gym/domain/entities/gym_entity.dart';
import 'package:manage_gym/features/gym/domain/entities/income_entity.dart';
import 'package:manage_gym/params/input_params.dart';

import 'package:manage_gym/common/usecases/usecase.dart';

import 'package:manage_gym/common/exceptions/exceptions.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/gym_repository.dart';

class GymRepositoryImpl implements GymRepository {
  final GymDataSource dataSource;

  GymRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, Nothing>> signUp(SignUpInputParams params) async {
    return await dataSource.signUp(params).toEither();
  }

  @override
  Future<Either<Failure, GymEntity>> gymInfo() async {
    return await dataSource.gymInfo().toEither();
  }

  @override
  Future<Either<Failure, Nothing>> updateGym(SignUpInputParams params) async {
    return await dataSource.updateGym(params).toEither();
  }

  @override
  Future<Either<Failure, List<IncomeEntity>>> incomes() async {
    return await dataSource.incomes().toEither();
  }
}
