import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/load_data.dart';
import '../../../utils/no_data_found.dart';
import '../../../view_model/user/voice_search_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../home/specialists_top_screen.dart';

class ShowDoctorsScreen extends StatefulWidget {
  const ShowDoctorsScreen({super.key});

  @override
  State<ShowDoctorsScreen> createState() => _ShowDoctorsScreenState();
}

class _ShowDoctorsScreenState extends State<ShowDoctorsScreen> {
  @override
  Widget build(BuildContext context) {
    final voiceSearchCon = Provider.of<VoiceSymptomSearchViewModel>(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      body:  voiceSearchCon.loading
          ? const Center(child: LoadData())
          : voiceSearchCon.aiSearchData == null|| voiceSearchCon.aiSearchData!.data ==[]
          ? Center(
          child: Container(
            color: AppColor.whiteColor,
            child: const NoMessage(
              message: "No specialists around here, for now...",
              title: "We’re working to bring expert care to your area",
            )
            // const ImageContainer(
            //   imagePath: 'assets/images/noDoctorFound.png',
            // ),
          ))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             AppbarConst(
              title: AppLocalizations.of(context)!.symptoms,
            ),
            Container(
              width: Sizes.screenWidth,
              child: Column(
                children: [
                  Sizes.spaceHeight25,
                  Center(
                    child: TextConst(
                      AppLocalizations.of(context)!
                          .based_on_your_symptoms,
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textfieldTextColor,
                    ),
                  ),
                  TextConst(
                    AppLocalizations.of(context)!
                        .top_rated_specialists_for_you,
                    size: Sizes.fontSizeFive,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textfieldTextColor,
                  ),
                  Sizes.spaceHeight30,
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF3F3F3).withOpacity(0.25),
                    offset: const Offset(0, 0),
                    blurRadius: 0,
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: const Color(0xFFF3F3F3).withOpacity(0.6),
                    offset: const Offset(0, 0),
                    blurRadius: 0,
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: const Color(0xFFF3F3F3).withOpacity(0.05),
                    offset: const Offset(0, 0),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SpecialistsTopScreen(
                doctors: voiceSearchCon.aiSearchData!.data!,
              ),
            ),
            Sizes.spaceHeight35,
            TextConst(
              AppLocalizations.of(context)!
                  .you_can_choose_a_specialist,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w400,
              color: AppColor.textfieldTextColor,
            ),
            Sizes.spaceHeight30,
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.screenWidth * 0.04),
              child: ButtonConst(
                title: AppLocalizations.of(context)!
                    .select_a_specialists,
                onTap: () {
                  Navigator.pushNamed(
                      context, RoutesName.allSpecialistScreen);
                },
                color: AppColor.btnPurpleColor,
              ),
            ),
            Sizes.spaceHeight20,
          ],
        ),
      ),
      // SingleChildScrollView(
      //   child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         const AppbarConst(
      //           title: 'Symptoms',
      //         ),
      //         Sizes.spaceHeight10,
      //         Center(
      //           child: TextConst(
      //             "Based on your symptoms, here are some",
      //             color: AppColor.textfieldTextColor,
      //             size: Sizes.fontSizeFour,
      //             fontWeight: FontWeight.w400,
      //           ),
      //         ),
      //         TextConst(
      //           "top rated specialists for you!",
      //           color: AppColor.textfieldTextColor,
      //           size: Sizes.fontSizeFour,
      //           fontWeight: FontWeight.w400,
      //         ),
      //         Sizes.spaceHeight20,
      //         Container(
      //           margin: const EdgeInsets.all(11),
      //           padding: const EdgeInsets.only(top: 10,bottom: 15,left: 15,right: 15),
      //           width: Sizes.screenWidth,
      //           decoration: BoxDecoration(
      //             // gradient: LinearGradient(
      //             //   colors: [
      //             //     Colors.white.withOpacity(0.3),
      //             //     Colors.white.withOpacity(0.1),
      //             //   ],
      //             //   begin: Alignment.topLeft,
      //             //   end: Alignment.bottomRight,
      //             // ),
      //             borderRadius: BorderRadius.circular(20),
      //             boxShadow: [
      //               BoxShadow(
      //                 color: const Color(0xFFF3F3F3).withOpacity(0.25),
      //                 offset: const Offset(0, 0),
      //                 blurRadius: 0,
      //                 spreadRadius: -2,
      //               ),
      //               BoxShadow(
      //                 color: const Color(0xFFF3F3F3).withOpacity(0.6),
      //                 offset: const Offset(0, 0),
      //                 blurRadius: 0,
      //                 spreadRadius: -2,
      //               ),
      //               BoxShadow(
      //                 color: const Color(0xFFF3F3F3).withOpacity(0.05),
      //                 offset: const Offset(0, 0),
      //                 blurRadius: 10,
      //                 spreadRadius: 2,
      //               ),
      //             ],
      //           ),
      //           // decoration: BoxDecoration(
      //           //   borderRadius: BorderRadius.circular(24),
      //           //
      //           //   color: const Color(0xFFF3F3F3),
      //           // ),
      //           child:
      //           GridView.builder(
      //             padding: const EdgeInsets.all(0),
      //             shrinkWrap: true,
      //             physics: const NeverScrollableScrollPhysics(),
      //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 2,
      //               crossAxisSpacing: 30.0,
      //               mainAxisSpacing: 30.0,
      //               childAspectRatio: 0.862,
      //             ),
      //             itemCount: doctorListCon.doctors.length,
      //             itemBuilder: (context, index) {
      //               final doctor = doctorListCon.doctors[index];
      //               // return
      //               //   DoctorTile(
      //               //   doctor: doctor,
      //               //     color: AppColor.white,
      //               // );
      //
      //             },
      //           ),
      //         ),
      //         Sizes.spaceHeight20,
      //         TextConst(
      //           "Or else,  you can choose a specialist",
      //           color: AppColor.textfieldTextColor,
      //           size: Sizes.fontSizeFour,
      //           fontWeight: FontWeight.w400,
      //         ),
      //         Sizes.spaceHeight20,
      //         Padding(
      //           padding:  EdgeInsets.symmetric(horizontal: Sizes.screenWidth*0.05),
      //           child: ButtonConst(
      //             title: 'Select a Specialist',
      //             color: AppColor.blue,
      //             onTap: () {
      //               Navigator.pushNamed(context, RoutesName.allSpecialistScreen);
      //             },
      //           ),
      //         ),
      //         Sizes.spaceHeight20,
      //
      //       ],
      //     ),
      // ),

    );
  }

  Widget proContainer(
    Color color,
    dynamic label,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      height: 14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Image(
              image: AssetImage(Assets.iconsCheck),
              height: 10,
              width: 10,
              fit: BoxFit.cover,
            ),
            // Sizes.spaceWidth5,
            TextConst(
              label,
              size: Sizes.fontSizeOne,
              fontWeight: FontWeight.w400,
              color: AppColor.white,
            )
          ],
        ),
      ),
    );
  }
}
