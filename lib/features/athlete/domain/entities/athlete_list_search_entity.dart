class AthleteListSearchEntity {
  String? name;

  AthleteListSearchEntity({this.name});

  AthleteListSearchEntity copyWith({
    String? name,
  }) {
    return AthleteListSearchEntity(
      name: name ?? this.name,
    );
  }
}
