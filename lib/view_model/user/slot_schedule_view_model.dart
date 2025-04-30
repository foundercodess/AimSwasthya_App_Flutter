import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class SlotScheduleViewModel extends ChangeNotifier{

  List<Map<String, dynamic>> generateSlots({
    required int doctorId,
    required int clinicId,
    required DateTime startDate,
    int days = 7,
  }) {
    final List<Map<String, String>> timeSlots = [
      {'start_time': '08:00 AM', 'end_time': '11:00 AM'},
      {'start_time': '02:00 PM', 'end_time': '04:00 PM'},
      {'start_time': '06:00 PM', 'end_time': '08:00 PM'},
    ];

    List<Map<String, dynamic>> allSlots = [];

    for (int i = 0; i < days; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      String availabilityDate = DateFormat('yy-MM-dd').format(currentDate);
      String ddMonthName = DateFormat('dd-MMM').format(currentDate);

      for (var slot in timeSlots) {
        allSlots.add({
          'doctor_id': doctorId,
          'clinic_id': clinicId,
          'availability_date': availabilityDate,
          'dd_month_name': ddMonthName,
          'start_time': slot['start_time'],
          'end_time': slot['end_time'],
          'available_flag': 'Y',
        });
      }
      debugPrint("slots data: $allSlots");
    }

    return allSlots;
  }

}