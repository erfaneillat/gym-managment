import 'package:equatable/equatable.dart';
import 'package:manage_gym/features/athlete/domain/entities/athlete.dart';

abstract class GetAthleteState extends Equatable {
  const GetAthleteState();

  @override
  List<Object> get props => [];
}

class GetAthleteInitial extends GetAthleteState {}

class GetAthleteLoading extends GetAthleteState {}

class GetAthleteSuccess extends GetAthleteState {
  final AthleteEntity athleteEntity;
  const GetAthleteSuccess({required this.athleteEntity});
}

class GetAthleteFailure extends GetAthleteState {
  final String message;

  const GetAthleteFailure({required this.message});
}
