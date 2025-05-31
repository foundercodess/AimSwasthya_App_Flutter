import 'dart:convert';
import 'package:aim_swasthya/model/user/upsert_wellness_model.dart';
import 'package:aim_swasthya/repo/user/upsert_wellness_library_repo.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/foundation.dart';

class UpsertWellnessLibraryViewModel extends ChangeNotifier {
  final _upsertWellnessLibraryRepo = UpsertWellnessLibraryRepo();

  bool _loading = false;
  bool get loading => _loading;

  UpsertWellnessLibraryModel? _upsertWellnessLibraryModel;
  UpsertWellnessLibraryModel? get upsertWellnessLibraryModel =>
      _upsertWellnessLibraryModel;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setUpsertWellnessData(UpsertWellnessLibraryModel value) {
    _upsertWellnessLibraryModel = value;
    notifyListeners();
  }

  bool _isFavourite = false;
  bool get isFavourite => _isFavourite;

  void setFavourite(bool value) {
    _isFavourite = value;
    notifyListeners();
  }

  void removeFromFavorites(value) {
    _upsertWellnessLibraryModel?.data?.removeAt(value);
    notifyListeners();
  }

  Future<void> upsertWellnessApi(dynamic healthTipId,context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "patient_id": userId,
      "health_tip_id":healthTipId,
      "favourite_flag":"Y"
    };
    print(jsonEncode(data));
    _upsertWellnessLibraryRepo.upsertWellnessApi(data).then((value) {
      if (value.status == true) {
        setUpsertWellnessData(value);
        setFavourite(true);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
