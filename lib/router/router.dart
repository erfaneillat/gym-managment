import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_gym/features/athlete/domain/entities/athlete.dart';
import 'package:manage_gym/features/athlete/presentation/bloc/athlete_bloc.dart';
import 'package:manage_gym/features/athlete/presentation/pages/add_athlete.dart';
import 'package:manage_gym/features/athlete/presentation/pages/athlete_info.dart';
import 'package:manage_gym/features/athlete/presentation/pages/athlete_list_screen.dart';
import 'package:manage_gym/features/auth/presentation/pages/login_screen.dart';
import 'package:manage_gym/features/auth/presentation/pages/otp_screen.dart';
import 'package:manage_gym/features/gym/domain/entities/gym_entity.dart';
import 'package:manage_gym/main.dart';

import '../features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

import '../features/gym/presentation/blocs/sign_up_bloc/sign_up_gym_bloc.dart';
import '../features/gym/presentation/pages/sign_up_gym_screen.dart';
import '../features/home/home_screen.dart';
import '../locator.dart';

// GoRouter configuration
final router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
        name: '/splash'),
    GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const LoginScreen(),
            )),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
        path: '/athletes',
        builder: (context, state) => const AthleteListScreen()),
    GoRoute(
        path: '/otp/:phone',
        builder: (context, state) => OtpScreen(
              phone: state.pathParameters['phone'] ?? "",
            )),
    GoRoute(
        path: '/athlete/:id',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => sl<AthleteBloc>(),
            child: AthleteInfoScreen(
              id: state.pathParameters['id'] ?? "",
            ),
          );
        }),
    GoRoute(
        path: '/addAthlete',
        builder: (context, state) => BlocProvider(
              create: (context) => sl<AthleteBloc>(),
              child: AddAthleteScreen(
                athleteEntity: state.extra as AthleteEntity?,
              ),
            )),
    GoRoute(
        path: '/signUpGym',
        builder: (context, state) => BlocProvider(
            create: (c) => sl<SignUpGymBloc>(),
            child: SignUpGymScreen(
              gymEntity: state.extra as GymEntity?,
            ))),
  ],
);
