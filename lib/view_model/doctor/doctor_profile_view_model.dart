// view_model/doctor/doctor_profile_view_model.dart
import 'dart:convert';

import 'package:aim_swasthya/model/doctor/doctor_profile_model.dart';
import 'package:aim_swasthya/repo/doctor/doctor_profile_repo.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/view_model/doctor/doc_home_view_model.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class DoctorProfileViewModel extends ChangeNotifier {
  final _doctorProfileRepo = DoctorProfileRepo();
  bool _loading = false;
  bool get loading => _loading;

  bool _isEditMode = false;
  bool get isEditMode => _isEditMode;

  void setEditMode(bool value) {
    _isEditMode = value;
    notifyListeners();
  }

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

  Future<void> doctorProfileApi(BuildContext context,
      {bool isLoad = true}) async {
    final userId = await UserViewModel().getUser();
    if (isLoad) {
      setLoading(true);
    }
    Map data = {
      "doctor_id": userId,
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

  Future<bool> updateDoctorProfileApi(
    BuildContext context, {
    required String name,
    required String gender,
    required String email,
    required String phoneNumber,
    required String specializationId,
    required String practiceStartYear,
  }) async {
    try {
      final userId = await UserViewModel().getUser();
      Map data = {
        "doctor_id": userId,
        "name": name,
        "gender": gender,
        "email": email,
        "phone_number": phoneNumber,
        "specialization_id": specializationId,
        "practice_start_year": practiceStartYear,
      };
      debugPrint("bodyff: ${jsonEncode(data)}");
      final response = await _doctorProfileRepo.updateDoctorProfileApi(data);
      if (response['status'] == true) {
        await doctorProfileApi(context, isLoad: false);
        Provider.of<DoctorHomeViewModel>(context, listen: false)
            .doctorHomeApi(context);
        Utils.show(response['message'], context);
        return true;
      } else {
        Utils.show(response['message'] ?? "Update failed", context);
        return false;
      }
    } catch (error) {
      if (kDebugMode) {
        print('error: $error');
      }
      Utils.show("Something went wrong", context);
      return false;
    }
  }
}
