import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/switch_btn.dart';
import 'package:aim_swasthya/view_model/doctor/doc_reg_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doctor_profile_view_model.dart';
import 'package:aim_swasthya/view_model/user/bottom_nav_view_model.dart';
import 'package:aim_swasthya/view_model/user/slot_schedule_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int selectedIndex = 0;
  void toggleSelection(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final registerCon =
          Provider.of<RegisterViewModel>(context, listen: false);
      registerCon.resetValues();
      final slotScheduleCon =
          Provider.of<SlotScheduleViewModel>(context, listen: false);
      slotScheduleCon.docScheduleApi('2');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomCon = Provider.of<BottomNavProvider>(context);
    final slotScheduleCon = Provider.of<SlotScheduleViewModel>(context);
    final registerCon = Provider.of<RegisterViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.white,
      appBar: appBarConstant(context, isBottomAllowed: true, onTap: () {
        if (bottomCon.currentIndex == 1) {
          bottomCon.setIndex(0);
        } else {
          Navigator.pop(context);
        }
      },
          child: Container(
            height: Sizes.screenHeight * 0.013,
            width: Sizes.screenWidth * 0.4,
            decoration: BoxDecoration(
              color: AppColor.textfieldGrayColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Sizes.screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: registerCon.isPersonalInfoSelected
                        ? AppColor.lightBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  width: Sizes.screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: !registerCon.isPersonalInfoSelected
                        ? AppColor.lightBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Sizes.spaceHeight30,
            registerCon.isPersonalInfoSelected == true
                ? scheduleDates()
                : scheduleHours(),
            SizedBox(
                height: Sizes.screenHeight *
                    (registerCon.isPersonalInfoSelected == true ? 0.045 : 0.1)),
            Padding(
              padding: EdgeInsets.only(
                  left: Sizes.screenWidth * 0.1,
                  right: Sizes.screenWidth * 0.1,
                  bottom: Sizes.screenHeight * 0.016),
              child: AppBtn(
                height: Sizes.screenHeight * 0.06,
                width: Sizes.screenWidth,
                title: registerCon.isPersonalInfoSelected == true
                    ? AppLocalizations.of(context)!.continue_con
                    : AppLocalizations.of(context)!.save,
                color: AppColor.blue,
                borderRadius: 18,
                fontWidth: FontWeight.w400,
                onTap: () {
                  if (registerCon.isPersonalInfoSelected == false) {
                    slotScheduleCon.docScheduleInsertApi();
                    // Navigator.pushNamed(context, RoutesName.doctorBottomNevBar);
                  } else {
                    registerCon.changeWidget(false);
                  }
                },
              ),
            ),
            SizedBox(height: Sizes.screenHeight * 0.16),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBarConstant(BuildContext context,
      {Widget? child,
      bool isBottomAllowed = false,
      String? label,
      void Function()? onTap}) {
    return AppBar(
        backgroundColor: AppColor.white,
        leading: GestureDetector(
            onTap: onTap ??
                () {
                  Navigator.pop(context);
                },
            child: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Image(image: AssetImage(Assets.iconsBackBtn)),
            )),
        bottom: isBottomAllowed
            ? PreferredSize(
                preferredSize: const Size.fromHeight(10),
                child: child ?? TextConst(label ?? ""),
              )
            : null);
  }

  Widget scheduleDates() {
    final docProfileCon = Provider.of<DoctorProfileViewModel>(context);
    final slotScheduleCon = Provider.of<SlotScheduleViewModel>(context);
    print(docProfileCon.doctorProfileModel!.data!.clinics!.length);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.08,
          vertical: Sizes.screenHeight * 0.02),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: TextConst(
                AppLocalizations.of(context)!.manage_your_schedule,
                size: Sizes.fontSizeSix * 1.07,
                fontWeight: FontWeight.w500,
              ),
            ),
            Center(
              child: TextConst(
                AppLocalizations.of(context)!.select_maximum_days,
                size: Sizes.fontSizeFive * 1.2,
                fontWeight: FontWeight.w400,
                color: AppColor.textfieldTextColor.withOpacity(0.7),
              ),
            ),
            SizedBox(
              height: Sizes.screenHeight * 0.09,
            ),
            Center(
              child: Container(
                width: Sizes.screenWidth / 1.29,
                height: 55,
                decoration: BoxDecoration(
                    color: AppColor.grey,
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.only(
                    left: Sizes.screenWidth * 0.03,
                    right: Sizes.screenWidth * 0.03),
                child: DropdownButton<String>(
                  value: slotScheduleCon.selectedClinicId,
                  hint: TextConst(
                    "Select option",
                    size: Sizes.fontSizeFour,
                    color: AppColor.textfieldTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                  underline: const SizedBox(),
                  isExpanded: true,
                  items: docProfileCon.doctorProfileModel!.data!.clinics!
                      .map((clinic) => DropdownMenuItem<String>(
                            value: clinic.clinicId.toString(),
                            child: TextConst(
                              clinic.name.toString(),
                              fontWeight: FontWeight.w500,
                              size: Sizes.fontSizeFive,
                              color: AppColor.blue,
                            ),
                          ))
                      .toList(),
                  onChanged: (String? newId) {
                    slotScheduleCon.setSelectedClinicId(newId!);
                  },
                ),
              ),
            ),
            Sizes.spaceHeight10,
            Container(
              padding: EdgeInsets.only(
                  left: Sizes.screenWidth * 0.03,
                  right: Sizes.screenWidth * 0.03),
              child: CustomTextField(
                contentPadding:
                    const EdgeInsets.only(top: 18, bottom: 18, left: 10),
                fillColor: AppColor.grey,
                hintText: "Consultation fee",
                hintWeight: FontWeight.w400,
                hintSize: Sizes.fontSizeFour,
                cursorColor: AppColor.textGrayColor,
              ),
            ),
            SizedBox(
              height: Sizes.screenHeight * 0.08,
            ),
            TextConst(
              AppLocalizations.of(context)!.appointment_duration,
              size: Sizes.fontSizeFivePFive,
              fontWeight: FontWeight.w400,
            ),
            Sizes.spaceHeight25,
            timeDuration(),
            Sizes.spaceHeight35,
            TextConst(
              AppLocalizations.of(context)!.data_range,
              size: Sizes.fontSizeFivePFive,
              fontWeight: FontWeight.w400,
            ),
            Sizes.spaceHeight25,
            dataRange(),
          ],
        ),
      ),
    );
  }

  Widget timeDuration() {
    final slotScheduleCon = Provider.of<SlotScheduleViewModel>(context);

    return Padding(
        padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
        child: Row(
          spacing: 10,
          children: List.generate(
              slotScheduleCon.appointmentDurationList.length, (index) {
            final time = slotScheduleCon.appointmentDurationList[index];
            return GestureDetector(
              onTap: () {
                slotScheduleCon.setAppointmentDuration(time);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes.screenWidth * 0.04,
                    vertical: Sizes.screenHeight * 0.01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: slotScheduleCon.appointmentDuration == time
                        ? AppColor.lightBlue
                        : AppColor.textfieldGrayColor),
                child: TextConst(
                  time,
                  size: Sizes.fontSizeFive,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }),
        )
        // Row(
        //   children: [
        //
        //     Container(
        //       padding: EdgeInsets.symmetric(
        //           horizontal: Sizes.screenWidth * 0.04,
        //           vertical: Sizes.screenHeight * 0.01),
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(8),
        //           color: AppColor.textfieldGrayColor),
        //       child: TextConst(
        //         "10 min",
        //         size: Sizes.fontSizeFive,
        //         fontWeight: FontWeight.w400,
        //       ),
        //     ),
        //     Sizes.spaceWidth15,
        //     Container(
        //       padding: EdgeInsets.symmetric(
        //           horizontal: Sizes.screenWidth * 0.04,
        //           vertical: Sizes.screenHeight * 0.01),
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(8),
        //           color: AppColor.lightBlue),
        //       child: TextConst(
        //         "30 min",
        //         size: Sizes.fontSizeFive,
        //         fontWeight: FontWeight.w400,
        //       ),
        //     ),
        //   ],
        // ),
        );
  }

  Widget dataRange() {
    return Padding(
      padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => toggleSelection(0),
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedIndex == 0
                          ? AppColor.lightBlue
                          : AppColor.textfieldGrayColor,
                      width: 2,
                    ),
                  ),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedIndex == 0
                          ? AppColor.lightBlue
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
              Sizes.spaceWidth10,
              TextConst(
                AppLocalizations.of(context)!.within_a_range,
                size: Sizes.fontSizeFourPFive,
                fontWeight: FontWeight.w400,
                color: AppColor.textfieldTextColor,
              ),
              const Spacer(),
              // Sizes.spaceWidth15,
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes.screenWidth * 0.02,
                    vertical: Sizes.screenHeight * 0.0065),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.grey),
                child: Row(
                  children: [
                    TextConst(
                      "1 Jun - 7 Jun 2024",
                      size: Sizes.fontSizeThree * 1.06,
                      fontWeight: FontWeight.w400,
                      color: AppColor.lightBlack,
                    ),
                    Sizes.spaceWidth20,
                    Image.asset(
                      Assets.assetsIconsArrowDown,
                      width: Sizes.screenWidth * 0.045,
                      color: AppColor.black,
                    )
                  ],
                ),
              ),
            ],
          ),
          Sizes.spaceHeight30,
          Row(
            children: [
              GestureDetector(
                onTap: () => toggleSelection(1),
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedIndex == 0
                          ? AppColor.textfieldGrayColor
                          : AppColor.lightBlue,
                      width: 2,
                    ),
                  ),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedIndex == 1
                          ? AppColor.lightBlue
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
              Sizes.spaceWidth10,
              TextConst(
                AppLocalizations.of(context)!.continue_indefinitely,
                size: Sizes.fontSizeFourPFive,
                fontWeight: FontWeight.w400,
                color: AppColor.textfieldTextColor,
              ),
            ],
          ),
        ],
      ),
    );
    //   Padding(
    //   padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
    //   child: Column(
    //     children: [
    //       Row(
    //         children: [
    //           GestureDetector(
    //             onTap: () {},
    //             child: Container(
    //               height: 23,
    //               width: 23,
    //               decoration: const BoxDecoration(
    //                   shape: BoxShape.circle, color: AppColor.lightBlue),
    //             ),
    //           ),
    //           Sizes.spaceWidth10,
    //           TextConst(
    //             "Within a range",
    //             size: Sizes.fontSizeFive,
    //             fontWeight: FontWeight.w400,
    //             color: AppColor.textfieldTextColor,
    //           ),
    //           Sizes.spaceWidth15,
    //           Container(
    //             padding: EdgeInsets.symmetric(
    //                 horizontal: Sizes.screenWidth * 0.02,
    //                 vertical: Sizes.screenHeight * 0.0065),
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(8), color: AppColor.grey),
    //             child: Row(
    //               children: [
    //                 TextConst(
    //                   "1 Jun - 7 Jun 2024",
    //                   size: Sizes.fontSizeThree,
    //                   fontWeight: FontWeight.w300,
    //                   color: AppColor.lightBlack,
    //                 ),
    //                 Sizes.spaceWidth10,
    //                 Image.asset(
    //                   Assets.assetsIconsArrowDown,
    //                   width: Sizes.screenWidth * 0.045,
    //                   color: AppColor.black,
    //                 )
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //       Sizes.spaceHeight30,
    //       Row(
    //         children: [
    //           GestureDetector(
    //             onTap: () {},
    //             child: Container(
    //               height: 25,
    //               width: 25,
    //               decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   border: Border.all(color: AppColor.textfieldGrayColor)),
    //             ),
    //           ),
    //           Sizes.spaceWidth10,
    //           TextConst(
    //             "Continue indefinitely",
    //             size: Sizes.fontSizeFive,
    //             fontWeight: FontWeight.w400,
    //             color: AppColor.textfieldTextColor,
    //           ),
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }

  bool enable = false;
  Widget scheduleHours() {
    return Consumer<SlotScheduleViewModel>(
        builder: (context, slotScheduleCon, _) {
      print(slotScheduleCon.allSlots.length);
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.screenWidth * 0.05,
            vertical: Sizes.screenHeight * 0.02),
        child: Column(
          children: [
            Sizes.spaceHeight10,
            TextConst(
              AppLocalizations.of(context)!.working_hours,
              size: Sizes.fontSizeSix * 1.07,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: Sizes.screenHeight * 0.05,
            ),
            Column(
              spacing: 15,
              children:
                  List.generate(slotScheduleCon.allSlots.length, (slotIndex) {
                final slotData = slotScheduleCon.allSlots[slotIndex];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomSwitch(
                      value: slotData['available_flag'] == 'Y',
                      onChanged: (bool val) {
                        slotScheduleCon
                            .toggleSelectedDateAvailability(slotIndex);
                      },
                    ),
                    Sizes.spaceWidth15,
                    SizedBox(
                      width: Sizes.screenWidth * 0.12,
                      child: TextConst(
                        slotData['dd_month_name'],
                        size: Sizes.fontSizeFourPFive,
                        fontWeight: FontWeight.w400,
                        color: AppColor.textfieldGrayColor,
                      ),
                    ),
                    Sizes.spaceWidth5,
                    Sizes.spaceWidth3,
                    Column(
                      children:
                          List.generate(slotData['timing'].length, (timeIndex) {
                        final timingData = slotData['timing'][timeIndex];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          alignment: Alignment.centerRight,
                          width: Sizes.screenWidth * 0.61,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  slotScheduleCon.selectTime(context, slotIndex,
                                      timeIndex, 'start_time');
                                },
                                child: Container(
                                  height: Sizes.screenHeight * 0.03,
                                  width: Sizes.screenWidth * 0.24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: AppColor.textfieldGrayColor
                                          .withOpacity(0.5)),
                                  child: Center(
                                    child: TextConst(
                                      timingData['start_time'],
                                      size: Sizes.fontSizeFourPFive,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.textfieldTextColor
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                ),
                              ),
                              Sizes.spaceWidth3,
                              const Icon(
                                Icons.remove,
                                size: 15,
                                color: AppColor.textfieldTextColor,
                              ),
                              Sizes.spaceWidth3,
                              GestureDetector(
                                onTap: () {
                                  slotScheduleCon.selectTime(context, slotIndex,
                                      timeIndex, 'end_time');
                                },
                                child: Container(
                                  height: Sizes.screenHeight * 0.03,
                                  width: Sizes.screenWidth * 0.24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: AppColor.textfieldGrayColor
                                          .withOpacity(0.5)),
                                  child: Center(
                                    child: TextConst(
                                      timingData['end_time'],
                                      size: Sizes.fontSizeFourPFive,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.textfieldTextColor
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                ),
                              ),
                              Sizes.spaceWidth10,
                              (timeIndex == 0)
                                  ? GestureDetector(
                                      onTap: () {
                                        if (slotData['timing'].length < 3) {
                                          slotScheduleCon.addMoreTimeAtDate(
                                              slotIndex,
                                              slotData['timing'].length);
                                        } else {
                                          debugPrint(
                                              "No more slot addition allowed");
                                        }
                                      },
                                      child: const Icon(
                                        Icons.add_circle_outline,
                                        size: 15,
                                        color: AppColor.black,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        if (slotData['timing'].length > 1) {
                                          slotScheduleCon.removeTimeAtDate(
                                              slotIndex, timeIndex);
                                        } else {
                                          debugPrint(
                                              "No more slot deletion allowed");
                                        }
                                      },
                                      child: const Icon(
                                        Icons.cancel_outlined,
                                        size: 15,
                                        color: Colors.red,
                                      ),
                                    ),
                            ],
                          ),
                        );
                      }),
                    )
                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   width: Sizes.screenWidth * 0.61,
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         height: Sizes.screenHeight * 0.03,
                    //         width: Sizes.screenWidth * 0.24,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(7),
                    //             color: AppColor.textfieldGrayColor
                    //                 .withOpacity(0.5)),
                    //         child: Center(
                    //           child: TextConst(
                    //             "11.00 am",
                    //             size: Sizes.fontSizeFourPFive,
                    //             fontWeight: FontWeight.w400,
                    //             color: AppColor.textfieldTextColor
                    //                 .withOpacity(0.8),
                    //           ),
                    //         ),
                    //       ),
                    //       Sizes.spaceWidth3,
                    //       const Icon(
                    //         Icons.remove,
                    //         size: 15,
                    //         color: AppColor.textfieldTextColor,
                    //       ),
                    //       Sizes.spaceWidth3,
                    //       Container(
                    //         height: Sizes.screenHeight * 0.03,
                    //         width: Sizes.screenWidth * 0.24,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(7),
                    //             color: AppColor.textfieldGrayColor
                    //                 .withOpacity(0.5)),
                    //         child: Center(
                    //           child: TextConst(
                    //             "11.20 am",
                    //             size: Sizes.fontSizeFourPFive,
                    //             fontWeight: FontWeight.w400,
                    //             color: AppColor.textfieldTextColor
                    //                 .withOpacity(0.8),
                    //           ),
                    //         ),
                    //       ),
                    //       Sizes.spaceWidth10,
                    //       const Icon(
                    //         Icons.add_circle_outline,
                    //         size: 15,
                    //         color: AppColor.black,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                );
              }),
            ),
            // Row(
            //   children: [
            //     CustomSwitch(
            //       value: enable,
            //       onChanged: (bool val) {
            //         setState(() {
            //           enable = val;
            //         });
            //       },
            //     ),
            //     Sizes.spaceWidth15,
            //     SizedBox(
            //       width: Sizes.screenWidth * 0.1,
            //       child: TextConst(
            //         "1 Jan",
            //         // size: 12,
            //         size: Sizes.fontSizeFourPFive,
            //         fontWeight: FontWeight.w400,
            //         color: AppColor.textfieldGrayColor,
            //       ),
            //     ),
            //     Sizes.spaceWidth5,
            //     Sizes.spaceWidth3,
            //     Container(
            //       alignment: Alignment.centerRight,
            //       width: Sizes.screenWidth * 0.61,
            //       child: Row(
            //         children: [
            //           Container(
            //             height: Sizes.screenHeight * 0.03,
            //             width: Sizes.screenWidth * 0.24,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(7),
            //                 color:
            //                     AppColor.textfieldGrayColor.withOpacity(0.5)),
            //             child: Center(
            //               child: TextConst(
            //                 "11.00 am",
            //                 size: Sizes.fontSizeFourPFive,
            //                 fontWeight: FontWeight.w400,
            //                 color: AppColor.textfieldTextColor.withOpacity(0.8),
            //               ),
            //             ),
            //           ),
            //           Sizes.spaceWidth3,
            //           const Icon(
            //             Icons.remove,
            //             size: 15,
            //             color: AppColor.textfieldTextColor,
            //           ),
            //           Sizes.spaceWidth3,
            //           Container(
            //             height: Sizes.screenHeight * 0.03,
            //             width: Sizes.screenWidth * 0.24,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(7),
            //                 color:
            //                     AppColor.textfieldGrayColor.withOpacity(0.5)),
            //             child: Center(
            //               child: TextConst(
            //                 "11.20 am",
            //                 size: Sizes.fontSizeFourPFive,
            //                 fontWeight: FontWeight.w400,
            //                 color: AppColor.textfieldTextColor.withOpacity(0.8),
            //               ),
            //             ),
            //           ),
            //           Sizes.spaceWidth10,
            //           const Icon(
            //             Icons.add_circle_outline,
            //             size: 15,
            //             color: AppColor.black,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // Sizes.spaceHeight10,
            // Padding(
            //   padding: EdgeInsets.only(left: Sizes.screenWidth * 0.225),
            //   child: Row(
            //     children: [
            //       Image.asset(
            //         Assets.iconsDeleteIcon,
            //         width: 15,
            //       ),
            //       Sizes.spaceWidth5,
            //       Sizes.spaceWidth3,
            //       SizedBox(
            //         width: Sizes.screenWidth * 0.61,
            //         child: Row(
            //           children: [
            //             // Sizes.spaceWidth10,
            //             Container(
            //               height: Sizes.screenHeight * 0.03,
            //               width: Sizes.screenWidth * 0.24,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(7),
            //                   color:
            //                       AppColor.textfieldGrayColor.withOpacity(0.5)),
            //               child: Center(
            //                 child: TextConst(
            //                   "05.00 pm",
            //                   size: Sizes.fontSizeFive,
            //                   fontWeight: FontWeight.w400,
            //                   color:
            //                       AppColor.textfieldTextColor.withOpacity(0.8),
            //                 ),
            //               ),
            //             ),
            //             Sizes.spaceWidth3,
            //             const Icon(
            //               Icons.remove,
            //               size: 15,
            //               color: AppColor.textfieldTextColor,
            //             ),
            //             Sizes.spaceWidth3,
            //             Container(
            //               height: Sizes.screenHeight * 0.03,
            //               width: Sizes.screenWidth * 0.24,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(7),
            //                   color:
            //                       AppColor.textfieldGrayColor.withOpacity(0.5)),
            //               child: Center(
            //                 child: TextConst(
            //                   "08.00 pm",
            //                   size: Sizes.fontSizeFive,
            //                   fontWeight: FontWeight.w400,
            //                   color:
            //                       AppColor.textfieldTextColor.withOpacity(0.8),
            //                 ),
            //               ),
            //             ),
            //             Sizes.spaceWidth10,
            //             const Icon(
            //               Icons.add_circle_outline,
            //               size: 15,
            //               color: AppColor.black,
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Sizes.spaceHeight30,
            // Row(
            //   children: [
            //     CustomSwitch(
            //       value: enable,
            //       onChanged: (bool val) {
            //         setState(() {
            //           enable = val;
            //         });
            //       },
            //     ),
            //     Sizes.spaceWidth15,
            //     SizedBox(
            //       width: Sizes.screenWidth * 0.1,
            //       child: TextConst(
            //         "2 Jan",
            //         // size: 12,
            //         size: Sizes.fontSizeFourPFive,
            //         fontWeight: FontWeight.w400,
            //         color: AppColor.textfieldGrayColor,
            //       ),
            //     ),
            //     Sizes.spaceWidth5,
            //     Sizes.spaceWidth3,
            //     Container(
            //       alignment: Alignment.centerRight,
            //       width: Sizes.screenWidth * 0.61,
            //       child: Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Container(
            //             height: Sizes.screenHeight * 0.03,
            //             width: Sizes.screenWidth * 0.24,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(7),
            //                 color:
            //                     AppColor.textfieldGrayColor.withOpacity(0.5)),
            //             child: Center(
            //               child: TextConst(
            //                 "11.00 am",
            //                 size: Sizes.fontSizeFourPFive,
            //                 fontWeight: FontWeight.w400,
            //                 color: AppColor.textfieldTextColor.withOpacity(0.8),
            //               ),
            //             ),
            //           ),
            //           Sizes.spaceWidth3,
            //           const Icon(
            //             Icons.remove,
            //             size: 15,
            //             color: AppColor.textfieldTextColor,
            //           ),
            //           Sizes.spaceWidth3,
            //           Container(
            //             height: Sizes.screenHeight * 0.03,
            //             width: Sizes.screenWidth * 0.24,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(7),
            //                 color:
            //                     AppColor.textfieldGrayColor.withOpacity(0.5)),
            //             child: Center(
            //               child: TextConst(
            //                 "11.20 am",
            //                 size: Sizes.fontSizeFourPFive,
            //                 fontWeight: FontWeight.w400,
            //                 color: AppColor.textfieldTextColor.withOpacity(0.8),
            //               ),
            //             ),
            //           ),
            //           Sizes.spaceWidth10,
            //           const Icon(
            //             Icons.add_circle_outline,
            //             size: 15,
            //             color: AppColor.black,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      );
    });
  }
}
