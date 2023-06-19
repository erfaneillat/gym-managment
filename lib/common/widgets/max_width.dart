import 'package:flutter/material.dart';

class MaxWidthWidget extends StatelessWidget {
  const MaxWidthWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: child,
    );
  }
}
