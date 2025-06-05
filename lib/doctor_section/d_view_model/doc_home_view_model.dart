// doctor_section/d_view_model/doc_home_view_model.dart
import 'package:aim_swasthya/model/doctor/doc_home_model.dart';
import 'package:aim_swasthya/doctor_section/d_repo/doc_home_repo.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// import '../../model/doctor/revenue_doctor_model.dart' show EarningMonth;

class DoctorHomeViewModel extends ChangeNotifier {
  final _doctorHomeRepo = DoctorHomeRepo();
  bool _loading = false;
  bool get loading => _loading;

  DoctorHomeModel? _doctorHomeModel;
  DoctorHomeModel? get doctorHomeModel => _doctorHomeModel;

  setHomeDate(DoctorHomeModel value) {
    _doctorHomeModel = value;
    setDefaultMonthAndAmount(value.data!.earnings);
    notifyListeners();
  }

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

  void setDefaultMonthAndAmount(List<Earnings>? list) {
    if (list != null && list.isNotEmpty) {
      _selectedMonth = list.first.monthYear ?? '';
      _selectedAmount = list.first.totalamountformatted?.toString() ?? '0';
      notifyListeners();
    }
  }

  Future<void> doctorHomeApi(BuildContext context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "doctor_id": userId,
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
