import 'dart:convert';
import 'package:aim_swasthya/model/user/get_wellness_library_model.dart';
import 'package:aim_swasthya/repo/user/getPatient_Wellness_repo.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/foundation.dart';

class GetWellnessLibraryViewModel extends ChangeNotifier {
  final _upsertWellnessLibraryRepo = GetPatientWellnessRepo();

  bool _loading = false;
  bool get loading => _loading;

  GetWellnessLibraryModel? _getWellnessLibraryModel;
  GetWellnessLibraryModel? get getWellnessLibraryModel =>
      _getWellnessLibraryModel;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setPatientWellnessData(GetWellnessLibraryModel value) {
    value.data = value.data?.where((item) => item.favouriteFlag == "Y").toList();
    _getWellnessLibraryModel = value;
    notifyListeners();
  }

  void removeFromFavorites(int index) {
    _getWellnessLibraryModel?.data?.removeAt(index);
    notifyListeners();
  }
  //
  // setPatientWellnessData(GetWellnessLibraryModel value) {
  //   _getWellnessLibraryModel = value;
  //   notifyListeners();
  // }
  //
  // void removeFromFavorites(int index) {
  //   _getWellnessLibraryModel?.data?.removeAt(index);
  //   notifyListeners();
  // }

  Future<void> getPatientWellnessApi(context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "patient_id": userId,
    };
    debugPrint("aslkmd${jsonEncode(data)}");
    _upsertWellnessLibraryRepo.getWellnessLibraryApi(data).then((value) {
      if (value.status == true) {
        setPatientWellnessData(value);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
