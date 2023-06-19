import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/common/gen/assets.gen.dart';
import 'package:manage_gym/common/navigation/navigation.dart';
import 'package:manage_gym/common/widgets/loading_widget.dart';
import 'package:manage_gym/configs/config.dart';
import 'package:manage_gym/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:manage_gym/locator.dart';
import 'package:manage_gym/router/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('fa', 'IR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('fa', 'IR'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: config['theme'],
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
    );
  }
}

late AnimationController controller;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    if (!GetIt.I.isRegistered<AuthBloc>()) {
      await setup();
    }
    final shared = sl<SharedPreferences>();
    int? loginStep = shared.getInt('loginStep') ?? 0;

    if (loginStep == 1) {
      await Future.delayed(const Duration(seconds: 3));

      NavigationFlow.toSignUpGymScreen();
      return;
    }

    if (loginStep == 2) {
      await Future.delayed(const Duration(seconds: 3));

      NavigationFlow.toHome();
    } else {
      await Future.delayed(const Duration(seconds: 3));

      NavigationFlow.toLoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Hero(
            tag: 'logo',
            child: Assets.icons.appLogo
                .image(height: 150, width: 150)
                .animate()
                .fadeIn(),
          ),
          const SizedBox(
            height: 50,
            width: double.infinity,
          ),
          Hero(
            tag: 'appName',
            child: Text('app_name'.tr(),
                    style: context.textTheme.labelLarge!.copyWith(
                        fontSize: 26, color: context.colorScheme.onPrimary))
                .animate()
                .fadeIn(),
          ),
          const SizedBox(
            height: 3,
          ),
          Hero(
            tag: 'easyManage',
            child: Text('app_banner'.tr(),
                    style: context.textTheme.labelSmall!.copyWith(
                        fontSize: 14, color: context.colorScheme.onPrimary))
                .animate()
                .fadeIn(),
          ),
          const Spacer(),
          LoadingWidget(
            color: context.colorScheme.onPrimary,
          )
        ],
      ),
    );
  }
}
