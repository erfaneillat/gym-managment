import 'package:manage_gym/features/athlete/domain/entities/short_athlete_data.dart';

class ShortAthleteDataModel extends ShortAthleteDataEntity {
  ShortAthleteDataModel(
      {required super.nameAndFamily,
      required super.profileImage,
      required super.lastPayment,
      super.description,
      required super.id});

  factory ShortAthleteDataModel.fromMap(Map<String, dynamic> map) =>
      ShortAthleteDataModel(
          nameAndFamily: map['nameAndFamily'],
          id: map['_id'],
          profileImage: map['profileImage'],
          lastPayment: DateTime.parse(map['lastPayment']),
          description: map['description']);
}
