import 'package:manage_gym/features/gym/domain/entities/gym_entity.dart';

class GymModel extends GymEntity {
  GymModel(
      {required super.id,
      required super.gymName,
      required super.nameAndFamily,
      required super.athleteCount,
      required super.phoneNumber,
      required super.gymFee});

  factory GymModel.fromMap(Map<String, dynamic> map) => GymModel(
      id: map['id'],
      gymName: map['gymName'],
      nameAndFamily: map['nameAndFamily'],
      athleteCount: map['athleteCount'],
      phoneNumber: map['phoneNumber'],
      gymFee: (map['gymFee'] as int));
  factory GymModel.fromEntity(GymEntity entity) => GymModel(
      id: entity.id,
      gymName: entity.gymName,
      nameAndFamily: entity.nameAndFamily,
      athleteCount: entity.athleteCount,
      phoneNumber: entity.phoneNumber,
      gymFee: entity.gymFee);
}
