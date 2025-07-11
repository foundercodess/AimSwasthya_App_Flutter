// patient_section/view/p_bottom_nav/bottom_nev_bar.dart
import 'dart:ui';
import 'package:aim_swasthya/common/view_model/notification_view_model.dart';
import 'package:aim_swasthya/generated/assets.dart';
import 'package:aim_swasthya/patient_section/view/p_drawer/drawer_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_home/user_home_screen.dart';
import 'package:aim_swasthya/res/color_const.dart';
import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/res/size_const.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/patient_section/view/p_drawer/med_reports/medical_reports_screen.dart';
import 'package:aim_swasthya/patient_section/view/symptoms/dowenloade_image.dart';
import 'package:aim_swasthya/patient_section/p_view_model/bottom_nav_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_home_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_role_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/wellness_library_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../common/view_model/network_check.dart';
import '../../p_view_model/patient_profile_view_model.dart';
import '../../p_view_model/voice_search_view_model.dart';
import '../../p_view_model/user_role_view_model.dart';

class BottomNevBar extends StatefulWidget {
  const BottomNevBar({super.key});

  @override
  State<BottomNevBar> createState() => _BottomNevBarState();
}

class _BottomNevBarState extends State<BottomNevBar> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    scaffoldKey.currentWidget;
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _checkConnection();
    });
    super.initState();
  }

  void _checkConnection() async {
    final isInternetConnected = await NetworkChecker.hasInternetConnection();
    setState(() {});
    if (!isInternetConnected) {
      return;
    }
    final makeApiCall = ModalRoute.of(context)?.settings.arguments;
    if (makeApiCall == true) {
      Provider.of<PatientHomeViewModel>(context, listen: false)
          .getLocationApi(context);
      Provider.of<WellnessLibraryViewModel>(context, listen: false)
          .getPatientWellnessApi(context);
      await LocalImageHelper.instance.loadImages();
      Provider.of<UserPatientProfileViewModel>(context, listen: false)
          .userPatientProfileApi(context);
      Provider.of<NotificationViewModel>(context, listen: false)
          .fetchNotifications(
        type: 'patient',
      );
    }
    Provider.of<VoiceSymptomSearchViewModel>(context, listen: false)
        .clearValues();
  }

  @override
  Widget build(BuildContext context) {
    final makeApiCall = ModalRoute.of(context)?.settings.arguments as bool;
    List page = [
      UserHomeScreen(
        scaffoldKey: scaffoldKey, invokeAllAPi: makeApiCall,
      ),
      const MedicalReportsScreen(),
    ];
    final bottomCon = Provider.of<BottomNavProvider>(context);
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
        drawer: const DrawerScreen(),
        extendBody: true,
        body: page[bottomCon.currentIndex],
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
                color: const Color(0xffB6E5FF).withOpacity(0.82),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.doctorSpeakerScreen);
                },
                icon: Image(
                  image: const AssetImage(Assets.iconsMapUser),
                  height: Sizes.screenHeight * 0.055,
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
              padding: const EdgeInsets.symmetric(horizontal: 40),
              shape: const CircularNotchedRectangle(),
              color: const Color(0xffF0F0F0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      // regCon.disposeKey();
                      bottomCon.setIndex(0);
                    },
                    icon: const Image(
                      image: AssetImage(Assets.iconsBottomHome),
                      height: 22,
                      color: AppColor.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // regCon.disposeKey();
                      bottomCon.setIndex(1);
                    },
                    icon: const Image(
                      image: AssetImage(Assets.iconsUserBottomImg),
                      height: 22,
                      color: AppColor.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
