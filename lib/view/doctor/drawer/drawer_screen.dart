import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view_model/user/bottom_nav_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/doctor/doc_home_view_model.dart';

class DoctorDrawerScreen extends StatefulWidget {
  const DoctorDrawerScreen({
    super.key,
  });

  @override
  State<DoctorDrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DoctorDrawerScreen> {
  @override
  Widget build(BuildContext context) {
    final bottomCon = Provider.of<BottomNavProvider>(context);
    final docHomeCon = Provider.of<DoctorHomeViewModel>(context);

    return Drawer(
      backgroundColor: Colors.transparent,
      shadowColor: AppColor.blackColor,
      elevation: 15,
      width: Sizes.screenWidth * 0.6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          gradient: AppColor().primaryGradient(
            colors: [AppColor.naviBlue, AppColor.blue],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Sizes.screenHeight * 0.06),
            if(docHomeCon.doctorHomeModel !=null && docHomeCon.doctorHomeModel!.data !=null)
            ListTile(
              contentPadding: EdgeInsets.only(left: Sizes.screenWidth * .036),
              leading: const Image(
                image: AssetImage(Assets.iconsProfileIcon),
                // width: Sizes.screenWidth * 0.07,
                height: 22,
                width: 22,
              ),
              title: TextConst(
                docHomeCon.doctorHomeModel!.data!.doctors![0].doctorName??"",
                // size: 13,
                size: Sizes.fontSizeSix,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
            Sizes.spaceHeight10,
            ListTile(
              contentPadding: EdgeInsets.only(left: Sizes.screenWidth * .036),
              leading: const Image(
                image: AssetImage(Assets.iconsProfileIcon),
                color: AppColor.white,
                // width: Sizes.screenWidth * 0.07,
                height: 22,
                width: 22,
              ),
              title: TextConst(
                ' Profile',
                size: Sizes.fontSizeFive,
                fontWeight: FontWeight.w500,
                color: AppColor.white,
              ),
              onTap: () {
                Navigator.pushNamed(context, RoutesName.userDocProfilePage,
                    arguments: {'isNew': true});
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: Sizes.screenWidth * .036),
              leading: const Image(
                image: AssetImage(Assets.iconsBottomProfile),
                height: 22,
                width: 24,
                // height: Sizes.screenHeight * 0.024,
                color: AppColor.white,
              ),
              title: TextConst(
                ' Patient',
                size: Sizes.fontSizeFive,
                fontWeight: FontWeight.w500,
                color: AppColor.white,
              ),
              onTap: () {
                Navigator.pop(context);
                bottomCon.setIndex(1);
                // Navigator.pushNamed(context, RoutesName.showAllPatient);
                // Navigator.pushNamed(context, RoutesName.showAllPatient);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: Sizes.screenWidth * .036),
              leading: const Image(
                image: AssetImage(Assets.iconsCalendar),
                height: 26,
                width: 28,
                // height: Sizes.screenHeight * 0.025,
                color: AppColor.white,
              ),
              title: TextConst(
                'Schedule',
                size: Sizes.fontSizeFive,
                fontWeight: FontWeight.w500,
                color: AppColor.white,
              ),
              onTap: () {
                Navigator.pushNamed(context, RoutesName.clinicLocationScreen);

                // Navigator.pushNamed(context, RoutesName.scheduleScreen);
                // Navigator.pop(context);
                // bottomCon.setIndex(1);
              },
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                  bottom: Sizes.screenHeight * 0.1,
                  left: Sizes.screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: TextConst(
                      "About Us",
                      size: Sizes.fontSizeFivePFive,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                  ),
                  Sizes.spaceHeight10,
                  GestureDetector(
                    onTap: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return ActionOverlay(
                            );
                          });
                    },
                    child: TextConst(
                      "Log Out",
                      // size: 14,
                      size: Sizes.fontSizeFivePFive,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
