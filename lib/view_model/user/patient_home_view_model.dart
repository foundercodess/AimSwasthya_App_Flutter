import 'dart:convert';
import 'package:aim_swasthya/model/user/patient_home_model.dart';
import 'package:aim_swasthya/repo/user/patient_home_repo.dart';
import 'package:aim_swasthya/view_model/user/services/map_con.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../local_db/download_image.dart';
import '../../model/user/get_location_model.dart';
import '../../view/user/symptoms/dowenloade_image.dart';

class PatientHomeViewModel extends ChangeNotifier {
  final _patientHomeRepo = PatientHomeRepo();

  final _mapCon = MapController();
  bool _loading = false;
  bool get loading => _loading;

  GetLocationModel? _locationData;
  GetLocationModel? get locationData => _locationData;

  List<Locations> _searchedLocationData = [];
  List<Locations> get searchedLocationData => _searchedLocationData;

  void filterQueryBasedLocation(String query) {
    _searchedLocationData.clear();

    if (query.isEmpty) {
      notifyListeners();
      return;
    }

    for (var location in _locationData?.locations ?? []) {
      if (location.name!.toLowerCase().contains(query.toLowerCase())) {
        _searchedLocationData.add(location);
      }
    }

    notifyListeners();
  }

  // getUserCurrentLocation

  Locations? _selectedLocationData;
  Locations? get selectedLocationData => _selectedLocationData;

  bool _userSearchingOutOfLocation = false;
  bool get userSearchingOutOfLocation => _userSearchingOutOfLocation;

  Future<void> checkUserSearchingOutOfStation(LatLng location) async {
    final userCurrentLocation = await MapController().getCurrentLocation();

    double distance = Geolocator.distanceBetween(
      userCurrentLocation.latitude,
      userCurrentLocation.longitude,
      location.latitude,
      location.longitude,
    );

    const double threshold = 50000;

    _userSearchingOutOfLocation = distance > threshold;
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _noServicesArea = false;
  bool get noServicesArea => _noServicesArea;

  setNoServicesData(bool value) {
    _noServicesArea = value;
    notifyListeners();
  }

  setLocationData(GetLocationModel value, BuildContext context) {
    _locationData = value;
    _selectedLocationData = value.patientLocation!;
    notifyListeners();
    if ((_locationData == null ||
        locationData!.patientLocation!.name == null)) {
      print(locationData);
      print("panddaaa");
      setNoServicesData(true);
    }
    checkUserSearchingOutOfStation(LatLng(
        double.parse(value.patientLocation!.latitude.toString()),
        double.parse(value.patientLocation!.longitude.toString())));

    patientHomeApi();
    notifyListeners();
  }

  Future<void> getLocationApi(BuildContext context,
      {double? lat, double? lng}) async {
    setLoading(true);
    Position position = await _mapCon.getCurrentLocation();
    double latitude = lat ?? position.latitude;
    double longitude = lng ?? position.longitude;
    final userId = await UserViewModel().getUser();
    Map data = {
      "lat": latitude.toStringAsFixed(5),
      "lon": longitude.toStringAsFixed(5),
      // "lat": "27.571410",
      // "lon": "81.593142",
      "patient_id": userId
    };
    _patientHomeRepo.getLocationApi(data).then((value) {
      setLocationData(value, context);
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      patientHomeApi();
      if (kDebugMode) {
        print('error: $error');
      }
    });
    await Future.delayed(const Duration(minutes: 5), () async {
      print("fun invoked");
      await LocalImageHelper.instance.loadImages();
    });
  }

  PatientHomeModel? _patientHomeModel;
  PatientHomeModel? get patientHomeModel => _patientHomeModel;

  setPatientHomeData(PatientHomeModel value) {
    _patientHomeModel = value;
    if (value.data!.doctors == []) return;
    for (var data in value.data!.doctors!) {
      ImageDownloader()
          .downloadAndSaveDoctorImage(data.imageUrl!, data.doctorId);
    }
    notifyListeners();
  }

  Future<void> patientHomeApi() async {
    if (_selectedLocationData == null ||
        (_selectedLocationData!.latitude == null &&
            _selectedLocationData!.longitude == null)) {
      debugPrint("Location data not found");
      // return;
    }
    final latitude = _selectedLocationData!.latitude != null
        ? double.parse(_selectedLocationData!.latitude!).toStringAsFixed(5)
        : null;
    final longitude = _selectedLocationData!.longitude != null
        ? double.parse(_selectedLocationData!.longitude!).toStringAsFixed(5)
        : null;

    final userId = await UserViewModel().getUser();
    Map data = {
      "lat": latitude,
      "lon": longitude,
      "patient_id": userId,
      "location_id": _selectedLocationData == null
          ? ""
          : _selectedLocationData!.locationId ?? "",
    };
    print("ansjn${jsonEncode(data)}");
    _patientHomeRepo.patientHomeApi(data).then((value) {
      if (value.status == true) {
        setPatientHomeData(value);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
