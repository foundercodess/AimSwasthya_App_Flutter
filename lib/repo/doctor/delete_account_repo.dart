import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

import '../../model/doctor/delete_account_model.dart';

class DeleteAccountDoctorRepo {
  final _apiServices = NetworkApiServices();

  Future<DeleteAccountModel> deleteAccountApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.deleteAccountDoctor, data);
      return DeleteAccountModel.fromJson(response);

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during deleteAccountApi: $e');
      }
      rethrow;
    }
  }
}