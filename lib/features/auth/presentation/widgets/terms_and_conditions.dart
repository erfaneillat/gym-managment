import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_gym/common/extensions/context.dart';

import '../blocs/auth_bloc/auth_bloc.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) =>
              previous.acceptTermsStatus != current.acceptTermsStatus,
          builder: (context, state) {
            return Checkbox(
                value: state.acceptTermsStatus.accepted,
                onChanged: (val) {
                  context
                      .read<AuthBloc>()
                      .add(AuthCheckTerms(acceptedTerms: val!));
                });
          },
        ),
        RichText(
          text: TextSpan(
              text: '${'with'.tr()} ',
              style: context.textTheme.labelMedium!.copyWith(fontSize: 14),
              children: [
                TextSpan(
                  text: "${'terms_conditions'.tr()} ",
                  style: context.textTheme.labelMedium!.copyWith(
                      fontSize: 14, color: context.colorScheme.primary),
                ),
                TextSpan(
                  text: 'terms_conditions_accept'.tr(args: ['app_name'.tr()]),
                  style: context.textTheme.labelMedium!.copyWith(fontSize: 14),
                ),
              ]),
        ),
      ],
    );
  }
}
