import 'dart:convert';
import 'package:aim_swasthya/repo/doctor/addClinicDoctorRopo.dart';
import 'package:aim_swasthya/view_model/user/services/map_con.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class AddClinicDoctorViewModel extends ChangeNotifier {
  final _mapCon = MapController();
  final _addClinicDoctorRepo = AddClinicDoctorRepo();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _isClicked = false;
  bool get isClicked => _isClicked;
  setClinicData(bool value) {
    _isClicked = value;
    notifyListeners();
  }
  Future<void> addClinicDoctorApi(dynamic clinicName, dynamic address,
      dynamic phone, dynamic landMark, context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Position position = await _mapCon.getCurrentLocation();
    double latitude = position.latitude;
    double longitude = position.longitude;
    Map data = {
      "doctor_id": 6,
      "name": clinicName,
      "address": address,
      "fee": "500",
      "phone_number": phone,
      "city": "Ghaziabad",
      // "latitude": 19.076090,
      // "longitude": 72.877426,
      "latitude": latitude.toStringAsFixed(5),
      "longitude": longitude.toStringAsFixed(5),
      "landmark": landMark
    };
    print(jsonEncode(data));
    _addClinicDoctorRepo.addClinicDocApi(data).then((value) {
      if (value ["status"] == true) {
        print("mdmkd${value}");
        setClinicData(true);
      }
      setClinicData(true);
      setLoading(false);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
      setLoading(false);
    });
  }
}
