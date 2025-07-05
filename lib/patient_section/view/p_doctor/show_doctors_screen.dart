// patient_section/view/p_doctor/show_doctors_screen.dart
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/load_data.dart';
import '../../../utils/no_data_found.dart';
import '../../p_view_model/voice_search_view_model.dart';
import 'package:aim_swasthya/l10n/app_localizations.dart';

import '../p_home/specialists_top_screen.dart';

class ShowDoctorsScreen extends StatefulWidget {
  const ShowDoctorsScreen({super.key});

  @override
  State<ShowDoctorsScreen> createState() => _ShowDoctorsScreenState();
}

class _ShowDoctorsScreenState extends State<ShowDoctorsScreen> {
  @override
  Widget build(BuildContext context) {
    final voiceSearchCon = Provider.of<VoiceSymptomSearchViewModel>(context);
    final homeCon = Provider.of<PatientHomeViewModel>(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: voiceSearchCon.loading
          ? const Center(child: LoadData())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AppbarConst(
                    title: AppLocalizations.of(context)!.symptoms,
                  ),
                  if (voiceSearchCon.aiSearchData == null ||
                      (voiceSearchCon.aiSearchData!.data == null ||
                          voiceSearchCon.aiSearchData!.data!.isEmpty))
                    SizedBox(
                      height: Sizes.screenHeight / 1.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const NoMessage(
                            message: "No specialists around here, for now...",
                            title:
                                "We’re working to bring expert care to your area",
                          ),
                          if (homeCon.noServicesArea)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.screenWidth * 0.04),
                              child: ButtonConst(
                                title: 'Change Location',
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                color: AppColor.btnPurpleColor,
                              ),
                            )
                        ],
                      ),
                    ),
                  if (voiceSearchCon.aiSearchData != null &&
                      voiceSearchCon.aiSearchData!.data != null &&
                      voiceSearchCon.aiSearchData!.data!.isNotEmpty) ...[
                    SizedBox(
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
                      AppLocalizations.of(context)!.you_can_choose_a_specialist,
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textfieldTextColor,
                    ),
                    Sizes.spaceHeight30,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.screenWidth * 0.04),
                      child: ButtonConst(
                        title:
                            AppLocalizations.of(context)!.select_a_specialists,
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutesName.allSpecialistScreen);
                        },
                        color: AppColor.btnPurpleColor,
                      ),
                    ),
                    Sizes.spaceHeight20,
                  ]
                ],
              ),
            ),
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
