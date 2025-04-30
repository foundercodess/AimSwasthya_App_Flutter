import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/doctor_avl_appointment_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class DoctorAvlAppointmentRepo {
  final _apiServices = NetworkApiServices();

  Future<DoctorAvlAppointmentModel> doctorAvlAppointmentApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.doctorAppointments, data);
      return DoctorAvlAppointmentModel.fromJson(response);

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during doctorAvlAppointmentApi: $e');
      }
      rethrow;
    }
  }

  Future<dynamic> doctorBookAppointmentApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.boolAppointmentUrl, data);
      return response;

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during doctorAvlAppointmentApi: $e');
      }
      rethrow;
    }
  }
}