// view/doctor/patients/patient_profile_screen.dart
import 'dart:core';
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/view/doctor/common_nav_bar.dart';
import 'package:aim_swasthya/view_model/doctor/patient_profile_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../model/doctor/patient_profile_model.dart';
import '../../../res/popUp_const.dart' show ActionOverlay;
import '../../../utils/show_server_error.dart';
import '../../../view_model/doctor/doc_update_appointment_view_model.dart';
import '../../../view_model/user/cancelAppointment_view_model.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final patientProfileData = Provider.of<PatientProfileViewModel>(context);
    return patientProfileData.patientProfileModel == null ||
            patientProfileData.loading
        ? const Center(child: LoadData())
        : Scaffold(
            extendBody: true,
            primary: false,
            backgroundColor: AppColor.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBarConstant(
                    context,
                    isBottomAllowed: true,
                    child: Center(
                      child: TextConst(
                        "Patient profile",
                        size: Sizes.fontSizeSix * 1.1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Sizes.spaceHeight30,
                  TextConst(
                    padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
                    "General information",
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w400,
                  ),
                  Sizes.spaceHeight15,
                  patientProfile(),
                  Sizes.spaceHeight20,
                  TextConst(
                    padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
                    "Symptoms",
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w400,
                  ),
                  Sizes.spaceHeight15,
                  symptomsSec(),
                  Sizes.spaceHeight20,
                  TextConst(
                    padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
                    "Medical records",
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w400,
                  ),
                  Sizes.spaceHeight5,
                  uploadedRecords(),
                  SizedBox(
                    height: Sizes.screenHeight * 0.06,
                  ),
                  const SizedBox(
                    height: kBottomNavigationBarHeight,
                  )
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 70,
              width: Sizes.screenWidth,
              color: Colors.transparent,
              child: const DocComBottomNevBar(),
            ),
          );
  }

  Widget patientProfile({bool isCancelAllowed = true}) {
    final patientAppointmentData =
        Provider.of<DocPatientAppointmentViewModel>(context)
            .doctorsAppointmentsDataModel;
    final cancelRescheduleAllowed = isMoreThanOneHourAway(
        patientAppointmentData!.appointmentDate.toString(),
        patientAppointmentData.appointmentTime.toString());
    final isCancelled =
        patientAppointmentData.status!.toLowerCase() == "cancelled";
    print("status ${patientAppointmentData.status}");
    return patientAppointmentData != null
        ? Container(
            margin: EdgeInsets.only(
                left: Sizes.screenWidth * 0.04,
                right: Sizes.screenWidth * 0.05),
            width: Sizes.screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.grey.withOpacity(0.5)),
            child: Row(
              children: [
                Container(
                  height: Sizes.screenHeight * 0.275,
                  width: Sizes.screenWidth / 3.5,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      image: DecorationImage(
                          image: patientAppointmentData.signedImageUrl != null
                              ? NetworkImage(
                                  patientAppointmentData.signedImageUrl!)
                              : const AssetImage(Assets.logoDoctor),
                          fit: BoxFit.fitHeight)),

                ),
                Sizes.spaceWidth15,
                SizedBox(
                  width: Sizes.screenWidth / 1.8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: Sizes.screenHeight * 0.01,
                            right: Sizes.screenWidth * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              Assets.iconsSolarCalendar,
                              width: Sizes.screenWidth * 0.05,
                            ),
                            Sizes.spaceWidth5,
                            TextConst(
                              DateFormat('d MMM').format(DateTime.parse(
                                  patientAppointmentData.appointmentDate
                                      .toString())),
                              size: Sizes.fontSizeFour,
                              fontWeight: FontWeight.w400,
                            ),
                            Sizes.spaceWidth5,
                            Image.asset(
                              Assets.iconsMdiClock,
                              width: Sizes.screenWidth * 0.055,
                            ),
                            Sizes.spaceWidth5,
                            TextConst(
                              patientAppointmentData.appointmentTime.toString(),
                              size: Sizes.fontSizeFour,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                      Sizes.spaceHeight30,
                      TextConst(
                        patientAppointmentData.patientName ?? "",
                        size: Sizes.fontSizeSix,
                        fontWeight: FontWeight.w500,
                      ),
                      Sizes.spaceHeight10,
                      TextConst(
                        // "Date of birth : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(patientProfileData.patientProfileModel!.patientProfile![0].dateOfBirth.toString()))}",
                        "Date of birth : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(patientAppointmentData.dateOfBirth.toString()))}",
                        size: Sizes.fontSizeFour,
                        fontWeight: FontWeight.w400,
                      ),
                      Sizes.spaceHeight5,
                      TextConst(
                        // "Weight : ${patientProfileData.patientProfileModel!.patientProfile![0].weight}",
                        "Weight : ${patientAppointmentData.weight}",
                        size: Sizes.fontSizeFour,
                        fontWeight: FontWeight.w400,
                      ),
                      Sizes.spaceHeight5,
                      TextConst(
                        "Height : ${patientAppointmentData.height}",
                        // "Height : ${patientProfileData.patientProfileModel!.patientProfile![0].height}",
                        size: Sizes.fontSizeFour,
                        fontWeight: FontWeight.w400,
                      ),
                      Sizes.spaceHeight15,
                      isCancelled
                          ? SizedBox(
                              height: Sizes.screenHeight * 0.06,
                              child: TextConst(
                                "Cancelled",
                                color: Colors.grey,
                                size: Sizes.fontSizeFour,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Row(
                              children: [
                                ButtonConst(
                                    title: "Reschedule",
                                    size: Sizes.fontSizeFour,
                                    fontWeight: FontWeight.w400,
                                    borderRadius: 8,
                                    height: Sizes.screenHeight * 0.038,
                                    width: Sizes.screenWidth * 0.35,
                                    color: AppColor.blue,
                                    onTap: () {
                                      // Navigator.pushNamed(context, RoutesName.patientProfileScreen);
                                    }),
                                Sizes.spaceWidth10,
                                // if (isCancelAllowed && !isCancelled)
                                //   Center(
                                //     child: GestureDetector(
                                //       onTap: () {
                                //         if (cancelRescheduleAllowed) {
                                //           showCupertinoDialog(
                                //             context: context,
                                //             builder: (_) => ActionOverlay(
                                //               text: "Cancel Appointment",
                                //               subtext:
                                //               "Are you sure you want to cancel\n your appointment?",
                                //               onTap: () {
                                //                 Provider.of<CancelAppointmentViewModel>(
                                //                     context,
                                //                     listen: false)
                                //                     .cancelAppointmentApi(
                                //                     context,
                                //                     appointmentData.appointmentId
                                //                         .toString());
                                //               },
                                //             ),
                                //           );
                                //         } else {
                                //           showInfoOverlay(
                                //               title: "Info",
                                //               errorMessage:
                                //               "Oops! You can’t cancellation appointments less than 1 hour before the scheduled time.");
                                //         }
                                //       },
                                //       child: TextConst(
                                //         "Cancel",
                                //         color: Colors.red,
                                //         size: Sizes.fontSizeFive,
                                //         fontWeight: FontWeight.w500,
                                //       ),
                                //     ),
                                //   ),
                                // if (isCancelled)
                                //   Center(
                                //     child: TextConst(
                                //       "Cancelled",
                                //       color: Colors.grey,
                                //       size: Sizes.fontSizeFive,
                                //       fontWeight: FontWeight.w500,
                                //     ),
                                //   ),
                                if (isCancelAllowed && !isCancelled)
                                  TextButton(
                                    onPressed: () {
                                      if (cancelRescheduleAllowed) {
                                        showCupertinoDialog(
                                          context: context,
                                          builder: (_) => ActionOverlay(
                                            text: "Cancel Appointment",
                                            subtext:
                                                "Are you sure you want to cancel\n your appointment?",
                                            onTap: () {
                                              Provider.of<CancelAppointmentViewModel>(
                                                      context,
                                                      listen: false)
                                                  .cancelAppointmentApi(
                                                      isDoctorCancel: true,
                                                      context,
                                                      patientAppointmentData
                                                          .appointmentId
                                                          .toString());
                                            },
                                          ),
                                        );
                                      } else {
                                        showInfoOverlay(
                                            title: "Info",
                                            errorMessage:
                                                "Oops! You can’t cancellation appointments less than 1 hour before the scheduled time.");
                                      }
                                    },
                                    child: TextConst(
                                      "Cancel",
                                      size: Sizes.fontSizeFour,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.red,
                                    )),
                                if (isCancelled)
                                  Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: Sizes.screenHeight * 0.06,
                                      child: TextConst(
                                        "Cancelled",
                                        color: Colors.grey,
                                        size: Sizes.fontSizeFour,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                      Sizes.spaceHeight5,
                      Sizes.spaceHeight3,
                    ],
                  ),

                ),

              ],
            ),
          )
        : const SizedBox();

  }



  Widget symptomsSec() {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(
        horizontal: Sizes.screenWidth * 0.04,
      ),
      height: Sizes.screenHeight * 0.19,
      width: Sizes.screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: AppColor.grey),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xffF8F8F8),
        ),
        height: Sizes.screenHeight * 0.2,
        width: Sizes.screenWidth,
        child: Center(
          child: TextConst(
            "Chest pain, High blood pressure, and Fatigue",
            size: 12,
            // size: Sizes.fontSizeFour,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget uploadedRecords() {
    final patientProfileData = Provider.of<PatientProfileViewModel>(context);
    return patientProfileData.patientProfileModel != null &&
            patientProfileData.patientProfileModel!.medicalRecords != null &&
            patientProfileData.patientProfileModel!.medicalRecords!.isNotEmpty
        ? Container(
            margin: const EdgeInsets.all(12),
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.screenWidth * 0.035,
                vertical: Sizes.screenHeight * 0.015),
            width: Sizes.screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: AppColor.grey),
            child: Column(
              children: [
                SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: patientProfileData
                        .patientProfileModel!.medicalRecords!.length,
                    itemBuilder: (context, index) {
                      final docData = patientProfileData
                          .patientProfileModel!.medicalRecords![index];
                      return index == 0
                          ? DottedBorder(
                              color: AppColor.lightBlue,
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(8),
                              dashPattern: const [3, 2],
                              padding: EdgeInsets.zero,
                              child: reportData(docData, true),
                            )
                          : reportData(docData, false);
                    },
                  ),
                ),
              ],
            ),
          )
        : const Center(child: NoDataMessages());
  }

  Widget reportData(MedicalRecords docData, bool isDate) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.02,
          vertical: Sizes.screenHeight * 0.009),
      child: Row(
        children: [
          Image.asset(
            Assets.imagesMedicalReports,
            width: Sizes.screenWidth * 0.09,
            fit: BoxFit.cover,
          ),
          SizedBox(width: Sizes.screenWidth * 0.02),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextConst(
                  docData.documentName ?? "",
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                ),

                isDate == 0
                    ? TextConst(
                        DateFormat('dd/MM/yyyy').format(
                            DateTime.parse(docData.uploadedAt.toString())),
                        size: Sizes.fontSizeTwo,
                        color: AppColor.blue,
                        fontWeight: FontWeight.w400,
                      )
                    : TextConst(
                        "Tap to view",
                        size: Sizes.fontSizeFour,
                        color: AppColor.textGrayColor,
                        fontWeight: FontWeight.w400,
                      ),
                // TextConst(
                //   DateFormat('dd/MM/yyyy').format(DateTime.parse(docData.uploadedAt.toString())),
                //   size: isDate ? Sizes.fontSizeTwo : Sizes.fontSizeFour,
                //   color: isDate ? AppColor.blue : null,
                //   fontWeight: FontWeight.w400,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // bool isMoreThanOneHourAway(String bookingDate, String hour24Format) {
  //   print(bookingDate);
  //   print(hour24Format);
  //   // Combine date and time
  //   String dateTimeString = "$bookingDate $hour24Format";
  //
  //   // Parse using the correct format
  //   // DateFormat format = DateFormat("dd-MM-yyyy hh:mm a");
  //   DateFormat format = DateFormat("yyyy-MM-dd hh:mm a");
  //   DateTime bookingDateTime = format.parse(dateTimeString);
  //
  //   // Get current time
  //   DateTime now = DateTime.now();
  //
  //   // Calculate difference
  //   Duration difference = bookingDateTime.difference(now);
  //
  //   // Return true if more than 1 hour away
  //   return difference.inMinutes > 60;
  // }
  bool isMoreThanOneHourAway(String bookingDate, String hour24Format) {
    try {
      // Try parsing bookingDate in multiple known formats
      DateTime parsedDate;
      try {
        parsedDate = DateFormat("yyyy-MM-dd").parse(bookingDate);
      } catch (_) {
        try {
          parsedDate = DateFormat("dd-MM-yyyy").parse(bookingDate);
        } catch (_) {
          try {
            parsedDate = DateFormat("MM/dd/yyyy").parse(bookingDate);
          } catch (e) {
            print("Date parsing failed: $e");
            return false;
          }
        }
      }

      // Convert to standard format: dd-MM-yyyy
      String formattedDate = DateFormat("dd-MM-yyyy").format(parsedDate);

      // Combine with time
      String dateTimeString = "$formattedDate $hour24Format";

      // Parse combined string using standard format
      DateTime bookingDateTime = DateFormat("dd-MM-yyyy hh:mm a").parse(dateTimeString);

      // Compare with current time
      Duration difference = bookingDateTime.difference(DateTime.now());
      return difference.inMinutes > 60;

    } catch (e) {
      print("Error in date comparison: $e");
      return false;
    }
  }
}
