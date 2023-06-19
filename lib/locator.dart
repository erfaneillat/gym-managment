import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/features/athlete/data/data_source/athlete_data_source.dart';
import 'package:manage_gym/features/athlete/data/repositories/athlete_repository_impl.dart';
import 'package:manage_gym/features/athlete/domain/repositories/athlete_repository.dart';
import 'package:manage_gym/features/athlete/domain/usecases/add_athlete_use_case.dart';
import 'package:manage_gym/features/athlete/domain/usecases/get_athletes_use_case.dart';
import 'package:manage_gym/features/athlete/domain/usecases/pay_use_case.dart';
import 'package:manage_gym/features/athlete/presentation/bloc/athlete_bloc.dart';
import 'package:manage_gym/features/auth/data/data_source/auth_data_source.dart';
import 'package:manage_gym/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:manage_gym/features/auth/domain/repositories/auth_repository.dart';
import 'package:manage_gym/features/auth/domain/usecases/current_user_id_use_case.dart';
import 'package:manage_gym/features/auth/domain/usecases/request_otp_use_case.dart';
import 'package:manage_gym/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:manage_gym/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:manage_gym/features/gym/data/data_source/gym_data_source.dart';
import 'package:manage_gym/features/gym/data/repositories/gym_repository_impl.dart';
import 'package:manage_gym/features/gym/domain/repositories/gym_repository.dart';
import 'package:manage_gym/features/gym/domain/usecases/get_gym_info_use_case.dart';
import 'package:manage_gym/features/gym/domain/usecases/get_incomes_use_case.dart';
import 'package:manage_gym/features/gym/domain/usecases/sign_up_use_case.dart';
import 'package:manage_gym/features/gym/domain/usecases/update_gym_use_case.dart';
import 'package:manage_gym/features/gym/presentation/blocs/gym_bloc/gym_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/athlete/domain/entities/short_athlete_data.dart';
import 'features/athlete/domain/usecases/delete_athlete_use_case.dart';
import 'features/athlete/domain/usecases/get_athlete_use_case.dart';
import 'features/athlete/domain/usecases/update_athlete_use_case.dart';
import 'features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'features/gym/presentation/blocs/sign_up_bloc/sign_up_gym_bloc.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  sl.registerSingleton<PagingController<int, ShortAthleteDataEntity>>(
      PagingController(firstPageKey: 1));
  sl.registerSingleton<Dio>(Dio());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

//data source
  sl.registerSingleton<AuthDataSource>(AuthDataSourceImpl(preferences: sl()));
  sl.registerSingleton<GymDataSource>(
      GymDataSourceImpl(getGymId: () => sl<CurrentUserIdUseCase>()(Nothing())));
  sl.registerSingleton<AthleteDataSource>(AthleteDataSourceImpl(
      getCurrentUserId: () => sl<CurrentUserIdUseCase>()(Nothing())));

//repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(dataSource: sl()));
  sl.registerSingleton<GymRepository>(GymRepositoryImpl(dataSource: sl()));
  sl.registerSingleton<AthleteRepository>(
      AthleteRepositoryImpl(dataSource: sl()));

  //use cases
  sl.registerSingleton(RequestOtpUseCase(repository: sl()));
  sl.registerSingleton(VerifyOtpUseCase(repository: sl()));
  sl.registerSingleton(SignUpUseCase(repository: sl()));
  sl.registerSingleton(SignOutUseCase(repository: sl()));
  sl.registerSingleton(CurrentUserIdUseCase(repository: sl()));
  sl.registerSingleton(AddAthleteUseCase(repository: sl()));
  sl.registerSingleton(GetAthletesUseCase(repository: sl()));
  sl.registerSingleton(GetAthleteUseCase(repository: sl()));
  sl.registerSingleton(DeleteAthleteUseCase(repository: sl()));
  sl.registerSingleton(UpdateAthleteUseCase(repository: sl()));
  sl.registerSingleton(GetGymInfoUseCase(repository: sl()));
  sl.registerSingleton(UpdateGymUseCase(repository: sl()));
  sl.registerSingleton(PayUseCase(repository: sl()));
  sl.registerSingleton(GetIncomesUseCase(repository: sl()));

//bloc
  sl.registerFactory<AuthBloc>(() => AuthBloc(requestOtpUseCase: sl()));
  sl.registerFactory<GymBloc>(
      () => GymBloc(getGymInfoUseCase: sl(), getGymIncomesUseCase: sl()));
  sl.registerFactory<SignUpGymBloc>(
      () => SignUpGymBloc(signUpUseCase: sl(), updateGymUseCase: sl()));
  sl.registerFactory<AthleteBloc>(() => AthleteBloc(
      addAthleteUseCase: sl(),
      getAthleteUseCase: sl(),
      updateAthleteUseCase: sl()));
}
