// repo/doctor/notification_repo.dart
import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/doctor/notification_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class NotificationRepo {
  final _apiServices = NetworkApiServices();

  Future<NotificationModel> getNotificationsDetails(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        DoctorApiUrl.baseUrl + 'getNotificationsDetails',
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
} 