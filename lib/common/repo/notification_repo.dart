// common/repo/notification_repo.dart
import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/doctor/notification_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:flutter/foundation.dart';

class NotificationRepo {
  final _apiServices = NetworkApiServices();

  Future<NotificationModel> getNotificationsDetails(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        PatientApiUrl.getNotificationsDetails,
        data,
      );
      return NotificationModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during getNotificationsDetails: $e');
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
    Future<dynamic> addNotificationApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          PatientApiUrl.addNotifications, data);
      return response;
    } catch (e) {
      showInfoOverlay(statusCode: "response.statusCode");
      if (kDebugMode) {
        print('Error occurred during addNotificationApi: $e');
      }
      rethrow;
    }
  }

} 