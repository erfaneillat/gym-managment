import '../features/athlete/domain/entities/athlete_list_search_entity.dart';

class VerifyOtpInputParams {
  final String code;
  final String phoneNumber;
  VerifyOtpInputParams({required this.code, required this.phoneNumber});
}

class SignUpInputParams {
  final String nameAndFamily;
  final String gymName;
  final double gymFee;
  SignUpInputParams(
      {required this.nameAndFamily,
      required this.gymName,
      required this.gymFee});
}

class AthleteListInputParams {
  final int? key;
  final AthleteListSearchEntity? searchParameters;
  AthleteListInputParams({this.key = 1, this.searchParameters});
}
