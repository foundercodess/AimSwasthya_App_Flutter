import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/patient_profile_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:flutter/foundation.dart';

class UserPatientAppointmentRepo {
  final _apiServices = NetworkApiServices();

  Future<UserPatientProfileModel> userPatientProfileApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.getPatientProfile, data);
      return UserPatientProfileModel.fromJson(response);

    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during userPatientProfileApi: $e');
      }
      rethrow;
    }
  }


  Future<dynamic> updatePatientProfileApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.updatePatientProfile, data);
      return response;

    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during updatePatientProfileApi: $e');
      }
      rethrow;
    }
  }
  Future<dynamic> addImageUrlApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(CommonApiUrl.addImage,data);
      print(response);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during addImageUrlApi: $e');
      }
      rethrow;
    }
  }
}