import 'package:manage_gym/features/athlete/domain/entities/athlete.dart';
import 'package:manage_gym/features/gym/domain/entities/gym_entity.dart';
import 'package:manage_gym/router/router.dart';

class NavigationFlow {
  static back([r]) {
    router.pop(r);
  }

  static toLoginScreen() {
    router.pushReplacement('/login');
  }

  static popUntilSplash() {
    while (router.canPop()) {
      router.pop();
    }
    router.pushReplacement('/');
  }

  static toHome() {
    router.pushReplacement('/home');
  }

  static toOtpScreen(String phoneNumber) {
    router.push('/otp/$phoneNumber');
  }

  static toSignUpGymScreen({GymEntity? gymEntity}) {
    if (gymEntity != null) {
      return router.push('/signUpGym', extra: gymEntity);
    } else {
      router.pushReplacement('/signUpGym');
    }
  }

  static toAthleteInfo(String id) {
    router.push('/athlete/$id');
  }

  static toAddAthlete({AthleteEntity? athlete}) {
    return router.push('/addAthlete', extra: athlete);
  }
}
