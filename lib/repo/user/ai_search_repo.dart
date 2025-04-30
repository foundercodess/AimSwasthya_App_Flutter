import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/doctor_details_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

import '../../model/user/ai_search_model.dart';

class AiSearchRepo {
  final _apiServices = NetworkApiServices();

  Future<GetAiSuggestionModel> aiSearch(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.getAiDoctorSuggestion, data);
      return GetAiSuggestionModel.fromJson(response);

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during aiSearch: $e');
      }
      rethrow;
    }
  }
}