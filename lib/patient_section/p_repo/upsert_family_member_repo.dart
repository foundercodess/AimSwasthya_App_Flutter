import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/upsert_family_member_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:flutter/foundation.dart';

class UpsertFamilyMemberRepo {
  final _apiServices = NetworkApiServices();

  Future<UpsertFamilyMemberModel> upsertFamilyMemberApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(PatientApiUrl.upsertFamilyMember, data);
      return  UpsertFamilyMemberModel.fromJson(response);

    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during upsertFamilyMemberApi: $e');
      }
      rethrow;
    }
  }
}