import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_gym/common/extensions/context.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: color ?? context.colorScheme.primary,
      size: 40,
    );
  }
}
