import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/patient_home_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

import '../../model/user/get_location_model.dart';
import '../../utils/show_server_error.dart';

class PatientHomeRepo {
  final _apiServices = NetworkApiServices();

  Future<PatientHomeModel> patientHomeApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.patientHome, data);
      print("ddddddd: $response");
      return PatientHomeModel.fromJson(response);
    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during patientHomeApi: $e');
      }
      rethrow;
    }
  }
  Future<GetLocationModel> getLocationApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.getLocation, data);
      return GetLocationModel.fromJson(response);
    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during getLocationApi: $e');
      }
      rethrow;
    }
  }

}