import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/get_wellness_library_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:flutter/foundation.dart';

class GetPatientWellnessRepo {
  final _apiServices = NetworkApiServices();

  Future<GetWellnessLibraryModel> getWellnessLibraryApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          PatientApiUrl.getPatientWellnessLibrary, data);
      return GetWellnessLibraryModel.fromJson(response);
    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during getWellnessLibraryApi: $e');
      }
      rethrow;
    }
  }
}
