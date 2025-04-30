import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/material.dart';

class ButtonConst extends StatelessWidget {
  final String title;
  final Color titleColor;
  final double? size;
  final FontWeight? fontWeight;
  final Color color;
  final VoidCallback onTap;
  final double? width;
  final double height;
  final double borderRadius;
  final bool loading;
  final dynamic margin;

  const ButtonConst({
    super.key,
    required this.title,
    this.titleColor = Colors.white,
    this.color = Colors.blueAccent,
    required this.onTap,
    this.width,
    this.height = 45,
    this.borderRadius = 12,
    this.loading = false,
    this.margin,
    this.size,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: height,
        width: width ?? Sizes.screenWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: !loading
            ? TextConst(title,
                size: size ?? Sizes.fontSizeFive,
                fontWeight: fontWeight ?? FontWeight.w400,
                color: titleColor)
            : const CircularProgressIndicator(),
      ),
    );
  }
}

class ProfileBtnConst extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Color color;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double borderRadius;
  final bool loading;
  final double? fontSize;

  const ProfileBtnConst(
      {super.key,
      required this.title,
      this.titleColor = Colors.white,
      this.color = Colors.blueAccent,
      required this.onTap,
      this.width = 400,
      this.height = 45,
      this.borderRadius = 40,
      this.loading = false,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: !loading
            ? TextConst(title,
                size: fontSize ?? Sizes.fontSizeFour,
                fontWeight: FontWeight.w500,
                color: titleColor)
            : const CircularProgressIndicator(),
      ),
    );
  }
}


