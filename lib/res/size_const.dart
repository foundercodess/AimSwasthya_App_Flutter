import 'package:flutter/cupertino.dart';

class Sizes {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
  }

  static double get fontSizeZero => screenWidth < 500 ? screenWidth / 80 : screenWidth / 90;
  static double get fontSizeOne => screenWidth < 500 ? screenWidth / 60 : screenWidth / 70;
  static double get fontSizeTwo => screenWidth < 500 ? screenWidth / 50 : screenWidth / 60;
  static double get fontSizeThree => screenWidth < 500 ? screenWidth / 40 : screenWidth / 58;
  static double get fontSizeFour => screenWidth < 500 ? screenWidth / 35 : screenWidth / 50;
  static double get fontSizeFourPFive => screenWidth < 500 ? screenWidth / 29 : screenWidth / 45;
  static double get fontSizeFive => screenWidth < 500 ? screenWidth / 28 : screenWidth / 38;
  static double get fontSizeFivePFive => screenWidth < 500 ? screenWidth / 27.4 : screenWidth / 37.5;
  static double get fontSizeSix => screenWidth < 500 ? screenWidth / 23 : screenWidth / 33;
  static double get fontSizeSeven => screenWidth < 500 ? screenWidth / 20 : screenWidth / 30;
  static double get fontSizeEight => screenWidth < 500 ? screenWidth / 18 : screenWidth / 28;
  static double get fontSizeNine => screenWidth < 500 ? screenWidth / 16 : screenWidth / 26;
  static double get fontSizeTen => screenWidth < 500 ? screenWidth / 14 : screenWidth / 24;


  static const spaceWidth3 = SizedBox(width: 3);
  static const spaceWidth5 = SizedBox(width: 5);
  static const spaceWidth10 = SizedBox(width: 10);
  static const spaceWidth15 = SizedBox(width: 15);
  static const spaceWidth20 = SizedBox(width: 20);
  static const spaceWidth25 = SizedBox(width: 25);

  static const spaceHeight3 = SizedBox(height: 3);
  static const spaceHeight5 = SizedBox(height: 5);
  static const spaceHeight10 = SizedBox(height: 10);
  static const spaceHeight15 = SizedBox(height: 15);
  static const spaceHeight20 = SizedBox(height: 20);
  static const spaceHeight25 = SizedBox(height: 25);
  static const spaceHeight30 = SizedBox(height: 30);
  static const spaceHeight35 = SizedBox(height: 35);
}
