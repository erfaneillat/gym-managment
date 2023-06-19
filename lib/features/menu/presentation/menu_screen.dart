import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/common/gen/assets.gen.dart';
import 'package:manage_gym/common/navigation/navigation.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/common/widgets/custom_alert_dialog.dart';
import 'package:manage_gym/common/widgets/max_width.dart';
import 'package:manage_gym/features/auth/domain/usecases/sign_out_use_case.dart';

import '../../../locator.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: SafeArea(
        child: MaxWidthWidget(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Assets.icons.appLogo.image(width: 120, height: 120),
              const SizedBox(
                height: 10,
              ),
              Text(
                'app_name'.tr(),
                style: context.textTheme.labelMedium!.copyWith(
                    color: context.colorScheme.onPrimary, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
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
                child: MaxWidthWidget(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      children: [
                        MenuItem(
                          title: 'rules'.tr(),
                          icon: Icons.menu_book_outlined,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(
                                        'rules'.tr(),
                                        style: context.textTheme.labelMedium,
                                      ),
                                      content: Text('rules_content'.tr()),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'ok'.tr(),
                                              style:
                                                  context.textTheme.labelMedium,
                                            ))
                                      ],
                                    ));
                          },
                        ),
                        MenuItem(
                          title: 'about_us'.tr(),
                          icon: Icons.info_outline_rounded,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(
                                        'about_us'.tr(),
                                        style: context.textTheme.labelMedium,
                                      ),
                                      content: Text('rules_content'.tr()),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'ok'.tr(),
                                              style:
                                                  context.textTheme.labelMedium,
                                            ))
                                      ],
                                    ));
                          },
                        ),
                        MenuItem(
                          title: 'exit'.tr(),
                          icon: Icons.exit_to_app,
                          onTap: () async {
                            final exit = await showCustomAlertDialog(
                                context,
                                'exit_account'.tr(),
                                'exit_account_message'.tr());
                            if (exit) {
                              final result =
                                  await sl<SignOutUseCase>()(Nothing());
                              result.fold((l) => null, (r) {
                                sl.reset();
                                return NavigationFlow.popUntilSplash();
                              });
                            }
                          },
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
      required this.title,
      required this.icon,
      this.color,
      required this.onTap});
  final String title;
  final IconData icon;
  final Function() onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.1)))),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: context.textTheme.labelMedium!.copyWith(color: color),
              )
            ],
          ),
        ),
      ),
    );
  }
}
