import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/doctor/all_specialization_doc_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class AllSpecializationDocRepo {
  final _apiServices = NetworkApiServices();

  Future<AllSpecializationDocModel> allSpecializationDocApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(DoctorApiUrl.getAllSpecializationsDoctor);
      return AllSpecializationDocModel.fromJson(response);

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during allSpecializationDocApi: $e');
      }
      rethrow;
    }
  }
}