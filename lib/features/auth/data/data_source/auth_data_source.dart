import 'package:manage_gym/common/constants/constants.dart';
import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:manage_gym/params/input_params.dart';
import 'package:manage_gym/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/usecases/usecase.dart';
import '../../../../params/return_params.dart';

abstract class AuthDataSource {
  Future<Nothing> requestOtp(String phoneNumber);
  Future<VerifyOtpReturnParams> verifyOtp(VerifyOtpInputParams params);
  Future<String> currentUserId();
  Future<Nothing> signOut();
}

class AuthDataSourceImpl implements AuthDataSource {
  final SharedPreferences preferences;
  String? id;
  AuthDataSourceImpl({required this.preferences});
  @override
  Future<Nothing> requestOtp(String phoneNumber) async {
    await ApiService.postRequest('${Constants.baseUrl}/auth/request-otp', {
      'phoneNumber': phoneNumber,
    });

    return Nothing();
  }

  @override
  Future<VerifyOtpReturnParams> verifyOtp(VerifyOtpInputParams params) async {
    final data =
        await ApiService.postRequest('${Constants.baseUrl}/auth/verify-otp', {
      'phoneNumber': params.phoneNumber,
      'code': params.code,
    });

    return VerifyOtpReturnParams(
        id: data['result']['id'],
        completedProfile: data['result']['completedProfile']);
  }

  @override
  Future<String> currentUserId() async {
    id ??= preferences.getString('userID');
    if (id == null || id == '') {
      signOut();
      throw UnExceptedFailure();
    }
    return id!;
  }

  @override
  Future<Nothing> signOut() async {
    await preferences.remove('userID');
    await preferences.remove('loginStep');
    return Nothing();
  }
}
