// patient_section/p_view_model/patient_medical_records_view_model.dart
import 'dart:convert';
import 'package:aim_swasthya/model/user/patient_medical_records_model.dart';
import 'package:aim_swasthya/patient_section/p_repo/patient_medical_records_repo.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_home_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

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

  Future<void> patientMedRecApi(context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    print("ghjkjlk: $userId");
    Map data = {
      "entity_id": "$userId",
      "entity_type": "patient",
      "file_type": "medical_record"
    };
    print(jsonEncode(data));
    _patientMedicalRecordsRepo.patientMedicalRecordsApi(data).then((value) {
      if (value.status == true) {
        Provider.of<PatientHomeViewModel>(context, listen: false)
            .patientHomeApi(context);
        setPatientMedRecData(value);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
