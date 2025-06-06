// patient_section/p_view_model/patient_pref_doc_view_model.dart
import 'package:aim_swasthya/model/user/patient_preferred_doc_model.dart';
import 'package:aim_swasthya/patient_section/p_repo/patient_preferred_doc_repo.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_home_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class PatientPrefDocViewModel extends ChangeNotifier {
  final _patientMedicalRecordsRepo = PatientPreferredDocRepo();

  bool _loading = false;
  bool get loading => _loading;

  PatienPreferredDocModel? _patienPreferredDocModel;
  PatienPreferredDocModel? get patienPreferredDocModel => _patienPreferredDocModel;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setPatientPrefDocData(PatienPreferredDocModel value) {
    _patienPreferredDocModel = value;
    notifyListeners();
  }

  Future<void> patientPrefDocApi(context) async {

    final userId = await UserViewModel().getUser();
    setLoading(true);
    final locationData =
        Provider.of<PatientHomeViewModel>(context, listen: false)
            .selectedLocationData;
    double latitude = double.tryParse(locationData!.latitude.toString())??0.0;
    double longitude = double.tryParse(locationData.longitude.toString())??0.0;
    Map data = {
      "patient_id": userId,
    };
    print("bnvnv: $data");
    _patientMedicalRecordsRepo.patienPreferredDocApi(data).then((value) {
      if (value.status == true) {
        setPatientPrefDocData(value);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}