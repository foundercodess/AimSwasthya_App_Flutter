// doctor_section/view/bottom_nav_bar_screen.dart
import 'dart:ui';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/doctor_section/view/dashboard_page.dart';
import 'package:aim_swasthya/doctor_section/view/drawer/drawer_screen.dart';
import 'package:aim_swasthya/doctor_section/view/patients/my_appointments.dart';
import 'package:aim_swasthya/doctor_section/view/patients/show_all_patient.dart';
import 'package:aim_swasthya/patient_section/p_view_model/bottom_nav_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_role_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DoctorBottomNevBar extends StatefulWidget {
  const DoctorBottomNevBar({super.key});

  @override
  State<DoctorBottomNevBar> createState() => _DoctorBottomNevBarState();
}

class _DoctorBottomNevBarState extends State<DoctorBottomNevBar> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      DoctorDashboardScreen(
        scaffoldKey: scaffoldKey,
      ),
      const ShowAllPatient(),
      const MyAppointmentsScreen(),
    ];
    final regCon = Provider.of<UserRoleViewModel>(context);
    final bottomCon = Provider.of<BottomNavProvider>(context);
    print("current index f bottom: ${bottomCon.currentIndex}");
    return WillPopScope(
      onWillPop: () async {
        if (bottomCon.currentIndex != 0) {
          bottomCon.setIndex(0);
          return false;
        }
        bool shouldExit = await showCupertinoDialog(
            context: context,
            builder: (context) {
              return ActionOverlay(
                text: "Exit App",
                subtext: "Do you really want to close the app?",
                onTap: () {
                  SystemNavigator.pop();
                },
              );
            });
        return shouldExit;
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: const DoctorDrawerScreen(),
        extendBody: true,
        body: pages[bottomCon.currentIndex],
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
                  regCon.disposeKey();
                  bottomCon.setIndex(0);
                },
                icon: Image(
                  image: const AssetImage(Assets.iconsBottomHome),
                  width: Sizes.screenWidth * 0.09,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          bottom: true,
          child: Container(
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
                    },
                    icon: Image.asset(
                      Assets.iconsBottomProfile,
                      height: 22,
                      color: AppColor.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      regCon.disposeKey();
                      bottomCon.setIndex(2);
                    },
                    icon: Image.asset(
                      Assets.iconsCalendar,
                      height: 30,
                      color: AppColor.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
