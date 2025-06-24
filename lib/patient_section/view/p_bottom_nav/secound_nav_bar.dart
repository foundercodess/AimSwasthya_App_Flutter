// patient_section/view/p_bottom_nav/secound_nav_bar.dart
import 'package:aim_swasthya/generated/assets.dart';
import 'package:aim_swasthya/res/color_const.dart';
import 'package:aim_swasthya/res/size_const.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/patient_section/view/p_bottom_nav/bottom_nev_bar.dart';
import 'package:aim_swasthya/patient_section/p_view_model/bottom_nav_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_role_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommenBottomNevBar extends StatefulWidget {
  const CommenBottomNevBar({super.key});

  @override
  State<CommenBottomNevBar> createState() => _CommenBottomNevBarState();
}

class _CommenBottomNevBarState extends State<CommenBottomNevBar> {
  @override
  Widget build(BuildContext context) {
    final regCon = Provider.of<UserRoleViewModel>(context);
    final bottomCon = Provider.of<BottomNavProvider>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 72,
        width: 72,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xffB6E5FF).withOpacity(0.82)),
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
                    // regCon.disposeKey();
                    bottomCon.setIndex(0);
                     Navigator.pushNamedAndRemoveUntil(context, RoutesName.bottomNavBar, (context)=> false,arguments: false);
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const BottomNevBar()),
                          (Route<dynamic> route) => false,
                    );
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
    );
  }
}
