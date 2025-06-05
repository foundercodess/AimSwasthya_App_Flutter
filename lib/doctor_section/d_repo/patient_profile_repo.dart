import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/doctor/doctor_profile_model.dart';
import 'package:aim_swasthya/model/doctor/patient_profile_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class PatientProfileRepo {
  final _apiServices = NetworkApiServices();

  Future<PatientProfileModel> patientProfileApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.getPatientProfileDoctor, data);
      return PatientProfileModel.fromJson(response);

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during patientProfileApi: $e');
      }
      rethrow;
    }
  }
}