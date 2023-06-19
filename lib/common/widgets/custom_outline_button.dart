import 'package:flutter/material.dart';
import 'package:manage_gym/common/extensions/context.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {super.key, required this.child, required this.onPressed});
  final Widget child;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: BorderSide(color: context.colorScheme.primary),
        ),
        onPressed: onPressed,
        child: child);
  }
}
