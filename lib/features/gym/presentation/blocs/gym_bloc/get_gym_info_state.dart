import 'package:equatable/equatable.dart';
import 'package:manage_gym/features/gym/domain/entities/gym_entity.dart';
import 'package:manage_gym/features/gym/domain/entities/income_entity.dart';

abstract class GetGymInfoState extends Equatable {
  const GetGymInfoState();

  @override
  List<Object> get props => [];
}

class GetGymInfoInitial extends GetGymInfoState {}

class GetGymInfoLoading extends GetGymInfoState {}

class GetGymInfoSuccess extends GetGymInfoState {
  final GymEntity gymEntity;
  final List<IncomeEntity> incomes;
  const GetGymInfoSuccess({required this.gymEntity, required this.incomes});
}

class GetGymInfoFailure extends GetGymInfoState {
  final String message;

  const GetGymInfoFailure({required this.message});
}
