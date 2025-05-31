import 'dart:convert';

import 'package:aim_swasthya/repo/user/updateAppointmentDetails.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/view_model/user/patient_appointment_view_model.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateAppointmentViewModel extends ChangeNotifier {
  final _updateAppointmentRepo = UpdateAppointmentRepo();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String _rescheduleAppointmentID = '';

  setRescheduleAppointmentID(String id) {
    _rescheduleAppointmentID = id;
    notifyListeners();
  }

  Future<void> updateAppointmentApi(
    context, {
    dynamic docId,
    dynamic clinicId,
    dynamic bookingDate,
    dynamic timeId,
    dynamic appId,
  }) async {
    print("jhghjgj");
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "patient_id": userId,
      "doctor_id": docId,
      "clinic_id": clinicId,
      "booking_date": DateFormat("yyyy-MM-dd")
          .format(DateTime.parse(bookingDate)),
      "time_id": timeId,
      "appointment_id": appId,
      // "appointment_id": _rescheduleAppointmentID,
      "status": "scheduled"
    };
    print("datfkhja: ${jsonEncode(data)}");
    _updateAppointmentRepo.updateAppointmentApi(data).then((value) {
      Utils.show(value['message'], context);
      if (value['status'] == true) {
        // setRescheduleAppointmentID("");
        Provider.of<PatientAppointmentViewModel>(context, listen: false)
            .patientAppointmentApi(context);
        Provider.of<PatientHomeViewModel>(context, listen: false)
            .patientHomeApi(context);
        Navigator.pop(context);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
