// patient_section/p_view_model/cancelAppointment_view_model.dart
import 'package:aim_swasthya/patient_section/p_repo/cancel_appointment_repo.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/doc_home_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_appointment_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../../doctor_section/d_view_model/doc_update_appointment_view_model.dart' show DocPatientAppointmentViewModel;
import 'doctor_avl_appointment_view_model.dart';


class CancelAppointmentViewModel extends ChangeNotifier {
  final _cancelAppointmentRepo = CancelAppointmentRepo();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> cancelAppointmentApi(context,dynamic appId,{bool isDoctorCancel  = false, String? status}) async {
    setLoading(true);
    Map data = {
      "appointment_id" : appId,
      "status" : status??"cancelled"
    };
    _cancelAppointmentRepo.cancelAppointmentApi(data).then((value) {
      Utils.show(value['message'], context);
      if (value['status'] == true) {
        if(isDoctorCancel == false){
          Provider.of<PatientAppointmentViewModel>(context, listen: false)
              .patientAppointmentApi(context);
          Provider.of<PatientHomeViewModel>(context, listen: false)
              .patientHomeApi(context);
          Navigator.pop(context);
        }else{
          Provider.of<DocPatientAppointmentViewModel>(context, listen: false)
              .docPatientAppointmentApi();
          Provider.of<DoctorHomeViewModel>(context, listen: false)
              .doctorHomeApi(context);
        }

        Navigator.pop(context);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
