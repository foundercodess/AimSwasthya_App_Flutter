import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/size_const.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/view/user/secound_nav_bar.dart';
import 'package:flutter/material.dart';

import '../../../res/common_material.dart';

class UserNotificationScreen extends StatefulWidget {
  const UserNotificationScreen({super.key});

  @override
  State<UserNotificationScreen> createState() => _UserNotificationScreenState();
}

class _UserNotificationScreenState extends State<UserNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppbarConst(title: 'Notifications'),
          Sizes.spaceHeight25,
          SizedBox(
            child: SizedBox(
              height: Sizes.screenHeight*0.7,
              child: Center(
                child: NoDataMessages(height: Sizes.screenHeight*0.44,
                  image:
                Image.asset(Assets.iconsNotification,
                    height: Sizes.screenHeight * 0.03,
                    width: Sizes.screenHeight * 0.03),
                  // image: AssetImage(Assets.iconsNotification,),
                  message: "All quiet here",
                  title:
                  "You’ll receive updates here when\nsomething needs your attention",
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 90,
        width: Sizes.screenWidth,
        color: AppColor.white,
        child: const CommenBottomNevBar(),
      ),
    );
  }
}
