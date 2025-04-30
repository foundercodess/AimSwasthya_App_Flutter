import 'dart:io';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/view/user/home/specialisation.dart';
import 'package:aim_swasthya/view/user/symptoms/dowenloade_image.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../model/user/patient_home_model.dart';
import '../../view_model/user/voice_search_view_model.dart';
import 'home/doctor_Tile.dart';
import 'home/health_section_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserHomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const UserHomeScreen({super.key, required this.scaffoldKey});
  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final sectionSpacing = SizedBox(
    height: Sizes.screenHeight * 0.035,
  );
  final commentSpacing = SizedBox(
    height: Sizes.screenHeight * 0.02,
  );
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final homeCon = Provider.of<PatientHomeViewModel>(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: homeCon.patientHomeModel== null|| homeCon.patientHomeModel!.data== null|| homeCon.loading
          ? const Center(child: LoadData())
          : RefreshIndicator(
              color: AppColor.blue,
              onRefresh: () async {
                Provider.of<PatientHomeViewModel>(context, listen: false)
                    .getLocationApi(context);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      constAppBarContainer(),
                      sectionSpacing,
                      // if (homeCon.locationData == null ||
                      //     homeCon.locationData!.patientLocation!.name == null)
                      //   outOfServiceArea(),
                      // if (homeCon.locationData != null &&
                      //     homeCon.locationData!.patientLocation!.name != null &&
                      //     homeCon.patientHomeModel != null) ...[
                      if (homeCon.patientHomeModel != null &&
                          homeCon.patientHomeModel!.data!.appointments!
                              .isNotEmpty &&
                          !homeCon.noServicesArea)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.screenWidth * 0.04,
                          ),
                          child: textFields(BorderRadius.circular(15)),
                        ),
                      sectionSpacing,
                      if (homeCon.patientHomeModel != null &&
                          homeCon.patientHomeModel!.data != null)
                        symptomsSection(),
                      sectionSpacing,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.screenWidth * 0.03),
                        width: Sizes.screenWidth,
                        child: const Image(
                            image: AssetImage(Assets.imagesAppointment)),
                      ),
                      sectionSpacing,
                      if (homeCon.patientHomeModel != null &&
                          homeCon.patientHomeModel!.data != null)
                        const SpecialiasationScreen(),
                      sectionSpacing,
                      topSpecialistNearMe(),
                      sectionSpacing,
                      const HealthSectionScreen(),
                      SizedBox(height: Sizes.screenHeight * 0.16),
                    ]
                    // ],
                    ),
              ),
            ),
    );
  }

  Widget starRatings({
    required double averageRating,
    required double size,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if (averageRating >= index + 1) {
          return Icon(
            Icons.star,
            color: const Color(0xffFFE500),
            size: size,
          );
        } else if (averageRating > index && averageRating < index + 1) {
          return Icon(
            Icons.star_half,
            color: const Color(0xffFFE500),
            size: size,
          );
        } else {
          // Empty star
          return Icon(
            Icons.star_border,
            color: const Color(0xffFFE500),
            size: size,
          );
        }
      }),
    );
  }

  // Widget outOfServiceArea() {
  //   return Center(
  //     child: Column(
  //       children: [
  //         TextConst(
  //           "Service Unavailable at Your Location",
  //           fontWeight: FontWeight.bold,
  //         ),
  //         const SizedBox(
  //           height: 15,
  //         ),
  //         Container(
  //           height: Sizes.screenWidth / 2,
  //           width: Sizes.screenWidth / 2,
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10),
  //               image: const DecorationImage(
  //                   image: AssetImage(Assets.assetsNoService))),
  //         ),
  //         const SizedBox(
  //           height: 15,
  //         ),
  //         Container(
  //             padding: const EdgeInsets.only(top: 10),
  //             width: Sizes.screenWidth / 1.2,
  //             child: TextConst(
  //               textAlign: TextAlign.center,
  //               size: Sizes.fontSizeFourPFive,
  //               "We're currently not offering services in your area. \nPlease try selecting a different city to continue with your booking.",
  //             )),
  //       ],
  //     ),
  //   );
  // }

  Widget constAppBarContainer() {
    return Consumer<PatientHomeViewModel>(builder: (context, homeCon, _) {
      return Container(
        padding: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.topCenter,
        width: Sizes.screenWidth,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(45),
            bottomRight: Radius.circular(45),
          ),
          color: AppColor.lightBlue,
          boxShadow: [
            BoxShadow(
              color: AppColor.blue.withOpacity(0.7),
              blurRadius: 9,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.screenWidth * 0.03,
              vertical: Sizes.screenHeight * 0.011),
          width: Sizes.screenWidth,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [AppColor.naviBlue, AppColor.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Sizes.spaceHeight25,
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        if (widget.scaffoldKey!.currentState != null) {
                          if (widget.scaffoldKey!.currentState!.isDrawerOpen) {
                            widget.scaffoldKey!.currentState!.closeDrawer();
                          } else {
                            widget.scaffoldKey!.currentState!.openDrawer();
                          }
                        } else {
                          if (kDebugMode) {
                            print("ScaffoldState is null!");
                          }
                        }
                      },
                      child: Image.asset(
                        Assets.iconsProfileIcon,
                        width: 24,
                      )),
                  Sizes.spaceWidth5,
                  Sizes.spaceWidth3,
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        barrierColor: Colors.black.withOpacity(0.7),
                        elevation: 5,
                        backgroundColor: Colors.transparent,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                        ),
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return showLocationBottomSheet();
                        },
                      );
                    },
                    child: SizedBox(
                      height: 20,
                      // width: 100,
                      child: Row(
                        children: [
                          Consumer<PatientHomeViewModel>(
                              builder: (context, homeCon, _) {
                            if (homeCon.selectedLocationData == null) {
                              return const SizedBox();
                            }
                            return TextConst(
                              homeCon.selectedLocationData!.name ??
                                  "No service area",
                              size: Sizes.fontSizeFive,
                              fontWeight: FontWeight.w400,
                              color: AppColor.white,
                            );
                          }),
                          Sizes.spaceWidth5,
                          const Image(
                            image: AssetImage(
                              Assets.iconsArrowDown,
                            ),
                            color: AppColor.whiteColor,
                            width: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Image(
                      image: const AssetImage(Assets.logoProfileAppLogo),
                      fit: BoxFit.contain,
                      width: Sizes.screenWidth * 0.25),
                ],
              ),
              const Divider(
                thickness: 0.5,
                color: Color(0xff306E92),
              ),
              // if (homeCon.locationData == null ||
              //     homeCon.locationData!.patientLocation!.name == null)
              //   noServesArea(),
              // if (homeCon.patientHomeModel != null &&
              //     homeCon.locationData != null)
              //   homeCon.patientHomeModel!.data!.appointments!.isEmpty
              //       ?
              //       : docRescheduleScr(
              //           homeCon.patientHomeModel!.data!.appointments![0]),
              getAppbarContentBasedOnCondition(),
              Sizes.spaceHeight3,
            ],
          ),
        ),
      );
    });
  }

  Widget getAppbarContentBasedOnCondition() {
    return Consumer<PatientHomeViewModel>(builder: (context, homeCon, _) {
      if ((homeCon.locationData == null ||
          homeCon.locationData!.patientLocation!.name == null)) {
        return noServesArea();
      } else {
        if (homeCon.patientHomeModel != null && homeCon.locationData != null) {
          if (homeCon.patientHomeModel!.data!.appointments!.isEmpty) {
            return docMainSrc(homeCon.patientHomeModel!.data!.patient);
          } else {
            return docRescheduleScr(
                homeCon.patientHomeModel!.data!.appointments![0]);
          }
        } else {
          return const SizedBox();
        }
      }
    });
  }

  Widget symptomsSection() {
    final homeCon = Provider.of<PatientHomeViewModel>(context);
    final symptomSearchCon = Provider.of<VoiceSymptomSearchViewModel>(context);

    List<Symptom>? symptom = [];
    for (var data in homeCon.patientHomeModel!.data!.symptomsDetails!) {
      symptom.addAll(data.symptom!);
    }
    final dataLen = symptom.length > 5 ? 5 : symptom.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextConst(
          padding: EdgeInsets.only(
            left: Sizes.screenWidth * 0.04,
          ),
          AppLocalizations.of(context)!.choose_symptoms,
          size: Sizes.fontSizeFivePFive,
          fontWeight: FontWeight.w500,
        ),
        commentSpacing,
        Container(
          height: Sizes.screenWidth * 0.27,
          color: Colors.transparent,
          child: ListView.builder(
            addRepaintBoundaries: true,
            clipBehavior: Clip.none,
            shrinkWrap: true,
            itemCount: dataLen + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == dataLen) {
                return Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: Sizes.screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // if (homeCon.noServicesArea) {
                          //   return;
                          // }
                          Navigator.pushNamed(
                              context, RoutesName.allSymptomsScreen);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: Sizes.screenWidth / 5.4,
                          width: Sizes.screenWidth / 5.4,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.blue,
                          ),
                          child: Image.asset(Assets.iconsSymptoms),
                        ),
                      ),
                      Sizes.spaceHeight10,
                      TextConst(
                        textAlign: TextAlign.center,
                        "More",
                        size: Sizes.fontSizeFour * 1.1,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ),
                    ],
                  ),
                );
              }
              final item = symptom[index];
              String? imagePath = LocalImageHelper.instance
                  .getImagePath(item.symptomName ?? "");
              return Container(
                margin: EdgeInsets.only(
                  left: index == 0
                      ? Sizes.screenWidth * 0.04
                      : Sizes.screenWidth * 0.06,
                  right: index == dataLen - 1 ? Sizes.screenWidth * 0.04 : 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // if(homeCon.noServicesArea){return;}

                        symptomSearchCon
                            .toggleSelectedSymptoms(item.symptomName ?? "");
                        Navigator.pushNamed(
                            context, RoutesName.allSymptomsScreen);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: Sizes.screenWidth / 5.4,
                        width: Sizes.screenWidth / 5.4,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.grey,
                            border: symptomSearchCon.selectedSymptoms
                                    .contains(item.symptomName ?? "")
                                ? Border.all(color: AppColor.blue)
                                : null),
                        child: imagePath != null
                            ? Image.file(
                                File(imagePath),
                                height: 55,
                                width: 55,
                                fit: BoxFit.fill,
                              )
                            : const Icon(Icons.image,
                                size: 55, color: Colors.grey),
                      ),
                    ),
                    Sizes.spaceHeight10,
                    TextConst(
                      textAlign: TextAlign.center,
                      item.symptomName ?? "",
                      size: Sizes.fontSizeFour * 1.1,
                      fontWeight: FontWeight.w400,
                      color: AppColor.black,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget topSpecialistNearMe() {
    final homeCon = Provider.of<PatientHomeViewModel>(context).patientHomeModel;
    if (homeCon == null) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextConst(
          padding: EdgeInsets.only(
            left: Sizes.screenWidth * 0.04,
          ),
          AppLocalizations.of(context)!.top_specialist_near_you,
          size: Sizes.fontSizeFivePFive,
          fontWeight: FontWeight.w500,
        ),
        commentSpacing,
        if (homeCon == null || homeCon.data!.doctors!.isEmpty)
          const Center(
            child: NoMessage(
              message: "No Specialists around here,for now....",
              title: "We're working to bring expert care to your area",
            ),
          ),
        if (homeCon != null || homeCon.data!.doctors!.isNotEmpty) ...[
          Container(
            color: Colors.transparent,
            height: homeCon == null || homeCon.data!.doctors!.isEmpty
                ? Sizes.screenHeight * 0
                : Sizes.screenHeight * 0.22,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: homeCon.data!.doctors!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final doctor = homeCon.data!.doctors![index];
                return Container(
                    margin: EdgeInsets.only(
                        right: index == homeCon.data!.doctors!.length - 1
                            ? Sizes.screenWidth * 0.04
                            : 0,
                        left: index == 0
                            ? Sizes.screenWidth * 0.04
                            : Sizes.screenWidth * 0.065),
                    child: DoctorTile(
                      doctor: doctor,
                    ));
              },
            ),
          ),
          commentSpacing,
          Center(
              child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.searchDoctorScreen,
                  arguments: "Specialist");
            },
            child: homeCon == null || homeCon.data!.doctors!.isEmpty
                ? const SizedBox()
                : TextConst(
                    AppLocalizations.of(context)!.view_all,
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w500,
                  ),
          ))
        ]
      ],
    );
  }

  Widget textFields(dynamic borderRadius) {
    final homeCon = Provider.of<PatientHomeViewModel>(context);
    return TextField(
      readOnly: true,
    onTap: () {
     // if (!homeCon.noServicesArea) {
       Navigator.pushNamed(context, RoutesName.searchDoctorScreen,
            arguments: AppLocalizations.of(context)!.search);
     // }
      },
      decoration: InputDecoration(
        constraints: const BoxConstraints(maxHeight: 40),
        hintText: "Search",
        hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: Sizes.fontSizeSix),
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: AppColor.blue,
        ),
        suffixIcon: const Icon(Icons.mic, color: AppColor.blue),
        fillColor: AppColor.grey,
        filled: true,
        contentPadding: const EdgeInsets.only(top: 2, bottom: 2),
      ),
      cursorColor: AppColor.textGrayColor,
    );
  }

  Widget showLocationBottomSheet() {
    return Consumer<PatientHomeViewModel>(builder: (context, homeCon, _) {
      if (homeCon.locationData == null ||
          homeCon.locationData!.locations == null) {
        const SizedBox();
      }
      print("sfff: ${homeCon.searchedLocationData}");
      final locations = homeCon.searchedLocationData.isEmpty
          ? homeCon.locationData!.locations
          : homeCon.searchedLocationData;
      return Container(
        width: Sizes.screenWidth,
        padding: EdgeInsets.only(
            left: Sizes.screenWidth * 0.04,
            right: Sizes.screenWidth * 0.04,
            top: Sizes.screenHeight * 0.04),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
                color: AppColor.black.withOpacity(0.5),
                offset: const Offset(0, 25),
                blurRadius: 3,
                spreadRadius: -10)
          ],
          gradient: AppColor().primaryGradient(
            colors: [AppColor.naviBlue, AppColor.blue],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    Assets.iconsMap,
                    width: Sizes.screenWidth * 0.045,
                  ),
                  Sizes.spaceWidth10,
                  TextConst("Choose your location",
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white),
                ],
              ),
              Sizes.spaceHeight25,
              TextField(
                onChanged: (v) {
                  homeCon.filterQueryBasedLocation(v);
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: Sizes.fontSizeSix),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: const Icon(Icons.mic, color: AppColor.blue),
                  fillColor: AppColor.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 9.0,
                    // horizontal: 11.0,
                  ),
                ),
                cursorColor: AppColor.textGrayColor,
                cursorHeight: 21,
                style: const TextStyle(color: AppColor.blue),
              ),
              Sizes.spaceHeight15,
              Row(
                children: [
                  Image.asset(
                    Assets.iconsCurrentLocaton,
                    width: Sizes.screenWidth * 0.06,
                  ),
                  Sizes.spaceWidth10,
                  TextConst("Use your current location",
                      size: Sizes.fontSizeFourPFive,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white),
                ],
              ),
              Sizes.spaceHeight10,
              const Divider(),
              Sizes.spaceHeight10,
              Builder(builder: (context) {
                return Container(
                  constraints: BoxConstraints(
                      maxHeight: Sizes.screenHeight / 1.8,
                      minHeight: Sizes.screenHeight / 2),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: locations!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: const Image(
                          image: AssetImage(Assets.iconsMap),
                          color: AppColor.white,
                          height: 22,
                        ),
                        title: TextConst(
                          locations[index].name ?? "",
                          size: Sizes.fontSizeFive,
                          fontWeight: FontWeight.w500,
                          color: homeCon.selectedLocationData != null &&
                                  homeCon.selectedLocationData!.name ==
                                      locations[index].name
                              ? AppColor.blue
                              : AppColor.white,
                        ),
                        onTap: () {
                          homeCon.getLocationApi(context,
                              lat: double.parse(locations[index].latitude!),
                              lng: double.parse(locations[index].longitude!));
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      );
    });
  }

  Widget docRescheduleScr(Appointments appointmentData) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Assets.imagesPlusIcons), fit: BoxFit.fitWidth),
      ),
      child: Column(
        children: [
          Sizes.spaceHeight5,
          Row(
            children: [
              TextConst(
                AppLocalizations.of(context)!.upcoming_appointment,
                size: Sizes.fontSizeFivePFive,
                // size: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.white,
              ),
              const Spacer(),
              Image.asset(
                Assets.iconsSolarCalendar,
                color: AppColor.lightBlue,
                height: 18,
              ),
              Sizes.spaceWidth5,
              TextConst(
                DateFormat('d MMM').format(
                    DateTime.parse(appointmentData.bookingDate.toString())),
                size: Sizes.fontSizeFour,
                fontWeight: FontWeight.w400,
                color: AppColor.white,
              ),
              Sizes.spaceWidth10,
              const Icon(
                Icons.watch_later_outlined,
                color: AppColor.lightBlue,
                size: 20,
              ),
              Sizes.spaceWidth5,
              TextConst(
                appointmentData.hour24Format.toString(),
                size: Sizes.fontSizeFour,
                fontWeight: FontWeight.w400,
                color: AppColor.white,
              ),
            ],
          ),
          Sizes.spaceHeight10,
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Column(
                  children: [
                    Container(
                      height: 83,
                      width: 83,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: appointmentData.signedImageUrl != null
                          ? Image.network(
                              appointmentData.signedImageUrl ?? "",
                              height: Sizes.screenHeight * 0.13,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            )
                          : const Image(
                              image: AssetImage(Assets.logoDoctor),
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      height: Sizes.screenHeight * 0.006,
                    ),
                    starRatings(
                        averageRating: double.parse(
                            appointmentData.averageRating.toString()),
                        size: 11),
                    Sizes.spaceHeight3,
                    TextConst(
                      "${appointmentData.reviewCount.toString()}+ Reviews",
                      size: Sizes.fontSizeThree,
                      fontWeight: FontWeight.w400,
                      color: AppColor.white,
                    ),
                  ],
                ),
              ),
              Sizes.spaceWidth15,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextConst(
                    appointmentData.doctorName ?? "",
                    size: Sizes.fontSizeSix,
                    fontWeight: FontWeight.w500,
                    color: AppColor.white,
                  ),
                  Sizes.spaceHeight3,
                  TextConst(
                    "${appointmentData.qualification} (${appointmentData.specializationName})",
                    size: Sizes.fontSizeFivePFive,
                    fontWeight: FontWeight.w400,
                    color: AppColor.white,
                  ),
                  Sizes.spaceHeight3,
                  TextConst(
                    appointmentData.experience ?? "",
                    size: Sizes.fontSizeFour,
                    fontWeight: FontWeight.w400,
                    color: AppColor.white,
                  ),
                  Sizes.spaceHeight15,
                  ProfileBtnConst(
                    title: AppLocalizations.of(context)!.reschedule,
                    fontSize: Sizes.fontSizeFourPFive,
                    onTap: () {
                      Navigator.pushNamed(
                          context, RoutesName.doctorProfileScreen,
                          arguments: {
                            "isNew": false,
                            "doctor_id": appointmentData.doctorId,
                            "clinic_id": "${appointmentData.doctorId}",
                          });
                    },
                    height: Sizes.screenHeight * 0.042,
                    width: Sizes.screenWidth * 0.66,
                    color: AppColor.lightBlue,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget docMainSrc(Patient? patient) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Assets.imagesPlusIcons), fit: BoxFit.fitWidth),
      ),
      child: Column(
        children: [
          Sizes.spaceHeight20,
          TextConst(
            "Welcome, ${patient!.patientName ?? ""}!",
            size: Sizes.fontSizeFourPFive,
            fontWeight: FontWeight.w500,
            color: AppColor.white,
          ),
          TextConst(
            " Together, Let’s AIMSwasthya!",
            size: Sizes.fontSizeFourPFive,
            fontWeight: FontWeight.w500,
            color: AppColor.white,
          ),
          Sizes.spaceHeight20,
          Container(
            width: Sizes.screenWidth,
            alignment: Alignment.center,
            height: Sizes.screenHeight * 0.013,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.lightSkyBlue.withOpacity(0.5),
            ),
            child: Container(
              width: Sizes.screenWidth / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.lightBlue,
              ),
            ),
            // Row(
            //   children: [
            //     Container(
            //       // height: Sizes.screenHeight*0.01,
            //       width: 110,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color: Colors.transparent,
            //       ),
            //     ),
            //
            //     // Container(
            //     //   // height: Sizes.screenHeight*0.018,
            //     //   width: 110,
            //     //   decoration: BoxDecoration(
            //     //     borderRadius: BorderRadius.circular(20),
            //     //     color: Colors.transparent,
            //     //   ),
            //     // ),
            //   ],
            // ),
          ),
          Sizes.spaceHeight25,
          textFields(BorderRadius.circular(20))
        ],
      ),
    );
  }

  Widget noServesArea() {
    return Consumer<PatientHomeViewModel>(builder: (context, homeCon, _) {
      if (homeCon.locationData == null ||
          homeCon.locationData!.patientLocation!.name == null) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.imagesPlusIcons),
                fit: BoxFit.fitWidth),
          ),
          child: Column(
            children: [
              Image.asset(
                Assets.assetsGroupInfo,
                height: Sizes.screenHeight * 0.12,
                width: Sizes.screenWidth * 0.18,
              ),
              // Sizes.spaceHeight5,
              TextConst(
                "We’re not here yet, but we’re on our way",
                size: Sizes.fontSizeSix,
                // size: 16,
                fontWeight: FontWeight.w500,
                color: AppColor.white,
              ),
              TextConst(
                "Good health is coming to your area soon. Stay tuned",
                size: Sizes.fontSizeFour,
                // size: 10,
                fontWeight: FontWeight.w400,
                color: AppColor.white,
              ),
              Sizes.spaceHeight20,
              Container(
                width: Sizes.screenWidth,
                alignment: Alignment.center,
                height: Sizes.screenHeight * 0.013,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor.lightSkyBlue.withOpacity(0.5),
                ),
                child: Container(
                  width: Sizes.screenWidth / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.lightBlue,
                  ),
                ),
                // Row(
                //   children: [
                //     Container(
                //       // height: Sizes.screenHeight*0.01,
                //       width: 110,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(20),
                //         color: Colors.transparent,
                //       ),
                //     ),
                //
                //     // Container(
                //     //   // height: Sizes.screenHeight*0.018,
                //     //   width: 110,
                //     //   decoration: BoxDecoration(
                //     //     borderRadius: BorderRadius.circular(20),
                //     //     color: Colors.transparent,
                //     //   ),
                //     // ),
                //   ],
                // ),
              ),
              Sizes.spaceHeight25,

              textFields(BorderRadius.circular(20))
            ],
          ),
        );
      }
      return const SizedBox();
    });
  }
}
