// view/doctor/schedule/range_calander_overlay.dart
import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import '../../../patient_section/p_view_model/slot_schedule_view_model.dart';

class RangeCalenderOverlay extends StatelessWidget {
  const RangeCalenderOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final slotScheduleCon = Provider.of<SlotScheduleViewModel>(context);
    final now = DateTime.now();
    final firstDate = now.subtract(const Duration(days: 365));
    final lastDate = now.add(const Duration(days: 365));
    return Dialog(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextConst("Select date range"),
          Sizes.spaceHeight10,
          dp.RangePicker(
            selectedPeriod: slotScheduleCon.selectedRange == null
                ? dp.DatePeriod(now, now)
                : dp.DatePeriod(
                    slotScheduleCon.selectedRange!.start,
                    slotScheduleCon.selectedRange!.end,
                  ),
            onChanged: (dp.DatePeriod period) {
              final range = DateTimeRange(
                start: period.start,
                end: period.end,
              );
              final days = range.end.difference(range.start).inDays + 1;
              if (days <= 7) {
                slotScheduleCon.setRange(range);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select a range of up to 7 days.'),
                  ),
                );
              }
            },
            firstDate: firstDate,
            lastDate: lastDate,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (slotScheduleCon.selectedRange != null)
                Padding(
                  padding:const EdgeInsets.only(left: 10),
                  child: TextConst(
                    "Selected Date- ${DateFormat('d MMMM').format(slotScheduleCon.selectedRange!.start.toLocal())} - ${DateFormat('d MMMM').format(slotScheduleCon.selectedRange!.end.toLocal())}",
                    size: Sizes.fontSizeFour,
                    fontWeight: FontWeight.w400,
                    color: AppColor.lightBlack,
                  ),
                ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: TextConst("Done", color: AppColor.blue,)),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
