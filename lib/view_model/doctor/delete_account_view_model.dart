import 'dart:convert';
import 'package:aim_swasthya/model/doctor/delete_account_model.dart';
import 'package:aim_swasthya/model/doctor/doc_medical_reports_model.dart';
import 'package:aim_swasthya/repo/doctor/delete_account_repo.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../utils/routes/routes_name.dart';

class DeleteAccountViewModel extends ChangeNotifier {
  final _deleteAccountDoctorRepo = DeleteAccountDoctorRepo();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  DeleteAccountModel? _deleteAccountModel;
  DeleteAccountModel? get deleteAccountModel => _deleteAccountModel;
  setDeleteAccountData(DeleteAccountModel value) {
    _deleteAccountModel = value;
    notifyListeners();
  }
  Future<void> deleteAccountApi( context) async {
    setLoading(true);
    final userId = await UserViewModel().getUser();
    Map data = {
      "doctor_id" : userId
    };
    print(jsonEncode(data));
    _deleteAccountDoctorRepo.deleteAccountApi(data).then((value) {
      if (value.status == true) {
        UserViewModel().remove();
        // Navigator.pushNamed(
        //     context, RoutesName.introScreen);
        Navigator.pushNamedAndRemoveUntil(context,
            RoutesName.introScreen, (context) => false);
        setDeleteAccountData(value);
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
