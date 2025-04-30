import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/doctor_details_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class DoctorDetailsRepo {
  final _apiServices = NetworkApiServices();

  Future<DoctorDetailsModel> doctorDetailsApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.doctorDetailByLocation, data);
      return DoctorDetailsModel.fromJson(response);

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during doctorDetailsApi: $e');
      }
      rethrow;
    }
  }
}