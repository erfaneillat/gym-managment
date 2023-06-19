import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/features/gym/domain/entities/gym_entity.dart';
import 'package:manage_gym/features/gym/domain/repositories/gym_repository.dart';

class GetGymInfoUseCase extends UseCase<GymEntity, Nothing> {
  final GymRepository repository;
  GetGymInfoUseCase({required this.repository});
  @override
  Future<Either<Failure, GymEntity>> call(Nothing param) {
    return repository.gymInfo();
  }
}
