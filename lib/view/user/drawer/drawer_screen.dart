import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view_model/user/bottom_nav_view_model.dart';
import 'package:flutter/cupertino.dart'
    show CupertinoAlertDialog, CupertinoDialogAction, showCupertinoDialog;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../view_model/user/patient_home_view_model.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PatientHomeViewModel>(builder: (context, homeCon, _) {
      return Drawer(
        backgroundColor: Colors.transparent,
        shadowColor: AppColor.blackColor,
        elevation: 12,
        width: Sizes.screenWidth * 0.6,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            gradient: AppColor().primaryGradient(
              colors: [AppColor.naviBlue, AppColor.blue],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Sizes.screenHeight * 0.06),
              if(homeCon.patientHomeModel !=null && homeCon.patientHomeModel!.data !=null)
              ListTile(
                contentPadding: EdgeInsets.only(left: Sizes.screenWidth * .036),
                leading: const Image(
                  image: AssetImage(Assets.iconsProfileIcon),
                  width: 25,
                ),
                title: TextConst(
                  homeCon.patientHomeModel!.data!.patient!.patientName ?? "",
                  size: Sizes.fontSizeSix,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                ),
              ),
              Sizes.spaceHeight15,
              ListTile(
                contentPadding: EdgeInsets.only(left: Sizes.screenWidth * .04),
                leading: const Image(
                  image: AssetImage(Assets.iconsReports),
                  height: 20,
                ),
                title: TextConst(
                  AppLocalizations.of(context)!.appointments,
                  size: Sizes.fontSizeFive,
                  fontWeight: FontWeight.w500,
                  color: AppColor.white,
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, RoutesName.viewAppointmentsScreen);
                },
              ),
              Consumer<BottomNavProvider>(builder: (context, navCon, _) {
                return ListTile(
                  contentPadding:
                      EdgeInsets.only(left: Sizes.screenWidth * .03),
                  leading: const Image(
                    image: AssetImage(Assets.iconsAppointmens),
                    height: 20,
                  ),
                  title: TextConst(
                    AppLocalizations.of(context)!.medical_records,
                    size: Sizes.fontSizeFive,
                    fontWeight: FontWeight.w500,
                    color: AppColor.white,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    navCon.setIndex(1);
                  },
                );
              }),
              ListTile(
                contentPadding: EdgeInsets.only(left: Sizes.screenWidth * .04),
                leading: const Image(
                  image: AssetImage(Assets.iconsDoctorTools),
                  height: 20,
                ),
                title: TextConst(
                  AppLocalizations.of(context)!.my_doctors,
                  size: Sizes.fontSizeFive,
                  fontWeight: FontWeight.w500,
                  color: AppColor.white,
                ),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.myDoctorsScreen);
                },
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                    bottom: Sizes.screenHeight * 0.1,
                    left: Sizes.screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.userDeleteAccountScreen);
                        // Navigator.pushNamed(context, RoutesName.wellnesslibraryScreen);

                      },
                      child: TextConst(
                        "Delete Account",
                        size: Sizes.fontSizeFive,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                      ),
                    ),
                    Sizes.spaceHeight10,
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.aboutUsScreen);
                      },
                      child: TextConst(
                        AppLocalizations.of(context)!.about_Us,
                        size: Sizes.fontSizeFive,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                      ),
                    ),
                    Sizes.spaceHeight10,
                    GestureDetector(
                      onTap: () {
                        showCupertinoDialog(
                            barrierDismissible: false,
                            barrierLabel: "Register Prompt",
                            // barrierColor: Colors.black.withOpacity(0.4),

                            context: context,
                            builder: (context) {
                              return const ActionOverlay();
                            });
                      },
                      child: TextConst(
                        AppLocalizations.of(context)!.log_Out,
                        size: Sizes.fontSizeFive,
                        fontWeight: FontWeight.w600,
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
    });
  }
}
