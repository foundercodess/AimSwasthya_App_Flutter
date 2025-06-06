// doctor_section/d_view_model/schedule_doctor_view_model.dart
import 'dart:convert';
import 'package:aim_swasthya/model/doctor/doc_schedule_model.dart';
import 'package:aim_swasthya/doctor_section/d_repo/doc_schedule_repo.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';

class ScheduleDoctorViewModel extends ChangeNotifier {
  final _docScheduleRepo = DocScheduleRepo();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ScheduleDoctorModel? _scheduleDoctorModel;
  ScheduleDoctorModel? get scheduleDoctorModel => _scheduleDoctorModel;
  setRevenueDoctorData(ScheduleDoctorModel value) {
    _scheduleDoctorModel = value;
    notifyListeners();
  }
  // Future<void> docScheduleApi(dynamic clinicId) async {
  //   final userId = await UserViewModel().getUser();
  //   setLoading(true);
  //   Map data = {
  //     "doctor_id": userId,
  //     "clinic_id": clinicId
  //   };
  //   print("app sch dt: ${jsonEncode(data)}");
  //   _docScheduleRepo.docScheduleApi(data).then((value) {
  //     if (value.status == true) {
  //       setRevenueDoctorData(value);
  //     }
  //     setLoading(false);
  //   }).onError((error, stackTrace) {
  //     if (kDebugMode) {
  //       print('error: $error');
  //     }
  //     setLoading(false);
  //   });
  // }
}
