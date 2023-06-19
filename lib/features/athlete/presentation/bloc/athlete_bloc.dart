import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manage_gym/features/athlete/domain/entities/athlete.dart';
import 'package:manage_gym/features/athlete/domain/usecases/add_athlete_use_case.dart';
import 'package:manage_gym/features/athlete/presentation/bloc/add_athlete_state.dart';
import 'package:manage_gym/features/athlete/presentation/bloc/get_athlete_state.dart';

import '../../domain/usecases/get_athlete_use_case.dart';
import '../../domain/usecases/update_athlete_use_case.dart';

part 'athlete_event.dart';
part 'athlete_state.dart';

class AthleteBloc extends Bloc<AthleteEvent, AthleteState> {
  final AddAthleteUseCase addAthleteUseCase;
  final GetAthleteUseCase getAthleteUseCase;
  final UpdateAthleteUseCase updateAthleteUseCase;
  AthleteBloc(
      {required this.addAthleteUseCase,
      required this.getAthleteUseCase,
      required this.updateAthleteUseCase})
      : super(AthleteState(
          addAthleteState: AddAthleteInitial(),
          getAthleteState: GetAthleteInitial(),
        )) {
    on<AddAthleteEvent>((event, emit) async {
      emit(state.copyWith(addAthleteState: AddAthleteLoading()));

      final result = event.isUpdate
          ? await updateAthleteUseCase(event.athleteEntity)
          : await addAthleteUseCase(event.athleteEntity);
      result.fold(
          (l) => emit(state.copyWith(
              addAthleteState: AddAthleteFailure(message: l.message))),
          (r) => emit(state.copyWith(
              addAthleteState: AddAthleteSuccess(isUpdate: event.isUpdate))));
    });
    on<GetAthleteInfoEvent>((event, emit) async {
      emit(state.copyWith(getAthleteState: GetAthleteLoading()));
      final result = await getAthleteUseCase(event.athleteId);
      result.fold(
          (l) => emit(state.copyWith(
              getAthleteState: GetAthleteFailure(message: l.message))),
          (r) => emit(state.copyWith(
              getAthleteState: GetAthleteSuccess(athleteEntity: r))));
    });
  }
}
