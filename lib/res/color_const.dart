import 'package:flutter/material.dart';

class AppColor {
  static const white = Color(0xFFffffff);
  static const blue = Color(0xFF004AAD);
  static const lightBlue = Color(0xFF38B6FF);
  static const naviBlue = Color(0xFF001E47);
  static const gray = Color(0xFF004AAD);
  static const primaryGray = Color(0xFFBFBFBF);
  static const primaryBlue = Color(0xFF4C97FB);
  static const black = Color(0xFF000000);
  static const lightGray = Color(0xFF00000040);
  static const loginButtonBlueColor = Color(0xff1a7dd3);
  static const textfieldGrayColor = Color(0xffD9D9D9);
  static const textGrayColor = Color(0xff9D9D9D);
  static const textfieldTextColor = Color(0xff595959);
  static const whiteColor = Color(0xffF8F8F8);
  static const blackColor = Color(0xff4F4F4F);
  static const lightBlack = Color(0xff7F7F7F);
  static const lightSkyBlue = Color(0xffa7cee5);
  static const lightWhiteBlue = Color(0xffF0F0F0);
  static const lightGreen = Color(0xff64DB3A);
  static const conLightBlue = Color(0xff80D0FF);
  static const darkBlack = Color(0xff0A2A5B);
  static const grey = Color(0xffF4F4F4);
  static const darkPurple = Color(0xff09003E);
  static const purple = Color(0xff03E008C);
  static const btnPurpleColor = Color(0xff4D00D9);
  static const lightPurpleColor = Color(0xff9747FF);
  static const docProfileColor = Color(0xffE1E1E1);
  static const textFieldBtnColor = Color(0xff353535);
  static const primeryPurple = Color(0xff050022);





  // static const primaryBlueGradient = LinearGradient(
  //   colors: [blue, lightBlue,],
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  // );
   LinearGradient primaryGradient({List<Color>? colors}){
    return LinearGradient(
      colors:colors?? [blue, lightBlue,],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  static const primaryBlueRadGradient = RadialGradient(
    colors: [ blue,lightBlue,],
    center: Alignment.centerRight,
    radius: 1.2,
  );

  // static const darkBlueGradient = LinearGradient(
  //   colors: [naviBlue, darkBlue,],
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  // );
}
