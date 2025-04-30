
import 'package:flutter/foundation.dart';

import '../../helper/network/network_api_services.dart';
import '../../res/api_urls.dart';

class TCPPRepo {
  final _apiServices = NetworkApiServices();

  Future<dynamic> tCApi(String data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(PatientApiUrl.tcApiUrl+data,);
      return response;

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during cancelAppointmentApi: $e');
      }
      rethrow;
    }
  }

}