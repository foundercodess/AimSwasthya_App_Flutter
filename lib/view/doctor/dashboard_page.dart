// view/doctor/dashboard_page.dart
import 'package:aim_swasthya/res/border_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:aim_swasthya/view_model/doctor/doc_home_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doctor_profile_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/revenue_doctor_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../view_model/user/cancelAppointment_view_model.dart';

class DoctorDashboardScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const DoctorDashboardScreen({
    super.key,
    this.scaffoldKey,
  });

  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DoctorHomeViewModel>(context, listen: false)
          .doctorHomeApi(context);
      Provider.of<DoctorProfileViewModel>(context, listen: false)
          .doctorProfileApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final docHomeCon = Provider.of<DoctorHomeViewModel>(context);
    return docHomeCon.doctorHomeModel == null || docHomeCon.loading
        ? const Center(child: LoadData())
        : RefreshIndicator(
            color: AppColor.blue,
            onRefresh: () async {
              Provider.of<DoctorHomeViewModel>(context, listen: false)
                  .doctorHomeApi(context);
            },
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBarContainer(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Sizes.spaceHeight20,
                          TextConst(
                            padding:
                                EdgeInsets.only(left: Sizes.screenWidth * 0.04),
                            AppLocalizations.of(context)!.upcoming_appointment,
                            size: Sizes.fontSizeFive,
                            fontWeight: FontWeight.w500,
                            // size: 14,
                          ),
                          Sizes.spaceHeight15,
                          seeSchedule(),
                          Sizes.spaceHeight20,
                          TextConst(
                            padding:
                                EdgeInsets.only(left: Sizes.screenWidth * 0.04),
                            AppLocalizations.of(context)!.dash_board,
                            size: Sizes.fontSizeFive,
                            fontWeight: FontWeight.w500,
                          ),
                          Sizes.spaceHeight15,
                          Container(
                            height: Sizes.screenHeight / 2.65,
                            padding: EdgeInsets.only(
                              left: Sizes.screenWidth * 0.04,
                              right: Sizes.screenWidth * 0.03,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    dashSchedule(),
                                    // Sizes.spaceHeight5,
                                    dashProfile()
                                  ],
                                ),
                                appointmentSection()
                              ],
                            ),
                          ),
                          Sizes.spaceHeight15,
                          TextConst(
                            padding:
                                EdgeInsets.only(left: Sizes.screenWidth * 0.04),
                            AppLocalizations.of(context)!.your_earnings,
                            size: Sizes.fontSizeFive,
                            fontWeight: FontWeight.w500,
                          ),
                          Sizes.spaceHeight15,
                          earningDetails(),
                          SizedBox(
                            height: Sizes.screenHeight * 0.13,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget appBarContainer() {
    // final profileCon =
    //     Provider.of<DoctorProfileViewModel>(context).doctorProfileModel;
    // return profileCon!= null && profileCon.data!.doctors!.isNotEmpty
    //     ?
    final docHomeCon =
        Provider.of<DoctorHomeViewModel>(context).doctorHomeModel;
    return docHomeCon != null && docHomeCon.data!.doctors!.isNotEmpty
        ? Container(
            padding: EdgeInsets.only(top: Sizes.screenHeight * 0.015),
            width: Sizes.screenWidth,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              gradient: LinearGradient(
                colors: [AppColor.naviBlue, AppColor.blue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Sizes.spaceHeight30,
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.screenWidth * 0.03),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (widget.scaffoldKey!.currentState != null) {
                            if (widget
                                .scaffoldKey!.currentState!.isDrawerOpen) {
                              widget.scaffoldKey!.currentState!.closeDrawer();
                            } else {
                              widget.scaffoldKey!.currentState!.openDrawer();
                            }
                          } else {
                            print("ScaffoldState is null!");
                          }
                        },
                        child: Image.asset(
                          Assets.iconsProfileIcon,
                          height: 22,
                          width: 22,
                        ),
                      ),
                      Sizes.spaceWidth10,
                      TextConst(
                        "Welcome ${docHomeCon.data!.doctors![0].doctorName ?? ""}!",
                        size: Sizes.fontSizeFive,
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.notificationScreen);
                          },
                          child: Image(
                            image: const AssetImage(Assets.iconsWellIcon),
                            height: Sizes.screenHeight * 0.025,
                          ))
                    ],
                  ),
                ),
                const Divider(
                  endIndent: 12,
                  indent: 12,
                  thickness: 0.2,
                ),
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.imagesPlusIcons),
                          fit: BoxFit.cover)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        ),
                        child: docHomeCon.data!.doctors![0].signedImageUrl !=
                                null
                            ? Image.network(
                                docHomeCon.data!.doctors![0].signedImageUrl ??
                                    "",
                                height: Sizes.screenHeight * 0.155,
                                width: Sizes.screenWidth * 0.4,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              )
                            : Image(
                                image: const AssetImage(Assets.logoDoctor),
                                height: Sizes.screenHeight * 0.155,
                                width: Sizes.screenWidth * 0.4,
                                fit: BoxFit.fitWidth,
                              ),
                      ),
                      Sizes.spaceWidth10,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextConst(
                            docHomeCon.data!.doctors![0].experience ??
                                "5 years Experience",
                            size: Sizes.fontSizeFour,
                            fontWeight: FontWeight.w400,
                            color: AppColor.white,
                          ),
                          Sizes.spaceHeight5,
                          TextConst(
                            docHomeCon.data!.doctors![0].doctorName ?? "",
                            // "Dr. Vikram Batra",
                            // size: 18,
                            size: Sizes.fontSizeSix,
                            fontWeight: FontWeight.w500,
                            color: AppColor.white,
                          ),
                          TextConst(
                            '${docHomeCon.data!.doctors![0].qualification ?? ''} '
                            '(${docHomeCon.data!.doctors![0].specializationName ?? "MBBS, MD (Cardiology)"})',
                            size: Sizes.fontSizeFivePFive,
                            fontWeight: FontWeight.w400,
                            color: AppColor.white,
                          ),
                          Sizes.spaceHeight10,
                          Row(
                            children: [
                              Image(
                                image: const AssetImage(
                                  Assets.iconsReward,
                                ),
                                width: Sizes.screenWidth * 0.06,
                                fit: BoxFit.cover,
                              ),
                              Sizes.spaceWidth5,
                              Sizes.spaceWidth3,
                              docHomeCon.data!.doctors![0].topRated
                                          .toUpperCase() ==
                                      "Y"
                                  ? proContainer(
                                      AppColor.lightGreen, 'Top choice')
                                  : const SizedBox(),
                              Sizes.spaceWidth10,
                              docHomeCon.data!.doctors![0].mostBooked
                                          .toUpperCase() ==
                                      "Y"
                                  ? proContainer(
                                      AppColor.conLightBlue, 'Most booked')
                                  : const SizedBox(),
                            ],
                          ),
                          Sizes.spaceHeight10,
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        : const Center(child: Center(child: SizedBox()));
  }

  Widget proContainer(
    Color color,
    dynamic label,
  ) {
    return Container(
      padding: const EdgeInsets.only(left: 4, right: 5, top: 3, bottom: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: Row(
        children: [
          Image(
            image: const AssetImage(Assets.iconsCheck),
            width: Sizes.screenWidth * 0.035,
            fit: BoxFit.fill,
          ),
          Sizes.spaceWidth3,
          TextConst(
            label,
            size: Sizes.fontSizeTwo,
            fontWeight: FontWeight.w700,
            color: AppColor.white,
          )
        ],
      ),
    );
  }

  Widget seeSchedule() {
    final docHomeCon = Provider.of<DoctorHomeViewModel>(context);
    return docHomeCon.doctorHomeModel != null &&
            docHomeCon.doctorHomeModel!.data!.appointments!.isNotEmpty
        ? SizedBox(
            height: Sizes.screenHeight * 0.1,
            child: ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount:
                    docHomeCon.doctorHomeModel!.data!.appointments!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final schedule =
                      docHomeCon.doctorHomeModel!.data!.appointments![index];
                  print("udysue${schedule.status}");
                  final cancelRescheduleAllowed = isMoreThanOneHourAway(
                      schedule.appointmentDate.toString(),
                      schedule.appointmentTime.toString());
                  final isCancelled =
                      schedule.status!.toLowerCase() == "cancelled";
                  final isRescheduled =
                      schedule.status!.toLowerCase() == "reschduled";
                  return Container(
                    margin: EdgeInsets.only(
                      left: index == 0
                          ? Sizes.screenWidth * 0.06
                          : Sizes.screenWidth * 0.03,
                      right: index == 1 ? Sizes.screenWidth * 0.03 : 0,
                    ),
                    padding: EdgeInsets.only(
                        left: Sizes.screenWidth * 0.02,
                        right: Sizes.screenWidth * 0.04,
                        top: Sizes.screenHeight * 0.01,
                        bottom: Sizes.screenHeight * 0.01),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.docProfileColor.withOpacity(0.5)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: Sizes.screenHeight * 0.073,
                              width: Sizes.screenHeight * 0.073,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: schedule.signInImageUrl != null
                                      ? NetworkImage(schedule.signInImageUrl)
                                      : const AssetImage(Assets.logoDoctor),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Sizes.spaceWidth5,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextConst(
                                  schedule.patientName ?? "",
                                  // size: 12,
                                  size: Sizes.fontSizeFour * 1.09,
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
                                    Sizes.spaceWidth5,
                                    TextConst(
                                      DateFormat('d MMM').format(DateTime.parse(
                                          schedule.appointmentDate.toString())),
                                      size: Sizes.fontSizeThree * 1.0,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff535353),
                                    ),
                                    Sizes.spaceWidth5,
                                    Image.asset(
                                      Assets.iconsMdiClock,
                                      // height: 16,
                                      width: Sizes.screenWidth * 0.041,
                                    ),
                                    Sizes.spaceWidth5,
                                    TextConst(
                                      schedule.appointmentTime.toString(),
                                      size: Sizes.fontSizeThree,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff535353),
                                    ),
                                  ],
                                ),
                                Sizes.spaceHeight5,
                                if (!isRescheduled && !isCancelled)
                                  ButtonConst(
                                    title: "Reschedule",
                                    size: Sizes.fontSizeThree * 1.05,
                                    fontWeight: FontWeight.w400,
                                    borderRadius: 7,
                                    height: Sizes.screenHeight * 0.026,
                                    width: Sizes.screenWidth * 0.33,
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
                                                      schedule.appointmentId
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
                                    },
                                  ),
                                if (isCancelled || isRescheduled) ...[
                                  Sizes.spaceWidth5,
                                  Center(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 4),
                                      alignment: Alignment.center,
                                      // height: Sizes.screenHeight * 0.06,
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
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }))
        : const Center(
            child: NoDataMessages(),
          );
  }

  Widget dashSchedule() {
    // final docScheduleCon = Provider.of<ScheduleDoctorViewModel>(context);
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, RoutesName.scheduleScreen);
        Navigator.pushNamed(context, RoutesName.scheduleScreen);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.screenWidth * 0.0,
            vertical: Sizes.screenHeight * 0.025),
        width: Sizes.screenWidth * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.blue,
        ),
        child: Column(
          children: [
            Image.asset(
              Assets.iconsCalendar,
              width: Sizes.screenWidth * 0.1,
              fit: BoxFit.fill,
              color: AppColor.lightBlue,
            ),
            // Sizes.spaceHeight3,
            TextConst(
              AppLocalizations.of(context)!.schedule,
              // size: 12,
              size: Sizes.fontSizeFourPFive,
              fontWeight: FontWeight.w500,
              color: AppColor.white,
            ),
            Sizes.spaceHeight3,
            TextConst(
              AppLocalizations.of(context)!.manage_your_appointments,
              size: Sizes.fontSizeThree,
              fontWeight: FontWeight.w400,
              color: AppColor.white.withOpacity(0.7),
            ),
            TextConst(
              AppLocalizations.of(context)!.and_schedule,
              size: Sizes.fontSizeThree,
              fontWeight: FontWeight.w400,
              color: AppColor.white.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashProfile() {
    final docProfileCon = Provider.of<DoctorProfileViewModel>(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.userDocProfilePage);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.screenWidth * 0.02,
            vertical: Sizes.screenHeight * 0.02),
        height: Sizes.screenHeight * 0.218,
        width: Sizes.screenWidth * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [AppColor.blue, AppColor.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextConst(
              AppLocalizations.of(context)!.profile,
              size: Sizes.fontSizeFourPFive,
              fontWeight: FontWeight.w500,
              color: AppColor.white,
            ),
            Sizes.spaceHeight10,
            TextConst(
              AppLocalizations.of(context)!.edit_personal_information,
              size: Sizes.fontSizeThree,
              fontWeight: FontWeight.w400,
              color: const Color(0xffD0D0D0),
            ),
            TextConst(
              AppLocalizations.of(context)!.and_clinic_details,
              size: Sizes.fontSizeThree,
              fontWeight: FontWeight.w400,
              color: const Color(0xffD0D0D0),
            )
          ],
        ),
      ),
    );
  }

  Widget appointmentSection() {
    final docHomeCon =
        Provider.of<DoctorHomeViewModel>(context).doctorHomeModel;
    final todayAppointments = docHomeCon!.data!.appointments!.where((item) {
      final apptDate = DateTime.parse(item.appointmentDate.toString());
      final now = DateTime.now();
      return apptDate.year == now.year &&
          apptDate.month == now.month &&
          apptDate.day == now.day;
    }).toList();
    return Container(
      clipBehavior: Clip.none,
      width: Sizes.screenWidth / 1.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.textfieldGrayColor.withOpacity(0.3),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          todayAppointments.isEmpty
              ? Center(
                  child: TextConst(
                    "No Today Appointment",
                    size: Sizes.fontSizeFour,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                )
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 15, left: 4, right: 5),
                  itemCount: todayAppointments.length,
                  itemBuilder: (context, index) {
                    final item = todayAppointments[index];
                    return Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: index == 0
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.center,
                          children: [
                            Sizes.spaceWidth5,
                            Container(
                              height: Sizes.screenHeight * 0.054,
                              width: Sizes.screenWidth / 2.9,
                              padding: const EdgeInsets.only(
                                left: 3,
                                top: 2,
                                bottom: 2,
                                right: 3,
                              ),
                              decoration: BoxDecoration(
                                  color: AppColor.lightSkyBlue.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Sizes.spaceHeight3,
                                  TextConst(
                                    item.patientName ?? "",
                                    size: Sizes.fontSizeFour,
                                    // size: Sizes.fontSizeThree,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Sizes.spaceHeight5,
                                  // Sizes.spaceHeight3,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            Assets.iconsSolarCalendar,
                                            width: Sizes.screenWidth / 30,
                                          ),
                                          Sizes.spaceWidth3,
                                          TextConst(
                                            DateFormat('d MMM').format(
                                                DateTime.parse(item
                                                    .appointmentDate
                                                    .toString())),
                                            size: Sizes.fontSizeThree,
                                            // size: Sizes.fontSizeThree,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff535353),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            Assets.iconsMdiClock,
                                            width: Sizes.screenWidth / 30,
                                          ),
                                          Sizes.spaceWidth3,
                                          TextConst(
                                            item.appointmentTime.toString(),
                                            size: Sizes.fontSizeThree,
                                            // size: Sizes.fontSizeThree,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff535353),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            if (index == 0) ...[
                              Sizes.spaceWidth3,
                              Container(
                                height: Sizes.screenHeight * 0.054,
                                width: Sizes.screenWidth * 0.06,
                                // alignment: Alignment.center,
                                // decoration: BoxDecoration(
                                //     color:
                                //         AppColor.lightSkyBlue.withOpacity(0.5),
                                //     borderRadius: BorderRadius.circular(5)),
                                // child: TextConst(
                                //   "+1",
                                // ),
                              )
                            ]
                          ],
                        ),
                        Positioned(
                          top: 1,
                          left: -1,
                          child: SizedBox(
                            width: Sizes.screenWidth / 7.6,
                            child: Column(
                              children: [
                                TextConst(
                                  item.appointmentTime.toString(),
                                  size: Sizes.fontSizeThree,
                                ),
                                if (item.status != null && item.status != 0)
                                  item.status == 1
                                      ? appContainer(Colors.green, "Completed")
                                      : appContainer(const Color(0xff0A2A5B),
                                          "In progress")
                              ],
                            ),
                          ),
                        ),
                        if (item.status == 2)
                          Positioned(
                            bottom: 6,
                            child: SizedBox(
                              width: Sizes.screenWidth / 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(28, (index) {
                                  if (index == 0) {
                                    return Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          Assets.iconsPlaySound,
                                          height: 8,
                                          color: const Color(0xff0A2A5B)
                                              .withOpacity(0.8),
                                        ),
                                        // Icon(Icons.play_arrow,size: 10,
                                        //     color:Color(0xff0A2A5B)),
                                        Container(
                                          width: 4,
                                          height: 1,
                                          color: const Color(0xff0A2A5B)
                                              .withOpacity(0.8),
                                        )
                                      ],
                                    );
                                  } else {
                                    return Container(
                                      width: 4,
                                      height: 1,
                                      color: const Color(0xff0A2A5B)
                                          .withOpacity(0.8),
                                    );
                                  }
                                }),
                              ),
                            ),
                          )
                      ],
                    );
                    //   ListTile(
                    //   title: Text(item["name"]),
                    //   subtitle: Text("${item["date"]} • ${item["time"]}"),
                    //   trailing: Icon(
                    //     item["status"] == 1 ? Icons.check_circle : Icons.cancel,
                    //     color: item["status"] == 1 ? Colors.green : Colors.red,
                    //   ),
                    // );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
          Positioned(
              top: -9.5,
              child: Container(
                padding:
                    const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(5)),
                child: TextConst(
                  AppLocalizations.of(context)!.today_appointments,
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff2F2F2F),
                ),
              ))
        ],
      ),
    );
  }

  Widget earningDetails() {
    final docHomeCon = Provider.of<DoctorHomeViewModel>(context);
    return SizedBox(
      height: Sizes.screenHeight * 0.193,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          BorderContainer(
            margin: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.04),
            padding: const EdgeInsets.all(1),
            radius: 10,
            gradient: LinearGradient(
              colors: [const Color(0xff9FC1EF), AppColor.blue.withOpacity(0.7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            child: Container(
              height: Sizes.screenHeight * 0.17,
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.screenWidth * 0.04,
                  vertical: Sizes.screenHeight * 0.01),
              width: Sizes.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffC9E0FF),
                    Color(0xffCAECFF),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                // color: AppColor.lightSkyBlue
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextConst(
                        AppLocalizations.of(context)!.net_revenue,
                        size: Sizes.fontSizeFour,
                        fontWeight: FontWeight.w400,
                      ),
                      const Spacer(),
                      TextConst(
                        docHomeCon.selectedMonth,
                        size: Sizes.fontSizeFour,
                        fontWeight: FontWeight.w400,
                        color: AppColor.textfieldTextColor,
                      ),
                      Sizes.spaceWidth5,
                      GestureDetector(
                        onTapDown: (TapDownDetails details) async {
                          final selected = await showMenu<Map<String, String>>(
                            context: context,
                            position: RelativeRect.fromLTRB(
                              details.globalPosition.dx,
                              details.globalPosition.dy,
                              details.globalPosition.dx,
                              details.globalPosition.dy,
                            ),
                            items: docHomeCon.doctorHomeModel!.data!.earnings!
                                .map(
                                  (month) => PopupMenuItem<Map<String, String>>(
                                    value: {
                                      'monthYear': month.monthYear ?? '',
                                      'totalAmount': month.totalamountformatted
                                              ?.toString() ??
                                          '0',
                                    },
                                    child: Text(month.monthYear ?? ""),
                                  ),
                                )
                                .toList(),
                          );
                          if (selected != null) {
                            docHomeCon.setSelectedMonthAndAmount(
                              selected['monthYear']!,
                              selected['totalAmount']!,
                            );
                          }
                        },
                        child: Image.asset(
                          Assets.iconsArrowDown,
                          width: Sizes.screenWidth * 0.05,
                          color: AppColor.textfieldTextColor,
                        ),
                      )
                    ],
                  ),
                  // Sizes.spaceHeight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.iconsRupees,
                        width: Sizes.screenWidth * 0.16,
                      ),
                      Sizes.spaceWidth15,
                      TextConst(
                        docHomeCon.selectedAmount,
                        size: Sizes.fontSizeFivePFive,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ),
                    ],
                  ),
                  // Sizes.spaceHeight20,
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              // left: Sizes.screenWidth * 0.2,
              child: ButtonConst(
                  title: AppLocalizations.of(context)!.view,
                  fontWeight: FontWeight.w500,
                  size: Sizes.fontSizeFourPFive,
                  borderRadius: 6,
                  width: Sizes.screenWidth * 0.6,
                  height: Sizes.screenHeight * 0.046,
                  color: AppColor.lightBlue,
                  onTap: () {
                    Provider.of<RevenueDoctorViewModel>(context, listen: false)
                        .revenueDoctorApi();
                    Navigator.pushNamed(
                        context, RoutesName.scheduleHoursScreen);
                  }))
        ],
      ),
    );
  }

  Widget appointmentDetails() {
    return const Column(
      children: [
        Row(
          children: [],
        )
      ],
    );
  }

  Widget appContainer(
    Color color,
    dynamic label,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color,
      ),
      child: Row(
        children: [
          Sizes.spaceWidth3,
          Center(
            child: TextConst(
              textAlign: TextAlign.center,
              label,
              size: Sizes.fontSizeOne,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
          )
        ],
      ),
    );
  }

  bool isMoreThanOneHourAway(String bookingDate, String hour24Format) {
    // Combine date and time
    String dateTimeString = "$bookingDate $hour24Format";
    print("date time : ${dateTimeString}");
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
