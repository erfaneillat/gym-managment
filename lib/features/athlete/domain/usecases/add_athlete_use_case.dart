import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/features/athlete/domain/entities/athlete.dart';
import 'package:manage_gym/features/athlete/domain/repositories/athlete_repository.dart';

class AddAthleteUseCase extends UseCase<Nothing, AthleteEntity> {
  final AthleteRepository repository;
  AddAthleteUseCase({required this.repository});
  @override
  Future<Either<Failure, Nothing>> call(AthleteEntity param) async {
    return await repository.addAthlete(param);
  }
}
