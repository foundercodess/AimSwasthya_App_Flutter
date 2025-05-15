import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:aim_swasthya/view_model/doctor/doc_update_appointment_view_model.dart';
import 'package:aim_swasthya/view_model/user/cancelAppointment_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../res/common_material.dart';
import '../../../view_model/doctor/doc_health_report_view_model.dart';

class DocMedicalReportsScreen extends StatefulWidget {
  const DocMedicalReportsScreen({super.key});

  @override
  State<DocMedicalReportsScreen> createState() =>
      _DocMedicalReportsScreenState();
}

final List<Map<String, String>> bloodGroupList = [
  {"title": "Blood group", "value": "A+"},
  {"title": "Allergies", "value": "B-"},
  {"title": "Current medication", "value": "O+"},
  {"title": "Chronic illnesses", "value": "AB+"},
  {"title": "Lifestyle habits", "value": "A-"},
];

class _DocMedicalReportsScreenState extends State<DocMedicalReportsScreen> {
  @override
  Widget build(BuildContext context) {
    // final medData = Provider.of<DocHealthReportViewModel>(context);
    final medData = Provider.of<DocHealthReportViewModel>(context);
    final medicalHealthList =
        medData.medicalHealthReportModel?.medicalHealth ?? [];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBarConstant(
              context,
              paddingAllowed: true,
              isBottomAllowed: true,
              child: Center(
                child: TextConst(
                  "Medical Health Report",
                  size: Sizes.fontSizeSix * 1.07,
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

            ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: medicalHealthList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = medicalHealthList[index];
                final Map<String, dynamic> itemMap = item.toJson();
                return Column(
                  children: itemMap.entries.map((entry) {
                    // final title = entry.key
                    //     .replaceAll('_', ' ')
                    //     .toUpperCase(); // e.g. BLOOD GROUP
                    final title = entry.key
                        .replaceAll('_', ' ')
                        .toUpperCase(); // e.g. BLOOD GROUP
                    final value = (entry.value ?? '').toString().isEmpty
                        ? 'N/A'
                        : entry.value.toString();

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Sizes.screenHeight * 0.01,
                          left: Sizes.screenWidth * 0.04,
                          bottom: Sizes.screenHeight * 0.02,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextConst(
                              title,
                              size: Sizes.fontSizeFour,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffD2D2D2),
                            ),
                            SizedBox(height: Sizes.screenHeight * 0.004),
                            TextConst(
                              value,
                              size: Sizes.fontSizeFour,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff595959),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            // ListView.builder(
            //       padding: const EdgeInsets.all(15),
            //       itemCount: medData.medicalHealthReportModel!.medicalHealth!.length,
            //       shrinkWrap: true,
            //       physics: const NeverScrollableScrollPhysics(),
            //       itemBuilder: (context, index) {
            //         final item = medData.medicalHealthReportModel!.medicalHealth![index];
            //         return Column(
            //           children: [
            //             Container(
            //               padding: EdgeInsets.only(
            //                 top: Sizes.screenHeight * 0.01,
            //                 left: Sizes.screenWidth * 0.04,
            //                 bottom: Sizes.screenHeight * 0.02,
            //               ),
            //               width: double.infinity,
            //               decoration: BoxDecoration(
            //                 color: AppColor.grey,
            //                 borderRadius: BorderRadius.circular(12),
            //               ),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   TextConst(
            //                     item. ?? "",
            //                     size: Sizes.fontSizeFour,
            //                     fontWeight: FontWeight.w400,
            //                     color: const Color(0xffD2D2D2),
            //                   ),
            //                   SizedBox(height: Sizes.screenHeight * 0.004),
            //                   TextConst(
            //                     item["value"] ?? "",
            //                     size: Sizes.fontSizeFour,
            //                     fontWeight: FontWeight.w400,
            //                     color: const Color(0xff595959),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Sizes.spaceHeight15,
            //           ],
            //         );
            //       },
            //     )
          ],
        ),
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
    final isRescheduled =
        patientAppointmentData.status!.toLowerCase() == "reschduled";
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
                      ),
                      Sizes.spaceHeight30,
                      TextConst(
                        patientAppointmentData.patientName ?? "",
                        size: Sizes.fontSizeSix,
                        fontWeight: FontWeight.w500,
                      ),
                      Sizes.spaceHeight10,
                      TextConst(
                        "Date of birth : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(patientAppointmentData.dateOfBirth.toString()))}",
                        size: Sizes.fontSizeFour,
                        fontWeight: FontWeight.w400,
                      ),
                      Sizes.spaceHeight5,
                      TextConst(
                        "Weight : ${patientAppointmentData.weight}",
                        size: Sizes.fontSizeFour,
                        fontWeight: FontWeight.w400,
                      ),
                      Sizes.spaceHeight5,
                      TextConst(
                        "Height : ${patientAppointmentData.height}",
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
                                if (!isRescheduled && !isCancelled)
                                  ButtonConst(
                                      title: "Reschedule",
                                      size: Sizes.fontSizeTwo,
                                      fontWeight: FontWeight.w400,
                                      borderRadius: 8,
                                      height: Sizes.screenHeight * 0.031,
                                      width: Sizes.screenWidth * 0.23,
                                      color: AppColor.blue,
                                      onTap: () {
                                        if (cancelRescheduleAllowed) {
                                          showCupertinoDialog(
                                            context: context,
                                            builder: (_) => ActionOverlay(
                                              text: "Reschedule Appointment",
                                              subtext:
                                                  "Are you sure you want to reschedule\n your appointment?",
                                              onTap: () {
                                                Provider.of<CancelAppointmentViewModel>(
                                                        context,
                                                        listen: false)
                                                    .cancelAppointmentApi(
                                                        status: 'reschduled',
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
                                                  "Oops! You can't reschedule appointments less than 1 hour before the scheduled time.");
                                        }
                                        // Navigator.pop(context);
                                      }),
                                if (isCancelled || isRescheduled) ...[
                                  Sizes.spaceWidth5,
                                  Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: Sizes.screenHeight * 0.06,
                                      child: TextConst(
                                        isCancelled
                                            ? "Cancelled"
                                            : "Rescheduled",
                                        color: Colors.grey,
                                        size: Sizes.fontSizeFour,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                                Sizes.spaceWidth10,
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
      DateTime bookingDateTime =
          DateFormat("dd-MM-yyyy hh:mm a").parse(dateTimeString);

      // Compare with current time
      Duration difference = bookingDateTime.difference(DateTime.now());
      return difference.inMinutes > 60;
    } catch (e) {
      print("Error in date comparison: $e");
      return false;
    }
  }
}
