// patient_section/view/p_doctor/search_doctor_screen.dart
import 'dart:io';
import 'package:aim_swasthya/model/user/patient_home_model.dart';
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/utils/const_config.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/patient_section/view/p_home/doctor_Tile.dart';
import 'package:aim_swasthya/patient_section/view/p_home/specialists_top_screen.dart';
import 'package:aim_swasthya/patient_section/view/symptoms/dowenloade_image.dart';
import 'package:aim_swasthya/patient_section/p_view_model/doctor_details_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../res/popUp_const.dart';
import '../../../res/user_button_const.dart';
import '../../p_view_model/voice_search_view_model.dart';

class SearchDoctorScreen extends StatefulWidget {
  const SearchDoctorScreen({super.key});
  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

class _SearchDoctorScreenState extends State<SearchDoctorScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DoctorDetailsViewModel>(context, listen: false)
          .doctorDetailsApi(context);
      Provider.of<VoiceSymptomSearchViewModel>(context, listen: false)
          .searchCon
          .clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeCon = Provider.of<PatientHomeViewModel>(context);
    final title = ModalRoute.of(context)?.settings.arguments as String;
    final doctorDetailCon = Provider.of<DoctorDetailsViewModel>(context);
    final voiceSearchCon = Provider.of<VoiceSymptomSearchViewModel>(context);

    return Scaffold(
        backgroundColor: AppColor.white,
        body: doctorDetailCon.loading
            ? const Center(child: LoadData())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppbarConst(
                      title: title,
                    ),
                    if (doctorDetailCon.filterDoctorDetailsModel == null ||
                        (doctorDetailCon.filterDoctorDetailsModel!.isEmpty &&
                            homeCon.noServicesArea))
                      SizedBox(
                        height: Sizes.screenHeight / 1.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                                child: NoMessage(
                              message: "No specialists around here, for now...",
                              title:
                                  "We're working to bring expert care to your area",
                            )),
                            Sizes.spaceHeight15,
                            if (homeCon.noServicesArea)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Sizes.screenWidth * 0.04),
                                child: ButtonConst(
                                  title: 'Change Location',
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  color: AppColor.btnPurpleColor,
                                ),
                              )
                          ],
                        ),
                      ),
                    if (doctorDetailCon.filterDoctorDetailsModel?.isNotEmpty ??
                        false) ...[
                      Sizes.spaceHeight10,
                      textFields(),
                      Sizes.spaceHeight30,
                      TextConst(
                        AppLocalizations.of(context)!.specialties,
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.screenWidth * 0.04,
                        ),
                        size: Sizes.fontSizeFivePFive,
                        fontWeight: FontWeight.w500,
                      ),
                      Sizes.spaceHeight25,
                      (homeCon.patientHomeModel?.data?.doctors == null ||
                              homeCon.patientHomeModel!.data!.doctors!.isEmpty)
                          ? const NoMessage(
                              message: "No specialists around here, for now...",
                              title:
                                  "We're working to bring expert care to your area",
                            )
                          // const ImageContainer(
                          //         imagePath: "assets/noDoctorFound.png")
                          : Builder(builder: (context) {
                              debugPrint(
                                  "sdde: ${voiceSearchCon.searchCon.text}");
                              final List<Specializations> symptomsData;
                              if (voiceSearchCon.searchCon.text.isEmpty) {
                                symptomsData = homeCon.patientHomeModel?.data
                                        ?.specializations ??
                                    [];
                              } else {
                                symptomsData = homeCon
                                        .patientHomeModel?.data?.specializations
                                        ?.where((e) {
                                      final name =
                                          e.specializationName?.toLowerCase() ??
                                              "";
                                      return name.contains(voiceSearchCon
                                          .searchCon.text
                                          .toLowerCase());
                                    }).toList() ??
                                    [];
                              }
                              if (symptomsData.isEmpty) {
                                return const Center(
                                    child: NoMessage(
                                  message:
                                      "No specialists around here, for now...",
                                  title:
                                      "We're working to bring expert care to your area",
                                ));
                              }
                              return SizedBox(
                                height: Sizes.screenHeight * 0.15,
                                child: ListView.builder(
                                  itemCount: symptomsData.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final item = symptomsData[index];
                                    bool isSelected = item.specializationId ==
                                        (doctorDetailCon.selectedSpecialist ==
                                                null
                                            ? 0
                                            : doctorDetailCon
                                                .selectedSpecialist!
                                                .specializationId);
                                    String? imagePath =
                                        LocalImageHelper.instance.getImagePath(
                                            item.specializationName ?? "");
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            doctorDetailCon
                                                .getSpecialistById(item);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: index ==
                                                        homeCon
                                                                .patientHomeModel!
                                                                .data!
                                                                .specializations!
                                                                .length -
                                                            1
                                                    ? Sizes.screenWidth * 0.03
                                                    : 0,
                                                left: index == 0
                                                    ? Sizes.screenWidth * 0.03
                                                    : Sizes.screenWidth * 0.03),
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: isSelected
                                                  ? const Color(0xff73CBFF)
                                                  : AppColor.grey,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if (imagePath != null)
                                                  Image.file(
                                                    File(imagePath),
                                                    height: Sizes.screenHeight *
                                                        0.05,
                                                    width: Sizes.screenWidth *
                                                        0.11,
                                                    fit: BoxFit.cover,
                                                  )
                                                else
                                                  Icon(
                                                    Icons.image,
                                                    size: Sizes.screenHeight *
                                                        0.05,
                                                    color: AppColor.blue,
                                                  ),
                                                Sizes.spaceHeight5,
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: Sizes.screenHeight *
                                                      0.041,
                                                  width:
                                                      Sizes.screenWidth * 0.2,
                                                  child: Center(
                                                    child: TextConst(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      item.specializationName ??
                                                          "",
                                                      size: Sizes.fontSizeFour *
                                                          1.1,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColor.black,
                                                    ),
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
                              );
                            }),
                      Sizes.spaceHeight30,
                      TextConst(
                        doctorDetailCon.selectedSpecialist == null
                            ? AppLocalizations.of(context)!.top_specialists
                            : "Top ${doctorDetailCon.selectedSpecialist!.specializationName ?? ""}",
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.screenWidth * 0.04,
                        ),
                        size: Sizes.fontSizeFivePFive,
                        fontWeight: FontWeight.w500,
                      ),
                      Sizes.spaceHeight10,
                      doctorDetailCon.filterDoctorDetailsModel?.isNotEmpty ??
                              false
                          ? Builder(builder: (context) {
                              final topSpecialist = doctorDetailCon
                                      .filterDoctorDetailsModel
                                      ?.where((e) {
                                    final rating = double.tryParse(
                                            e.averageRating?.toString() ??
                                                "0") ??
                                        0;
                                    return rating >=
                                        Config.topSpecialistAverageReview;
                                  }).toList() ??
                                  [];
                              topSpecialist.sort((a, b) =>
                                  double.parse(b.averageRating.toString())
                                      .compareTo(double.parse(
                                          a.averageRating.toString())));
                              if (topSpecialist.isEmpty) {
                                return const Center(
                                    child: NoMessage(
                                  message:
                                      "No specialists around here, for now...",
                                  title:
                                      "We're working to bring expert care to your area",
                                ));
                              }
                              final List<Doctors> topDrSpecialist;
                              //
                              if (voiceSearchCon.searchCon.text.isEmpty) {
                                topDrSpecialist = topSpecialist;
                              } else {
                                topDrSpecialist = topSpecialist
                                    .where((e) =>
                                        e.specializationName!
                                            .toLowerCase()
                                            .contains(voiceSearchCon
                                                .searchCon.text) ||
                                        e.doctorName!.toLowerCase().contains(
                                            voiceSearchCon.searchCon.text))
                                    .toList();
                              }
                              if (topDrSpecialist.isEmpty) {
                                return const Center(
                                    child: NoMessage(
                                  message:
                                      "No specialists around here, for now...",
                                  title:
                                      "We're working to bring expert care to your area",
                                ));
                              }
                              return SizedBox(
                                height: Sizes.screenHeight * 0.262,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: topDrSpecialist.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final doctor = topDrSpecialist[index];
                                    return Container(
                                        padding: const EdgeInsets.all(6),
                                        margin: const EdgeInsets.all(10),
                                        child: DoctorTile(
                                          doctor: doctor,
                                        ));
                                  },
                                ),
                              );
                            })
                          : const Center(
                              child: NoMessage(
                              message: "No specialists around here, for now...",
                              title:
                                  "We're working to bring expert care to your area",
                            )),
                      Sizes.spaceHeight10,
                      Row(
                        children: [
                          TextConst(
                            AppLocalizations.of(context)!.near_you,
                            padding: EdgeInsets.symmetric(
                              horizontal: Sizes.screenWidth * 0.04,
                            ),
                            size: Sizes.fontSizeFivePFive,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Sizes.spaceHeight15,
                      Builder(builder: (context) {
                        if (doctorDetailCon
                                .filterDoctorDetailsModel?.isNotEmpty ??
                            false) {
                          final List<Doctors> nearDrSpecialist;
                          if (voiceSearchCon.searchCon.text.isEmpty) {
                            nearDrSpecialist =
                                doctorDetailCon.filterDoctorDetailsModel!;
                          } else {
                            nearDrSpecialist = doctorDetailCon
                                .filterDoctorDetailsModel!
                                .where((e) =>
                                    e.specializationName!
                                        .toLowerCase()
                                        .contains(
                                            voiceSearchCon.searchCon.text) ||
                                    e.doctorName!.toLowerCase().contains(
                                        voiceSearchCon.searchCon.text))
                                .toList();
                          }
                          if (nearDrSpecialist.isEmpty) {
                            return const Center(
                                child: NoMessage(
                              message: "No specialists around here, for now...",
                              title:
                                  "We're working to bring expert care to your area",
                            ));
                          }
                          return SpecialistsTopScreen(
                              doctors: nearDrSpecialist);
                        }
                        return const Center(
                            child: NoMessage(
                          message: "No specialists around here, for now...",
                          title:
                              "We're working to bring expert care to your area",
                        ));
                      }),
                      SizedBox(
                        height: Sizes.screenHeight * 0.06,
                      )
                    ]
                  ],
                ),
              ));
  }

  Widget textFields() {
    final voiceSearchCon = Provider.of<VoiceSymptomSearchViewModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.04,
          vertical: Sizes.screenHeight * 0.01),
      child: TextField(
        controller: voiceSearchCon.searchCon,
        decoration: InputDecoration(
          constraints: const BoxConstraints(maxHeight: 40),
          hintText: AppLocalizations.of(context)!.search,
          hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: Sizes.fontSizeSix),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColor.blue,
          ),
          suffixIcon: GestureDetector(
              onTap: () async {
                var status = await Permission.microphone.status;
                if (status.isGranted) {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return const VoiceSearchDialog();
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
                          text: "Permission Required",
                          subtext:
                              "We use your microphone so you can speak your symptoms instead of typing — making it faster and easier for you!",
                          onTap: () {
                            Navigator.pop(context);
                            // voiceSearchCon.initSpeech(context).then((_) {
                            //   voiceSearchCon.isListening
                            //       ? voiceSearchCon.stopListening()
                            //       : voiceSearchCon.startListening();
                            // });
                            voiceSearchCon.initSpeech(context).then((_) {
                              voiceSearchCon.isListening
                                  ? voiceSearchCon.stopListening()
                                  : voiceSearchCon.startListening();
                            });
                          },
                        );
                      });
                }
              },
              child: const Icon(Icons.mic, color: AppColor.blue)),
          fillColor: AppColor.grey,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 6.0,
          ),
        ),
        cursorColor: AppColor.textGrayColor,
        cursorHeight: 20,
        style:
            const TextStyle(color: AppColor.blue, fontWeight: FontWeight.w500),
      ),
    );
  }
}
