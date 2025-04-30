import 'package:aim_swasthya/model/user/patient_preferred_doc_model.dart';
import 'package:aim_swasthya/repo/user/patient_preferred_doc_repo.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
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
    double latitude = double.parse(locationData!.latitude.toString());
    double longitude = double.parse(locationData.longitude.toString());
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