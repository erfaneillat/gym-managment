import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/features/athlete/domain/entities/athlete.dart';

import '../repositories/athlete_repository.dart';

class GetAthleteUseCase extends UseCase<AthleteEntity, String> {
  final AthleteRepository repository;
  GetAthleteUseCase({required this.repository});
  @override
  Future<Either<Failure, AthleteEntity>> call(String param) async {
    return await repository.getAthlete(param);
  }
}
