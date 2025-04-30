import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/doctor/doc_update_appointment_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class DocPatientAppointmentRepo {
  final _apiServices = NetworkApiServices();

  Future<DocPatientAppointmentModel> docUpdateAppointmentApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.getPatientAppointmentDoctor, data);
      return DocPatientAppointmentModel.fromJson(response);

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during docUpdateAppointmentApi: $e');
      }
      rethrow;
    }
  }
}