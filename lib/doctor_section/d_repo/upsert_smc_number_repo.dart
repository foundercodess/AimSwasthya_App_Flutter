import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/doctor/upsert_smc_number_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class UpsertSmcNumberRepo {
  final _apiServices = NetworkApiServices();

  Future<UpsertSmcNumberModel> upsertSmcNumberApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.upsertSmcNumberDoctor, data);
      return UpsertSmcNumberModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during upsertSmcNumberApi: $e');
      }
      rethrow;
    }
  }
}