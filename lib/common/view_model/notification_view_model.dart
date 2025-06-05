// common/view_model/notification_view_model.dart
import 'package:aim_swasthya/common/repo/notification_repo.dart';
import 'package:aim_swasthya/model/doctor/notification_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum NotificationType {
  specialistAvailable('Specialist Now Available'),
  slotBookingReminder('Slot Booking Reminder'),
  slotBookingFull('Slot Booking Full'),
  profileCompleted('Profile Successfully Completed'),
  serviceLive('Service Live in Your City'),
  rescheduleAccepted('Reschedule Request Accepted'),
  profileNotCompleted('Profile Not Completed'),
  noMedicalRecords('No Medical Records Yet (Nudge)'),
  newSlotAdded('New Slot Added Confirmation'),
  newAppointmentBooked('New Appointment Booked'),
  missedAppointmentFollowup('Missed Appointment Follow-up'),
  missedAppointment('Missed Appointment'),
  followUpReminder('Follow-Up Reminder'),
  appointmentRescheduleRequested('Appointment Reschedule Requested by Doctor'),
  appointmentReminder24hr('Appointment Reminder (24hr)'),
  appointmentReminder1hr('Appointment Reminder (1hr)'),
  appointmentFeedback('Appointment Feedback Received'),
  appointmentCompleted('Appointment Completed'),
  appUpdateAvailable('App Update Available'),
  addMoreLocations('Add more locations'),
  addClinicDetails('Add clinic details'),
  accountDeletionRequested('Account Deletion Request Initiated');

  final String title;
  const NotificationType(this.title);
}

class NotificationViewModel extends ChangeNotifier {
  final _notificationRepo = NotificationRepo();
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

  Future<void> fetchNotifications({required String type, bool isLoading=true}) async {
    setLoading(isLoading);
    final id = await UserViewModel().getUser();
    Map<String, dynamic> data = {
      "id": id,
      "type": type,
    };
    print("object: $data");
    try {
      final result = await _notificationRepo.getNotificationsDetails(data);
      setNotificationData(result);
    } catch (e) {
      // Handle error as needed
    } finally {
      setLoading(false);
    }
  }

  Future<void> sendNotification({
    required int patientId,
    required int doctorId,
    required NotificationType type,
    String? appointmentDate,
    String? appointmentTime,
    required String role,
    required BuildContext context,
  }) async {
    try {
      setLoading(true);
      Map<String, dynamic> data = {
        "patient_id": patientId,
        "doctor_id": doctorId,
        "title": type.title,
      };

      // Add appointment details if provided
      if (appointmentDate != null) {
        data["appointment_date"] = appointmentDate;
      }
      if (appointmentTime != null) {
        data["appointment_time"] = appointmentTime;
      }

      final response = await _notificationRepo.addNotificationApi(data);

      if (response['success'] == true) {
        await fetchNotifications(type: role, isLoading: false);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending notification: $e');
      }
      Utils.show("Error sending notification", context);
    } finally {
      setLoading(false);
    }
  }

  // Helper methods for specific notification types
  Future<void> sendAppointmentReminder({
    required int patientId,
    required int doctorId,
    required String appointmentDate,
    required String appointmentTime,
    required String role,
    required BuildContext context,
    bool is24Hour = false,
  }) async {
    await sendNotification(
      patientId: patientId,
      doctorId: doctorId,
      type: is24Hour ? NotificationType.appointmentReminder24hr : NotificationType.appointmentReminder1hr,
      appointmentDate: appointmentDate,
      appointmentTime: appointmentTime,
      role: role,
      context: context,
    );
  }

  Future<void> sendProfileCompletionNotification({
    required int patientId,
    required int doctorId,
    required String role,
    required BuildContext context,
    bool isCompleted = true,
  }) async {
    await sendNotification(
      patientId: patientId,
      doctorId: doctorId,
      type: isCompleted ? NotificationType.profileCompleted : NotificationType.profileNotCompleted,
      role: role,
      context: context,
    );
  }

  Future<void> sendAppointmentStatusNotification({
    required int patientId,
    required int doctorId,
    required String appointmentDate,
    required String appointmentTime,
    required String role,
    required BuildContext context,
    bool isCompleted = false,
    bool isMissed = false,
  }) async {
    NotificationType type;
    if (isCompleted) {
      type = NotificationType.appointmentCompleted;
    } else if (isMissed) {
      type = NotificationType.missedAppointment;
    } else {
      type = NotificationType.newAppointmentBooked;
    }

    await sendNotification(
      patientId: patientId,
      doctorId: doctorId,
      type: type,
      appointmentDate: appointmentDate,
      appointmentTime: appointmentTime,
      role: role,
      context: context,
    );
  }

  Future<void> updateNotification(String role) async {
    if (_notificationModel!.data == null) {
      return;
    }
    final unSeenNotifications = _notificationModel!.data!
        .map((e) {
          if (e.readAt == null) {
            return e.notificationId;
          }
          return null;
        })
        .where((id) => id != null)
        .toList();

    if (unSeenNotifications.isEmpty) {
      return;
    }

    try {
      // setLoading(true);
      for (var notificationId in unSeenNotifications) {
        final response = await _notificationRepo
            .updateNotificationApi({'notification_id': notificationId});
        if (response['success'] == true) {
          if (kDebugMode) {
            print('Updated notification: $notificationId');
          }
          // Update the local model to reflect the read status
          final index = _notificationModel!.data!.indexWhere(
            (n) => n.notificationId == notificationId,
          );
          if (index != -1) {
            _notificationModel!.data![index].readAt = DateTime.now().toString();
          }
        }
      }
      notifyListeners(); 
      await fetchNotifications(type: role, isLoading: false);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating notification: $e');
      }
    } finally {
      setLoading(false);
    }
  }
}
