import 'dart:io';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view/user/symptoms/dowenloade_image.dart';
import 'package:aim_swasthya/view_model/user/doctor_specialisation_view_model.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SpecialiasationScreen extends StatefulWidget {
  const SpecialiasationScreen({super.key});
  @override
  State<SpecialiasationScreen> createState() => _SpecialiasationScreenState();
}

class _SpecialiasationScreenState extends State<SpecialiasationScreen> {
  @override
  Widget build(BuildContext context) {
    final homeCon = Provider.of<PatientHomeViewModel>(context);
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.screenWidth * 0.04,
            vertical: Sizes.screenHeight * 0.02),
        width: Sizes.screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.blue, AppColor.naviBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Sizes.spaceHeight15,
            TextConst(
              "Choose a specialisation",
              size: Sizes.fontSizeFivePFive,
              fontWeight: FontWeight.w500,
              color: AppColor.white,
            ),
            Sizes.spaceHeight20,
            homeCon.patientHomeModel!.data!.specializations!.isNotEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 3 columns
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: homeCon.patientHomeModel!.data!.specializations!.length > 6
                        ? 6
                        : homeCon.patientHomeModel!.data!.specializations!.length,
                    itemBuilder: (context, index) {
                      final item = homeCon.patientHomeModel!.data!.specializations![index];
                      String? imagePath = LocalImageHelper.instance
                          .getImagePath(item.specializationName ?? "");
                      int rowIndex = index ~/ 3;
                      bool isFirstRow = rowIndex == 0;
                      bool isSecondRow = rowIndex == 1;
                      return GestureDetector(
                        onTap: () {
                          // if(homeCon.noServicesArea){return;}
                          Provider.of<DoctorSpecialisationViewModel>(context,
                                  listen: false)
                              .setSpeciality(item, context);
                          Navigator.pushNamed(context, RoutesName.allSpecialistScreen);

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(Assets.imagesBoxImage),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(13),
                            border: Border(
                              bottom: isFirstRow
                                  ? BorderSide(
                                      color: const Color(0xff92C8D6)
                                          .withOpacity(0.3),
                                      width: 2,
                                    )
                                  : BorderSide.none,
                              top: isSecondRow
                                  ? BorderSide(
                                      color: const Color(0xff92C8D6)
                                          .withOpacity(0.4),
                                      width: 2,
                                    )
                                  : BorderSide.none,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (imagePath != null)
                                Image.file(
                                  File(imagePath),
                                  height: Sizes.screenHeight * 0.04,
                                  width: Sizes.screenWidth * 0.1,
                                  fit: BoxFit.cover,
                                  color: AppColor.lightBlue,
                                )
                              else
                                Icon(
                                  Icons.image,
                                  size: Sizes.screenHeight * 0.05,
                                  color: AppColor.lightBlue,
                                ),
                              Sizes.spaceHeight3,
                              TextConst(
                                item.specializationName ?? "",
                                textAlign: TextAlign.center,
                                size: Sizes.fontSizeFour * 1.1,
                                fontWeight: FontWeight.w400,
                                color: AppColor.white,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
            Sizes.spaceHeight25,
            Center(
              child: GestureDetector(
                onTap: () {
                  // if(homeCon.noServicesArea){return;}
                  Navigator.pushNamed(context, RoutesName.searchDoctorScreen,
                      arguments: "Specialist");
                },
                child: TextConst(
                  AppLocalizations.of(context)!.view_more,
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                  color: AppColor.white,
                ),
              ),
            ),
            Sizes.spaceHeight5,
          ],
        ));
  }
}
