// view/doctor/schedule/schedule_screen.dart
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/view/doctor/schedule/range_calander_overlay.dart';
import 'package:aim_swasthya/view/doctor/schedule/schedule_hour.dart';
import 'package:aim_swasthya/view_model/user/bottom_nav_view_model.dart';
import 'package:aim_swasthya/view_model/user/slot_schedule_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'clinic_location_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // int selectedIndex = 0;
  // void toggleSelection(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //   });
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final slotScheduleCon =
          Provider.of<SlotScheduleViewModel>(context, listen: false);
      slotScheduleCon.clearSelectedValues();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomCon = Provider.of<BottomNavProvider>(context);
    final slotScheduleCon = Provider.of<SlotScheduleViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.white,
      appBar: appBarConstant(context, isBottomAllowed: true, onTap: () {
        if (slotScheduleCon.widgetIndex > 1) {
          slotScheduleCon.setWidgetIndex(slotScheduleCon.widgetIndex - 1);
        } else {
          Navigator.pop(context);
        }
      },
          child: Container(
            height: Sizes.screenHeight * 0.013,
            width: Sizes.screenWidth * 0.6,
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
                    color: slotScheduleCon.widgetIndex == 1
                        ? AppColor.lightBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  width: Sizes.screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: slotScheduleCon.widgetIndex == 2
                        ? AppColor.lightBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  width: Sizes.screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: slotScheduleCon.widgetIndex == 3
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
            slotScheduleCon.widgetIndex == 1
                ? const ClinicLocationScreen()
                : slotScheduleCon.widgetIndex == 2
                    ? manageSchedule()
                    : const ScheduleHour(),
            SizedBox(height: Sizes.screenHeight * 0.16),
          ],
        ),
      ),
      bottomSheet: scheduleActionsHandling(),
    );
  }

  Widget scheduleActionsHandling() {
    final slotScheduleCon = Provider.of<SlotScheduleViewModel>(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          left: Sizes.screenWidth * 0.1,
          right: Sizes.screenWidth * 0.1,
          bottom: Sizes.screenHeight * 0.04),
      child: AppBtn(
        height: Sizes.screenHeight * 0.06,
        width: Sizes.screenWidth,
        title: slotScheduleCon.widgetIndex <= 2
            ? AppLocalizations.of(context)!.continue_con
            : AppLocalizations.of(context)!.save,
        color: AppColor.blue,
        borderRadius: 18,
        fontWidth: FontWeight.w400,
        onTap: () {
          if (slotScheduleCon.widgetIndex == 1) {
            if (slotScheduleCon.selectedClinicId == null) {
              Utils.show("Please select a clinic to continue schedule creation",
                  context);
            } else {
              slotScheduleCon.docScheduleApi();
              slotScheduleCon.setWidgetIndex(2);
            }
          } else if (slotScheduleCon.widgetIndex == 2) {
            slotScheduleCon.docScheduleSlotTypeApi(context);
          }else{
            slotScheduleCon.docScheduleInsertApi(context);
          }
        },
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

  Widget manageSchedule() {
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
                size: Sizes.fontSizeFive ,
                fontWeight: FontWeight.w400,
                color: AppColor.textfieldTextColor.withOpacity(0.7),
              ),
            ),
            SizedBox(
              height: Sizes.screenHeight * 0.09,
            ),
            // Center(
            //   child: Container(
            //     width: Sizes.screenWidth / 1.29,
            //     height: 55,
            //     decoration: BoxDecoration(
            //         color: AppColor.grey,
            //         borderRadius: BorderRadius.circular(15)),
            //     padding: EdgeInsets.only(
            //         left: Sizes.screenWidth * 0.03,
            //         right: Sizes.screenWidth * 0.03),
            //     child: DropdownButton<String>(
            //       value: slotScheduleCon.selectedClinicId,
            //       hint: TextConst(
            //         "Select option",
            //         size: Sizes.fontSizeFour,
            //         color: AppColor.textfieldTextColor,
            //         fontWeight: FontWeight.w400,
            //       ),
            //       underline: const SizedBox(),
            //       isExpanded: true,
            //       items: docProfileCon.doctorProfileModel!.data!.clinics!
            //           .map((clinic) => DropdownMenuItem<String>(
            //                 value: clinic.clinicId.toString(),
            //                 child: TextConst(
            //                   clinic.name.toString(),
            //                   fontWeight: FontWeight.w500,
            //                   size: Sizes.fontSizeFive,
            //                   color: AppColor.blue,
            //                 ),
            //               ))
            //           .toList(),
            //       onChanged: (String? newId) {
            //         slotScheduleCon.setSelectedClinicId(newId!);
            //       },
            //     ),
            //   ),
            // ),
            Sizes.spaceHeight10,
            // Container(
            //   padding: EdgeInsets.only(
            //       left: Sizes.screenWidth * 0.03,
            //       right: Sizes.screenWidth * 0.03),
            //   child: CustomTextField(
            //     keyboardType: TextInputType.number,
            //     contentPadding:
            //         const EdgeInsets.only(top: 18, bottom: 18, left: 10),
            //     fillColor: AppColor.grey,
            //     hintText: "Consultation fee",
            //     hintWeight: FontWeight.w400,
            //     hintSize: Sizes.fontSizeFour,
            //     cursorColor: AppColor.textGrayColor,
            //   ),
            // ),
            // SizedBox(
            //   height: Sizes.screenHeight * 0.08,
            // ),
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
                print("asdfghjkl;: ${time['value']}");
                slotScheduleCon.setAppointmentDuration(time['value']!);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes.screenWidth * 0.04,
                    vertical: Sizes.screenHeight * 0.01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: slotScheduleCon.appointmentDuration == time['value']
                        ? AppColor.lightBlue
                        : AppColor.textfieldGrayColor),
                child: TextConst(
                  time['label']!,
                  size: Sizes.fontSizeFive,
                  fontWeight: FontWeight.w400,
                  color: slotScheduleCon.appointmentDuration == time['value']
                      ? AppColor.whiteColor
                      : Colors.black,
                ),
              ),
            );
          }),
        ));
  }

  Widget dataRange() {
    final slotScheduleCon = Provider.of<SlotScheduleViewModel>(context);
    return Padding(
      padding: EdgeInsets.only(left: Sizes.screenWidth * 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRangeOption(
            slotScheduleCon: slotScheduleCon,
            type: 'weekly',
            label: AppLocalizations.of(context)!.within_a_range,
            showDatePicker: true,
          ),
          Sizes.spaceHeight30,
          _buildRangeOption(
            slotScheduleCon: slotScheduleCon,
            type: 'indefinitely',
            label: AppLocalizations.of(context)!.continue_indefinitely,
            showDatePicker: false,
          ),
        ],
      ),
    );
  }

  Widget _buildRangeOption({
    required SlotScheduleViewModel slotScheduleCon,
    required String type,
    required String label,
    required bool showDatePicker,
  }) {
    final isSelected = slotScheduleCon.slotType == type;
    
    return Row(
      children: [
        _buildRadioButton(
          isSelected: isSelected,
          onTap: () => slotScheduleCon.setSlotType(type),
        ),
        Sizes.spaceWidth10,
        Expanded(
          child: TextConst(
            label,
            size: Sizes.fontSizeFourPFive,
            fontWeight: FontWeight.w400,
            color: AppColor.textfieldTextColor,
          ),
        ),
        if (showDatePicker) ...[
          // const Spacer(),
          _buildDatePickerButton(slotScheduleCon),
        ],
      ],
    );
  }

  Widget _buildRadioButton({
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColor.lightBlue : AppColor.textfieldGrayColor,
            width: 2,
          ),
        ),
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? AppColor.lightBlue : Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerButton(SlotScheduleViewModel slotScheduleCon) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => const RangeCalenderOverlay(),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.02,
          vertical: Sizes.screenHeight * 0.0065,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.grey,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (slotScheduleCon.selectedRange != null)
              TextConst(
                "${DateFormat('d MMMM').format(slotScheduleCon.selectedRange!.start.toLocal())} - ${DateFormat('d MMMM').format(slotScheduleCon.selectedRange!.end.toLocal())}",
                size: Sizes.fontSizeThree * 1.06,
                fontWeight: FontWeight.w400,
                color: AppColor.lightBlack,
              ),
            Sizes.spaceWidth20,
            Image.asset(
              Assets.assetsIconsArrowDown,
              width: Sizes.screenWidth * 0.045,
              color: AppColor.black,
            ),
          ],
        ),
      ),
    );
  }

  // bool enable = false;
  // Widget scheduleHours() {
  //   return Consumer<SlotScheduleViewModel>(
  //       builder: (context, slotScheduleCon, _) {
  //     return Padding(
  //       padding: EdgeInsets.symmetric(
  //           horizontal: Sizes.screenWidth * 0.05,
  //           vertical: Sizes.screenHeight * 0.02),
  //       child: Column(
  //         children: [
  //           Sizes.spaceHeight10,
  //           TextConst(
  //             AppLocalizations.of(context)!.working_hours,
  //             size: Sizes.fontSizeSix * 1.07,
  //             fontWeight: FontWeight.w500,
  //           ),
  //           SizedBox(
  //             height: Sizes.screenHeight * 0.05,
  //           ),
  //           Column(
  //             spacing: 15,
  //             children:
  //                 List.generate(slotScheduleCon.allSlots.length, (slotIndex) {
  //               final slotData = slotScheduleCon.allSlots[slotIndex];
  //               return Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   CustomSwitch(
  //                     value: slotData['available_flag'] == 'Y',
  //                     onChanged: (bool val) {
  //                       slotScheduleCon
  //                           .toggleSelectedDateAvailability(slotIndex);
  //                     },
  //                   ),
  //                   Sizes.spaceWidth15,
  //                   SizedBox(
  //                     width: Sizes.screenWidth * 0.12,
  //                     child: TextConst(
  //                       slotData['dd_month_name'],
  //                       size: Sizes.fontSizeFourPFive,
  //                       fontWeight: FontWeight.w400,
  //                       color: AppColor.textfieldGrayColor,
  //                     ),
  //                   ),
  //                   Sizes.spaceWidth5,
  //                   Sizes.spaceWidth3,
  //                   Column(
  //                     children:
  //                         List.generate(slotData['timing'].length, (timeIndex) {
  //                       final timingData = slotData['timing'][timeIndex];
  //                       return Container(
  //                         margin: const EdgeInsets.only(bottom: 8),
  //                         alignment: Alignment.centerRight,
  //                         width: Sizes.screenWidth * 0.61,
  //                         child: Row(
  //                           children: [
  //                             GestureDetector(
  //                               onTap: () {
  //                                 slotScheduleCon.selectTime(context, slotIndex,
  //                                     timeIndex, 'start_time');
  //                               },
  //                               child: Container(
  //                                 height: Sizes.screenHeight * 0.03,
  //                                 width: Sizes.screenWidth * 0.24,
  //                                 decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(7),
  //                                     color: AppColor.textfieldGrayColor
  //                                         .withOpacity(0.5)),
  //                                 child: Center(
  //                                   child: TextConst(
  //                                     timingData['start_time'],
  //                                     size: Sizes.fontSizeFourPFive,
  //                                     fontWeight: FontWeight.w400,
  //                                     color: AppColor.textfieldTextColor
  //                                         .withOpacity(0.8),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             Sizes.spaceWidth3,
  //                             const Icon(
  //                               Icons.remove,
  //                               size: 15,
  //                               color: AppColor.textfieldTextColor,
  //                             ),
  //                             Sizes.spaceWidth3,
  //                             GestureDetector(
  //                               onTap: () {
  //                                 slotScheduleCon.selectTime(context, slotIndex,
  //                                     timeIndex, 'end_time');
  //                               },
  //                               child: Container(
  //                                 height: Sizes.screenHeight * 0.03,
  //                                 width: Sizes.screenWidth * 0.24,
  //                                 decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(7),
  //                                     color: AppColor.textfieldGrayColor
  //                                         .withOpacity(0.5)),
  //                                 child: Center(
  //                                   child: TextConst(
  //                                     timingData['end_time'],
  //                                     size: Sizes.fontSizeFourPFive,
  //                                     fontWeight: FontWeight.w400,
  //                                     color: AppColor.textfieldTextColor
  //                                         .withOpacity(0.8),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             Sizes.spaceWidth10,
  //                             (timeIndex == 0)
  //                                 ? GestureDetector(
  //                                     onTap: () {
  //                                       if (slotData['timing'].length < 3) {
  //                                         slotScheduleCon.addMoreTimeAtDate(
  //                                             slotIndex,
  //                                             slotData['timing'].length);
  //                                       } else {
  //                                         debugPrint(
  //                                             "No more slot addition allowed");
  //                                       }
  //                                     },
  //                                     child: const Icon(
  //                                       Icons.add_circle_outline,
  //                                       size: 15,
  //                                       color: AppColor.black,
  //                                     ),
  //                                   )
  //                                 : GestureDetector(
  //                                     onTap: () {
  //                                       if (slotData['timing'].length > 1) {
  //                                         slotScheduleCon.removeTimeAtDate(
  //                                             slotIndex, timeIndex);
  //                                       } else {
  //                                         debugPrint(
  //                                             "No more slot deletion allowed");
  //                                       }
  //                                     },
  //                                     child: const Icon(
  //                                       Icons.cancel_outlined,
  //                                       size: 15,
  //                                       color: Colors.red,
  //                                     ),
  //                                   ),
  //                           ],
  //                         ),
  //                       );
  //                     }),
  //                   )
  //                 ],
  //               );
  //             }),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }
}
