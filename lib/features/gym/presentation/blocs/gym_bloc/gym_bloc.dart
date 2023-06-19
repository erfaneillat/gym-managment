import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/features/gym/domain/usecases/get_gym_info_use_case.dart';
import 'package:manage_gym/features/gym/domain/usecases/get_incomes_use_case.dart';
import 'package:manage_gym/features/gym/presentation/blocs/gym_bloc/get_gym_info_state.dart';

part 'gym_event.dart';
part 'gym_state.dart';

class GymBloc extends Bloc<GymEvent, GymState> {
  final GetGymInfoUseCase getGymInfoUseCase;
  final GetIncomesUseCase getGymIncomesUseCase;

  GymBloc({required this.getGymInfoUseCase, required this.getGymIncomesUseCase})
      : super(GymState(
          getGymInfoState: GetGymInfoInitial(),
        )) {
    on<GetGymInfoEvent>((event, emit) async {
      emit(state.copyWith(getGymInfoState: GetGymInfoLoading()));
      await Future.delayed(const Duration(milliseconds: 2000));
      final resGym = await getGymInfoUseCase(Nothing());
      final resIncomes = await getGymIncomesUseCase(Nothing());
      final bindedEither = resGym.bind((a) => resIncomes);

      bindedEither.fold(
          (l) => emit(state.copyWith(
              getGymInfoState: GetGymInfoFailure(message: l.message))), (r) {
        emit(state.copyWith(
            getGymInfoState: GetGymInfoSuccess(
                gymEntity: resGym.toIterable().first, incomes: r)));
      });
    });
  }
}
