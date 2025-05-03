import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/by_animation/mic_bg_animation.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/user/voice_search_view_model.dart';

class DoctorSpeakerScreen extends StatefulWidget {
  const DoctorSpeakerScreen({super.key});

  @override
  State<DoctorSpeakerScreen> createState() => _DoctorSpeakerScreenState();
}

class _DoctorSpeakerScreenState extends State<DoctorSpeakerScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VoiceSymptomSearchViewModel>(context, listen: false)
          .clearInput();
    });
    super.initState();
  }

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
                    AppLocalizations.of(context)!.back,
                    size: Sizes.fontSizeFive,
                    fontWeight: FontWeight.w400,
                    color: AppColor.white,
                  ),
                ],
              ),
            ),
            Container(
              // height: 2500
              width: Sizes.screenWidth,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        Assets.imagesPlusIcons,
                      ),
                      fit: BoxFit.fitWidth)),
              child: Column(
                children: [
                  SizedBox(height: Sizes.screenHeight * 0.08),
                  Center(
                    child: Image.asset(
                      Assets.logoSwasthyaSaathi,
                      fit: BoxFit.contain,
                      // height: Sizes.screenHeight * 0.03,
                      width: Sizes.screenWidth * 0.55,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: Sizes.screenWidth * 0.08),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        Assets.logoAimSwasthaya,
                        fit: BoxFit.contain,
                        // height: Sizes.screenHeight * 0.025,
                        width: Sizes.screenWidth * 0.26,
                      ),
                    ),
                  ),
                  Sizes.spaceHeight30,
                ],
              ),
            ),
            Sizes.spaceHeight10,
            TextConst(
              AppLocalizations.of(context)!.what_symptoms_are_you,
              size: Sizes.fontSizeFive * 1.25,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
            Sizes.spaceHeight30,
            TextConst(
              AppLocalizations.of(context)!.try_one_by_one_such_as,
              size: Sizes.fontSizeFour,
              fontWeight: FontWeight.w400,
              color: const Color(0xffB2B2B2),
            ),
            TextConst(
              "“Headache” , “Fatigue” , “High BP” , etc.",
              size: Sizes.fontSizeFour,
              fontWeight: FontWeight.w400,
              color: const Color(0xffB2B2B2),
            ),
            const Spacer(),
            Container(
              height: Sizes.screenHeight * 0.54,
              width: Sizes.screenWidth,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
                gradient: AppColor().primaryGradient(
                  colors: [AppColor.darkPurple, AppColor.purple],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes.screenWidth * 0.06,
                    vertical: Sizes.screenHeight * 0.01),
                child: Column(
                  children: [
                    Sizes.spaceHeight10,
                    GestureDetector(
                      onTap: () async {
                        var status = await Permission.microphone.status;

                        if (status.isGranted) {
                          voiceSearchCon.initSpeech(context).then((data) {
                            if (data == true) {
                              voiceSearchCon.isListening
                                  ? voiceSearchCon.stopListening()
                                  : voiceSearchCon.startListening();
                            }
                          });
                        } else {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return ActionOverlay(
                                  height: Sizes.screenHeight / 5.2,
                                  padding: EdgeInsets.only(
                                      left: Sizes.screenWidth * 0.03,
                                      right: Sizes.screenWidth * 0.05,
                                      top: Sizes.screenHeight * 0.02),
                                  text: "Mic Permission Required",
                                  yesLabel: "Allow",
                                  noLabel: "Deny",
                                  subtext:
                                      "We use your microphone so you can speak your symptoms instead of typing — making it faster and easier for you!",
                                  onTap: () {
                                    Navigator.pop(context);
                                    voiceSearchCon
                                        .initSpeech(context)
                                        .then((_) {
                                      voiceSearchCon.isListening
                                          ? voiceSearchCon.stopListening()
                                          : voiceSearchCon.startListening();
                                    });
                                  },
                                );
                              });
                        }
                      },
                      child: Container(
                        height: Sizes.screenHeight * 0.2,
                        width: Sizes.screenHeight * 0.2,
                        decoration: const BoxDecoration(
                            color: AppColor.purple, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: voiceSearchCon.isListening
                            ? const MicAnimation()
                            : Image(
                                image: const AssetImage(
                                  Assets.iconsMapUser,
                                ),
                                color: AppColor.white,
                                height: Sizes.screenHeight * 0.09,
                                width: Sizes.screenHeight * 0.09,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: Sizes.screenHeight * 0.05,
                    ),
                    // Sizes.spaceHeight30,
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: voiceSearchCon.voiceSearchResults.length,
                          itemBuilder: (_, int i) {
                            final data = voiceSearchCon.voiceSearchResults[i];
                            return searchSymptoms(data, voiceSearchCon);
                          }),
                    ),
                    SizedBox(height: Sizes.screenHeight * 0.08),
                    ButtonConst(
                      width: Sizes.screenWidth,
                      height: Sizes.screenHeight * .06,
                      title: AppLocalizations.of(context)!.next,
                      onTap: () {
                        if (voiceSearchCon.voiceSearchResults.isNotEmpty) {
                          voiceSearchCon.aiSearchApi(context);
                          Navigator.pushNamed(
                              context, RoutesName.allDoctorsScreen);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please search using the mic before proceeding.')),
                          );
                        }
                        // voiceSearchCon.aiSearchApi(context);
                        // Navigator.pushNamed(
                        //     context, RoutesName.allDoctorsScreen);
                      },
                      color: AppColor.btnPurpleColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchSymptoms(
      dynamic label, VoiceSymptomSearchViewModel voiceSearchCon) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      padding: const EdgeInsets.only(left: 7, right: 7),
      height: Sizes.screenHeight * 0.035,
      decoration: BoxDecoration(
          color: AppColor.lightSkyBlue, borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
              child: TextConst(
            label,
            size: Sizes.fontSizeFour,
            fontWeight: FontWeight.w400,
          )),
          GestureDetector(
            onTap: () {
              voiceSearchCon.removeSearchedItem(label);
            },
            child: const Center(
                child: Icon(
              Icons.close,
              size: 20,
              color: Colors.red,
            )),
          )
        ],
      ),
    );
  }
}
