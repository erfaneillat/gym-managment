part of 'athlete_bloc.dart';

abstract class AthleteEvent extends Equatable {
  const AthleteEvent();

  @override
  List<Object> get props => [];
}

class AddAthleteEvent extends AthleteEvent {
  final AthleteEntity athleteEntity;
  final bool isUpdate;
  const AddAthleteEvent({required this.athleteEntity, required this.isUpdate});
}

class GetAthleteInfoEvent extends AthleteEvent {
  final String athleteId;
  const GetAthleteInfoEvent({required this.athleteId});
}
