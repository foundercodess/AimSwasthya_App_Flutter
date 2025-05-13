// view/doctor/patients/my_appointments.dart
// import 'package:aim_swasthya/res/appbar_const.dart';
// import 'package:aim_swasthya/res/common_material.dart';
// import 'package:aim_swasthya/res/user_button_const.dart';
// import 'package:aim_swasthya/utils/routes/routes_name.dart';
// import 'package:aim_swasthya/view_model/doctor/doc_schedule_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class MyAppointments extends StatefulWidget {
//   const MyAppointments({super.key});
//
//   @override
//   State<MyAppointments> createState() => _MyAppointmentsState();
// }
//
// class _MyAppointmentsState extends State<MyAppointments> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.white,
//       body: Column(
//         children: [],
//       ),
//       // body: SingleChildScrollView(
//       //   child: Column(
//       //     crossAxisAlignment: CrossAxisAlignment.start,
//       //     children: [
//             appBarConstant(
//               context,
//               child: Center(
//                 child: TextConst(
//                   "My Patient",
//                   size: Sizes.fontSizeSix*1.1,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               isBottomAllowed: true,
//             ),
//             Sizes.spaceHeight20,
//             TextConst(
//               padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
//               "Active patients",
//               size: Sizes.fontSizeFourPFive,
//               fontWeight: FontWeight.w500,
//               color: AppColor.textfieldTextColor,
//             ),
//       //       Sizes.spaceHeight20,
//       //       activeAppointmentSec(),
//       //       Sizes.spaceHeight25,
//       //       TextConst(
//       //         "Past history",
//       //         padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
//       //         size: Sizes.fontSizeFourPFive,
//       //         fontWeight: FontWeight.w500,
//       //         color: AppColor.textfieldTextColor,
//       //       ),
//       //       Sizes.spaceHeight20,
//       //       pastAppointmentHistory(),
//       //       Sizes.spaceHeight30,
//       //       // Sizes.spaceHeight30,
//       //       // Sizes.spaceHeight30,
//       //     ],
//       //   ),
//       // ),
//     );
//   }
//   //
//   // Widget activeAppointmentSec() {
//   //   final scheduleCon = Provider.of<ScheduleViewModel>(context);
//   //   return SizedBox(
//   //     height: Sizes.screenHeight * 0.16,
//   //     child: ListView.builder(
//   //         padding: const EdgeInsets.all(0),
//   //         shrinkWrap: true,
//   //         itemCount: scheduleCon.scheduleList.length,
//   //         scrollDirection: Axis.horizontal,
//   //         itemBuilder: (context, index) {
//   //           final schedule = scheduleCon.scheduleList[index];
//   //           return Container(
//   //             margin: EdgeInsets.only(
//   //                 left: index == 0
//   //                     ? Sizes.screenWidth * 0.06
//   //                     : Sizes.screenWidth * 0.03,
//   //                 right: index == scheduleCon.scheduleList.length - 1
//   //                     ? Sizes.screenWidth * 0.04
//   //                     : 0),
//   //             padding: EdgeInsets.only(
//   //               right: Sizes.screenWidth * 0.02,
//   //             ),
//   //             decoration: BoxDecoration(
//   //                 borderRadius: BorderRadius.circular(20),
//   //                 color: AppColor.grey.withOpacity(0.8)),
//   //             child: Column(
//   //               children: [
//   //                 Row(
//   //                   children: [
//   //                     Container(
//   //                       height: Sizes.screenHeight * 0.16,
//   //                       width: Sizes.screenWidth / 3.7,
//   //                       decoration: BoxDecoration(
//   //                           borderRadius: const BorderRadius.only(
//   //                             topLeft: Radius.circular(20),
//   //                             bottomLeft: Radius.circular(20),
//   //                           ),
//   //                           image: DecorationImage(
//   //                               image: AssetImage(schedule["image"]),
//   //                               fit: BoxFit.fitHeight)),
//   //                     ),
//   //                     Sizes.spaceWidth10,
//   //                     Column(
//   //                       mainAxisAlignment: MainAxisAlignment.center,
//   //                       mainAxisSize: MainAxisSize.min,
//   //                       crossAxisAlignment: CrossAxisAlignment.start,
//   //                       children: [
//   //                         Sizes.spaceHeight20,
//   //                         TextConst(
//   //                           schedule["name"],
//   //                           size: Sizes.fontSizeFourPFive,
//   //                           fontWeight: FontWeight.w400,
//   //                         ),
//   //                         Sizes.spaceHeight3,
//   //                         Row(
//   //                           children: [
//   //                             Image.asset(
//   //                               schedule["clnImg"],
//   //                               // height: 16,
//   //                               width: Sizes.screenWidth * 0.04,
//   //                             ),
//   //                             Sizes.spaceWidth3,
//   //                             TextConst(
//   //                               schedule["day"],
//   //                               size: Sizes.fontSizeThree,
//   //                               fontWeight: FontWeight.w500,
//   //                               color: Color(0xff535353),
//   //                             ),
//   //                             Sizes.spaceWidth5,
//   //                             Image.asset(
//   //                               schedule["clockImg"],
//   //                               // height: 16,
//   //                               width: Sizes.screenWidth * 0.045,
//   //                             ),
//   //                             Sizes.spaceWidth3,
//   //                             TextConst(
//   //                               schedule["time"],
//   //                               size: Sizes.fontSizeThree,
//   //                               fontWeight: FontWeight.w500,
//   //                               color: Color(0xff535353),
//   //                             ),
//   //                           ],
//   //                         ),
//   //                         Sizes.spaceHeight20,
//   //                         ButtonConst(
//   //                             title: "View",
//   //                             size: Sizes.fontSizeFour,
//   //                             fontWeight: FontWeight.w400,
//   //                             borderRadius: 5,
//   //                             height: Sizes.screenHeight * 0.038,
//   //                             width: Sizes.screenWidth * 0.33,
//   //                             color: AppColor.blue,
//   //                             onTap: () {
//   //                               Navigator.pushNamed(
//   //                                   context, RoutesName.patientProfileScreen);
//   //                             })
//   //                       ],
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ],
//   //             ),
//   //           );
//   //         }),
//   //   );
//   // }
//   //
//   // Widget pastAppointmentHistory() {
//   //   final scheduleCon = Provider.of<ScheduleViewModel>(context);
//   //   return SizedBox(
//   //     child: ListView.builder(
//   //         physics: const NeverScrollableScrollPhysics(),
//   //         padding: const EdgeInsets.all(0),
//   //         shrinkWrap: true,
//   //         itemCount: 4,
//   //         scrollDirection: Axis.vertical,
//   //         itemBuilder: (context, index) {
//   //           final schedule = scheduleCon.scheduleList[index];
//   //           return Container(
//   //             margin: EdgeInsets.only(bottom: Sizes.screenHeight * 0.03),
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //               children: [
//   //                 Container(
//   //                   margin: EdgeInsets.only(
//   //                     left: Sizes.screenWidth * 0.07,
//   //                   ),
//   //                   padding: EdgeInsets.only(
//   //                       left: Sizes.screenWidth * 0.026,
//   //                       right: Sizes.screenWidth * 0.037,
//   //                       top: Sizes.screenHeight * 0.006,
//   //                       bottom: Sizes.screenHeight * 0.01),
//   //                   decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(15),
//   //                       // color: Colors.grey.shade100
//   //                       color: AppColor.grey.withOpacity(0.8)
//   //                   ),
//   //                   child: Column(
//   //                     children: [
//   //                       Row(
//   //                         children: [
//   //                           Container(
//   //                             height: Sizes.screenHeight * 0.067,
//   //                             width: Sizes.screenWidth * 0.167,
//   //                             decoration: const BoxDecoration(
//   //                                 shape: BoxShape.circle,
//   //                                 color: AppColor.lightBlue),
//   //                             child: Center(
//   //                               child: TextConst(
//   //                                 "K",
//   //                                 size: Sizes.fontSizeTen,
//   //                                 fontWeight: FontWeight.w700,
//   //                                 color: AppColor.white,
//   //                               ),
//   //                             ),
//   //                           ),
//   //                           Sizes.spaceWidth10,
//   //                           Container(
//   //                             alignment: Alignment.bottomCenter,
//   //                             child: Column(
//   //                               crossAxisAlignment: CrossAxisAlignment.start,
//   //                               // mainAxisSize: MainAxisSize.min,
//   //                               children: [
//   //                                 // Sizes.spaceHeight3,
//   //                                 TextConst(
//   //                                   schedule["name"],
//   //                                   // size: 12,
//   //                                   size: Sizes.fontSizeFourPFive,
//   //                                   fontWeight: FontWeight.w400,
//   //                                 ),
//   //                                 Sizes.spaceHeight3,
//   //                                 Row(
//   //                                   children: [
//   //                                     Image.asset(
//   //                                       schedule["clnImg"],
//   //                                       // height: 16,
//   //                                       width: Sizes.screenWidth * 0.035,
//   //                                     ),
//   //                                     Sizes.spaceWidth5,
//   //                                     TextConst(
//   //                                       schedule["day"],
//   //                                       size: Sizes.fontSizeThree,
//   //                                       fontWeight: FontWeight.w500,
//   //                                       color: Color(0xff535353),
//   //                                     ),
//   //                                     Sizes.spaceWidth5,
//   //                                     Image.asset(
//   //                                       schedule["clockImg"],
//   //                                       // height: 16,
//   //                                       width: Sizes.screenWidth * 0.04,
//   //                                     ),
//   //                                     Sizes.spaceWidth5,
//   //                                     TextConst(
//   //                                       schedule["time"],
//   //                                       size: Sizes.fontSizeThree,
//   //                                       fontWeight: FontWeight.w500,
//   //                                       color: Color(0xff535353),
//   //                                     ),
//   //                                   ],
//   //                                 ),
//   //                                 Sizes.spaceHeight5,
//   //                                 ButtonConst(
//   //                                     title: "View",
//   //                                     size: Sizes.fontSizeFour,
//   //                                     fontWeight: FontWeight.w400,
//   //                                     borderRadius: 5,
//   //                                     height: Sizes.screenHeight * 0.029,
//   //                                     width: Sizes.screenWidth * 0.37,
//   //                                     color: AppColor.blue,
//   //                                     onTap: () {})
//   //                               ],
//   //                             ),
//   //                           ),
//   //                         ],
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //                 Container(
//   //                   margin: EdgeInsets.only(right: Sizes.screenWidth * 0.07),
//   //                   padding: EdgeInsets.symmetric(
//   //                       horizontal: Sizes.screenWidth * 0.053,
//   //                       vertical: Sizes.screenHeight * 0.032),
//   //                   decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(15),
//   //                       color: AppColor.grey.withOpacity(0.8)),
//   //                   child: const Icon(
//   //                     Icons.call,
//   //                     color: AppColor.lightBlue,
//   //                     size: 23,
//   //                   ),
//   //                 ),
//   //
//   //               ],
//   //             ),
//   //
//   //           );
//   //         }),
//   //
//   //   );
//   // }
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view_model/doctor/doc_update_appointment_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/patient_profile_view_model.dart';
import 'package:aim_swasthya/view_model/user/bottom_nav_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:url_launcher/url_launcher.dart';
import '../../../res/common_material.dart';
import '../../../res/popUp_const.dart';
import '../../../utils/show_server_error.dart';
import '../../../view_model/user/cancelAppointment_view_model.dart';
import '../../../view_model/user/update_appointment_view_model.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  // int selectedIndex = 0;
  // void toggleSelection(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //   });
  // }
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
    final appointmentCon = Provider.of<DocPatientAppointmentViewModel>(context);

    final bottomCon = Provider.of<BottomNavProvider>(context);
    return appointmentCon.docPatientAppointmentModel == null ||
            appointmentCon.loading
        ? const Center(child: LoadData())
        : Scaffold(
            extendBody: true,
            primary: false,
            body: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBarConstant(
                  context,
                  onTap: () {
                    if (bottomCon.currentIndex == 2) {
                      bottomCon.setIndex(0);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Center(
                    child: TextConst(
                      "Appointments",
                      size: Sizes.fontSizeSix * 1.1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  isBottomAllowed: true,
                ),
                Sizes.spaceHeight20,
                TextConst(
                  padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
                  "Active appointments",
                  size: Sizes.fontSizeFourPFive,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textfieldTextColor,
                ),
                Sizes.spaceHeight20,
                activeAppointment(),
                Sizes.spaceHeight30,
                TextConst(
                  "Past history",
                  padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
                  size: Sizes.fontSizeFourPFive,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textfieldTextColor,
                ),
                Sizes.spaceHeight20,
                pastAppointment(),
                Sizes.spaceHeight30,
                const SizedBox(
                  height: kBottomNavigationBarHeight,
                )
              ],
            )),
            // bottomNavigationBar: Container(
            //   height: 90,
            //   width: Sizes.screenWidth,
            //   color: Colors.transparent,
            //   child: const DocComBottomNevBar(),
            // ),
          );
  }

  Widget activeAppointment({
    bool isCancelAllowed = true,
  }) {
    final appointmentCon = Provider.of<DocPatientAppointmentViewModel>(context);
    return appointmentCon.docPatientAppointmentModel != null &&
            appointmentCon
                .docPatientAppointmentModel!.activeAppointments!.isNotEmpty
        ? SizedBox(
            height: Sizes.screenHeight * 0.2,
            child: ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: appointmentCon
                    .docPatientAppointmentModel!.activeAppointments!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final appointmentData = appointmentCon
                      .docPatientAppointmentModel!.activeAppointments![index];
                  print("udysue${appointmentData.status}");
                  final cancelRescheduleAllowed = isMoreThanOneHourAway(
                      appointmentData.appointmentDate.toString(),
                      appointmentData.appointmentTime.toString());
                  final isCancelled =
                      appointmentData.status!.toLowerCase() == "cancelled";
                  final isRescheduled =
                      appointmentData.status!.toLowerCase() == "reschduled";
                  return Container(
                    margin: EdgeInsets.only(
                        left: index == 0
                            ? Sizes.screenWidth * 0.05
                            : Sizes.screenWidth * 0,
                        right: Sizes.screenWidth * .03),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.grey.withOpacity(0.5)),
                    child: Row(
                      children: [
                        Container(
                          width: Sizes.screenWidth / 5,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              image: DecorationImage(
                                  // doctor.signedImageUrl != null
                                  //     ? Image.network(
                                  //   doctor.signedImageUrl!,
                                  //   height: Sizes.screenHeight * 0.13,
                                  //   width: double.infinity,
                                  //   fit: BoxFit.cover,
                                  //   alignment: Alignment.topCenter,
                                  // )
                                  //     : Image(
                                  //   image: const AssetImage(Assets.logoDoctor),
                                  //   height: Sizes.screenHeight * 0.13,
                                  //   width:double.infinity,
                                  //   fit: BoxFit.fill,
                                  //   alignment: Alignment.topCenter,
                                  // ),
                                  image: appointmentData.signedImageUrl != null
                                      ? NetworkImage(
                                          appointmentData.signedImageUrl!)
                                      : const AssetImage(Assets.logoDoctor),
                                  // image: AssetImage(Assets.imagesPatientImage),
                                  fit: BoxFit.cover)),
                        ),
                        Sizes.spaceWidth10,
                        SizedBox(
                          width: Sizes.screenWidth / 2.44,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Sizes.screenHeight * 0.012,
                                    right: Sizes.screenWidth * 0.03),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      Assets.iconsSolarCalendar,
                                      width: Sizes.screenWidth * 0.035,
                                    ),
                                    Sizes.spaceWidth3,
                                    TextConst(
                                      DateFormat('d MMM').format(DateTime.parse(
                                          appointmentData.appointmentDate
                                              .toString())),
                                      size: Sizes.fontSizeTwo,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    Sizes.spaceWidth3,
                                    Image.asset(
                                      Assets.iconsMdiClock,
                                      width: Sizes.screenWidth * 0.04,
                                    ),
                                    Sizes.spaceWidth3,
                                    TextConst(
                                      appointmentData.appointmentTime
                                          .toString(),
                                      size: Sizes.fontSizeTwo,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              Sizes.spaceHeight10,
                              TextConst(
                                appointmentData.patientName ?? "",
                                size: Sizes.fontSizeFive,
                                fontWeight: FontWeight.w500,
                              ),
                              Sizes.spaceHeight5,
                              TextConst(
                                "Date of birth : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(appointmentData.dateOfBirth.toString()))}",
                                size: Sizes.fontSizeThree,
                                fontWeight: FontWeight.w400,
                              ),
                              Sizes.spaceHeight5,
                              TextConst(
                                "Weight : ${appointmentData.weight.toString()}",
                                size: Sizes.fontSizeThree,
                                fontWeight: FontWeight.w400,
                              ),
                              Sizes.spaceHeight5,
                              TextConst(
                                "Height : ${appointmentData.height.toString()}",
                                size: Sizes.fontSizeThree,
                                fontWeight: FontWeight.w400,
                              ),
                              // Sizes.spaceHeight5,
                              Row(
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
                                                          appointmentData
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
                                  // if ( isScheduled)
                                  //   Center(
                                  //     child: TextConst(
                                  //       "scheduled",
                                  //       color: Colors.grey,
                                  //       size: Sizes.fontSizeFive,
                                  //       fontWeight: FontWeight.w500,
                                  //     ),
                                  //   ),
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

                                  Sizes.spaceWidth5,
                                  if (isCancelAllowed && !isCancelled)
                                    Center(
                                      child: GestureDetector(
                                          child: SizedBox(
                                        height: Sizes.screenHeight * 0.06,
                                        child: TextButton(
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
                                                              isDoctorCancel:
                                                                  true,
                                                              context,
                                                              appointmentData
                                                                  .appointmentId
                                                                  .toString());
                                                    },
                                                  ),
                                                );
                                              } else {
                                                showInfoOverlay(
                                                    title: "Info",
                                                    errorMessage:
                                                        "Oops! You can't cancellation appointments less than 1 hour before the scheduled time.");
                                              }
                                            },
                                            child: TextConst(
                                              "Cancel",
                                              size: Sizes.fontSizeFour,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.red,
                                            )),
                                      )),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          )
        : const Center(child: NoDataMessages());
  }

  Widget pastAppointment() {
    final appointmentCon = Provider.of<DocPatientAppointmentViewModel>(context);
    final patientProfileData = Provider.of<PatientProfileViewModel>(context);
    return appointmentCon.docPatientAppointmentModel != null &&
            appointmentCon.docPatientAppointmentModel!.pastAppointments !=
                null &&
            appointmentCon
                .docPatientAppointmentModel!.pastAppointments!.isNotEmpty
        ? SizedBox(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: appointmentCon
                    .docPatientAppointmentModel!.pastAppointments!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final scheduleData = appointmentCon
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
                                        scheduleData.patientName!
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Sizes.spaceHeight3,
                                        TextConst(
                                          scheduleData.name ?? "",
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
                                              DateFormat('d MMM').format(
                                                  DateTime.parse(scheduleData
                                                      .appointmentDate
                                                      .toString())),
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
                                              scheduleData.appointmentTime
                                                  .toString(),
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
                                              appointmentCon
                                                  .setDoctorsAppointmentsData(
                                                      scheduleData);
                                              patientProfileData
                                                  .patientProfileApi(
                                                      scheduleData.patientId
                                                          .toString(),
                                                      context);
                                              Navigator.pushNamed(
                                                  context,
                                                  RoutesName
                                                      .patientProfileScreen);
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
                          onTap: () {
                            final phone = scheduleData.phoneNumber.toString();
                            if (phone.isNotEmpty) {
                              launchDialer(phone);
                            } else {
                              print("No phone number available.");
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: Sizes.screenWidth * 0.07),
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
          )
        : const Center(
            child: NoDataMessages(
            message: "No past Appointment yet",
          ));
  }

  void launchDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  bool isMoreThanOneHourAway(String bookingDate, String hour24Format) {
    // Combine date and time
    String dateTimeString = "$bookingDate $hour24Format";

    // Parse using the correct format
    DateFormat format = DateFormat("yyyy-MM-dd hh:mm a");
    DateTime bookingDateTime = format.parse(dateTimeString);

    // Get current time
    DateTime now = DateTime.now();

    // Calculate difference
    Duration difference = bookingDateTime.difference(now);

    // Return true if more than 1 hour away
    return difference.inMinutes > 60;
  }
}
