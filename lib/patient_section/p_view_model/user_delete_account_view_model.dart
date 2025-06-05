// patient_section/p_view_model/user_delete_account_view_model.dart
import 'dart:convert';
import 'package:aim_swasthya/model/user/user_delete_account_model.dart';
import 'package:aim_swasthya/patient_section/p_repo/user_delete_account_repo.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../utils/routes/routes_name.dart';

class UserDeleteAccountViewModel extends ChangeNotifier {
  final _userDeleteAccountDoctorRepo = UserDeleteAccountRepo();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  UserDeleteAccountModel? _userDeleteAccountModel;
  UserDeleteAccountModel? get userDeleteAccountModel => _userDeleteAccountModel;
  setUserDeleteProfileData(UserDeleteAccountModel value) {
    _userDeleteAccountModel = value;
    notifyListeners();
  }
  Future<void> userDeleteAccountApi(context) async {
    setLoading(true);
    final userId = await UserViewModel().getUser();
    Map data = {
      "patient_id" : userId
    };
    print("hdued${jsonEncode(data)}");
    _userDeleteAccountDoctorRepo.userDeleteProfileApi(data).then((value) {
      if (value.status == true) {
        UserViewModel().remove();
        // Navigator.pushNamed(
        //     context, RoutesName.introScreen);
        Navigator.pushNamedAndRemoveUntil(context,
            RoutesName.introScreen, (context) => false);
        setUserDeleteProfileData(value);
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
