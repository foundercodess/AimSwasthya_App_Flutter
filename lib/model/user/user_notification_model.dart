class AddNotificationModel {
  bool? success;
  String? message;
  Notification? notification;

  AddNotificationModel({this.success, this.message, this.notification});

  AddNotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    notification = json['notification'] != null
        ? Notification.fromJson(json['notification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (notification != null) {
      data['notification'] = notification!.toJson();
    }
    return data;
  }
}

class Notification {
  int? patientId;
  int? doctorId;
  String? title;
  String? message;
  String? sentAt;

  Notification(
      {this.patientId, this.doctorId, this.title, this.message, this.sentAt});

  Notification.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    title = json['title'];
    message = json['message'];
    sentAt = json['sent_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patient_id'] = patientId;
    data['doctor_id'] = doctorId;
    data['title'] = title;
    data['message'] = message;
    data['sent_at'] = sentAt;
    return data;
  }
}



class GetNotificationModel {
  bool? status;
  List<Data>? data;

  GetNotificationModel({this.status, this.data});

  GetNotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? notificationId;
  int? patientId;
  int? doctorId;
  String? notificationType;
  String? title;
  String? message;
  String? sentAt;
  dynamic readAt;

  Data(
      {this.notificationId,
        this.patientId,
        this.doctorId,
        this.notificationType,
        this.title,
        this.message,
        this.sentAt,
        this.readAt});

  Data.fromJson(Map<String, dynamic> json) {
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
