import 'dart:convert';

import 'package:aim_swasthya/model/user/patient_medical_records_model.dart';
import 'package:aim_swasthya/repo/user/patient_medical_records_repo.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/foundation.dart';

class PatientMedicalRecordsViewModel extends ChangeNotifier {
  final _patientMedicalRecordsRepo = PatientMedicalRecordsRepo();

  bool _loading = false;
  bool get loading => _loading;

  GetMedicalRecordData? _patientMedicalRecordsModel;
  GetMedicalRecordData? get patientMedicalRecordsModel =>
      _patientMedicalRecordsModel;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setPatientMedRecData(GetMedicalRecordData value) {
    _patientMedicalRecordsModel = value;
    notifyListeners();
  }

  Future<void> patientMedRecApi() async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    print("ghjkjlk: $userId");
    Map data = {
      "entity_id": "$userId",
      "entity_type": "patient" ,
      "file_type": "medical_record"
    };
    print(jsonEncode(data));
    _patientMedicalRecordsRepo.patientMedicalRecordsApi(data).then((value) {
      if (value.status == true) {
        setPatientMedRecData(value);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
