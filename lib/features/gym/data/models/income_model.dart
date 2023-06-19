import 'package:manage_gym/features/gym/domain/entities/income_entity.dart';

class IncomeModel extends IncomeEntity {
  IncomeModel({required super.date, required super.income});
  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel(
      date: DateTime.parse(json['date']),
      income: int.parse(json['income'].toString()),
    );
  }
}
