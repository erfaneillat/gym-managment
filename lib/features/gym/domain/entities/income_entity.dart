import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class IncomeEntity {
  final DateTime date;
  final int income;
  IncomeEntity({required this.date, required this.income});

  String get formattedDate {
    final formatter = Jalali.fromDateTime(date).formatter;
    return '${formatter.mN} ${formatter.yyyy}';
  }
}
