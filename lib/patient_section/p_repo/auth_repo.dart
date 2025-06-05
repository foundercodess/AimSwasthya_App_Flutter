import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:flutter/foundation.dart';

class PatientAuthRepo{
  final _apiServices= NetworkApiServices();

  // sendOtpApi Repo
  Future<dynamic> sendOtpApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.sendOtp,data);
      return response;
    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during sendOtpApi: $e');
      }
      rethrow;
    }
  }

  //IsRegisterApi Repo
 Future<dynamic> isRegisterApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.isRegistered,data);
      return response;
    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during isRegisterApi: $e');
      }
      rethrow;
    }
  }

  //verifyOtpApi Repo
  Future<dynamic> verifyOtpApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.verifyOtp,data);
      return response;
    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during verifyOtpApi: $e');
      }
      rethrow;
    }
  }

  //patientRegisterApi Repo
  Future<dynamic> patientRegisterApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.patientRegister,data);
      print(response);
      return response;
    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during patientRegisterApi: $e');
      }
      rethrow;
    }
  }


// Future<dynamic> getApi(dynamic data) async {
  //   try {
  //     dynamic response =
  //     await _apiServices.getGetApiResponse(ApiUrl.sendOtp+data);
  //     return response;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error occurred during sendOtpApi: $e');
  //     }
  //     rethrow;
  //   }
  // }
}