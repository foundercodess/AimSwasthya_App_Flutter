import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/user_delete_account_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:flutter/foundation.dart';

class UserDeleteAccountRepo {
  final _apiServices = NetworkApiServices();

  Future<UserDeleteAccountModel> userDeleteProfileApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.userDeleteProfile, data);
      print(response);
      return UserDeleteAccountModel.fromJson(response);

    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during userDeleteProfileApi: $e');
      }
      rethrow;
    }
  }
}