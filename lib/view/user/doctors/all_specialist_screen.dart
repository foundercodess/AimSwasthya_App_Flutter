import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/view/user/home/doctor_Tile.dart';
import 'package:aim_swasthya/view_model/user/doctor_specialisation_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/user/patient_home_model.dart';
import '../../../res/popUp_const.dart';
import '../../../utils/const_config.dart';
import '../../../utils/no_data_found.dart';
import '../../../view_model/user/voice_search_view_model.dart';
import '../home/specialists_top_screen.dart';

class AllSpecialistScreen extends StatefulWidget {
  const AllSpecialistScreen({super.key});

  @override
  State<AllSpecialistScreen> createState() => _AllSpecialistScreenState();
}

class _AllSpecialistScreenState extends State<AllSpecialistScreen> {
  @override
  Widget build(BuildContext context) {
    final doctorSpeCon = Provider.of<DoctorSpecialisationViewModel>(context);
    final voiceSearchCon = Provider.of<VoiceSymptomSearchViewModel>(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      body: doctorSpeCon.doctorSpecialisationModel == null
          ? const Center(
              child: LoadData(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppbarConst(
                    title: 'Specialist',
                  ),
                  textFields(),
                  Sizes.spaceHeight30,
                  TextConst(
                    "Top ${doctorSpeCon.selectedSpecialist!.specializationName ?? ""}",
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.screenWidth * 0.04,
                    ),
                    size: Sizes.fontSizeFive,
                    fontWeight: FontWeight.w500,
                  ),
                  Sizes.spaceHeight20,
                  SizedBox(
                      height: Sizes.screenHeight * 0.241,
                      child: doctorSpeCon.doctorSpecialisationModel!.data !=
                                  null ||
                              doctorSpeCon.doctorSpecialisationModel!.data!
                                  .doctors!.isNotEmpty
                          ? Builder(builder: (context) {
                              final topSpecialist = doctorSpeCon
                                  .doctorSpecialisationModel!.data!.doctors!
                                  .where((e) =>
                                      double.parse(
                                          e.averageRating.toString()) >=
                                      Config.topSpecialistAverageReview)
                                  .toList();
                              if (topSpecialist.isEmpty) {
                                return const Center(
                                    child: NoMessage(
                                      message: "No specialists around here, for now...",
                                      title:
                                      "We’re working to bring expert care to your area",
                                    ));
                              }
                              final List<Doctors> topDrSpecialist;
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
                                      message: "No specialists around here, for now...",
                                      title:
                                      "We’re working to bring expert care to your area",
                                    ));
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: topDrSpecialist.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final doctor = topDrSpecialist[index];
                                  return Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: EdgeInsets.only(
                                          right: index ==
                                                  topDrSpecialist.length - 1
                                              ? Sizes.screenWidth * 0.03
                                              : 0,
                                          left: index == 0
                                              ? Sizes.screenWidth * 0.02
                                              : Sizes.screenWidth * 0.04),
                                      child: DoctorTile(
                                        doctor: doctor,
                                      ));
                                },
                              );
                            })
                          : const Center(
                              child: NoMessage(
                                message: "No specialists around here, for now...",
                                title:
                                "We’re working to bring expert care to your area",
                              )
                      )),
                  Sizes.spaceHeight20,
                  Row(
                    children: [
                      TextConst(
                        "Near you",
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.screenWidth * 0.04,
                            vertical: Sizes.screenHeight * 0.01),
                        size: Sizes.fontSizeFive,
                        fontWeight: FontWeight.w500,
                      ),
                      doctorSpeCon.doctorSpecialisationModel != null &&
                              doctorSpeCon.doctorSpecialisationModel!.data!
                                  .doctors!.isNotEmpty
                          ? Container(
                              height: Sizes.screenHeight * 0.05,
                              width: Sizes.screenWidth * 0.05,
                              decoration: const BoxDecoration(
                                color: AppColor.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: TextConst(
                                  '${doctorSpeCon.doctorSpecialisationModel!.data!.doctors!.length}',
                                  color: AppColor.white,
                                  size: Sizes.fontSizeTwo,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  Sizes.spaceHeight20,
                  Builder(builder: (context) {
                    if (voiceSearchCon.searchCon.text.isNotEmpty) {
                      final doctorData = doctorSpeCon
                          .doctorSpecialisationModel!.data!.doctors!
                          .where((e) =>
                              e.doctorName!
                                  .contains(voiceSearchCon.searchCon.text) ||
                              e.specializationName!
                                  .contains(voiceSearchCon.searchCon.text))
                          .toList();
                      return SpecialistsTopScreen(
                        doctors: doctorData,
                      );
                    }
                    return SpecialistsTopScreen(
                      doctors: doctorSpeCon
                          .doctorSpecialisationModel!.data!.doctors!,
                    );
                  }),
                  Sizes.spaceHeight25,
                ],
              ),
            ),
    );
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
          hintText: "Search",
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
              onTap: () {
                showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return const VoiceSearchDialog();
                    });
              },
              child: Icon(Icons.mic, color: AppColor.blue)),
          fillColor: AppColor.grey,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 6.0,
          ),
        ),
      ),
    );
  }
}
