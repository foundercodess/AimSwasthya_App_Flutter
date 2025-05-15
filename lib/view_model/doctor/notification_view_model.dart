// view_model/doctor/notification_view_model.dart
import 'package:aim_swasthya/model/doctor/notification_model.dart';
import 'package:aim_swasthya/repo/doctor/notification_repo.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/material.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotificationRepo _notificationRepo = NotificationRepo();
  bool _loading = false;
  bool get loading => _loading;

  NotificationModel? _notificationModel;
  NotificationModel? get notificationModel => _notificationModel;

  setNotificationData(NotificationModel value) {
    _notificationModel = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchNotifications({ required String type}) async {
    setLoading(true);
    final id = await UserViewModel().getUser();
    Map<String, dynamic> data = {
      "id": id,
      "type": type,
    };
    try {
      final result = await _notificationRepo.getNotificationsDetails(data);
      setNotificationData(result);
    } catch (e) {
      // Handle error as needed
    } finally {
      setLoading(false);
    }
  }
} 