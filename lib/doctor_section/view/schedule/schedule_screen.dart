// doctor_section/view/schedule/schedule_screen.dart
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/doctor_section/view/schedule/range_calander_overlay.dart';
import 'package:aim_swasthya/doctor_section/view/schedule/schedule_hour.dart';
import 'package:aim_swasthya/patient_section/p_view_model/bottom_nav_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/slot_schedule_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:aim_swasthya/l10n/app_localizations.dart';
import 'clinic_location_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
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
    final slotScheduleCon = Provider.of<SlotScheduleViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.white,
      appBar: appBarConstant(
          context, isBottomAllowed: true, onTap: () {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (slotScheduleCon.widgetIndex > 2) ...[
            GestureDetector(
              onTap: () {
                slotScheduleCon.setWidgetIndex(2);
              },
              child: TextConst(
                "Re-select date range",
                color: const Color(0xff767676),
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xff767676),
                size: Sizes.fontSizeFourPFive,
              ),
            ),
            Sizes.spaceHeight35,
          ],
          AppBtn(
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
                  Utils.show(
                      "Please select a clinic to continue schedule creation",
                      context);
                } else {
                  slotScheduleCon.docScheduleApi();
                  slotScheduleCon.setWidgetIndex(2);
                }
              } else if (slotScheduleCon.widgetIndex == 2) {
                slotScheduleCon.docScheduleSlotTypeApi(context);
              } else {
                slotScheduleCon.docScheduleInsertApi(context);
              }
            },
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget appBarConstant(BuildContext context,
      {Widget? child,
      bool isBottomAllowed = false,
      String? label,
      void Function()? onTap}) {
    return AppBar(
      elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        leadingWidth: 30,
        toolbarHeight: 30,
        leading: GestureDetector(
            onTap: onTap ??
                () {
                  Navigator.pop(context);
                },
            child: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Image(
                image: AssetImage('assets/icons/back.png'),
                width: 20,
                height: 20,
                alignment: Alignment.center,
              ),
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
                size: Sizes.fontSizeFive,
                fontWeight: FontWeight.w400,
                color: AppColor.textfieldTextColor.withOpacity(0.7),
              ),
            ),
            SizedBox(
              height: Sizes.screenHeight * 0.09,
            ),
            Sizes.spaceHeight10,
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
            color:
                isSelected ? AppColor.lightBlue : AppColor.textfieldGrayColor,
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
                "${DateFormat('d MMMM').format(slotScheduleCon.selectedRange!.start.toLocal())} - ${DateFormat('d MMMM').format(slotScheduleCon.selectedRange!.end.toLocal())} ${DateFormat('yyyy').format(slotScheduleCon.selectedRange!.end.toLocal())}",
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
}
