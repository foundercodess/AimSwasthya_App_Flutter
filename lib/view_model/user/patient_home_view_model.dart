// view_model/user/patient_home_view_model.dart
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

  int? _selectedMemberIndex;
  int? get selectedMemberIndex => _selectedMemberIndex;

  setSelectedMemberIndex(int value) {
    _selectedMemberIndex = value;
    fillControllersWithFirstMember();
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
      debugPrint("fun invoked");
      await LocalImageHelper.instance.loadImages();
    });
  }

  PatientHomeModel? _patientHomeModel;

  PatientHomeModel? get patientHomeModel => _patientHomeModel;

  setPatientHomeData(PatientHomeModel value) {
    _patientHomeModel = value;
    setSelectedMemberIndex(-1);
    if (value.data!.doctors == []) return;
    setSelectedMemberIndex(0);
    for (var data in value.data!.doctors!) {
      ImageDownloader()
          .downloadAndSaveDoctorImage(data.imageUrl!, data.doctorId);
    }

    fillControllersWithFirstMember();
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
      // "lat": "28.6014",
      // "lon": "77.4460",
      "lat": latitude,
      "lon": longitude,
      "patient_id": userId,
      "location_id": _selectedLocationData == null
          ? ""
          : _selectedLocationData!.locationId ?? "",
    };
    debugPrint("ansjn${jsonEncode(data)}");
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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  void fillControllersWithFirstMember() {
    final familyList = patientHomeModel?.data?.familyMembers;

    if (familyList != null && familyList.isNotEmpty) {
      final first = familyList[0];

      nameController.text = first.name ?? '';
      ageController.text = calculateAgeFromDob(first.dateOfBirth);
      genderController.text = first.gender ?? '';
      heightController.text = first.height ?? '';
      weightController.text = first.weight ?? '';

      notifyListeners();
    }
  }

  String calculateAgeFromDob(String? dob) {
    if (dob == null || dob.isEmpty) return '';
    final birthDate = DateTime.tryParse(dob);
    if (birthDate == null) return '';
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }

  // Dispose controllers
  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    genderController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }
}
