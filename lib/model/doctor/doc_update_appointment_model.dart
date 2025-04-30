class DocPatientAppointmentModel {
  bool? status;
  String? message;
  List<DoctorsAppointmentsDataModel>? activeAppointments;
  List<DoctorsAppointmentsDataModel>? pastAppointments;

  DocPatientAppointmentModel(
      {this.status,
        this.message,
        this.activeAppointments,
        this.pastAppointments});

  DocPatientAppointmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['active_appointments'] != null) {
      activeAppointments = <DoctorsAppointmentsDataModel>[];
      json['active_appointments'].forEach((v) {
        activeAppointments!.add(DoctorsAppointmentsDataModel.fromJson(v));

      });
    }
    if (json['past_appointments'] != null) {
      pastAppointments = <DoctorsAppointmentsDataModel>[];
      json['past_appointments'].forEach((v) {
        pastAppointments!.add(DoctorsAppointmentsDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (activeAppointments != null) {
      data['active_appointments'] =
          activeAppointments!.map((v) => v.toJson()).toList();
    }
    if (pastAppointments != null) {
      data['past_appointments'] =
          pastAppointments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoctorsAppointmentsDataModel {
  int? appointmentId;
  int? patientId;
  String? name;
  String? dateOfBirth;
  String? height;
  String? weight;
  String? phoneNumber;
  String? imageUrl;
  int? doctorId;
  int? clinicId;
  String? appointmentDate;
  int? timeId;
  String? status;
  String? patientName;
  String? appointmentTime;
  String? signedImageUrl;

  DoctorsAppointmentsDataModel(
      {this.appointmentId,
        this.patientId,
        this.name,
        this.dateOfBirth,
        this.height,
        this.weight,
        this.phoneNumber,
        this.imageUrl,
        this.doctorId,
        this.clinicId,
        this.appointmentDate,
        this.timeId,
        this.status,
        this.patientName,
        this.appointmentTime,
        this.signedImageUrl});

  DoctorsAppointmentsDataModel.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    patientId = json['patient_id'];
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
    height = json['height'];
    weight = json['weight'];
    phoneNumber = json['phone_number'];
    imageUrl = json['image_url'];
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
    appointmentDate = json['appointment_date'];
    timeId = json['time_id'];
    status = json['status'];
    patientName = json['patient_name'];
    appointmentTime = json['appointment_time'];
    signedImageUrl = json['signedImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointment_id'] = appointmentId;
    data['patient_id'] = patientId;
    data['name'] = name;
    data['date_of_birth'] = dateOfBirth;
    data['height'] = height;
    data['weight'] = weight;
    data['phone_number'] = phoneNumber;
    data['image_url'] = imageUrl;
    data['doctor_id'] = doctorId;
    data['clinic_id'] = clinicId;
    data['appointment_date'] = appointmentDate;
    data['time_id'] = timeId;
    data['status'] = status;
    data['patient_name'] = patientName;
    data['appointment_time'] = appointmentTime;
    data['signedImageUrl'] = signedImageUrl;
    return data;
  }
}

