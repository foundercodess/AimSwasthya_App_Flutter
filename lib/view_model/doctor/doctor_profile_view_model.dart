import 'package:aim_swasthya/model/doctor/doctor_profile_model.dart';
import 'package:aim_swasthya/repo/doctor/doctor_profile_repo.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DoctorProfileViewModel extends ChangeNotifier {
  final _doctorProfileRepo = DoctorProfileRepo();
  bool _loading = false;
  bool get loading => _loading;

  DoctorProfileModel? _doctorProfileModel;
  DoctorProfileModel? get doctorProfileModel => _doctorProfileModel;
  setProfileDate(DoctorProfileModel value) {
    _doctorProfileModel = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> doctorProfileApi(BuildContext context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "doctor_id": 6,
    };
    debugPrint("body: $data");
    _doctorProfileRepo.doctorProfileApi(data).then((value) {
      if (value.status == true) {
        setProfileDate(value);
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
