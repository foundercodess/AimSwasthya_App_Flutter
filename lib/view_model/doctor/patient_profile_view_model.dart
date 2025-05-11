// view_model/doctor/patient_profile_view_model.dart
import 'package:aim_swasthya/model/doctor/patient_profile_model.dart';
import 'package:aim_swasthya/repo/doctor/patient_profile_repo.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../utils/routes/routes_name.dart';

class PatientProfileViewModel extends ChangeNotifier {
  final _patientProfileRepo = PatientProfileRepo();
  bool _loading = false;
  bool get loading => _loading;

  PatientProfileModel? _patientProfileModel;
  PatientProfileModel? get patientProfileModel => _patientProfileModel;

  setHomeDate(PatientProfileModel value) {
    _patientProfileModel = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> patientProfileApi(patientId,context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "patient_id": patientId,
      "doctor_id" : userId
    };
    debugPrint("body: $data");
    _patientProfileRepo.patientProfileApi(data).then((value) {
      if (value.status == true) {
        setHomeDate(value);
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
