// doctor_section/d_view_model/doc_insert_schedule_view_model.dart
import 'dart:convert';
import 'package:aim_swasthya/doctor_section/d_repo/insert_schedule_doc_repo.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';

class DocInsertScheduleViewModel extends ChangeNotifier {
  final _docInsertScheduleRepo = DocInsertScheduleRepo();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }


}
