import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/patient_preferred_doc_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class PatientPreferredDocRepo {
  final _apiServices = NetworkApiServices();

  Future<PatienPreferredDocModel> patienPreferredDocApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.patientPreferredDoctor, data);
      print(response);
      return PatienPreferredDocModel.fromJson(response);

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during patienPreferredDocApi: $e');
      }
      rethrow;
    }
  }
}