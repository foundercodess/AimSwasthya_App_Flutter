import 'dart:convert';
import 'package:aim_swasthya/model/user/patient_profile_model.dart';
import 'package:aim_swasthya/repo/user/patient_profile_repo.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/foundation.dart';

class UserPatientProfileViewModel extends ChangeNotifier {
  final _userPatientProfileRepo = UserPatientAppointmentRepo();

  bool _loading = false;
  bool get loading => _loading;

  UserPatientProfileModel? _userPatientProfileModel;
  UserPatientProfileModel? get userPatientProfileModel =>
      _userPatientProfileModel;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setUserPatientProfileData(UserPatientProfileModel value) {
    _userPatientProfileModel = value;
    notifyListeners();
  }

  Future<void> userPatientProfileApi() async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    print("ghjkjlk: $userId");
    Map data = {
      "patient_id": "$userId",
    };
    print(jsonEncode(data));
    _userPatientProfileRepo.userPatientProfileApi(data).then((value) {
      if (value.status == true) {
        setUserPatientProfileData(value);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
