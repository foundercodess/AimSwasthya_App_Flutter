import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/doctor/doc_update_profile_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class DoctorUpdateProfileRepo {
  final _apiServices = NetworkApiServices();

  Future<DocUpdateProfileModel> docUpdateProfileApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.getProfileDoctor, data);
      return DocUpdateProfileModel.fromJson(response);

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during doctorProfileApi: $e');
      }
      rethrow;
    }
  }
}