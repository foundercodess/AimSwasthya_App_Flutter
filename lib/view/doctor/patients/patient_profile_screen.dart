// view/doctor/patients/patient_profile_screen.dart
import 'dart:core';
import 'dart:io';
import 'package:aim_swasthya/local_db/download_image.dart';
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view/doctor/common_nav_bar.dart';
import 'package:aim_swasthya/view/user/symptoms/dowenloade_image.dart';
import 'package:aim_swasthya/view_model/doctor/doc_health_report_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/patient_profile_view_model.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
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
    return Scaffold(
      extendBody: true,
      primary: false,
      backgroundColor: AppColor.white,
      body: patientProfileData.patientProfileModel == null ||
              patientProfileData.loading
          ? const Center(child: LoadData())
          : SingleChildScrollView(
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
                                // ButtonConst(
                                //     title: "Reschedule",
                                //     size: Sizes.fontSizeFour,
                                //     fontWeight: FontWeight.w400,
                                //     borderRadius: 8,
                                //     height: Sizes.screenHeight * 0.038,
                                //     width: Sizes.screenWidth * 0.35,
                                //     color: AppColor.blue,
                                //     onTap: () {
                                //       if (cancelRescheduleAllowed) {
                                //         showCupertinoDialog(
                                //           context: context,
                                //           builder: (_) => ActionOverlay(
                                //             text: "Reschedule Appointment",
                                //             subtext:
                                //             "Are you sure you want to reschedule\n your appointment?",
                                //             onTap: () {
                                //
                                //             },
                                //           ),
                                //         );
                                //       }
                                //       else {
                                //         showInfoOverlay(
                                //             title: "Info",
                                //             errorMessage:
                                //             "Oops! You can't cancellation appointments less than 1 hour before the scheduled time.");
                                //       }
                                //       // Navigator.pushNamed(context, RoutesName.patientProfileScreen);
                                //     }),
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
    final patientProfileData = Provider.of<PatientProfileViewModel>(context);
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
            patientProfileData
                        .patientProfileModel?.patientSymptoms?.isNotEmpty ==
                    true
                ? patientProfileData
                    .patientProfileModel!.patientSymptoms!.first.symptoms!
                    .replaceAll("~", ", ")
                : "No symptoms available",
            size: 12,
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
              vertical: Sizes.screenHeight * 0.015,
            ),
            width: Sizes.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColor.grey,
            ),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: patientProfileData
                      .patientProfileModel!.medicalRecords!.length,
                  itemBuilder: (context, index) {
                    final docData = patientProfileData
                        .patientProfileModel!.medicalRecords![index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0)
                          Column(
                            children: [
                              DottedBorder(
                                color: AppColor.lightBlue,
                                strokeWidth: 1,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(8),
                                dashPattern: const [3, 2],
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4, bottom: 4),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      Assets.imagesMedicalReports,
                                      width: Sizes.screenWidth * 0.09,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: Sizes.screenWidth * 0.02),
                                    TextConst(
                                      "Medical Health Report",
                                      size: Sizes.fontSizeFour,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<DocHealthReportViewModel>(
                                                context,
                                                listen: false)
                                            .medicalHealthReportApi(
                                                patientProfileData
                                                    .patientProfileModel!
                                                    .patientProfile![0]
                                                    .patientId
                                                    .toString());
                                        Navigator.pushNamed(context,
                                            RoutesName.docMedicalReportsScreen);
                                      },
                                      child: TextConst(
                                        "Tap to view",
                                        size: Sizes.fontSizeTwo,
                                        color: AppColor.blue,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],
                          ),
                        reportData(docData),
                      ],
                    );
                  },
                ),
              ],
            ),
          )
        : const Center(child: NoDataMessages());
  }

  Widget reportData(MedicalRecords docData) {
    String imageUrl = docData.imageUrl ?? "";
    String documentName = imageUrl.split('/').last;
    print(documentName); // Output: ffgi.pdf
    return GestureDetector(
        onTap: () async {
          // String imageUrl = "patient/52/medical_record/20250430/ffgi.pdf";
          List<String> parts = imageUrl.split('/');
          parts.removeLast(); // Removes 'ffgi.pdf'
          String directoryPath = parts.join('/') + '/';
          print("rtbnfyuf" +
              directoryPath); // Output: patient/52/medical_record/20250430/
          final userId = await UserViewModel().getUser();
          ImageDownloader()
              .fetchAndDownloadImages(context,
                  folderName: directoryPath,
                  fileNames: documentName,
                  matchName: docData.imageUrl,
                  loopAllowed: false)
              .then((_) {});
          await Future.delayed(const Duration(seconds: 3));
          LocalImageHelper.instance.loadingComplete.then((_) {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (_) {
                  return showImage(docData, documentName);
                });
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.screenWidth * 0.02,
            vertical: Sizes.screenHeight * 0.009,
          ),
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
                      documentName ?? "",
                      size: Sizes.fontSizeFour,
                      fontWeight: FontWeight.w400,
                    ),
                    // TextConst(
                    //   DateFormat('dd/MM/yyyy')
                    //       .format(DateTime.parse("docData.uploadedAt.toString()")),
                    //   size: Sizes.fontSizeThree,
                    //   color: AppColor.black,
                    //   fontWeight: FontWeight.w400,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget showImage(MedicalRecords medRecData, String docName) {
    String? imagePath = LocalImageHelper.instance.getImagePath(docName ?? "");
    print(imagePath);
    if (imagePath == null) {
      return const CircularProgressIndicator();
    }
    if (medRecData.imageUrl!.endsWith('.pdf')) {
      print("pdfcase");
      return Stack(
        children: [
          Container(
            width: Sizes.screenWidth,
            height: Sizes.screenHeight,
            child: imagePath.toLowerCase().endsWith('.pdf')
                ? PDFView(filePath: imagePath)
                : Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(imagePath)),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
          ),
          Positioned(
              top: 40,
              left: 16,
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back, color: Colors.black))),
        ],
      );
    }

    return Stack(
      children: [
        Container(
          width: Sizes.screenWidth,
          height: Sizes.screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(imagePath.toString())),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back, color: Colors.black))),
      ],
    );

    // return Container(
    //   width: Sizes.screenWidth,
    //   height: Sizes.screenHeight,
    //   decoration: BoxDecoration(
    //       image: DecorationImage(image: FileImage(File(imagePath.toString())))),
    // );
  }


  // Widget reportData(MedicalRecords docData, bool isDate) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(
  //         horizontal: Sizes.screenWidth * 0.02,
  //         vertical: Sizes.screenHeight * 0.009),
  //     child: Row(
  //       children: [
  //         Image.asset(
  //           Assets.imagesMedicalReports,
  //           width: Sizes.screenWidth * 0.09,
  //           fit: BoxFit.cover,
  //         ),
  //         SizedBox(width: Sizes.screenWidth * 0.02),
  //         Expanded(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               TextConst(
  //                 docData.documentName ?? "",
  //                 size: Sizes.fontSizeFour,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //               TextConst(
  //                 DateFormat('dd/MM/yyyy').format(DateTime.parse(docData.uploadedAt.toString())),
  //                 size: isDate ? Sizes.fontSizeTwo : Sizes.fontSizeFour,
  //                 color: isDate ? AppColor.blue : null,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  // Widget uploadedRecords() {
  //   final patientProfileData = Provider.of<PatientProfileViewModel>(context);
  //   return patientProfileData.patientProfileModel != null &&
  //           patientProfileData.patientProfileModel!.medicalRecords != null &&
  //           patientProfileData.patientProfileModel!.medicalRecords!.isNotEmpty
  //       ? Container(
  //           margin: const EdgeInsets.all(12),
  //           padding: EdgeInsets.symmetric(
  //               horizontal: Sizes.screenWidth * 0.035,
  //               vertical: Sizes.screenHeight * 0.015),
  //           width: Sizes.screenWidth,
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(12), color: AppColor.grey),
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 child: ListView.builder(
  //                   shrinkWrap: true,
  //                   padding: const EdgeInsets.all(0),
  //                   physics: const NeverScrollableScrollPhysics(),
  //                   itemCount: patientProfileData
  //                       .patientProfileModel!.medicalRecords!.length,
  //                   itemBuilder: (context, index) {
  //                     final docData = patientProfileData
  //                         .patientProfileModel!.medicalRecords![index];
  //                     return index == 0
  //                         ? DottedBorder(
  //                             color: AppColor.lightBlue,
  //                             strokeWidth: 1,
  //                             borderType: BorderType.RRect,
  //                             radius: const Radius.circular(8),
  //                             dashPattern: const [3, 2],
  //                             padding: EdgeInsets.zero,
  //                             child:Row(
  //                               children: [
  //                                 TextConst(
  //                                   "Medical Health Report",
  //                                   size: Sizes.fontSizeFour,
  //                                   fontWeight: FontWeight.w400,
  //                                 ),
  //                                 Spacer(),
  //                                 TextConst(
  //                                   "Tap to view",
  //                                   size: Sizes.fontSizeFour,
  //                                   color: AppColor.textGrayColor,
  //                                   fontWeight: FontWeight.w400,
  //                                 ),
  //                               ],
  //                             )
  //                             // reportData(docData, true),
  //                           )
  //                         : reportData(docData, true);
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         )
  //       : const Center(child: NoDataMessages());
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
