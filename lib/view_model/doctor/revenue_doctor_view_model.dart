import 'dart:convert';
import 'package:aim_swasthya/model/doctor/revenue_doctor_model.dart';
import 'package:aim_swasthya/repo/doctor/revenue_doctor_repo.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/foundation.dart';

class RevenueDoctorViewModel extends ChangeNotifier {
  final _revenueDoctorRepo = RevenueDoctorRepo();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  RevenueDoctorModel? _revenueDoctorModel;
  RevenueDoctorModel? get revenueDoctorModel => _revenueDoctorModel;
  setRevenueDoctorData(RevenueDoctorModel value) {
    _revenueDoctorModel = value;
    notifyListeners();
  }
  Future<void> revenueDoctorApi( ) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "doctor_id" : userId
    };
    print(jsonEncode(data));
    _revenueDoctorRepo.revenueDoctorApi(data).then((value) {
      if (value.status == true) {
        setRevenueDoctorData(value);
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
