import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:flutter/foundation.dart';

class GetImageUrlRepo {
  final _apiServices = NetworkApiServices();

  Future<dynamic> addMedicalRecordApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse('http://3.7.71.4:3000/addMedicalRecord', data);
      return response;

    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during getImageUrlApi: $e');
      }
      rethrow;
    }
  }
}