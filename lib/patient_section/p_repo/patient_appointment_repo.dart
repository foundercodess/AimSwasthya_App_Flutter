import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/patient_Appointment_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:flutter/foundation.dart';

class PatientAppointmentRepo {
  final _apiServices = NetworkApiServices();

  Future<PatientAppointmentModel> patientAppointmentApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.patientAppointments, data);
      return PatientAppointmentModel.fromJson(response);

    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during patientAppointmentApi: $e');
      }
      rethrow;
    }
  }
}