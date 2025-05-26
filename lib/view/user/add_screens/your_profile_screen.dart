import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:flutter/material.dart';
import '../../../res/common_material.dart';

class YourProfileScreen extends StatefulWidget {
  const YourProfileScreen({super.key});

  @override
  State<YourProfileScreen> createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      primary: false,
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          appBarConstant(
            context,
            isBottomAllowed: true,
            child: Center(
              child: TextConst(
                "Your profile",
                size: Sizes.fontSizeSix * 1.1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Sizes.spaceHeight25,
          addMemberSec(),
          Sizes.spaceHeight25,
          Container(
            height: Sizes.screenHeight*0.03,
            width: Sizes.screenWidth*0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
                color: Color(0xffDFEDFF)
            ),
          )

        ],
      ),
    );
  }

  Widget addMemberSec() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.04),
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.04,
          vertical: Sizes.screenHeight * 0.02),
      // height: Sizes.screenHeight * 0.4,
      width: Sizes.screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Color(0xffDFEDFF)),
      child: Column(
        children: [
          // Sizes.spaceHeight15,
          Image.asset(
            Assets.logoAppLogo,
            height: Sizes.screenHeight * 0.03,
          ),
          Sizes.spaceHeight15,
          TextConst(
            "Add family members",
            size: Sizes.fontSizeFourPFive,
            fontWeight: FontWeight.w600,
          ),
          Sizes.spaceHeight10,
          Center(
            child: TextConst(
              textAlign: TextAlign.center,
              "Get personalized doctor recommendations for\n upto 4 family members",
              size: Sizes.fontSizeFour,
              fontWeight: FontWeight.w400,
            ),
          ),
          Sizes.spaceHeight10,
          ButtonConst(
            title: "Add members",
            onTap: () {},
            width: Sizes.screenWidth * 0.45,
            height: Sizes.screenHeight * 0.037,
            color: AppColor.blue,
          )

          // Image.asset(
          //   Assets.logoProfileImg,
          //   height: Sizes.screenHeight * 0.07,
          // )
        ],
      ),
    );
  }
}
