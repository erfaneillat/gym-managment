import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/common/navigation/navigation.dart';

showCustomAlertDialog(BuildContext context, String title, String message) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      'no'.tr(),
      style: context.textTheme.labelMedium,
    ),
    onPressed: () {
      NavigationFlow.back(false);
    },
  );
  Widget continueButton = TextButton(
    child: Text(
      'yes'.tr(),
      style: context.textTheme.labelMedium,
    ),
    onPressed: () {
      NavigationFlow.back(true);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: context.textTheme.labelMedium
          ?.copyWith(color: context.colorScheme.primary),
    ),
    content: Text(
      message,
      style: context.textTheme.labelMedium,
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
