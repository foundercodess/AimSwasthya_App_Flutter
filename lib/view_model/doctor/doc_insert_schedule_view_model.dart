import 'dart:convert';
import 'package:aim_swasthya/repo/doctor/insert_schedule_doc_repo.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/foundation.dart';

class DocInsertScheduleViewModel extends ChangeNotifier {
  final _docInsertScheduleRepo = DocInsertScheduleRepo();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> docScheduleInsertApi( ) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "doctor_id" : "36"
    };
    print(jsonEncode(data));
    _docInsertScheduleRepo.docInsertScheduleApi(data).then((value) {
      if (value["status"] == true) {
        // setRevenueDoctorData(value);
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
