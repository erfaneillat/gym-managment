import 'package:equatable/equatable.dart';

abstract class AddAthleteState extends Equatable {
  const AddAthleteState();

  @override
  List<Object> get props => [];
}

class AddAthleteInitial extends AddAthleteState {}

class AddAthleteLoading extends AddAthleteState {}

class AddAthleteSuccess extends AddAthleteState {
  final bool isUpdate;
  const AddAthleteSuccess({this.isUpdate = false});
}

class AddAthleteFailure extends AddAthleteState {
  final String message;

  const AddAthleteFailure({required this.message});
}
