// doctor_section/d_view_model/upser_smc_number_view_model.dart
import 'package:aim_swasthya/model/doctor/doctor_profile_model.dart';
import 'package:aim_swasthya/model/doctor/upsert_smc_number_model.dart';
import 'package:aim_swasthya/doctor_section/d_repo/doctor_profile_repo.dart';
import 'package:aim_swasthya/doctor_section/d_repo/upsert_smc_number_repo.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../utils/utils.dart' show Utils;

class UpsertSmcNumberViewModel extends ChangeNotifier {
  final _upsertSmcNumberRepo = UpsertSmcNumberRepo();
  bool _loading = false;
  bool get loading => _loading;

  UpsertSmcNumberModel? _upsertSmcNumberModel;
  UpsertSmcNumberModel? get upsertSmcNumberModel => _upsertSmcNumberModel;
  setUpsertSmcNumber(UpsertSmcNumberModel? value) {
    _upsertSmcNumberModel = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> docUpsertSmcNumberApi(dynamic smcNumber,context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "smc_number": smcNumber,
      "doctor_id": userId,
    };
    debugPrint("body: $data");
    _upsertSmcNumberRepo.upsertSmcNumberApi(data).then((value) {
      Utils.show(value.message ?? "No message", context);
      if (value.status == true) {
        setUpsertSmcNumber(value);
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
