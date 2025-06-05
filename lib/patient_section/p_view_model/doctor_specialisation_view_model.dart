// patient_section/p_view_model/doctor_specialisation_view_model.dart
import 'package:aim_swasthya/model/user/doctor_specialisation_model.dart';
import 'package:aim_swasthya/model/user/patient_home_model.dart';
import 'package:aim_swasthya/patient_section/p_repo/doctor_specialisation_repo.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_home_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/services/map_con.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorSpecialisationViewModel extends ChangeNotifier {
  final _doctorSpecialisationRepo = DoctorSpecialisationRepo();
  final _mapCon = MapController();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Specializations? _selectedSpecialist;
  Specializations? get selectedSpecialist => _selectedSpecialist;

  setSpeciality(Specializations value, context) {
    _selectedSpecialist = value;
    doctorSpecialisationApi(context, value.specializationId);
    notifyListeners();
  }

  DoctorSpecialisationModel? _doctorSpecialisationModel;
  DoctorSpecialisationModel? get doctorSpecialisationModel =>
      _doctorSpecialisationModel;

  setDoctorSpecialisationModel(DoctorSpecialisationModel value) {
    _doctorSpecialisationModel = value;
    notifyListeners();
  }

  Future<void> doctorSpecialisationApi(
      BuildContext context, dynamic specId) async {
    _doctorSpecialisationModel=null;
    setLoading(true);
    final locationData= Provider.of<PatientHomeViewModel>(context,listen: false).selectedLocationData;
    double latitude = double.tryParse(locationData!.latitude?.toString() ?? '0') ?? 0.0;
    double longitude = double.tryParse(locationData.longitude?.toString() ?? '0') ?? 0.0;

    setLoading(true);
    Map data = {
      "specialization_id": specId,
      "lat": latitude.toStringAsFixed(5),
      "lon": longitude.toStringAsFixed(5),
    };

    _doctorSpecialisationRepo.doctorSpecialisationApi(data).then((value) {
      if (value.status == true) {
        setDoctorSpecialisationModel(value);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
