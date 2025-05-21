// view/doctor/patients/show_all_patient.dart
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view_model/doctor/doc_schedule_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_update_appointment_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/patient_profile_view_model.dart';
import 'package:aim_swasthya/view_model/user/bottom_nav_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowAllPatient extends StatefulWidget {
  const ShowAllPatient({super.key});

  @override
  State<ShowAllPatient> createState() => _ShowAllPatientState();
}

class _ShowAllPatientState extends State<ShowAllPatient> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DocPatientAppointmentViewModel>(context, listen: false)
          .docPatientAppointmentApi();
    });
  }
  @override
  Widget build(BuildContext context) {
    final bottomCon = Provider.of<BottomNavProvider>(context);
    final patientappCon = Provider.of<DocPatientAppointmentViewModel>(context);

    return  Scaffold(
      backgroundColor: AppColor.white,
      body:patientappCon.docPatientAppointmentModel ==null|| patientappCon.loading
          ? const Center(child: LoadData()) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBarConstant(
              context,
              onTap: () {
                if (bottomCon.currentIndex == 1) {
                  bottomCon.setIndex(0);
                } else {
                  Navigator.pop(context);
                }
              },
              child: Center(
                child: TextConst(
                  "My Patient",
                  size: Sizes.fontSizeSix * 1.1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              isBottomAllowed: true,
            ),
            Sizes.spaceHeight20,
            TextConst(
              padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
              "Active patients",
              size: Sizes.fontSizeFourPFive,
              fontWeight: FontWeight.w500,
              color: AppColor.textfieldTextColor,
            ),
            Sizes.spaceHeight20,
            activePatientSec(),
            Sizes.spaceHeight25,
            TextConst(
              "Past history",
              padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
              size: Sizes.fontSizeFourPFive,
              fontWeight: FontWeight.w500,
              color: AppColor.textfieldTextColor,
            ),
            Sizes.spaceHeight20,
            pastHistory(),
            Sizes.spaceHeight30,
            Sizes.spaceHeight30,
            Sizes.spaceHeight30,
          ],
        ),
      ),
    );
  }

  Widget activePatientSec() {
    final patientProfileData = Provider.of<PatientProfileViewModel>(context);
    final patientappCon = Provider.of<DocPatientAppointmentViewModel>(context);
    return patientappCon.docPatientAppointmentModel != null &&
            patientappCon
                .docPatientAppointmentModel!.activeAppointments!.isNotEmpty
        ? SizedBox(
            height: Sizes.screenHeight * 0.16,
            child: ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: patientappCon
                    .docPatientAppointmentModel!.activeAppointments!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final schedule = patientappCon
                      .docPatientAppointmentModel!.activeAppointments![index];
                  return Container(
                    margin: EdgeInsets.only(
                        left: index == 0
                            ? Sizes.screenWidth * 0.06
                            : Sizes.screenWidth * 0.03,
                        right: index ==
                                patientappCon.docPatientAppointmentModel!
                                        .activeAppointments!.length -
                                    1
                            ? Sizes.screenWidth * 0.04
                            : 0),
                    padding: EdgeInsets.only(
                      right: Sizes.screenWidth * 0.02,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.grey.withOpacity(0.8)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: Sizes.screenHeight * 0.16,
                              width: Sizes.screenWidth / 3.7,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  image: DecorationImage(
                                      image: schedule.signedImageUrl == null
                                          ? NetworkImage(
                                              schedule.signedImageUrl!)
                                          : const AssetImage(
                                              Assets.logoDoctor),
                                      fit: BoxFit.fitHeight)),
                            ),
                            Sizes.spaceWidth10,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Sizes.spaceHeight20,
                                TextConst(
                                  schedule.patientName ?? "",
                                  size: Sizes.fontSizeFourPFive,
                                  fontWeight: FontWeight.w400,
                                ),
                                Sizes.spaceHeight3,
                                Row(
                                  children: [
                                    Image.asset(
                                      Assets.iconsSolarCalendar,
                                      // height: 16,
                                      width: Sizes.screenWidth * 0.04,
                                    ),
                                    Sizes.spaceWidth3,
                                    TextConst(
                                      DateFormat('d MMM').format(DateTime.parse(
                                          schedule.appointmentDate.toString())),
                                      size: Sizes.fontSizeThree,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff535353),
                                    ),
                                    Sizes.spaceWidth5,
                                    Image.asset(
                                      Assets.iconsMdiClock,
                                      // height: 16,
                                      width: Sizes.screenWidth * 0.045,
                                    ),
                                    Sizes.spaceWidth3,
                                    TextConst(
                                      schedule.appointmentTime.toString(),
                                      size: Sizes.fontSizeThree,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff535353),
                                    ),
                                  ],
                                ),
                                Sizes.spaceHeight20,
                                ButtonConst(
                                    title: "View",
                                    size: Sizes.fontSizeFour,
                                    fontWeight: FontWeight.w400,
                                    borderRadius: 5,
                                    height: Sizes.screenHeight * 0.038,
                                    width: Sizes.screenWidth * 0.33,
                                    color: AppColor.blue,
                                    onTap: () {
                                      patientappCon.setDoctorsAppointmentsData(schedule);
                                        patientProfileData.patientProfileApi(schedule.patientId.toString(),schedule.appointmentId.toString(), context);
                                        Navigator.pushNamed(context,
                                            RoutesName.patientProfileScreen);
                                      // patientProfileData.patientProfileApi(schedule.patientId.toString(),context);
                                      // Navigator.pushNamed(context,
                                      //     RoutesName.patientProfileScreen,);
                                    })
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          )
        : const Center(child: NoDataMessages());
  }

  Widget pastHistory() {
    final patientappCon = Provider.of<DocPatientAppointmentViewModel>(context);
    final patientProfileData = Provider.of<PatientProfileViewModel>(context);

    return patientappCon.docPatientAppointmentModel != null &&
        patientappCon.docPatientAppointmentModel!.pastAppointments !=
            null &&
        patientappCon
            .docPatientAppointmentModel!.pastAppointments!.isNotEmpty
        ? SizedBox(
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: patientappCon
              .docPatientAppointmentModel!.pastAppointments!.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final patientData = patientappCon
                .docPatientAppointmentModel!.pastAppointments![index];
            return Container(
              margin: EdgeInsets.only(bottom: Sizes.screenHeight * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: Sizes.screenWidth * 0.07,
                    ),
                    padding: EdgeInsets.only(
                        left: Sizes.screenWidth * 0.026,
                        right: Sizes.screenWidth * 0.037,
                        top: Sizes.screenHeight * 0.006,
                        bottom: Sizes.screenHeight * 0.01),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // color: Colors.grey.shade100
                        color: AppColor.grey.withOpacity(0.8)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: Sizes.screenHeight * 0.067,
                              width: Sizes.screenWidth * 0.167,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.lightBlue),
                              child: Center(
                                child: TextConst(
                                  patientData.patientName!
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  size: Sizes.fontSizeTen,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                            Sizes.spaceWidth10,
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Sizes.spaceHeight3,
                                  TextConst(
                                    patientData.patientName??"",
                                    // size: 12,
                                    size: Sizes.fontSizeFourPFive,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  Sizes.spaceHeight3,
                                  Row(
                                    children: [
                                      Image.asset(
                                        Assets.iconsSolarCalendar,
                                        // height: 16,
                                        width: Sizes.screenWidth * 0.035,
                                      ),
                                      Sizes.spaceWidth5,
                                      TextConst(
                                          DateFormat('d MMM').format(DateTime.parse(
                                              patientData.appointmentDate.toString())),
                                        size: Sizes.fontSizeThree,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff535353),
                                      ),
                                      Sizes.spaceWidth5,
                                      Image.asset(
                                        Assets.iconsMdiClock,
                                        // height: 16,
                                        width: Sizes.screenWidth * 0.04,
                                      ),
                                      Sizes.spaceWidth5,
                                      TextConst(
                                        patientData.appointmentTime.toString(),
                                        size: Sizes.fontSizeThree,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff535353),
                                      ),
                                    ],
                                  ),
                                  Sizes.spaceHeight5,
                                  ButtonConst(
                                      title: "View",
                                      size: Sizes.fontSizeFour,
                                      fontWeight: FontWeight.w400,
                                      borderRadius: 5,
                                      height: Sizes.screenHeight * 0.029,
                                      width: Sizes.screenWidth * 0.37,
                                      color: AppColor.blue,
                                      onTap: () {
                                        patientappCon.setDoctorsAppointmentsData(patientData);
                                        patientProfileData.patientProfileApi(patientData.patientId.toString(),patientData.appointmentId.toString(), context);
                                        Navigator.pushNamed(context,
                                            RoutesName.patientProfileScreen);
                                      })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      final phone = patientData.phoneNumber.toString();
                      if (phone.isNotEmpty) {
                        launchDialer(phone);
                      } else {
                        print("No phone number available.");
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: Sizes.screenWidth * 0.07),
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.screenWidth * 0.053,
                          vertical: Sizes.screenHeight * 0.032),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColor.grey.withOpacity(0.8)),
                      child: const Icon(
                        Icons.call,
                        color: AppColor.lightBlue,
                        size: 23,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    ) :const Center(
        child: NoDataMessages(
          message: "No past Appointment yet",
        ));
  }
}

void launchDialer(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not launch $phoneUri';
  }
}

// void launchDialer(dynamic phoneNumber) async {
//   if (phoneNumber == null) {
//     print('Phone number is null');
//     return;
//   }
//
//   final String phone = phoneNumber.toString().trim();
//
//   if (phone.isEmpty) {
//     print('Phone number is empty');
//     return;
//   }
//
//   final Uri phoneUri = Uri(scheme: 'tel', path: phone);
//
//   if (await canLaunchUrl(phoneUri)) {
//     await launchUrl(phoneUri);
//   } else {
//     throw 'Could not launch dialer for $phone';
//   }
// }