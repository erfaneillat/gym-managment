part of 'athlete_bloc.dart';

class AthleteState extends Equatable {
  final AddAthleteState addAthleteState;
  final GetAthleteState getAthleteState;

  const AthleteState({
    required this.addAthleteState,
    required this.getAthleteState,
  });

  @override
  List<Object> get props => [addAthleteState, getAthleteState];

  AthleteState copyWith(
          {AddAthleteState? addAthleteState,
          GetAthleteState? getAthleteState}) =>
      AthleteState(
          addAthleteState: addAthleteState ?? this.addAthleteState,
          getAthleteState: getAthleteState ?? this.getAthleteState);
}
