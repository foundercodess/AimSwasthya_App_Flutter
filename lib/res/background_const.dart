import 'package:flutter/material.dart';
import 'common_material.dart';

class BackGroundPage extends StatelessWidget {
  final List<Widget> children;
  const BackGroundPage({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Sizes.screenHeight,
          width: Sizes.screenWidth,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: Sizes.screenHeight * 0.11),
              Image(
                image:  const AssetImage(
                  Assets.logoAppLogo,
                ),
                height: Sizes.screenHeight*0.22,
                width: Sizes.screenWidth * 0.7,
              ),
              Expanded(
                child: Container(
                  width: Sizes.screenWidth,
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.screenWidth * 0.08,
                      vertical: Sizes.screenHeight * 0.02),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2), // Soft border effect
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        tileMode: TileMode.mirror,
                        colors: [
                          Color(0xff004AAD),
                          Color(0xff38B6FF),
                        ],
                      )),
                  // decoration: BoxDecoration(
                  //   borderRadius: const BorderRadius.only(
                  //     topLeft: Radius.circular(25),
                  //     topRight: Radius.circular(25),
                  //   ),
                  //   gradient: AppColor().primaryGradient(
                  //     colors: [AppColor.blue, AppColor.lightBlue],
                  //   ),
                  // ),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center ?? MainAxisAlignment.start,
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
