import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view/user/home/specialists_top_screen.dart';
import 'package:aim_swasthya/view_model/user/voice_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllDoctorsScreen extends StatefulWidget {
  const AllDoctorsScreen({super.key});

  @override
  State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  @override
  Widget build(BuildContext context) {
    final voiceSearchCon = Provider.of<VoiceSymptomSearchViewModel>(context);

    return Scaffold(
      body: Container(
        height: Sizes.screenHeight,
        width: Sizes.screenWidth,
        decoration: BoxDecoration(
          gradient: AppColor().primaryGradient(
            colors: [AppColor.primeryPurple, AppColor.purple],
          ),
        ),
        child: voiceSearchCon.loading
            ? const Center(child: LoadData())
            : voiceSearchCon.aiSearchData == null ||
                    voiceSearchCon.aiSearchData!.data!.isEmpty
                ? const NoMessage(
                    imageColor: AppColor.purple,
                    message: "No specialists around here, for now...",
                    color: AppColor.white,
                    title: "We’re working to bring expert care to your area",
                    titleColor: AppColor.white,
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 35),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () => Navigator.of(context).pop(),
                                color: AppColor.lightBlue,
                              ),
                              TextConst(
                                AppLocalizations.of(context)!.symptoms,
                                size: Sizes.fontSizeFive,
                                fontWeight: FontWeight.w400,
                                color: AppColor.white,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: Sizes.screenWidth,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    Assets.imagesPlusIcons,
                                  ),
                                  fit: BoxFit.fitWidth)),
                          child: Column(
                            children: [
                              Sizes.spaceHeight25,
                              Center(
                                child: TextConst(
                                  AppLocalizations.of(context)!
                                      .based_on_your_symptoms,
                                  size: Sizes.fontSizeFive,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.white,
                                ),
                              ),
                              TextConst(
                                AppLocalizations.of(context)!
                                    .top_rated_specialists_for_you,
                                size: Sizes.fontSizeFive,
                                fontWeight: FontWeight.w400,
                                color: AppColor.white,
                              ),
                              Sizes.spaceHeight30,
                            ],
                          ),
                        ),
                        SpecialistsTopScreen(
                          doctors: voiceSearchCon.aiSearchData!.data!,
                        ),
                        Sizes.spaceHeight35,
                        TextConst(
                          AppLocalizations.of(context)!
                              .you_can_choose_a_specialist,
                          size: Sizes.fontSizeFive,
                          fontWeight: FontWeight.w400,
                          color: AppColor.white,
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
