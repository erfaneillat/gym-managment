import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/features/athlete/domain/entities/short_athlete_data.dart';
import 'package:manage_gym/features/athlete/domain/repositories/athlete_repository.dart';

import '../../../../params/input_params.dart';
import '../../../../utils/paginated_data.dart';

class GetAthletesUseCase extends UseCase<
    PaginatedData<List<ShortAthleteDataEntity>>, AthleteListInputParams> {
  final AthleteRepository repository;
  GetAthletesUseCase({required this.repository});
  @override
  Future<Either<Failure, PaginatedData<List<ShortAthleteDataEntity>>>> call(
      AthleteListInputParams param) async {
    return await repository.getAthletes(param);
  }
}
