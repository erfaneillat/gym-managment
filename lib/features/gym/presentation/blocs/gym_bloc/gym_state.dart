part of 'gym_bloc.dart';

class GymState extends Equatable {
  final GetGymInfoState getGymInfoState;

  const GymState({required this.getGymInfoState});

  @override
  List<Object> get props => [getGymInfoState];

  GymState copyWith({
    GetGymInfoState? getGymInfoState,
  }) {
    return GymState(
      getGymInfoState: getGymInfoState ?? this.getGymInfoState,
    );
  }
}
