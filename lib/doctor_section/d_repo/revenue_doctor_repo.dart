import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/doctor/doc_medical_reports_model.dart';
import 'package:aim_swasthya/model/doctor/doc_update_appointment_model.dart';
import 'package:aim_swasthya/model/doctor/revenue_doctor_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class RevenueDoctorRepo {
  final _apiServices = NetworkApiServices();

  Future<RevenueDoctorModel> revenueDoctorApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.revenueDoctor, data);
      return RevenueDoctorModel.fromJson(response);

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during revenueDoctorApi: $e');
      }
      rethrow;
    }
  }
}