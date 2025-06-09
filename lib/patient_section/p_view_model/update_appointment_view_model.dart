// patient_section/p_view_model/update_appointment_view_model.dart
import 'dart:convert';

import 'package:aim_swasthya/patient_section/p_repo/updateAppointmentDetails.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_appointment_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_home_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/user/patient_Appointment_model.dart';

class UpdateAppointmentViewModel extends ChangeNotifier {
  final _updateAppointmentRepo = UpdateAppointmentRepo();

  AppointmentsData? _rescheduleAppointmentData;
  AppointmentsData? get rescheduleAppointmentData=> _rescheduleAppointmentData;
  setRescheduleAppointmentData(AppointmentsData? data){
    _rescheduleAppointmentData=null;
    _rescheduleAppointmentData= data;
    notifyListeners();
  }
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
    final bookingDateFormatted = DateFormat("yyyy-MM-dd").format(
      DateFormat("dd-MM-yyyy").parse(bookingDate!.toString()),
    );
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "patient_id": userId,
      "doctor_id": docId,
      "clinic_id": clinicId,
      "booking_date": bookingDateFormatted,
      "time_id": timeId,
      "appointment_id": appId,
      // "appointment_id": _rescheduleAppointmentID,
      "status": "scheduled"
    };
    print("datfkhja: ${jsonEncode(data)}");
    _updateAppointmentRepo.updateAppointmentApi(data).then((value) {
      Utils.show(value['message'], context);
      if (value['status'] == true) {
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
