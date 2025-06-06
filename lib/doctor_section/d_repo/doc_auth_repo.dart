// doctor_section/d_repo/doc_auth_repo.dart
import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class DoctorAuthRepo{
  final _apiServices= NetworkApiServices();

  // DocSendOtpApi Repo
  Future<dynamic> docSendOtpApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.sendDoctorOtp,data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during docSendOtpApi: $e');
      }
      rethrow;
    }
  }

  //IsDoctorRegisterApi Repo
  Future<dynamic> isRegisterDocApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.isDoctorRegister,data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during isRegisterDocApi: $e');
      }
      rethrow;
    }
  }

  //verifyOtpApi Repo
  Future<dynamic> verifyDocOtpApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.verifyOTPDoctor,data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during verifyDocOtpApi: $e');
      }
      rethrow;
    }
  }

  //doctorRegisterApi Repo
  Future<dynamic> doctorRegisterApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.registerDoctor,data);
      print(response);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during doctorRegisterApi: $e');
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