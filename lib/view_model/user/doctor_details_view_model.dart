import 'package:aim_swasthya/model/user/doctor_details_model.dart';
import 'package:aim_swasthya/repo/user/doctor_details_repo.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:aim_swasthya/view_model/user/services/map_con.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../model/user/patient_home_model.dart';
import 'get_location_view_model.dart';

class DoctorDetailsViewModel extends ChangeNotifier {
  final _doctorDetailsRepo = DoctorDetailsRepo();
  final _mapCon = MapController();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Specializations? _selectedSpecialist;
  Specializations? get selectedSpecialist => _selectedSpecialist;

  DoctorDetailsModel? _doctorDetailsModel;
  DoctorDetailsModel? get doctorDetailsModel => _doctorDetailsModel;

  List<Doctors>? _filterDoctorDetailsModel;
  List<Doctors>? get filterDoctorDetailsModel => _filterDoctorDetailsModel;

  setDoctorDetails(DoctorDetailsModel value) {
    _doctorDetailsModel = value;
    _filterDoctorDetailsModel = value.data!.doctors;
    notifyListeners();
  }

  getSpecialistById(Specializations value) {
    if (_selectedSpecialist != null &&
        _selectedSpecialist!.specializationName == value.specializationName) {
      _selectedSpecialist = null;
      _filterDoctorDetailsModel = doctorDetailsModel!.data!.doctors!;
    } else {
      _selectedSpecialist = value;
      _filterDoctorDetailsModel = doctorDetailsModel!.data!.doctors!
          .where((e) => e.specializationId == value.specializationId)
          .toList();
    }

    if (_filterDoctorDetailsModel!.isEmpty) {
      _filterDoctorDetailsModel = [];
    }
    notifyListeners();
  }

  clearData() {
    _selectedSpecialist = null;
    if (_doctorDetailsModel != null) {
      _filterDoctorDetailsModel = _doctorDetailsModel!.data!.doctors;
    }
    notifyListeners();
  }

  Future<void> doctorDetailsApi(context) async {
    setLoading(true);
    clearData();
    final locationData =
        Provider.of<PatientHomeViewModel>(context, listen: false)
            .selectedLocationData;
    double latitude = double.tryParse(locationData!.latitude.toString())??0.0;
    double longitude = double.tryParse(locationData.longitude.toString())??0.0;
    // final selectedLocation =
    //     Provider.of<PatientHomeViewModel>(context, listen: false)
    //         .selectedLocationData;
    // if (selectedLocation == null) {
    //   debugPrint("Location data not found");
    //   return;
    // }
    Map data = {
      // "location_id": selectedLocation.locationId,
      "lat": latitude.toStringAsFixed(5),
      "lon": longitude.toStringAsFixed(5),
    };
    _doctorDetailsRepo.doctorDetailsApi(data).then((value) {
      if (value.status == true) {}
      setDoctorDetails(value);
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
