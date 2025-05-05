import 'package:aim_swasthya/res/border_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/const_drop_down.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view_model/doctor/doc_home_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doctor_profile_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/revenue_doctor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                        "Welcome ${docHomeCon.data!.doctors![0].doctorName ?? ""}",
                        // AppLocalizations.of(context)!.welcome_Vikram,
                        size: Sizes.fontSizeFive,
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      )
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
                            docHomeCon.data!.doctors![0].experience ?? "5 years Experience",
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
                            docHomeCon.data!.doctors![0].qualification ?? "MBBS, MD (Cardiology)",
                            size: Sizes.fontSizeFivePFive,
                            fontWeight: FontWeight.w400,
                            color: AppColor.white,
                          ),
                          Sizes.spaceHeight10,
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              docHomeCon.data!.doctors![0].topRated == "Y"
                                  ? proContainer(
                                      AppColor.lightGreen, 'Top choice')
                                  : const SizedBox(),
                              Sizes.spaceWidth10,
                              docHomeCon.data!.doctors![0].mostBooked == "Y"
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
                              decoration:  const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:
                                  AssetImage(Assets.imagesPatientImg),
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
                                ButtonConst(
                                    title: "Reschedule",
                                    size: Sizes.fontSizeThree * 1.05,
                                    fontWeight: FontWeight.w400,
                                    borderRadius: 7,
                                    height: Sizes.screenHeight * 0.026,
                                    width: Sizes.screenWidth * 0.33,
                                    color: AppColor.blue,
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          RoutesName.patientProfileScreen);
                                    })
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
        Navigator.pushNamed(context, RoutesName.clinicLocationScreen);
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
    List<Map<String, dynamic>> todayAppointmentList = [
      {"date": "7 June", "time": "10:30", "name": "Alice", "status": 1},
      {"date": "7 June", "time": "12:00", "name": "Bob", "status": 2},
      {"date": "7 June", "time": "15:45", "name": "Charlie", "status": null},
      {"date": "7 June", "time": "18:20", "name": "David", "status": 0},
      {"date": "7 June", "time": "21:10", "name": "Eve", "status": 0},
    ];
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
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 15, left: 4, right: 5),
            itemCount: todayAppointmentList.length,
            itemBuilder: (context, index) {
              final item = todayAppointmentList[index];
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
                        width: Sizes.screenWidth / 3.35,
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
                              item["name"],
                              size: Sizes.fontSizeFour,
                              // size: Sizes.fontSizeThree,
                              fontWeight: FontWeight.w500,
                            ),
                            Sizes.spaceHeight5,
                            // Sizes.spaceHeight3,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      Assets.iconsSolarCalendar,
                                      width: Sizes.screenWidth / 30,
                                    ),
                                    Sizes.spaceWidth3,
                                    TextConst(
                                      item["date"],
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
                                      "${item["time"]} PM",
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
                          width: Sizes.screenWidth * 0.079,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColor.lightSkyBlue.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextConst(
                            "+1",
                          ),
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
                            item['time'],
                            size: Sizes.fontSizeFour,
                          ),
                          if (item['status'] != null && item['status'] != 0)
                            item['status'] == 1
                                ? appContainer(Colors.green, "Completed")
                                : appContainer(
                                    const Color(0xff0A2A5B), "In progress")
                        ],
                      ),
                    ),
                  ),
                  if (item['status'] == 2)
                    Positioned(
                      bottom: 6,
                      child: SizedBox(
                        width: Sizes.screenWidth / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                color: const Color(0xff0A2A5B).withOpacity(0.8),
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
    //   Stack(
    //   clipBehavior: Clip.none,
    //   alignment: Alignment.topCenter,
    //   children: [
    //     Container(
    //       width: Sizes.screenWidth * 0.48,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(8),
    //         color: AppColor.textfieldGrayColor.withOpacity(0.3),
    //       ),
    //       child: Column(
    //         children: [
    //           Container(
    //             padding: EdgeInsets.only(
    //                 left: Sizes.screenWidth * 0.014,
    //                 right: Sizes.screenWidth * .01,
    //                 top: Sizes.screenHeight * 0.012,
    //                 // bottom: Sizes.screenHeight * 0.003
    //             ),
    //             // height: Sizes.screenHeight * 0.067,
    //             width: Sizes.screenWidth,
    //             decoration: const BoxDecoration(
    //               border: Border(
    //                 bottom: BorderSide(color: Color(0xffD0D0D0), width: 1),
    //               ),
    //             ),
    //             child: Column(
    //               children: [
    //                 Sizes.spaceHeight3,
    //                 Row(
    //                   mainAxisSize: MainAxisSize.min,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     TextConst(
    //                       "11.00",
    //                       size: Sizes.fontSizeFour,
    //                       fontWeight: FontWeight.w400,
    //                     ),
    //                     SizedBox(
    //                       width: Sizes.screenWidth * 0.02,
    //                     ),
    //                     Stack(
    //                       clipBehavior: Clip.none,
    //                       children: [
    //                         Container(
    //                           padding: const EdgeInsets.only(
    //                             left: 9,
    //                             top: 2,
    //                             bottom: 4,
    //                             right: 8,
    //                           ),
    //                           decoration: BoxDecoration(
    //                               color: AppColor.lightSkyBlue,
    //                               borderRadius: BorderRadius.circular(5)),
    //                           child: Column(
    //                             children: [
    //                               Sizes.spaceHeight3,
    //                               TextConst(
    //                                 "Kartik Mahajan",
    //                                 size: 8,
    //                                 // size: Sizes.fontSizeThree,
    //                                 fontWeight: FontWeight.w500,
    //                               ),
    //                               Sizes.spaceHeight5,
    //                               // Sizes.spaceHeight3,
    //                               Row(
    //                                 children: [
    //                                   Image.asset(
    //                                     Assets.iconsSolarCalendar,
    //                                     width: 13,
    //                                   ),
    //                                   SizedBox(
    //                                     width: Sizes.screenWidth * 0.005,
    //                                   ),
    //                                   TextConst(
    //                                     "7 June",
    //                                     size: 8,
    //                                     // size: Sizes.fontSizeThree,
    //                                     fontWeight: FontWeight.w400,
    //                                     color: const Color(0xff535353),
    //                                   ),
    //                                   SizedBox(
    //                                     width: Sizes.screenWidth * 0.008,
    //                                   ),
    //                                   Image.asset(
    //                                     Assets.iconsMdiClock,
    //                                     width: 13,
    //                                   ),
    //                                   SizedBox(
    //                                     width: Sizes.screenWidth * 0.003,
    //                                   ),
    //                                   TextConst(
    //                                     "11.00 PM",
    //                                     size: 8,
    //                                     // size: Sizes.fontSizeThree,
    //                                     fontWeight: FontWeight.w400,
    //                                     color: const Color(0xff535353),
    //                                   )
    //                                 ],
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                         Positioned(
    //                           top: 13,
    //                             left: -38,
    //                             child: appContainer(AppColor.lightGreen, 'Completed'))
    //                       ],
    //                     ),
    //                     SizedBox(
    //                       width: Sizes.screenWidth * 0.008,
    //                     ),
    //                     Container(
    //                       height: 37,
    //                       width: 30,
    //                       decoration: BoxDecoration(
    //                           color: AppColor.lightSkyBlue,
    //                           borderRadius: BorderRadius.circular(5)),
    //                       child: Center(
    //                           child: TextConst(
    //                         "+1",
    //                         size: Sizes.fontSizeFour,
    //                         fontWeight: FontWeight.w400,
    //                       )),
    //                     )
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(
    //               left: Sizes.screenWidth * 0.02,
    //               right: Sizes.screenWidth * 0.02,
    //               top: Sizes.screenHeight * 0.01,
    //             ),
    //             height: Sizes.screenHeight * 0.065,
    //             width: Sizes.screenWidth,
    //             decoration: const BoxDecoration(
    //               border: Border(
    //                 bottom: BorderSide(
    //                     color: Color(0xffD0D0D0), width: 1),
    //               ),
    //             ),
    //             child: Column(
    //               children: [
    //                 Row(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     TextConst(
    //                       "12.00",
    //                       size: Sizes.fontSizeFour,
    //                       fontWeight: FontWeight.w400,
    //                     ),
    //                     SizedBox(
    //                       width: Sizes.screenWidth * 0.016,
    //                     ),
    //                     Stack(
    //                       clipBehavior: Clip.none,
    //                       children: [
    //                         Container(
    //                           padding: const EdgeInsets.only(
    //                             left: 9,
    //                             top: 2,
    //                             bottom: 4,
    //                             right: 8,
    //                           ),
    //                           decoration: BoxDecoration(
    //                               color: AppColor.lightSkyBlue,
    //                               borderRadius: BorderRadius.circular(5)),
    //                           child: Column(
    //                             children: [
    //                               Sizes.spaceHeight3,
    //                               TextConst(
    //                                 "Sheena Jain",
    //                                 size: 8,
    //                                 // size: Sizes.fontSizeThree,
    //                                 fontWeight: FontWeight.w500,
    //                               ),
    //                               Sizes.spaceHeight5,
    //                               // Sizes.spaceHeight3,
    //                               Row(
    //                                 children: [
    //                                   Image.asset(
    //                                     Assets.iconsSolarCalendar,
    //                                     width: 13,
    //                                   ),
    //                                   SizedBox(
    //                                     width: Sizes.screenWidth * 0.005,
    //                                   ),
    //                                   TextConst(
    //                                     "7 June",
    //                                     size: 8,
    //                                     // size: Sizes.fontSizeThree,
    //                                     fontWeight: FontWeight.w400,
    //                                     color: const Color(0xff535353),
    //                                   ),
    //                                   SizedBox(
    //                                     width: Sizes.screenWidth * 0.008,
    //                                   ),
    //                                   Image.asset(
    //                                     Assets.iconsMdiClock,
    //                                     width: 13,
    //                                   ),
    //                                   SizedBox(
    //                                     width: Sizes.screenWidth * 0.003,
    //                                   ),
    //                                   TextConst(
    //                                     "11.00 PM",
    //                                     size: 8,
    //                                     // size: Sizes.fontSizeThree,
    //                                     fontWeight: FontWeight.w400,
    //                                     color: const Color(0xff535353),
    //                                   )
    //                                 ],
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                         Positioned(
    //                             top: 13,
    //                             left: -38,
    //                             child: appContainer(AppColor.naviBlue, 'In progress'))
    //                       ],
    //                     ),
    //
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(
    //               left: Sizes.screenWidth * 0.02,
    //               right: Sizes.screenWidth * 0.02,
    //               top: Sizes.screenHeight * 0.01,
    //             ),
    //             height: Sizes.screenHeight * 0.065,
    //             width: Sizes.screenWidth,
    //             decoration: const BoxDecoration(
    //               border: Border(
    //                 bottom: BorderSide(color: Color(0xffD0D0D0), width: 1),
    //               ),
    //             ),
    //             child: Column(
    //               children: [
    //                 Row(
    //                   children: [
    //                     TextConst(
    //                       "05.00",
    //                       size: Sizes.fontSizeFour,
    //                       fontWeight: FontWeight.w400,
    //                     )
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(
    //               left: Sizes.screenWidth * 0.02,
    //               right: Sizes.screenWidth * 0.02,
    //               top: Sizes.screenHeight * 0.01,
    //             ),
    //             height: Sizes.screenHeight * 0.065,
    //             width: Sizes.screenWidth,
    //             decoration: const BoxDecoration(
    //               border: Border(
    //                 bottom: BorderSide(color: Color(0xffD0D0D0), width: 1),
    //               ),
    //             ),
    //             child: Column(
    //               children: [
    //                 Row(
    //                   children: [
    //                     TextConst(
    //                       "06.00",
    //                       size: Sizes.fontSizeFour,
    //                       fontWeight: FontWeight.w400,
    //                     )
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(
    //               left: Sizes.screenWidth * 0.02,
    //               right: Sizes.screenWidth * 0.02,
    //               top: Sizes.screenHeight * 0.01,
    //             ),
    //             height: Sizes.screenHeight * 0.065,
    //             width: Sizes.screenWidth,
    //             decoration: const BoxDecoration(
    //               border: Border(
    //                 bottom: BorderSide(
    //                     color: Color(0xffD0D0D0), width: 1), // Only top border
    //               ),
    //             ),
    //             child: Column(
    //               children: [
    //                 Row(
    //                   children: [
    //                     TextConst(
    //                       "07.00",
    //                       size: Sizes.fontSizeFour,
    //                       fontWeight: FontWeight.w400,
    //                     ),
    //                     SizedBox(
    //                       width: Sizes.screenWidth * 0.013,
    //                     ),
    //                     Container(
    //                       padding: const EdgeInsets.only(
    //                         left: 9,
    //                         top: 2,
    //                         bottom: 4,
    //                         right: 8,
    //                       ),
    //                       decoration: BoxDecoration(
    //                           color: AppColor.lightSkyBlue,
    //                           borderRadius: BorderRadius.circular(5)),
    //                       child: Column(
    //                         children: [
    //                           Sizes.spaceHeight3,
    //                           TextConst(
    //                             "Abhinav Singh",
    //                             size: 8,
    //                             // size: Sizes.fontSizeThree,
    //                             fontWeight: FontWeight.w500,
    //                           ),
    //                           Sizes.spaceHeight5,
    //                           // Sizes.spaceHeight3,
    //                           Row(
    //                             children: [
    //                               Image.asset(
    //                                 Assets.iconsSolarCalendar,
    //                                 width: 13,
    //                               ),
    //                               SizedBox(
    //                                 width: Sizes.screenWidth * 0.005,
    //                               ),
    //                               TextConst(
    //                                 "7 June",
    //                                 size: 8,
    //                                 // size: Sizes.fontSizeThree,
    //                                 fontWeight: FontWeight.w400,
    //                                 color: const Color(0xff535353),
    //                               ),
    //                               SizedBox(
    //                                 width: Sizes.screenWidth * 0.008,
    //                               ),
    //                               Image.asset(
    //                                 Assets.iconsMdiClock,
    //                                 width: 13,
    //                               ),
    //                               SizedBox(
    //                                 width: Sizes.screenWidth * 0.003,
    //                               ),
    //                               TextConst(
    //                                 "11.00 PM",
    //                                 size: 8,
    //                                 // size: Sizes.fontSizeThree,
    //                                 fontWeight: FontWeight.w400,
    //                                 color: const Color(0xff535353),
    //                               )
    //                             ],
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(
    //               left: Sizes.screenWidth * 0.02,
    //               right: Sizes.screenWidth * 0.02,
    //               top: Sizes.screenHeight * 0.01,
    //             ),
    //             height: Sizes.screenHeight * 0.06,
    //             width: Sizes.screenWidth,
    //             decoration: const BoxDecoration(
    //               // border: Border(
    //               //   bottom: BorderSide(color: Color(0xffD0D0D0), width: 1),
    //               // ),
    //             ),
    //             child: Column(
    //               children: [
    //                 Row(
    //                   children: [
    //                     TextConst(
    //                       "08.00",
    //                       size: Sizes.fontSizeFour,
    //                       fontWeight: FontWeight.w400,
    //                     )
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     Positioned(
    //         left: 30,
    //         top: -10,
    //         child: Container(
    //           padding: const EdgeInsets.only(left: 2,right: 2,top: 1.5,bottom: 1.5),
    //           decoration: BoxDecoration(
    //               color: AppColor.white,
    //               borderRadius: BorderRadius.circular(6)),
    //           child: TextConst(
    //             "Today’s appointments",
    //             size: Sizes.fontSizeThree,
    //             fontWeight: FontWeight.w500,
    //             color: const Color(0xff2F2F2F),
    //           ),
    //         ))
    //   ],
    // );
  }

  String? selectedMonth;
  Widget earningDetails() {
    final docHomeCon = Provider.of<DoctorHomeViewModel>(context);
    final revenueDocCon = Provider.of<RevenueDoctorViewModel>(context);
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
                      CustomDropdown<String>(
                        items: docHomeCon.doctorHomeModel!.data!.earnings!
                            .map((e) => e.monthYear.toString())
                            .toList(),
                        selectedItem: selectedMonth,
                        hintText: 'Select Month',
                        onChanged: (value) {
                          setState(() {
                            selectedMonth = value;
                          });
                        },
                        isRequired: true, // Validation on
                      ),
                      // TextConst(
                      //   docHomeCon.doctorHomeModel!.data!.earnings![0].monthYear??"",
                      //   // "April",
                      //   size: Sizes.fontSizeFour,
                      //   fontWeight: FontWeight.w400,
                      // ),
                      // Sizes.spaceWidth5,
                      // Image.asset(
                      //   Assets.iconsArrowDown,
                      //   width: Sizes.screenWidth * 0.04,
                      // )
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
                        docHomeCon
                            .doctorHomeModel!.data!.earnings![0].totalAmount
                            .toString(),
                        // 'Rs. 20,000/-',
                        size: Sizes.fontSizeFivePFive,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blue,
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
                    revenueDocCon.revenueDoctorApi();
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
}
