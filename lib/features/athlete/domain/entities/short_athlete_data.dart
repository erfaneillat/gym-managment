class ShortAthleteDataEntity {
  final String id;
  final String nameAndFamily;
  final String profileImage;
  final DateTime lastPayment;
  final String? description;
  ShortAthleteDataEntity(
      {required this.nameAndFamily,
      required this.profileImage,
      required this.id,
      required this.lastPayment,
      this.description});

  int get untilPayment => lastPayment
      .add(const Duration(days: 30))
      .difference(DateTime.now())
      .inDays;
}
