import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class AddClinicDoctorRepo {
  final _apiServices = NetworkApiServices();

  Future<dynamic> addClinicDocApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.addClinicDoctor, data);
      return response;

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during addClinicDocApi: $e');
      }
      rethrow;
    }
  }
}