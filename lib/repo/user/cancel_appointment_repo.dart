import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class CancelAppointmentRepo {
  final _apiServices = NetworkApiServices();

  Future<dynamic> cancelAppointmentApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.cancelAppointment, data);
      return response;

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during cancelAppointmentApi: $e');
      }
      rethrow;
    }
  }

}