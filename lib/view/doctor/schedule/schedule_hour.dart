// view/doctor/schedule/schedule_hour.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../res/color_const.dart';
import '../../../res/size_const.dart';
import '../../../res/switch_btn.dart';
import '../../../res/text_const.dart';
import '../../../view_model/user/slot_schedule_view_model.dart';

class ScheduleHour extends StatelessWidget {
  const ScheduleHour({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SlotScheduleViewModel>(
        builder: (context, slotScheduleCon, _) {
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
                      children: List.generate(slotData['timings'].length,
                          (timeIndex) {
                        final timingData = slotData['timings'][timeIndex];
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
                              if (timeIndex == 0 && slotData['timings'].length < 3)
                                GestureDetector(
                                  onTap: () {
                                    if (slotData['timings'].length < 3) {
                                      slotScheduleCon.addMoreTimeAtDate(
                                          slotIndex,
                                          slotData['timings'].length);
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
                                ),
                              if (timeIndex > 0)
                                GestureDetector(
                                  onTap: () {
                                    if (slotData['timings'].length > 1) {
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
                  ],
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
