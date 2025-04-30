class PatientAppointmentModel {
  bool? status;
  Data? data;

  PatientAppointmentModel({this.status, this.data});

  PatientAppointmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<AppointmentsData>? upcomingAppointments;
  List<AppointmentsData>? pastAppointments;

  Data({this.upcomingAppointments, this.pastAppointments});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['UpcomingAppointments'] != null) {
      upcomingAppointments = <AppointmentsData>[];
      json['UpcomingAppointments'].forEach((v) {
        upcomingAppointments!.add(AppointmentsData.fromJson(v));
      });
    }
    if (json['PastAppointments'] != null) {
      pastAppointments = <AppointmentsData>[];
      json['PastAppointments'].forEach((v) {
        pastAppointments!.add(AppointmentsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (upcomingAppointments != null) {
      data['UpcomingAppointments'] =
          upcomingAppointments!.map((v) => v.toJson()).toList();
    }
    if (pastAppointments != null) {
      data['PastAppointments'] =
          pastAppointments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppointmentsData {
  dynamic appointmentId;
  String? bookingDate;
  dynamic status;
  dynamic patientId;
  dynamic patientName;
  dynamic doctorId;
  dynamic doctorName;
  dynamic qualification;
  String? imageUrl;
  dynamic clinicId;
  String? latitude;
  String? longitude;
  String? distanceInKm;
  dynamic practiceStartYear;
  String? experience;
  String? specializationName;
  String? consultationFeeType;
  String? consultationFee;
  dynamic averageRating;
  String? slotType;
  String? timeOfDay;
  String? amPm;
  String? hour24Format;
  dynamic signedImageUrl;

  AppointmentsData(
      {this.appointmentId,
        this.bookingDate,
        this.status,
        this.patientId,
        this.patientName,
        this.doctorId,
        this.doctorName,
        this.qualification,
        this.imageUrl,
        this.clinicId,
        this.latitude,
        this.longitude,
        this.distanceInKm,
        this.practiceStartYear,
        this.experience,
        this.specializationName,
        this.consultationFeeType,
        this.consultationFee,
        this.averageRating,
        this.slotType,
        this.timeOfDay,
        this.amPm,
        this.hour24Format,
        this.signedImageUrl,
      });

  AppointmentsData.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    bookingDate = json['booking_date'];
    status = json['status'];
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    qualification = json['qualification'];
    imageUrl = json['image_url'];
    clinicId = json['clinic_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distanceInKm = json['distance_in_km'];
    practiceStartYear = json['practice_start_year'];
    experience = json['experience'];
    specializationName = json['specialization_name'];
    consultationFeeType = json['consultation_fee_type'];
    consultationFee = json['consultation_fee'];
    averageRating = json['average_rating'];
    slotType = json['slot_type'];
    timeOfDay = json['time_of_day'];
    amPm = json['am_pm'];
    hour24Format = json['hour_24_format'];
    signedImageUrl = json['signedImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointment_id'] = appointmentId;
    data['booking_date'] = bookingDate;
    data['status'] = status;
    data['patient_id'] = patientId;
    data['patient_name'] = patientName;
    data['doctor_id'] = doctorId;
    data['doctor_name'] = doctorName;
    data['qualification'] = qualification;
    data['image_url'] = imageUrl;
    data['clinic_id'] = clinicId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['distance_in_km'] = distanceInKm;
    data['practice_start_year'] = practiceStartYear;
    data['experience'] = experience;
    data['specialization_name'] = specializationName;
    data['consultation_fee_type'] = consultationFeeType;
    data['consultation_fee'] = consultationFee;
    data['average_rating'] = averageRating;
    data['slot_type'] = slotType;
    data['time_of_day'] = timeOfDay;
    data['am_pm'] = amPm;
    data['hour_24_format'] = hour24Format;
    data['signedImageUrl'] = signedImageUrl;
    return data;
  }
}

// class PastAppointments {
//   dynamic appointmentId;
//   String? bookingDate;
//   String? status;
//   dynamic patientId;
//   String? patientName;
//   dynamic doctorId;
//   String? doctorName;
//   String? imageUrl;
//   String? latitude;
//   String? longitude;
//   String? distanceInKm;
//   dynamic practiceStartYear;
//   String? experience;
//   String? specializationName;
//   String? consultationFeeType;
//   String? consultationFee;
//   dynamic averageRating;
//   String? slotType;
//   String? timeOfDay;
//   String? amPm;
//   String? hour24Format;
//
//   PastAppointments(
//       {this.appointmentId,
//         this.bookingDate,
//         this.status,
//         this.patientId,
//         this.patientName,
//         this.doctorId,
//         this.doctorName,
//         this.imageUrl,
//         this.latitude,
//         this.longitude,
//         this.distanceInKm,
//         this.practiceStartYear,
//         this.experience,
//         this.specializationName,
//         this.consultationFeeType,
//         this.consultationFee,
//         this.averageRating,
//         this.slotType,
//         this.timeOfDay,
//         this.amPm,
//         this.hour24Format});
//
//   PastAppointments.fromJson(Map<String, dynamic> json) {
//     appointmentId = json['appointment_id'];
//     bookingDate = json['booking_date'];
//     status = json['status'];
//     patientId = json['patient_id'];
//     patientName = json['patient_name'];
//     doctorId = json['doctor_id'];
//     doctorName = json['doctor_name'];
//     imageUrl = json['image_url'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     distanceInKm = json['distance_in_km'];
//     practiceStartYear = json['practice_start_year'];
//     experience = json['experience'];
//     specializationName = json['specialization_name'];
//     consultationFeeType = json['consultation_fee_type'];
//     consultationFee = json['consultation_fee'];
//     averageRating = json['average_rating'];
//     slotType = json['slot_type'];
//     timeOfDay = json['time_of_day'];
//     amPm = json['am_pm'];
//     hour24Format = json['hour_24_format'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['appointment_id'] = appointmentId;
//     data['booking_date'] = bookingDate;
//     data['status'] = status;
//     data['patient_id'] = patientId;
//     data['patient_name'] = patientName;
//     data['doctor_id'] = doctorId;
//     data['doctor_name'] = doctorName;
//     data['image_url'] = imageUrl;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['distance_in_km'] = distanceInKm;
//     data['practice_start_year'] = practiceStartYear;
//     data['experience'] = experience;
//     data['specialization_name'] = specializationName;
//     data['consultation_fee_type'] = consultationFeeType;
//     data['consultation_fee'] = consultationFee;
//     data['average_rating'] = averageRating;
//     data['slot_type'] = slotType;
//     data['time_of_day'] = timeOfDay;
//     data['am_pm'] = amPm;
//     data['hour_24_format'] = hour24Format;
//     return data;
//   }
// }
