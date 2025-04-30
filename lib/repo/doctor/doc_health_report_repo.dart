import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/doctor/doc_medical_reports_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class DocHealthReportRepo {
  final _apiServices = NetworkApiServices();

  Future<MedicalHealthReportModel> docMedicalHealthReportApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.medicalHealthReportDoctor, data);
      return MedicalHealthReportModel.fromJson(response);

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during docMedicalHealthReportApi: $e');
      }
      rethrow;
    }
  }
}