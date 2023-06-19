part of 'gym_bloc.dart';

abstract class GymEvent extends Equatable {
  const GymEvent();

  @override
  List<Object> get props => [];
}

class GetGymInfoEvent extends GymEvent {
  const GetGymInfoEvent();
}
