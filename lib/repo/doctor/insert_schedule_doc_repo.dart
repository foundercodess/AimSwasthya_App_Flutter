import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class DocInsertScheduleRepo {
  final _apiServices = NetworkApiServices();

  Future<dynamic> docInsertScheduleApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.upsertScheduleDoctor, data);
      return response;

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during docInsertScheduleApi: $e');
      }
      rethrow;
    }
  }
}