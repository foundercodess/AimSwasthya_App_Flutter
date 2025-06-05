// repo/doctor/doctor_profile_repo.dart
import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/doctor/doctor_profile_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class DoctorProfileRepo {
  final _apiServices = NetworkApiServices();

  Future<DoctorProfileModel> doctorProfileApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          DoctorApiUrl.getProfileDoctor, data);
      return DoctorProfileModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during doctorProfileApi: $e');
      }
      rethrow;
    }
  }

  Future<dynamic> updateDoctorProfileApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          DoctorApiUrl.updateProfileDoctor, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during updateDoctorProfileApi: $e');
      }
      rethrow;
    }
  }
}
