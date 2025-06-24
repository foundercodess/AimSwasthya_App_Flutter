// utils/no_data_found.dart
import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/material.dart';

// class NoDataFound extends StatelessWidget {
//   const NoDataFound({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 100,
//           width: 100,
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage(Assets.imagesNoDoctorFound))),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         TextConst(
//           "No Data found",
//           size: Sizes.fontSizeFour,
//           fontWeight: FontWeight.w400,
//           color: Colors.grey,
//         )
//       ],
//     );
//   }
// }

class NoDataFound extends StatelessWidget {
  final String? message;
  const NoDataFound({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: Sizes.screenWidth / 2.2,
      width: Sizes.screenWidth / 2,
      decoration: const BoxDecoration(
          image:
              DecorationImage(image: AssetImage('assets/no_data_found.png'))),
      child: TextConst(
        message ?? "No data found",
        color: Colors.grey,
        size: Sizes.fontSizeFourPFive,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class NoDataMessages extends StatelessWidget {
  final String? message;
  final String? title;
  final double? height;
  final dynamic image;
  final bool? isSubTitleAllowed;
  const NoDataMessages(
      {super.key, this.message, this.title, this.height, this.image, this.isSubTitleAllowed=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.04,
          vertical: Sizes.screenHeight * 0.05),
      height: height ?? Sizes.screenHeight * 0.35,
      width: Sizes.screenWidth * 0.87,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffF5F5F5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image ??
              Image.asset("assets/info.png",
                  height: Sizes.screenHeight * 0.03,
                  width: Sizes.screenHeight * 0.03),
          Sizes.spaceHeight5,
          Sizes.spaceHeight3,
          TextConst(
            message ?? "No Appointment yet",
            size: Sizes.fontSizeFive,
            textAlign: TextAlign.center,
            // size: 14,
            fontWeight: FontWeight.w500,
          ),
          Sizes.spaceHeight5,
          // Sizes.spaceHeight3,
          if(isSubTitleAllowed!)
          SizedBox(
            width: Sizes.screenWidth * 0.6,
            child: Center(
              child: TextConst(
                textAlign: TextAlign.center,
                title ??
                    "Your health journey starts here, book your first consult now!",
                // size: 10,
                size: Sizes.fontSizeFour,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoMessage extends StatelessWidget {
  final String? message;
  final Color? color;
  final String? title;
  final Color? titleColor;
  final Color? imageColor;

  const NoMessage({
    super.key,
    this.message,
    this.title,
    this.color,
    this.titleColor,
    this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Sizes.spaceHeight20,
        Image.asset(
          "assets/groupInfo.png",
          height: Sizes.screenHeight * 0.08,
          width: Sizes.screenHeight * 0.08,
          color: imageColor ?? AppColor.lightBlue,
        ),
        Sizes.spaceHeight15,
        TextConst(
          message ?? "No Appointment yet",
          size: Sizes.fontSizeSix,
          // size: 14,
          fontWeight: FontWeight.w500,
          color: color ?? AppColor.black,
        ),
        Sizes.spaceHeight5,
        SizedBox(
          // width: Sizes.screenWidth * 0.,
          child: Center(
            child: TextConst(
              textAlign: TextAlign.center,
              title ??
                  "your health journey start hear,book your first consult now!",
              // size: 10,
              size: Sizes.fontSizeFour,
              fontWeight: FontWeight.w400,
              color: titleColor ?? AppColor.black,
            ),
          ),
        ),
        Sizes.spaceHeight20,
      ],
    );
  }
}
