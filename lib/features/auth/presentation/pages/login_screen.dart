import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/common/navigation/navigation.dart';
import 'package:manage_gym/common/widgets/max_width.dart';
import 'package:manage_gym/common/widgets/titled_textfield.dart';

import 'package:manage_gym/helper/validator.dart';
import 'package:manage_gym/router/router.dart';

import '../../../../common/gen/assets.gen.dart';
import '../../../../common/widgets/loading_widget.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/auth_bloc/login_state.dart';
import '../widgets/terms_and_conditions.dart';

final _loginFormKey = GlobalKey<FormBuilderState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    void onLogin() {
      if (_loginFormKey.currentState!.saveAndValidate()) {
        final phone = _loginFormKey.currentState!.fields['phone']!.value;
        context.read<AuthBloc>().add(AuthLoginEvent(phoneNumber: phone));
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Hero(
                tag: 'logo',
                child: Assets.icons.appLogo.image(height: 100, width: 100)),
            const SizedBox(
              height: 10,
              width: double.infinity,
            ),
            Hero(
              tag: 'appName',
              child: Text('app_name'.tr(),
                  style: context.textTheme.labelLarge!.copyWith(
                      fontSize: 20, color: context.colorScheme.onPrimary)),
            ),
            const SizedBox(
              height: 3,
            ),
            Hero(
                tag: 'easyManage',
                child: Text('app_banner'.tr(),
                    style: context.textTheme.labelSmall!.copyWith(
                        fontSize: 12, color: context.colorScheme.onPrimary))),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    FormBuilder(
                      key: _loginFormKey,
                      child: TitledTextField(
                          title: 'phone_number'.tr(),
                          validator: Validator.phone,
                          action: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          maxLines: 1,
                          name: 'phone',
                          hint: '09141111111'),
                    ),
                    const TermsAndConditionsWidget(),
                    const Spacer(),
                    BlocConsumer<AuthBloc, AuthState>(
                      listenWhen: (previous, current) =>
                          previous.authLoginState != current.authLoginState,
                      listener: (context, state) {
                        if (state.authLoginState is AuthLoginFailure) {
                          context.showMessage(
                              (state.authLoginState as AuthLoginFailure)
                                  .message,
                              SnackBarType.error);
                        }
                        if (state.authLoginState is AuthLoginSuccess) {
                          NavigationFlow.toOtpScreen(_loginFormKey
                              .currentState!.fields['phone']!.value);
                        }
                      },
                      buildWhen: (previous, current) =>
                          previous.authLoginState != current.authLoginState,
                      builder: (context, state) {
                        if (state.authLoginState is AuthLoginLoading) {
                          return const Center(child: LoadingWidget());
                        }
                        return MaxWidthWidget(
                          child: ElevatedButton(
                              onPressed: onLogin,
                              child: Text(
                                'login'.tr(),
                                style: context.textTheme.labelMedium!.copyWith(
                                    color: context.colorScheme.onPrimary),
                              )),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
