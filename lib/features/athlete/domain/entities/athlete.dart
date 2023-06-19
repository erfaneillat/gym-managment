class AthleteEntity {
  final String id;
  final String nameAndFamily;
  final String phoneNumber;
  final String? profileImage;
  final String nationalCode;
  final String fatherName;
  final String? description;
  final DateTime lastPayment;
  final DateTime registerInGymDate;
  final bool haveInsurance;
  final DateTime? insuranceStart;
  final DateTime? insuranceEnd;
  final bool registeredEveryOtherDay;

  AthleteEntity({
    required this.id,
    required this.nameAndFamily,
    required this.phoneNumber,
    this.profileImage,
    required this.nationalCode,
    required this.fatherName,
    this.description,
    required this.lastPayment,
    required this.registerInGymDate,
    required this.haveInsurance,
    this.insuranceStart,
    this.insuranceEnd,
    required this.registeredEveryOtherDay,
  });
  AthleteEntity copyWith({
    String? id,
    String? nameAndFamily,
    String? phoneNumber,
    String? profileImage,
    String? nationalCode,
    String? fatherName,
    String? description,
    DateTime? lastPayment,
    DateTime? registerInGymDate,
    bool? haveInsurance,
    DateTime? insuranceStart,
    DateTime? insuranceEnd,
    bool? registeredEveryOtherDay,
  }) =>
      AthleteEntity(
        id: id ?? this.id,
        nameAndFamily: nameAndFamily ?? this.nameAndFamily,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        nationalCode: nationalCode ?? this.nationalCode,
        fatherName: fatherName ?? this.fatherName,
        description: description ?? this.description,
        lastPayment: lastPayment ?? this.lastPayment,
        registerInGymDate: registerInGymDate ?? this.registerInGymDate,
        haveInsurance: haveInsurance ?? this.haveInsurance,
        registeredEveryOtherDay:
            registeredEveryOtherDay ?? this.registeredEveryOtherDay,
        insuranceStart: insuranceStart ?? this.insuranceStart,
        insuranceEnd: insuranceEnd ?? this.insuranceEnd,
        profileImage: profileImage ?? this.profileImage,
      );

  int get untilPayment => lastPayment
      .add(const Duration(days: 30))
      .difference(DateTime.now())
      .inDays;
}
