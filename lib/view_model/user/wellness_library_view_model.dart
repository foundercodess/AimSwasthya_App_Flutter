// view_model/user/wellness_library_view_model.dart
import 'dart:convert';
import 'package:aim_swasthya/model/user/get_wellness_library_model.dart';
import 'package:aim_swasthya/model/user/upsert_wellness_model.dart';
import 'package:aim_swasthya/repo/user/getPatient_Wellness_repo.dart';
import 'package:aim_swasthya/repo/user/upsert_wellness_library_repo.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/foundation.dart';

class WellnessLibraryViewModel extends ChangeNotifier {
  final _getWellnessRepo = GetPatientWellnessRepo();
  final _upsertWellnessRepo = UpsertWellnessLibraryRepo();

  bool _loading = false;
  bool get loading => _loading;

  // Get Wellness Library Data
  GetWellnessLibraryModel? _getWellnessLibraryModel;
  GetWellnessLibraryModel? get getWellnessLibraryModel => _getWellnessLibraryModel;

  // Upsert Wellness Library Data
  UpsertWellnessLibraryModel? _upsertWellnessLibraryModel;
  UpsertWellnessLibraryModel? get upsertWellnessLibraryModel => _upsertWellnessLibraryModel;

  bool _isFavourite = false;
  bool get isFavourite => _isFavourite;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setFavourite(bool value) {
    _isFavourite = value;
    notifyListeners();
  }

  void setPatientWellnessData(GetWellnessLibraryModel value) {
    value.data = value.data?.where((item) => item.favouriteFlag == "Y").toList();
    _getWellnessLibraryModel = value;
    notifyListeners();
  }

  void setUpsertWellnessData(UpsertWellnessLibraryModel value) {
    _upsertWellnessLibraryModel = value;
    notifyListeners();
  }

  void removeFromFavorites(int index) {
    _getWellnessLibraryModel?.data?.removeAt(index);
    notifyListeners();
  }

  // Get Wellness Library API
  Future<void> getPatientWellnessApi(context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "patient_id": userId,
    };
    debugPrint("aslkmd${jsonEncode(data)}");
    _getWellnessRepo.getWellnessLibraryApi(data).then((value) {
      if (value.status == true) {
        setPatientWellnessData(value);
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
      setLoading(false);
    });
  }

  // Upsert Wellness Library API
  Future<void> upsertWellnessApi(dynamic healthTipId, String flag,context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "patient_id": userId,
      "health_tip_id": healthTipId,
      "favourite_flag": flag
    };
    debugPrint("jashd${jsonEncode(data)}");
    _upsertWellnessRepo.upsertWellnessApi(data).then((value) {
      if (value.status == true) {
        setUpsertWellnessData(value);
        setFavourite(true);
        getPatientWellnessApi(context);
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