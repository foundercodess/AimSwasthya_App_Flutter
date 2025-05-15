// model/doctor/notification_model.dart
class NotificationModel {
  bool? status;
  List<NotificationData>? data;

  NotificationModel({this.status, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int? notificationId;
  int? patientId;
  int? doctorId;
  String? notificationType;
  String? title;
  String? message;
  String? sentAt;
  String? readAt;

  NotificationData({
    this.notificationId,
    this.patientId,
    this.doctorId,
    this.notificationType,
    this.title,
    this.message,
    this.sentAt,
    this.readAt,
  });

  NotificationData.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    notificationType = json['notification_type'];
    title = json['title'];
    message = json['message'];
    sentAt = json['sent_at'];
    readAt = json['read_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification_id'] = notificationId;
    data['patient_id'] = patientId;
    data['doctor_id'] = doctorId;
    data['notification_type'] = notificationType;
    data['title'] = title;
    data['message'] = message;
    data['sent_at'] = sentAt;
    data['read_at'] = readAt;
    return data;
  }
} 