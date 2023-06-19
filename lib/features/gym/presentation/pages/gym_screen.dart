import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/common/navigation/navigation.dart';
import 'package:manage_gym/common/widgets/custom_shimmer.dart';
import 'package:manage_gym/common/widgets/max_width.dart';
import 'package:manage_gym/features/gym/domain/entities/gym_entity.dart';
import 'package:manage_gym/features/gym/domain/entities/income_entity.dart';
import 'package:manage_gym/features/gym/presentation/blocs/gym_bloc/get_gym_info_state.dart';
import 'package:manage_gym/features/gym/presentation/blocs/gym_bloc/gym_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class GymScreen extends StatefulWidget {
  const GymScreen({super.key});

  @override
  State<GymScreen> createState() => _GymScreenState();
}

class _GymScreenState extends State<GymScreen> {
  final scrollController = ScrollController();
  bool scrolled = false;
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset > 30) {
        if (!scrolled) {
          setState(() {
            scrolled = true;
          });
        }
      } else {
        if (scrolled) {
          setState(() {
            scrolled = false;
          });
        }
      }
    });
    context.read<GymBloc>().add(const GetGymInfoEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.colorScheme.primary,
        body: SafeArea(
            child: MaxWidthWidget(
                child: BlocConsumer<GymBloc, GymState>(
          buildWhen: (previous, current) =>
              previous.getGymInfoState != current.getGymInfoState,
          listenWhen: (previous, current) =>
              previous.getGymInfoState != current.getGymInfoState,
          listener: (context, state) {},
          builder: (context, state) {
            GymEntity? gym = state.getGymInfoState is GetGymInfoSuccess
                ? (state.getGymInfoState as GetGymInfoSuccess).gymEntity
                : null;
            List<IncomeEntity>? incomes =
                state.getGymInfoState is GetGymInfoSuccess
                    ? (state.getGymInfoState as GetGymInfoSuccess).incomes
                    : null;

            return Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: context.height * 0.3,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: PopupMenuButton(
                              splashRadius: 25,
                              icon: Icon(
                                Icons.more_vert,
                                color: context.colorScheme.onPrimary,
                              ),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Text(
                                          'edit_account'.tr(),
                                          style: context.textTheme.labelMedium,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color:
                                              context.colorScheme.onBackground,
                                        )
                                      ],
                                    ),
                                  )
                                ];
                              },
                              onSelected: (val) async {
                                if (val == 'edit') {
                                  if (gym != null) {
                                    final edited =
                                        await NavigationFlow.toSignUpGymScreen(
                                            gymEntity: gym);
                                    if (edited) {
                                      context
                                          .read<GymBloc>()
                                          .add(const GetGymInfoEvent());
                                    }
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomShimmer(
                            enable: gym == null,
                            child: Container(
                              child: Text(gym?.nameAndFamily ?? '...',
                                  style: context.textTheme.labelLarge!.copyWith(
                                      color: context.colorScheme.onPrimary,
                                      fontSize: 25)),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomShimmer(
                            enable: gym == null,
                            child: Text(
                                'gym_manager'.tr(args: [gym?.gymName ?? '...']),
                                style: context.textTheme.labelMedium!.copyWith(
                                    color: context.colorScheme.onPrimary,
                                    fontSize: 16)),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: context.theme.scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: ListView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.only(top: 50),
                            itemCount: incomes?.length ?? 10,
                            itemBuilder: (context, index) {
                              final income = incomes?[index];
                              return CustomShimmer(
                                enable: incomes == null,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 3,
                                            blurRadius: 3)
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              income?.formattedDate ?? '',
                                              style:
                                                  context.textTheme.labelMedium,
                                            ),
                                            Text(
                                              '${'profit'.tr()} ${income?.income} تومان',
                                              style: context
                                                  .textTheme.labelMedium!
                                                  .copyWith(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
                    )
                  ],
                ),
                AnimatedPositioned(
                  top: context.height * (scrolled ? 0.2 : 0.25),
                  right: context.width * 0.3,
                  left: context.width * 0.3,
                  duration: const Duration(milliseconds: 200),
                  child: CustomShimmer(
                    enable: gym == null,
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: context.theme.scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 3,
                                  blurRadius: 3)
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'athlete_count'.tr(),
                              style: context.textTheme.labelMedium,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              gym?.athleteCount.toString() ?? '10',
                              style: context.textTheme.labelSmall,
                            ),
                          ],
                        )),
                  ),
                )
              ],
            );
          },
        ))));
  }
}
