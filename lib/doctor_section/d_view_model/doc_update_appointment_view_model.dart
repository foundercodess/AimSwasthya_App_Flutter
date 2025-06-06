// doctor_section/d_view_model/doc_update_appointment_view_model.dart
import 'package:aim_swasthya/model/doctor/doc_update_appointment_model.dart';
import 'package:aim_swasthya/doctor_section/d_repo/doc_update_appointment_repo.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';

class DocPatientAppointmentViewModel extends ChangeNotifier {
  final _doctorUpdateAppRepo = DocPatientAppointmentRepo();
  bool _loading = false;
  bool get loading => _loading;

  DocPatientAppointmentModel? _docUpdateAppointmentModel;
  DocPatientAppointmentModel? get docPatientAppointmentModel =>
      _docUpdateAppointmentModel;
  setUpdateAppDate(DocPatientAppointmentModel value) {
    _docUpdateAppointmentModel = value;
    notifyListeners();
  }

  DoctorsAppointmentsDataModel? _doctorsAppointmentsDataModel;
  DoctorsAppointmentsDataModel? get doctorsAppointmentsDataModel =>
      _doctorsAppointmentsDataModel;
  setDoctorsAppointmentsData(DoctorsAppointmentsDataModel value) {
    _doctorsAppointmentsDataModel = value;

    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> docPatientAppointmentApi() async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "doctor_id": userId,
    };
    debugPrint("body: $data");
    _doctorUpdateAppRepo.docUpdateAppointmentApi(data).then((value) {
      if (value.status == true) {
        setUpdateAppDate(value);
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
