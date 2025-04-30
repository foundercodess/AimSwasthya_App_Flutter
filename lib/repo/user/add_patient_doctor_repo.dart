import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class AddPatientDoctorRepo {
  final _apiServices = NetworkApiServices();

  Future<dynamic> addDoctorApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.addPatientDoctorUrl, data);
      return response;

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during addDoctorApi: $e');
      }
      rethrow;
    }
  }
}