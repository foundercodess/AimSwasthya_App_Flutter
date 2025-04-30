import 'package:flutter/material.dart';
import 'common_material.dart';

class AppBtn extends StatelessWidget {
  final String title;
  final Color titleColor;
  final dynamic fontWidth;
  final Color? color;
  final VoidCallback onTap;
  final double? width;
  final double height;
  final double borderRadius;
  final bool loading;
  final List<Color>? borderGradient;
  final bool? isShadowEnable;
  final dynamic padding;
  final double? fontSize;

  const AppBtn({
    super.key,
    required this.title,
    this.titleColor = Colors.white,
    this.color,
    required this.onTap,
    this.width,
    this.height = 58,
    this.borderRadius = 14,
    this.loading = false,
    this.borderGradient,
    this.isShadowEnable = false,
    this.padding,
    this.fontWidth,
    this.fontSize
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width ?? Sizes.screenWidth / 1.2,
        padding: padding ?? const EdgeInsets.all(1.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: isShadowEnable!
              ? [
                  BoxShadow(
                      color: Colors.black12.withAlpha(50),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                      spreadRadius: 1,
                      blurStyle: BlurStyle.inner),
                ]
              : [],
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            colors: borderGradient ?? [AppColor.primaryBlue, AppColor.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color ?? AppColor.loginButtonBlueColor,
            borderRadius: BorderRadius.circular(borderRadius - 1),
          ),
          alignment: Alignment.center,
          child: !loading
              ? TextConst(
                  title,
                  size:fontSize?? Sizes.fontSizeFourPFive,
                  fontWeight: fontWidth??FontWeight.w400,
                  color: titleColor,
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  final dynamic title;
  final double width;
  final VoidCallback? onTap;
  final double height;
  final dynamic  color;
  final double? fontSize;


  const AddButton(
      {super.key, this.title, required this.width, required this.height, this.color, this.fontSize,  this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [AppColor.lightBlue, AppColor.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                height: height,
                width: height,
                padding: const EdgeInsets.only(right: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [AppColor.lightBlue, AppColor.blue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Container(
                  padding:  const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColor.lightBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.white, width: 3)),
                      child: Icon(
                        size: width / 10,
                        Icons.favorite_border,
                        color: Colors.red,
                        weight: 0.3,
                      )),
                ),
              ),
              TextConst(
                padding: const EdgeInsets.only(left: 2,right: 2),
                title,
                size:fontSize?? Sizes.fontSizeOne,
                fontWeight: FontWeight.w300,

              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FevButton extends StatelessWidget {
  final dynamic title;
  final double width;
  final VoidCallback? onTap;
  final double height;
  final dynamic  color;
  final double? fontSize;


  const FevButton(
      {super.key, this.title, required this.width, required this.height, this.color, this.fontSize,  this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [AppColor.lightBlue, AppColor.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Center(
                child: TextConst(
                  textAlign: TextAlign.center,
                  padding: const EdgeInsets.only(left: 2,right: 2),
                  title,
                  size:fontSize?? Sizes.fontSizeOne,
                  fontWeight: FontWeight.w300,

                ),
              ),
              Spacer(),
              Container(
                height: height,
                // width: height,
                padding: const EdgeInsets.only(right: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [AppColor.lightBlue, AppColor.blue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Container(
                  padding:  const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.white, width: 3)),
                      child: Icon(
                        size: width / 10,
                        Icons.favorite_border,
                        color: AppColor.black,
                        weight: 0.3,
                      )),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
