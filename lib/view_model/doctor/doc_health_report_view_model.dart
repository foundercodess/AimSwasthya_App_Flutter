import 'dart:convert';
import 'package:aim_swasthya/model/doctor/doc_medical_reports_model.dart';
import 'package:aim_swasthya/repo/doctor/doc_health_report_repo.dart';
import 'package:flutter/foundation.dart';

class DocHealthReportViewModel extends ChangeNotifier {
  final _docHealthReportRepo = DocHealthReportRepo();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  MedicalHealthReportModel? _medicalHealthReportModel;
  MedicalHealthReportModel? get medicalHealthReportModel => _medicalHealthReportModel;
  setMedicalHealthData(MedicalHealthReportModel value) {
    _medicalHealthReportModel = value;
    notifyListeners();
  }
  Future<void> medicalHealthReportApi(dynamic patientId, ) async {
    setLoading(true);
    Map data = {
      "patient_id" : "42"
    };
    print(jsonEncode(data));
    _docHealthReportRepo.docMedicalHealthReportApi(data).then((value) {
      if (value.status == true) {
        setMedicalHealthData(value);
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
      setLoading(false);
    });
  }
}
