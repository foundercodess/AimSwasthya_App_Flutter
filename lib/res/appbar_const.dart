import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/material.dart';

Widget appBarConstant(BuildContext context,
    {Widget? child, void Function()? onTap,
    bool isBottomAllowed = false,
    String? label,
    bool paddingAllowed = true}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16),
      GestureDetector(
        onTap: onTap??() {
          Navigator.pop(context);
        },
        child: Padding(
          padding: paddingAllowed
              ? EdgeInsets.only(
                  left: Sizes.screenWidth * 0.047,
                  top: Sizes.screenHeight * 0.03)
              : const EdgeInsets.all(0),
          child: const Image(image: AssetImage(Assets.iconsBackBtn)),
        ),
      ),
      if (isBottomAllowed)
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: child ?? TextConst(label ?? ""),
        ),
    ],
  );
}

// PreferredSizeWidget appBarConstant(BuildContext context,
//     {Widget? child, bool isBottomAllowed = false, String? label}) {
//   return AppBar(
//       backgroundColor: AppColor.white,
//       leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Padding(
//             padding: EdgeInsets.only(left: 12),
//             child: Image(image: AssetImage(Assets.iconsBackBtn)),
//           )),
//       bottom: isBottomAllowed
//           ? PreferredSize(
//               preferredSize: const Size.fromHeight(10),
//               child: child ?? TextConst(label ?? ""),
//             )
//           : null);
// }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final Color backgroundColor;

  const CustomAppBar({
    required this.title,
    this.leading,
    this.backgroundColor = AppColor.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: leading ??
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppbarConst extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? titleColor;
  final Color? iconColor;
  final double? size;
 final FontWeight? fontWeight;
  final void Function()? onPressed;
  const AppbarConst({
    super.key,
    required this.title, this.onPressed, this.color, this.titleColor, this.iconColor, this.size,this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18),
      height: Sizes.screenHeight * 0.12,
      width: Sizes.screenWidth,
      decoration: BoxDecoration(color:color?? AppColor.white),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 0),
        child: Row(
          children: [
            IconButton(
              onPressed:onPressed?? () {
                Navigator.of(context).pop();
              },
              icon:  Icon(
                Icons.arrow_back,
                color:iconColor?? AppColor.black,
                size: 25,
              ),
            ),
            TextConst(
              title,
              size: Sizes.fontSizeFive,
              fontWeight: fontWeight?? FontWeight.w400,
              color:titleColor?? AppColor.blue,
            ),
          ],
        ),
      ),
    );
  }
}
