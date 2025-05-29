import 'package:aim_swasthya/model/user/patient_Appointment_model.dart';
import 'package:aim_swasthya/repo/user/patient_appointment_repo.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:aim_swasthya/view_model/user/services/map_con.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class PatientAppointmentViewModel extends ChangeNotifier {
  final _patientAppointmentRepo = PatientAppointmentRepo();
  bool _loading = false;
  bool get loading => _loading;

  PatientAppointmentModel? _patientAppointmentModel;
  PatientAppointmentModel? get patientAppointmentModel =>
      _patientAppointmentModel;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setPatientAppointmentData(PatientAppointmentModel value) {
    _patientAppointmentModel = value;
    notifyListeners();
  }

  Future<void> patientAppointmentApi(BuildContext context) async {
    final locationData =
        Provider.of<PatientHomeViewModel>(context, listen: false)
            .selectedLocationData;
    double latitude = double.parse(locationData!.latitude.toString());
    double longitude = double.parse(locationData!.longitude.toString());
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "lat": latitude.toStringAsFixed(5),
      "lon": longitude.toStringAsFixed(5),
      "patient_id": userId,
    };
    debugPrint("body: $data");
    _patientAppointmentRepo.patientAppointmentApi(data).then((value) {
      if (value.status == true) {
        setPatientAppointmentData(value);
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
