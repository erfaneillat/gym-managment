import 'package:dartz/dartz.dart';
import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:manage_gym/features/athlete/domain/entities/athlete.dart';
import 'package:manage_gym/features/athlete/domain/entities/short_athlete_data.dart';

import '../../../../common/usecases/usecase.dart';
import '../../../../params/input_params.dart';
import '../../../../utils/paginated_data.dart';

abstract class AthleteRepository {
  Future<Either<Failure, Nothing>> addAthlete(AthleteEntity athlete);
  Future<Either<Failure, AthleteEntity>> getAthlete(String athleteId);
  Future<Either<Failure, Nothing>> deleteAthlete(String athleteId);
  Future<Either<Failure, Nothing>> updateAthlete(AthleteEntity athleteEntity);
  Future<Either<Failure, PaginatedData<List<ShortAthleteDataEntity>>>>
      getAthletes(AthleteListInputParams params);
  Future<Either<Failure, Nothing>> pay(String athleteId);
}
