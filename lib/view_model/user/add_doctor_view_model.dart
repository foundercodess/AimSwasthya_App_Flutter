import 'dart:convert';
import 'package:aim_swasthya/repo/user/add_patient_doctor_repo.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'doctor_avl_appointment_view_model.dart';

class AddDoctorViewModel extends ChangeNotifier {
  final _addDoctorRepo = AddPatientDoctorRepo();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addDoctorApi(dynamic docId, context, {dynamic clinicId}) async {
    final userId = await UserViewModel().getUser();
    final locationData =
        Provider.of<PatientHomeViewModel>(context, listen: false)
            .selectedLocationData;
    double latitude = double.parse(locationData!.latitude.toString());
    double longitude = double.parse(locationData.longitude.toString());
    setLoading(true);
    Map data = {
      "lat": latitude,
      "lon": longitude,
      "clinic_id": clinicId,
      "patient_id": userId,
      "doctor_id": docId,
    };
    _addDoctorRepo.addDoctorApi(data).then((value) {
      Utils.show(value['message'], context);
      if (value['status'] == true) {
        if (clinicId != null) {
          final docDCon = Provider.of<DoctorAvlAppointmentViewModel>(context,
              listen: false);
          docDCon.doctorAvlAppointmentApi(docId, clinicId, context,
              clearCon: false);
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
