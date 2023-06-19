import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/common/navigation/navigation.dart';
import 'package:manage_gym/common/widgets/custom_alert_dialog.dart';
import 'package:manage_gym/common/widgets/custom_future_loading_dialog.dart';
import 'package:manage_gym/common/widgets/user_avatar.dart';
import 'package:manage_gym/features/athlete/domain/entities/athlete.dart';
import 'package:manage_gym/features/athlete/domain/usecases/delete_athlete_use_case.dart';
import 'package:manage_gym/features/athlete/presentation/bloc/athlete_bloc.dart';
import 'package:manage_gym/features/athlete/presentation/pages/athlete_list_screen.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/widgets/custom_outline_button.dart';
import '../../../../common/widgets/custom_shimmer.dart';
import '../../../../locator.dart';
import '../../domain/usecases/pay_use_case.dart';
import '../bloc/get_athlete_state.dart';
import '../dialogs/edit_insurance_dialog.dart';

class AthleteInfoScreen extends StatefulWidget {
  const AthleteInfoScreen({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<AthleteInfoScreen> createState() => _AthleteInfoScreenState();
}

class _AthleteInfoScreenState extends State<AthleteInfoScreen> {
  @override
  void initState() {
    context.read<AthleteBloc>().add(GetAthleteInfoEvent(athleteId: widget.id));
    super.initState();
  }

  @override
  void dispose() {
    //context.read<AthleteBloc>().close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AthleteBloc, AthleteState>(
      listener: (context, state) {},
      listenWhen: (previous, current) =>
          previous.getAthleteState != current.getAthleteState,
      buildWhen: (previous, current) =>
          previous.getAthleteState != current.getAthleteState,
      builder: (context, state) {
        final athlete = state.getAthleteState is GetAthleteSuccess
            ? (state.getAthleteState as GetAthleteSuccess).athleteEntity
            : null;

        return Scaffold(
          backgroundColor: context.colorScheme.primary,
          appBar: AppBar(
            backgroundColor: context.colorScheme.primary,
            elevation: 0,
            leading: IconButton(
                splashRadius: 20,
                onPressed: () {
                  NavigationFlow.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: context.colorScheme.onPrimary,
                )),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'delete_athlete'.tr(),
                            style: context.textTheme.labelMedium,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(Icons.delete, color: Colors.red)
                        ],
                      ),
                    ),
                  ];
                },
                onSelected: (value) async {
                  if (value == 'delete') {
                    final delete = await showCustomAlertDialog(context,
                        'delete_athlete'.tr(), 'delete_athlete_msg'.tr());
                    if (delete) {
                      final result = await showCustomFutureLoadingDialog(
                          context: context,
                          future: () => sl<DeleteAthleteUseCase>()(widget.id));
                      result.result?.fold((l) {
                        context.showMessage(l.message, SnackBarType.error);
                      }, (r) {
                        athleteListKey.currentState?.refresh();
                        NavigationFlow.back();

                        context.showMessage('athlete_deleted_successfully'.tr(),
                            SnackBarType.success);
                      });
                    }
                  }
                },
              )
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  const Expanded(child: SizedBox()),
                  Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            color: context.theme.scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30))),
                      ))
                ],
              ),
              SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    InfoBox(
                      athlete: athlete,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FeeInfoBox(
                      athlete: athlete,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InsuranceInfoBox(
                      athlete: athlete,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class InsuranceInfoBox extends StatelessWidget {
  const InsuranceInfoBox({super.key, this.athlete});
  final AthleteEntity? athlete;
  @override
  Widget build(BuildContext context) {
    return AthleteInfoBox(
        child: CustomShimmer(
      enable: athlete == null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'insurance_info'.tr(),
            style: context.textTheme.labelMedium,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    athlete?.haveInsurance != null
                        ? athlete!.haveInsurance
                            ? 'athlete_has_insurance'.tr()
                            : 'athlete_does_not_have_insurance'.tr()
                        : 'athlete_has_insurance'.tr(),
                    style:
                        context.textTheme.labelMedium!.copyWith(fontSize: 13),
                  ),
                  // _AthleteTextInfo(
                  //   text1: 'insurance_number'.tr(),
                  //   text2: '12354345',
                  // ),
                  if (athlete?.haveInsurance ?? false) ...[
                    _AthleteTextInfo(
                      text1: 'start_date'.tr(),
                      text2: athlete?.insuranceStart != null
                          ? Jalali.fromDateTime(athlete!.insuranceStart!)
                              .formatCompactDate()
                          : '1405/5/5',
                    ),
                    _AthleteTextInfo(
                      text1: 'end_date'.tr(),
                      text2: athlete?.insuranceEnd != null
                          ? Jalali.fromDateTime(athlete!.insuranceEnd!)
                              .formatCompactDate()
                          : '1405/5/5',
                    ),
                  ]
                ],
              ),
              const Spacer(),
              CustomOutlinedButton(
                onPressed: athlete == null
                    ? null
                    : () {
                        NavigationFlow.toAddAthlete(athlete: athlete);
                      },
                child: Row(
                  children: [
                    Text(
                      'edit_insurance'.tr(),
                      style: context.textTheme.labelMedium!.copyWith(
                          fontSize: 14, color: context.colorScheme.primary),
                    ),
                    const Icon(
                      Icons.edit,
                      size: 20,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}

class FeeInfoBox extends StatelessWidget {
  const FeeInfoBox({super.key, this.athlete});
  final AthleteEntity? athlete;
  @override
  Widget build(BuildContext context) {
    return AthleteInfoBox(
      child: CustomShimmer(
        enable: athlete == null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'fee_info'.tr(),
                  style: context.textTheme.labelMedium,
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: (athlete == null || athlete!.untilPayment > 0)
                        ? null
                        : () async {
                            final pay = await showCustomAlertDialog(context,
                                'payment'.tr(), 'payment_dialog_title'.tr());
                            if (pay) {
                              final result =
                                  // ignore: use_build_context_synchronously
                                  await showCustomFutureLoadingDialog(
                                      context: context,
                                      future: () =>
                                          sl<PayUseCase>()(athlete!.id));
                              result.result?.fold((l) {
                                context.showMessage(
                                    l.message, SnackBarType.error);
                              }, (r) {
                                context.read<AthleteBloc>().add(
                                    GetAthleteInfoEvent(
                                        athleteId: athlete!.id));
                                context.showMessage('payment_successfully'.tr(),
                                    SnackBarType.success);
                              });
                            }
                          },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(
                      'submit_payment'.tr(),
                      style: context.textTheme.labelMedium!
                          .copyWith(fontSize: 12, color: Colors.white),
                    ))
              ],
            ),
            // _AthleteTextInfo(text1: 'payed_fee'.tr(), text2: '0'),
            Row(
              children: [
                Checkbox(
                  value: athlete?.registeredEveryOtherDay ?? false,
                  onChanged: null,
                ),
                Expanded(
                  child: Text('registered_every_other_day'.tr(),
                      style: context.textTheme.labelMedium!
                          .copyWith(fontSize: 13)),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: _AthleteTextInfo(
                        text1: 'start_date'.tr(),
                        text2: athlete?.lastPayment != null
                            ? Jalali.fromDateTime(athlete!.lastPayment)
                                .formatCompactDate()
                            : '1402/2/2')),
                Expanded(
                    child: _AthleteTextInfo(
                        text1: 'end_date'.tr(),
                        text2: athlete?.lastPayment != null
                            ? Jalali.fromDateTime(athlete!.lastPayment
                                    .add(const Duration(days: 30)))
                                .formatCompactDate()
                            : '1402/3/2')),
              ],
            ),
            if (athlete != null)
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  athlete!.untilPayment < 0
                      ? '${athlete!.untilPayment.abs()} روز تاخیر در پرداخت شهریه'
                      : '${athlete!.untilPayment} روز مانده تا پرداخت شهریه',
                  style: context.textTheme.labelSmall!.copyWith(
                      color: athlete!.untilPayment < 0
                          ? Colors.red
                          : Colors.green[600]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox({super.key, this.athlete});
  final AthleteEntity? athlete;
  @override
  Widget build(BuildContext context) {
    return AthleteInfoBox(
      child: CustomShimmer(
        enable: athlete == null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UserAvatar(
                  initial: athlete?.profileImage,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        athlete?.nameAndFamily ?? ' عرفان ایلات',
                        style: context.textTheme.labelMedium,
                      ),
                      Text(
                        athlete?.registerInGymDate != null
                            ? Jalali.fromDateTime(athlete!.registerInGymDate)
                                .formatCompactDate()
                                .toString()
                            : '1400/2/1',
                        style:
                            context.textTheme.bodySmall!.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                CustomOutlinedButton(
                  onPressed: athlete == null
                      ? null
                      : () async {
                          final updated = await NavigationFlow.toAddAthlete(
                              athlete: athlete);
                          if (updated) {
                            context.read<AthleteBloc>().add(
                                GetAthleteInfoEvent(athleteId: athlete!.id));
                          }
                        },
                  child: Row(
                    children: [
                      Text(
                        'edit'.tr(),
                        style: context.textTheme.labelMedium!.copyWith(
                            fontSize: 14, color: context.colorScheme.primary),
                      ),
                      const Icon(
                        Icons.edit,
                        size: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            _AthleteTextInfo(
              text1: 'phone_number'.tr(),
              text2: athlete?.phoneNumber ?? '09149668006',
            ),
            _AthleteTextInfo(
              text1: athlete?.nationalCode ?? 'national_code'.tr(),
              text2: '2742061029',
            ),
            _AthleteTextInfo(
              text1: 'father_name'.tr(),
              text2: athlete?.fatherName ?? 'محمدرضا',
            ),
            _AthleteTextInfo(
              text1: 'description'.tr(),
              text2: athlete?.description ?? 'not_inserted'.tr(),
              textStyle: context.textTheme.labelSmall!.copyWith(
                  color: context.textTheme.bodySmall!.color, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _AthleteTextInfo extends StatelessWidget {
  const _AthleteTextInfo({
    super.key,
    required this.text1,
    required this.text2,
    this.textStyle,
  });
  final String text1;
  final String text2;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: '$text1 : ',
            style: textStyle ??
                context.textTheme.labelMedium!.copyWith(
                    fontSize: 13,
                    color: context.colorScheme.onSecondaryContainer),
            children: [
          TextSpan(
              text: text2,
              style: textStyle ??
                  context.textTheme.labelMedium!.copyWith(
                      fontSize: 13,
                      color: context.colorScheme.onSecondaryContainer))
        ]));
  }
}

class AthleteInfoBox extends StatelessWidget {
  const AthleteInfoBox({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
            color: context.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 3)
            ]),
        child: child);
  }
}
