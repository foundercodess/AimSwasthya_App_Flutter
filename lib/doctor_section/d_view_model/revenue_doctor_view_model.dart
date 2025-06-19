// doctor_section/d_view_model/revenue_doctor_view_model.dart
import 'dart:convert';
import 'package:aim_swasthya/model/doctor/revenue_doctor_model.dart';
import 'package:aim_swasthya/doctor_section/d_repo/revenue_doctor_repo.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';

class RevenueDoctorViewModel extends ChangeNotifier {
  final _revenueDoctorRepo = RevenueDoctorRepo();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }


  String _selectedMonth = '';
  String _selectedAmount = '';

  String get selectedMonth => _selectedMonth;
  String get selectedAmount => _selectedAmount;

  void setSelectedMonthAndAmount(String month, String amount) {
    _selectedMonth = month;
    _selectedAmount = amount;
    notifyListeners();
  }

  void setDefaultMonthAndAmount(List<EarningMonth>? list) {
    if (list != null && list.isNotEmpty) {
      _selectedMonth = list.first.monthYear ?? '';
      _selectedAmount = list.first.totalAmount?.toString() ?? '0';
      notifyListeners();
    }
  }

  RevenueDoctorModel? _revenueDoctorModel;
  RevenueDoctorModel? get revenueDoctorModel => _revenueDoctorModel;
  setRevenueDoctorData(RevenueDoctorModel value) {
    _revenueDoctorModel = value;
    setDefaultMonthAndAmount(value.earningMonth);
    notifyListeners();
  }


  List<RevenueDoctorModel> _transactions = [];

  List<RevenueDoctorModel> get transactions => _transactions;

  void setTransactions(List<dynamic> jsonList) {
    _transactions = jsonList.map((json) => RevenueDoctorModel.fromJson(json)).toList();
    notifyListeners();
  }

  Future<void> revenueDoctorApi( ) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "doctor_id" : userId
    };
    debugPrint(jsonEncode(data));
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
