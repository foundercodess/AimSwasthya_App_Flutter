// view_model/doctor/add_clinic_doctor_view_model.dart
import 'dart:convert';
import 'package:aim_swasthya/repo/doctor/addClinicDoctorRopo.dart';
import 'package:aim_swasthya/view_model/user/services/map_con.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class AddClinicDoctorViewModel extends ChangeNotifier {
  final _mapCon = MapController();
  final _addClinicDoctorRepo = AddClinicDoctorRepo();
  bool _loading = true;
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

  double? selectedLatitude;
  double? selectedLongitude;
  String? selectedAddress;
  GoogleMapController? mapController;

  clearSelectedLocation(){
    selectedAddress=null;
    selectedLatitude=null;
    selectedLongitude=null;
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      selectedLatitude = position.latitude;
      selectedLongitude = position.longitude;
      setLoading(false);
      notifyListeners();

      // Get address for current position
      await getAddressFromLatLng(LatLng(position.latitude, position.longitude));
    } catch (e) {
      print('Error getting location: $e');
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        selectedAddress = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
        notifyListeners();
      }
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  void updateSelectedLocation(LatLng position) {
    selectedLatitude = position.latitude;
    selectedLongitude = position.longitude;
    getAddressFromLatLng(position);
    notifyListeners();
  }

  void setMapController(GoogleMapController controller) {
    if (mapController != null) {
      mapController!.dispose();
    }
    mapController = controller;
  }

  void disposeMapController() {
    if (mapController != null) {
      mapController!.dispose();
      mapController = null;
    }
  }

  Future<void> addClinicDoctorApi(dynamic clinicName, dynamic address,
      dynamic phone, dynamic landMark, context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "doctor_id": 6,
      "name": clinicName,
      "address": address,
      "fee": "500",
      "phone_number": phone,
      "city": "Ghaziabad",
      "latitude": selectedLatitude!.toStringAsFixed(5),
      "longitude": selectedLongitude!.toStringAsFixed(5),
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
