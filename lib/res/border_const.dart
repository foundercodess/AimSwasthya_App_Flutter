import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  final Widget child;
 final dynamic padding;
 final dynamic margin;
 final double? radius;
 final Gradient? gradient;

  const BorderContainer({super.key, required this.child, this.padding, this.margin, this.radius, this.gradient,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius??12),
        gradient: gradient?? const LinearGradient(
          colors: [AppColor.conLightBlue, AppColor.darkBlack],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
