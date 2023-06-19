import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({super.key, required this.child, this.enable = true});
  final Widget child;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    if (!enable) {
      return child;
    }
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: child);
  }
}
