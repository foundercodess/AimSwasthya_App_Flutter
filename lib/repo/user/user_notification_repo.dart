import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/user/user_notification_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:flutter/foundation.dart';

class UserNotificationRepo {
  final _apiServices = NetworkApiServices();

  Future<AddNotificationModel> addNotificationApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          PatientApiUrl.addNotifications, data);
      return AddNotificationModel.fromJson(response);
    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during addNotificationApi: $e');
      }
      rethrow;
    }
  }

  Future<GetNotificationModel> getNotificationApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          PatientApiUrl.getNotificationsDetails, data);
      return GetNotificationModel.fromJson(response);
    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during getNotificationApi: $e');
      }
      rethrow;
    }
  }

  Future<dynamic> updateNotificationApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          PatientApiUrl.updateNotification, data);
      return response;
    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during updateNotificationApi: $e');
      }
      rethrow;
    }
  }
}
