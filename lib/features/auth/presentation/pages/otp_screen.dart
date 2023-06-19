import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/common/gen/assets.gen.dart';
import 'package:manage_gym/common/navigation/navigation.dart';
import 'package:manage_gym/common/widgets/max_width.dart';
import 'package:manage_gym/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:manage_gym/params/input_params.dart';
import 'package:pinput/pinput.dart';
import 'package:intl/intl.dart' as i;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../locator.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.phone});
  final String phone;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: context.textTheme.labelMedium,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 223, 228, 231)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.colorScheme.primary),
      borderRadius: BorderRadius.circular(8),
    );
    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.colorScheme.error),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
      color: const Color.fromRGBO(234, 239, 243, 1),
    ));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Flexible(
              child:
                  Lottie.asset(Assets.animations.otp, width: 250, height: 200)),
          const SizedBox(
            height: 20,
          ),
          MaxWidthWidget(
              child: Text(
            'otp_code_sent'.tr(args: [phone]),
            style: context.textTheme.labelMedium!.copyWith(fontSize: 15),
            textAlign: TextAlign.center,
          )),
          const SizedBox(
            height: 20,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              defaultPinTheme: defaultPinTheme,
              errorPinTheme: errorPinTheme,
              errorTextStyle: context.textTheme.labelSmall!
                  .copyWith(color: context.colorScheme.error),
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) async {
                final result = await sl<VerifyOtpUseCase>()
                    .call(VerifyOtpInputParams(code: pin, phoneNumber: phone));
                await result.fold((l) {
                  context.showMessage(l.message, SnackBarType.error);
                }, (r) async {
                  if (!r.completedProfile) {
                    await sl<SharedPreferences>.call().setInt('loginStep', 1);
                    await sl<SharedPreferences>.call()
                        .setString('userID', r.id);
                    NavigationFlow.toSignUpGymScreen();
                  } else {
                    await sl<SharedPreferences>.call().setInt('loginStep', 2);
                    await sl<SharedPreferences>.call()
                        .setString('userID', r.id);
                    NavigationFlow.toHome();
                  }
                });
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: NavigationFlow.back,
            child: Text(
              'otp_screen_edit_phone'.tr(),
              style: context.textTheme.labelSmall!
                  .copyWith(decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }
}
