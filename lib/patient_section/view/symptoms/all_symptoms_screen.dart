// patient_section/view/symptoms/all_symptoms_screen.dart
import 'dart:io';
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/patient_section/view/symptoms/dowenloade_image.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aim_swasthya/l10n/app_localizations.dart';
import '../../p_view_model/voice_search_view_model.dart';

class AllSymptomsScreen extends StatefulWidget {
  const AllSymptomsScreen({super.key});
  @override
  State<AllSymptomsScreen> createState() => _AllSymptomsScreenState();
}

class _AllSymptomsScreenState extends State<AllSymptomsScreen> {
  int? selectedOuterIndex;
  int? selectedInnerIndex;

  @override
  Widget build(BuildContext context) {
    final homeCon = Provider.of<PatientHomeViewModel>(context);
    final symptomSearchCon = Provider.of<VoiceSymptomSearchViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        print("hvhjhjfhjvjh");
        symptomSearchCon.clearValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarConst(
                onPressed: () {
                  symptomSearchCon.clearValues();
                  Navigator.pop(context);
                },
                title: AppLocalizations.of(context)!.symptoms,
              ),
              TextConst(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.screenWidth * 0.04,
                ),
                AppLocalizations.of(context)!.choose_symptoms,
                size: Sizes.fontSizeFivePFive,
                fontWeight: FontWeight.w500,
                // fontWeight: FontWeight.bold,
              ),
              Sizes.spaceHeight5,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    homeCon.patientHomeModel!.data!.symptomsDetails!.length,
                itemBuilder: (context, index) {
                  final currentItem =
                      homeCon.patientHomeModel!.data!.symptomsDetails![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.screenWidth * 0.04,
                            vertical: Sizes.screenHeight * 0.01),
                        child: Text(
                          currentItem.categoryName ?? "",
                          style: TextStyle(
                            fontSize: Sizes.fontSizeFourPFive,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Sizes.screenHeight / 5,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: currentItem.symptom!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, symptomIndex) {
                            final symptom = currentItem.symptom![symptomIndex];
                            String? imagePath = LocalImageHelper.instance
                                .getImagePath(symptom.symptomName ?? "");
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    symptomSearchCon.toggleSelectedSymptoms(
                                        symptom.symptomName ?? "");
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    margin: EdgeInsets.only(
                                      left: Sizes.screenWidth * 0.04,
                                      right: symptomIndex ==
                                              currentItem.symptom!.length - 1
                                          ? Sizes.screenWidth * 0.04
                                          : 0,
                                    ),
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.grey,
                                        border: symptomSearchCon
                                                .selectedSymptoms
                                                .contains(
                                                    symptom.symptomName ?? "")
                                            ? Border.all(color: AppColor.blue)
                                            : null),
                                    child: Column(
                                      children: [
                                        imagePath != null
                                            ? Image.file(
                                                File(imagePath),
                                                height: 55,
                                                width: 55,
                                                fit: BoxFit.fill,
                                              )
                                            : const Icon(Icons.image,
                                                size: 55, color: Colors.grey),
                                        const SizedBox(height: 5),
                                        Text(
                                          symptom.symptomName ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: Sizes.fontSizeFour * 1.1,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.darkBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              TextConst(
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes.screenWidth * 0.04,
                    vertical: Sizes.screenHeight * 0.02),
                AppLocalizations.of(context)!.did_find_your_symptoms,
                size: Sizes.fontSizeFourPFive,
                fontWeight: FontWeight.w500,
                color: AppColor.textfieldTextColor,
              ),
              Sizes.spaceHeight10,
              Center(
                child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.symmetric(
                        horizontal: Sizes.screenWidth * 0.07),
                    // height: Sizes.screenHeight * 0.12,
                    constraints:
                        BoxConstraints(minHeight: Sizes.screenHeight * 0.12),
                    width: Sizes.screenWidth,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColor.lightBlack)),
                    child: Column(
                      children: [
                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: List.generate(
                              symptomSearchCon.selectedSymptoms.length, (i) {
                            return searchSymptoms(
                                symptomSearchCon.selectedSymptoms[i],
                                symptomSearchCon);
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: ButtonConst(
                              title: AppLocalizations.of(context)!.add_symptoms,
                              size: Sizes.fontSizeFour,
                              borderRadius: 5,
                              height: Sizes.screenHeight * 0.03,
                              width: Sizes.screenWidth * 0.3,
                              color: AppColor.blue,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return addSymptoms();
                                    });
                              }),
                        ),
                        Sizes.spaceHeight5,
                      ],
                    )),
              ),
              ButtonConst(
                title: AppLocalizations.of(context)!.continue_con,
                color: AppColor.blue,
                margin: EdgeInsets.only(
                    top: Sizes.screenHeight * 0.04,
                    bottom: Sizes.screenHeight * 0.06,
                    left: Sizes.screenWidth * 0.04,
                    right: Sizes.screenWidth * 0.04),

                // borderRadius: 10,
                onTap: () {
                  symptomSearchCon.aiSearchApi(context,
                      isVoiceSearchReq: false);
                  Navigator.pushNamed(context, RoutesName.showDoctorsScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchSymptoms(
      dynamic label, VoiceSymptomSearchViewModel voiceSearchCon) {
    return Container(
      padding: const EdgeInsets.only(left: 7, right: 7),
      height: Sizes.screenHeight * 0.035,
      decoration: BoxDecoration(
          color: AppColor.grey, borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: TextConst(
            label,
            size: Sizes.fontSizeFour,
            fontWeight: FontWeight.w400,
          )),
          GestureDetector(
            onTap: () {
              voiceSearchCon.toggleSelectedSymptoms(label);
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

  final symptomsCon = TextEditingController();
  Widget addSymptoms() {
    final symptomSearchCon = Provider.of<VoiceSymptomSearchViewModel>(context);
    return Dialog(
      elevation: 3,
      backgroundColor: Colors.grey[400],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: Sizes.screenHeight / 5.5,
        padding: EdgeInsets.only(
            top: Sizes.screenHeight * 0.02, left: 15, right: 15),
        width: Sizes.screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xffF9F9F9)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextConst(
              AppLocalizations.of(context)!.add_symptoms,
              size: Sizes.fontSizeSix,
              fontWeight: FontWeight.w500,
            ),
            // Sizes.spaceHeight5,
            const Spacer(),
            TextField(
              controller: symptomsCon,
              decoration: InputDecoration(
                hintText: "eg. Headache",
                hintStyle: TextStyle(
                    color: const Color(0xffC5C5C5),
                    fontWeight: FontWeight.w400,
                    fontSize: Sizes.fontSizeThree),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                fillColor: const Color(0xffF5F5F5),
                filled: true,
                contentPadding:
                    const EdgeInsets.only(left: 7, right: 7, top: 6, bottom: 6),
              ),
              cursorColor: AppColor.textGrayColor,
              cursorHeight: 20,
              style: const TextStyle(color: AppColor.blue, fontSize: 14),
            ),

            const Spacer(),
            Sizes.spaceHeight10,
            Container(
              height: Sizes.screenHeight * 0.055,
              // width: Sizes.screenWidth * 0.78,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xffEBEBEB),
                  ),
                ),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: Sizes.screenHeight * 0.055,
                      width: Sizes.screenWidth * 0.35,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(30)),
                        border: Border(
                            right: BorderSide(
                          color: Color(0xffEBEBEB),
                        )),
                      ),
                      child: Center(
                        child: TextConst(
                          "Cancel",
                          size: Sizes.fontSizeFourPFive,
                          fontWeight: FontWeight.w400,
                          color: AppColor.lightBlue,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      symptomSearchCon.toggleSelectedSymptoms(symptomsCon.text);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: Sizes.screenHeight * 0.055,
                      width: Sizes.screenWidth * 0.33,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(30)),
                      ),
                      child: Center(
                        child: TextConst(
                          "Add",
                          size: Sizes.fontSizeFourPFive,
                          fontWeight: FontWeight.w400,
                          color: AppColor.lightBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
