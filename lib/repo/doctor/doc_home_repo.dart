import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/doctor/doc_home_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class DoctorHomeRepo {
  final _apiServices = NetworkApiServices();

  Future<DoctorHomeModel> doctorHomeApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.getHomeDoctor, data);
      return DoctorHomeModel.fromJson(response);

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during doctorHomeApi: $e');
      }
      rethrow;
    }
  }
}