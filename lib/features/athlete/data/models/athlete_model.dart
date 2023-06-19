import 'package:manage_gym/features/athlete/domain/entities/athlete.dart';

class AthleteModel extends AthleteEntity {
  AthleteModel(
      {required super.id,
      required super.nameAndFamily,
      required super.phoneNumber,
      super.profileImage,
      required super.nationalCode,
      required super.fatherName,
      super.description,
      required super.lastPayment,
      required super.registerInGymDate,
      required super.haveInsurance,
      super.insuranceStart,
      super.insuranceEnd,
      required super.registeredEveryOtherDay});

  factory AthleteModel.fromMap(Map<String, dynamic> map) => AthleteModel(
      id: map['_id'],
      nameAndFamily: map['nameAndFamily'],
      phoneNumber: map['phoneNumber'],
      profileImage: map['profileImage'],
      nationalCode: map['nationalCode'],
      fatherName: map['fatherName'],
      description: map['description'],
      lastPayment: DateTime.parse(map['lastPayment']),
      registerInGymDate: DateTime.parse(map['registerInGymDate']),
      haveInsurance: map['haveInsurance'],
      insuranceStart: map['insuranceStart'] != null
          ? DateTime.parse(map['insuranceStart'])
          : null,
      insuranceEnd: map['insuranceEnd'] != null
          ? DateTime.parse(map['insuranceEnd'])
          : null,
      registeredEveryOtherDay: map['registeredEveryOtherDay']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "nameAndFamily": nameAndFamily,
        "phoneNumber": phoneNumber,
        "nationalCode": nationalCode,
        "fatherName": fatherName,
        "profileImage": profileImage,
        "description": description,
        "lastPayment": lastPayment,
        "registerInGymDate": registerInGymDate,
        "haveInsurance": haveInsurance,
        "insuranceStart": insuranceStart,
        "insuranceEnd": insuranceEnd,
        "registeredEveryOtherDay": registeredEveryOtherDay
      };
  factory AthleteModel.fromEntity(AthleteEntity e) => AthleteModel(
      id: e.id,
      nameAndFamily: e.nameAndFamily,
      phoneNumber: e.phoneNumber,
      nationalCode: e.nationalCode,
      profileImage: e.profileImage,
      fatherName: e.fatherName,
      description: e.description,
      lastPayment: e.lastPayment,
      registerInGymDate: e.registerInGymDate,
      haveInsurance: e.haveInsurance,
      insuranceStart: e.insuranceStart,
      insuranceEnd: e.insuranceEnd,
      registeredEveryOtherDay: e.registeredEveryOtherDay);
}
