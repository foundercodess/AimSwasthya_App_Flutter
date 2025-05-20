// view/doctor/common_nav_bar.dart
import 'dart:ui';

import 'package:aim_swasthya/generated/assets.dart';
import 'package:aim_swasthya/res/color_const.dart';
import 'package:aim_swasthya/res/size_const.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view/doctor/bottom_nav_bar_screen.dart';
import 'package:aim_swasthya/view/user/bottom_nev_bar.dart';
import 'package:aim_swasthya/view_model/user/bottom_nav_view_model.dart';
import 'package:aim_swasthya/view_model/user/userRegisterCon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocComBottomNevBar extends StatefulWidget {
  const DocComBottomNevBar({super.key});

  @override
  State<DocComBottomNevBar> createState() => _DocComBottomNevBarState();
}
class _DocComBottomNevBarState extends State<DocComBottomNevBar> {
  @override
  Widget build(BuildContext context) {
    final regCon = Provider.of<UserRegisterViewModel>(context);
    final bottomCon = Provider.of<BottomNavProvider>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 1.5,
            sigmaY: 1.5,
          ),
          child: Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffB6E5FF).withOpacity(0.6),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.doctorBottomNevBar);
              },
              icon:  Image(image: const AssetImage(Assets.iconsBottomHome),width: Sizes.screenWidth*0.09,),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomAppBar(
          elevation: 20,
          shadowColor: AppColor.black,
          height: 60,
          padding: const EdgeInsets.only(left: 40, right: 40),
          shape: const CircularNotchedRectangle(),
          color: const Color(0xffF0F0F0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  regCon.disposeKey();
                  bottomCon.setIndex(1);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const DoctorBottomNevBar()),
                        (Route<dynamic> route) => false,
                  );

                },
                icon: Image.asset(
                  Assets.iconsBottomProfile,
                  height: 22,
                  color:  AppColor.blue,
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                onPressed: () {
                  regCon.disposeKey();
                  bottomCon.setIndex(2);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const DoctorBottomNevBar()),
                        (Route<dynamic> route) => false,
                  );
                },
                icon: Image.asset(
                  Assets.iconsCalendar,
                  height: 30,
                  color:  AppColor.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
