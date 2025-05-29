import 'package:aim_swasthya/model/user/upsert_family_member_model.dart';
import 'package:aim_swasthya/repo/user/upsert_family_member_repo.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UpsertFamilyMemberViewModel extends ChangeNotifier {
  final _upsertFamilyMemberRepo = UpsertFamilyMemberRepo();
  bool _loading = false;
  bool get loading => _loading;

  UpsertFamilyMemberModel? _upsertFamilyMemberModel;
  UpsertFamilyMemberModel? get upsertFamilyMemberModel =>
      _upsertFamilyMemberModel;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setFamilyMemberData(UpsertFamilyMemberModel value) {
    _upsertFamilyMemberModel = value;
    notifyListeners();
  }

  Future<void> upsertFamilyMemberApi(
    BuildContext context,
    dynamic familyId,
    dynamic name,
    dynamic gender,
    dynamic email,
    dynamic phone,
    dynamic dob,
    dynamic height,
    dynamic weight,
    dynamic relation,
  ) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "family_member_id": familyId,
      "patient_id": userId,
      "name": name,
      "gender": gender,
      "email": email,
      "phone_number": phone,
      "date_of_birth": dob,
      "height": height,
      "weight": weight,
      "relation": relation
    };
    debugPrint("body: $data");
    _upsertFamilyMemberRepo.upsertFamilyMemberApi(data).then((value) {
      if (value.status == true) {
        setFamilyMemberData(value);
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
