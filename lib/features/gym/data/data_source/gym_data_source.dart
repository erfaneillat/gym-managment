import 'package:manage_gym/features/auth/domain/usecases/current_user_id_use_case.dart';
import 'package:manage_gym/features/gym/data/models/gym_model.dart';
import 'package:manage_gym/features/gym/data/models/income_model.dart';
import 'package:manage_gym/features/gym/domain/entities/gym_entity.dart';
import 'package:manage_gym/features/gym/domain/entities/income_entity.dart';

import '../../../../common/constants/constants.dart';
import '../../../../common/usecases/usecase.dart';
import '../../../../locator.dart';
import '../../../../params/input_params.dart';
import '../../../../services/api_services.dart';

abstract class GymDataSource {
  Future<Nothing> signUp(SignUpInputParams params);
  Future<Nothing> updateGym(SignUpInputParams params);
  Future<GymEntity> gymInfo();
  Future<List<IncomeEntity>> incomes();
}

class GymDataSourceImpl implements GymDataSource {
  final Future<String> Function() getGymId;
  GymDataSourceImpl({required this.getGymId});
  @override
  Future<Nothing> signUp(SignUpInputParams params) async {
    final id = await getGymId();

    await ApiService.postRequest('${Constants.baseUrl}/gym', {
      'id': id,
      'nameAndFamily': params.nameAndFamily,
      'gymName': params.gymName,
      'gymFee': params.gymFee,
    });

    return Nothing();
  }

  @override
  Future<GymEntity> gymInfo() async {
    final id = await getGymId();

    final data = await ApiService.getRequest('${Constants.baseUrl}/gym', {
      'id': id,
    });
    return GymModel.fromMap(data['result']);
  }

  @override
  Future<Nothing> updateGym(SignUpInputParams params) async {
    final id = await getGymId();

    await ApiService.putRequest('${Constants.baseUrl}/gym', {
      'id': id,
      'nameAndFamily': params.nameAndFamily,
      'gymName': params.gymName,
      'gymFee': params.gymFee,
    });

    return Nothing();
  }

  @override
  Future<List<IncomeEntity>> incomes() async {
    final id = await getGymId();

    final result = await ApiService.postRequest('${Constants.baseUrl}/income', {
      'id': id,
    });

    return (result['result'] as List)
        .map((e) => IncomeModel.fromJson(e))
        .toList();
  }
}
