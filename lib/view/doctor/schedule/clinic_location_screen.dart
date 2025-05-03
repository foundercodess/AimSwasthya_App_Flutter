import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view_model/doctor/doc_reg_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doctor_profile_view_model.dart';
import 'package:aim_swasthya/view_model/user/bottom_nav_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicLocationScreen extends StatefulWidget {
  const ClinicLocationScreen({super.key});

  @override
  State<ClinicLocationScreen> createState() => _ClinicLocationScreenState();
}

class _ClinicLocationScreenState extends State<ClinicLocationScreen> {
  @override
  Widget build(BuildContext context) {
    final bottomCon = Provider.of<BottomNavProvider>(context);
    final registerCon = Provider.of<RegisterViewModel>(context);
    final profileCon = Provider.of<DoctorProfileViewModel>(context);
    final clinics = profileCon.doctorProfileModel!.data!.clinics!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.white,
      appBar: appBarConstant(context, isBottomAllowed: true, onTap: () {
        if (bottomCon.currentIndex == 1) {
          bottomCon.setIndex(0);
        } else {
          Navigator.pop(context);
        }
      }, child: Container(
            height: Sizes.screenHeight * 0.013,
            width: Sizes.screenWidth * 0.4,
            decoration: BoxDecoration(
              color: AppColor.textfieldGrayColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Sizes.screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: registerCon.isPersonalInfoSelected
                        ? AppColor.lightBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  width: Sizes.screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: !registerCon.isPersonalInfoSelected
                        ? AppColor.lightBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Sizes.spaceHeight35,
            Center(
              child: TextConst(
                "Choose a location",
                size: Sizes.fontSizeSix * 1.07,
                fontWeight: FontWeight.w500,
              ),
            ),
            Center(
              child: TextConst(
                "Select a clinic/hospital to create a schedule",
                size: Sizes.fontSizeFour,
                fontWeight: FontWeight.w400,
                color: AppColor.textfieldTextColor.withOpacity(0.7),
              ),
            ),
            Sizes.spaceHeight20,
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  height: Sizes.screenHeight,
                  width: Sizes.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: clinics.map((clinic) {
                      return GestureDetector(
                        onTap: (){
                          print("anshiak${clinic.clinicId}");
                          Navigator.pushNamed(context, RoutesName.scheduleScreen,arguments: clinic.clinicId, );
                        },
                        child: Container(
                          width: Sizes.screenWidth * 0.42,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade100,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextConst(
                                clinic.name ?? "",
                                size: Sizes.fontSizeFour,
                                color: Colors.grey,
                                textAlign: TextAlign.center,
                              ),
                              Sizes.spaceHeight3,
                              Image.asset(
                                Assets.logoClinicImage,
                                height: Sizes.screenHeight * 0.1,
                              ),
                              Sizes.spaceHeight3,
                              TextConst(
                                "${clinic.address}, ${clinic.city}",
                                size: Sizes.fontSizeFour * 1.1,
                                color: Colors.grey,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Sizes.spaceHeight10,
            // const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                  left: Sizes.screenWidth * 0.1,
                  right: Sizes.screenWidth * 0.1,
                  bottom: Sizes.screenHeight * 0.04),
              child: AppBtn(
                  height: Sizes.screenHeight * 0.06,
                  width: Sizes.screenWidth,
                  color: AppColor.blue,
                  borderRadius: 18,
                  fontWidth: FontWeight.w400,
                  title: "Continue",
                  onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBarConstant(BuildContext context,
      {Widget? child,
      bool isBottomAllowed = false,
      String? label,
      void Function()? onTap}) {
    return AppBar(
        backgroundColor: AppColor.white,
        leading: GestureDetector(
            onTap: onTap ??
                () {
                  Navigator.pop(context);
                },
            child: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Image(image: AssetImage(Assets.iconsBackBtn)),
            )),
        bottom: isBottomAllowed
            ? PreferredSize(
                preferredSize: const Size.fromHeight(10),
                child: child ?? TextConst(label ?? ""),
              )
            : null);
  }
}
