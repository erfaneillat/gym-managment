import 'package:manage_gym/common/extensions/future.dart';
import 'package:manage_gym/features/athlete/domain/entities/athlete.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:manage_gym/features/athlete/domain/entities/short_athlete_data.dart';
import 'package:manage_gym/features/athlete/domain/repositories/athlete_repository.dart';

import '../../../../params/input_params.dart';
import '../../../../utils/paginated_data.dart';
import '../data_source/athlete_data_source.dart';

class AthleteRepositoryImpl implements AthleteRepository {
  final AthleteDataSource dataSource;
  AthleteRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, Nothing>> addAthlete(AthleteEntity athlete) async {
    return await dataSource.addAthlete(athlete).toEither();
  }

  @override
  Future<Either<Failure, PaginatedData<List<ShortAthleteDataEntity>>>>
      getAthletes(AthleteListInputParams params) async {
    return await dataSource.getAthletes(params).toEither();
  }

  @override
  Future<Either<Failure, AthleteEntity>> getAthlete(String athleteId) async {
    return await dataSource.getAthlete(athleteId).toEither();
  }

  @override
  Future<Either<Failure, Nothing>> deleteAthlete(String athleteId) async {
    return await dataSource.deleteAthlete(athleteId).toEither();
  }

  @override
  Future<Either<Failure, Nothing>> updateAthlete(
      AthleteEntity athleteEntity) async {
    return await dataSource.updateAthlete(athleteEntity).toEither();
  }

  @override
  Future<Either<Failure, Nothing>> pay(String athleteId) async {
    return await dataSource.pay(athleteId).toEither();
  }
}
