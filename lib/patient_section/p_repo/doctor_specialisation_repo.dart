import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/doctor_specialisation_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:flutter/foundation.dart';

class DoctorSpecialisationRepo {
  final _apiServices = NetworkApiServices();

  Future<DoctorSpecialisationModel> doctorSpecialisationApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.doctorDetailBySpecialization, data);
      return DoctorSpecialisationModel.fromJson(response);

    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during doctorSpecialisationApi: $e');
      }
      rethrow;
    }
  }
}
