import 'package:aim_swasthya/model/doctor/doc_home_model.dart';
import 'package:aim_swasthya/repo/doctor/doc_home_repo.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DoctorHomeViewModel extends ChangeNotifier {
  final _doctorHomeRepo = DoctorHomeRepo();
  bool _loading = false;
  bool get loading => _loading;

  DoctorHomeModel? _doctorHomeModel;
  DoctorHomeModel? get doctorHomeModel => _doctorHomeModel;

  setHomeDate(DoctorHomeModel value) {
    _doctorHomeModel = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> doctorHomeApi(BuildContext context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "doctor_id": 8,
    };
    debugPrint("body: $data");
    _doctorHomeRepo.doctorHomeApi(data).then((value) {
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
