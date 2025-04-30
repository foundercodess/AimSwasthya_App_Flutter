import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/patient_medical_records_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class PatientMedicalRecordsRepo {
  final _apiServices = NetworkApiServices();

  Future<GetMedicalRecordData> patientMedicalRecordsApi(
      dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          PatientApiUrl.getMedicalRecordsPatients, data);
      return GetMedicalRecordData.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during patientMedicalRecordsApi: $e');
      }
      rethrow;
    }
  }
}
