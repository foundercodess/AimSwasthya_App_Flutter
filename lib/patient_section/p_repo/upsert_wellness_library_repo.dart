import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/upsert_wellness_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:flutter/foundation.dart';


class UpsertWellnessLibraryRepo {
  final _apiServices = NetworkApiServices();

  Future<UpsertWellnessLibraryModel> upsertWellnessApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.upsertPatientWellnessLibrary, data);
      return UpsertWellnessLibraryModel.fromJson(response);

    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during upsertWellnessApi: $e');
      }
      rethrow;
    }
  }
}