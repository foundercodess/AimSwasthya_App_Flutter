import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/switch_btn.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view/doctor/patients/patient_profile_screen.dart';
import 'package:aim_swasthya/view_model/doctor/doc_reg_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doctor_profile_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/patient_profile_view_model.dart';
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
      slotScheduleCon.generateSlots(
          doctorId: 6, clinicId: 6, startDate: DateTime.now());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomCon = Provider.of<BottomNavProvider>(context);
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
                    (registerCon.isPersonalInfoSelected == true
                        ? 0.045
                        : 0.35)),
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
                    Navigator.pushNamed(context, RoutesName.doctorBottomNevBar);
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
            //         Container(
            //           padding: EdgeInsets.only(
            //               left: Sizes.screenWidth * 0.03,
            //               right: Sizes.screenWidth * 0.03),
            //           child: DropdownButton<String>(
            // value: selectedValue,
            // hint: Text("Select option"),
            // underline: SizedBox(), // Removes the underline
            // isExpanded: true,
            // items: items.map((String value) {
            // return DropdownMenuItem<String>(
            // value: value,
            // child: Text(value),
            // );
            // }).toList(),
            // onChanged: (String? newValue) {
            // setState(() {
            // selectedValue = newValue!;
            // });
            // },),
            //         ),
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
    return Padding(
      padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.screenWidth * 0.04,
                vertical: Sizes.screenHeight * 0.01),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.textfieldGrayColor),
            child: TextConst(
              "10 min",
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w400,
            ),
          ),
          Sizes.spaceWidth15,
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.screenWidth * 0.04,
                vertical: Sizes.screenHeight * 0.01),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.lightBlue),
            child: TextConst(
              "30 min",
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
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
      // final slotsData = slotScheduleCon.generateSlots(doctorId: , clinicId: clinicId, startDate: startDate)
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
            Row(
              children: [
                CustomSwitch(
                  value: enable,
                  onChanged: (bool val) {
                    setState(() {
                      enable = val;
                    });
                  },
                ),
                Sizes.spaceWidth15,
                SizedBox(
                  width: Sizes.screenWidth * 0.1,
                  child: TextConst(
                    "1 Jan",
                    // size: 12,
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textfieldGrayColor,
                  ),
                ),
                Sizes.spaceWidth5,
                Sizes.spaceWidth3,
                Container(
                  alignment: Alignment.centerRight,
                  width: Sizes.screenWidth * 0.61,
                  child: Row(
                    children: [
                      Container(
                        height: Sizes.screenHeight * 0.03,
                        width: Sizes.screenWidth * 0.24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color:
                                AppColor.textfieldGrayColor.withOpacity(0.5)),
                        child: Center(
                          child: TextConst(
                            "11.00 am",
                            size: Sizes.fontSizeFourPFive,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textfieldTextColor.withOpacity(0.8),
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
                      Container(
                        height: Sizes.screenHeight * 0.03,
                        width: Sizes.screenWidth * 0.24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color:
                                AppColor.textfieldGrayColor.withOpacity(0.5)),
                        child: Center(
                          child: TextConst(
                            "11.20 am",
                            size: Sizes.fontSizeFourPFive,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textfieldTextColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                      Sizes.spaceWidth10,
                      const Icon(
                        Icons.add_circle_outline,
                        size: 15,
                        color: AppColor.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Sizes.spaceHeight10,
            Padding(
              padding: EdgeInsets.only(left: Sizes.screenWidth * 0.225),
              child: Row(
                children: [
                  Image.asset(
                    Assets.iconsDeleteIcon,
                    width: 15,
                  ),
                  Sizes.spaceWidth5,
                  Sizes.spaceWidth3,
                  SizedBox(
                    width: Sizes.screenWidth * 0.61,
                    child: Row(
                      children: [
                        // Sizes.spaceWidth10,
                        Container(
                          height: Sizes.screenHeight * 0.03,
                          width: Sizes.screenWidth * 0.24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color:
                                  AppColor.textfieldGrayColor.withOpacity(0.5)),
                          child: Center(
                            child: TextConst(
                              "05.00 pm",
                              size: Sizes.fontSizeFive,
                              fontWeight: FontWeight.w400,
                              color:
                                  AppColor.textfieldTextColor.withOpacity(0.8),
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
                        Container(
                          height: Sizes.screenHeight * 0.03,
                          width: Sizes.screenWidth * 0.24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color:
                                  AppColor.textfieldGrayColor.withOpacity(0.5)),
                          child: Center(
                            child: TextConst(
                              "08.00 pm",
                              size: Sizes.fontSizeFive,
                              fontWeight: FontWeight.w400,
                              color:
                                  AppColor.textfieldTextColor.withOpacity(0.8),
                            ),
                          ),
                        ),
                        Sizes.spaceWidth10,
                        const Icon(
                          Icons.add_circle_outline,
                          size: 15,
                          color: AppColor.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Sizes.spaceHeight30,
            Row(
              children: [
                CustomSwitch(
                  value: enable,
                  onChanged: (bool val) {
                    setState(() {
                      enable = val;
                    });
                  },
                ),
                Sizes.spaceWidth15,
                SizedBox(
                  width: Sizes.screenWidth * 0.1,
                  child: TextConst(
                    "2 Jan",
                    // size: 12,
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textfieldGrayColor,
                  ),
                ),
                Sizes.spaceWidth5,
                Sizes.spaceWidth3,
                Container(
                  alignment: Alignment.centerRight,
                  width: Sizes.screenWidth * 0.61,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: Sizes.screenHeight * 0.03,
                        width: Sizes.screenWidth * 0.24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color:
                                AppColor.textfieldGrayColor.withOpacity(0.5)),
                        child: Center(
                          child: TextConst(
                            "11.00 am",
                            size: Sizes.fontSizeFourPFive,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textfieldTextColor.withOpacity(0.8),
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
                      Container(
                        height: Sizes.screenHeight * 0.03,
                        width: Sizes.screenWidth * 0.24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color:
                                AppColor.textfieldGrayColor.withOpacity(0.5)),
                        child: Center(
                          child: TextConst(
                            "11.20 am",
                            size: Sizes.fontSizeFourPFive,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textfieldTextColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                      Sizes.spaceWidth10,
                      const Icon(
                        Icons.add_circle_outline,
                        size: 15,
                        color: AppColor.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
