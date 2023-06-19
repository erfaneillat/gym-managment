import 'dart:io';

import 'package:dio/dio.dart';
import 'package:manage_gym/features/athlete/data/models/athlete_model.dart';
import 'package:manage_gym/features/athlete/data/models/short_athlete_data_model.dart';
import 'package:manage_gym/features/athlete/domain/entities/athlete.dart';
import 'package:manage_gym/features/athlete/domain/entities/short_athlete_data.dart';
import 'package:manage_gym/features/auth/domain/usecases/current_user_id_use_case.dart';
import 'package:manage_gym/services/api_services.dart';
import 'package:manage_gym/utils/paginated_data.dart';

import '../../../../common/constants/constants.dart';
import '../../../../common/usecases/usecase.dart';
import '../../../../locator.dart';
import '../../../../params/input_params.dart';

abstract class AthleteDataSource {
  Future<Nothing> addAthlete(AthleteEntity athlete);
  Future<PaginatedData<List<ShortAthleteDataEntity>>> getAthletes(
      AthleteListInputParams params);
  Future<AthleteEntity> getAthlete(String id);
  Future<Nothing> deleteAthlete(String id);
  Future<Nothing> updateAthlete(AthleteEntity athlete);
  Future<Nothing> pay(String athleteId);
}

class AthleteDataSourceImpl implements AthleteDataSource {
  final Future<String> Function() getCurrentUserId;
  AthleteDataSourceImpl({required this.getCurrentUserId});
  @override
  Future<Nothing> addAthlete(AthleteEntity athlete) async {
    final id = await getCurrentUserId();
    Map<String, dynamic> map =
        AthleteModel.fromEntity(athlete.copyWith(id: id)).toMap();
    if (athlete.profileImage != null) {
      map.addAll({
        "profile": await MultipartFile.fromFile(athlete.profileImage!,
            filename: athlete.profileImage!.split('/').last),
      });
    }
    FormData formData = FormData.fromMap(map);
    await ApiService.postRequest('${Constants.baseUrl}/athlete', {}, formData);
    return Nothing();
  }

  @override
  Future<PaginatedData<List<ShortAthleteDataEntity>>> getAthletes(
      AthleteListInputParams params) async {
    final id = await sl<CurrentUserIdUseCase>()(Nothing());
    final data = await ApiService.getRequest('${Constants.baseUrl}/athletes',
        {'id': id, 'page': params.key, 'name': params.searchParameters?.name});
    return PaginatedData(
        data: (data['result']['athletes'] as List)
            .map((e) => ShortAthleteDataModel.fromMap(e))
            .toList(),
        page: int.parse(data['result']['page']));
  }

  @override
  Future<AthleteEntity> getAthlete(String id) async {
    final data =
        await ApiService.getRequest('${Constants.baseUrl}/athlete', {"id": id});

    return AthleteModel.fromMap(data['result']);
  }

  @override
  Future<Nothing> deleteAthlete(String id) async {
    await ApiService.deleteRequest('${Constants.baseUrl}/athlete', {"id": id});

    return Nothing();
  }

  @override
  Future<Nothing> updateAthlete(AthleteEntity athlete) async {
    Map<String, dynamic> map = AthleteModel.fromEntity(athlete).toMap();
    if (athlete.profileImage != null &&
        File(athlete.profileImage!).existsSync()) {
      map.addAll({
        "profile": await MultipartFile.fromFile(athlete.profileImage!,
            filename: athlete.profileImage!.split('/').last),
      });
    }
    FormData formData = FormData.fromMap(map);
    await ApiService.putRequest('${Constants.baseUrl}/athlete', {}, formData);
    return Nothing();
  }

  @override
  Future<Nothing> pay(String athleteId) async {
    final id = await sl<CurrentUserIdUseCase>()(Nothing());
    await ApiService.postRequest(
        '${Constants.baseUrl}/pay', {"athleteId": athleteId, "gymId": id});
    return Nothing();
  }
}
