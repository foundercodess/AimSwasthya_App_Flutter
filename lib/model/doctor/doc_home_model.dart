class DoctorHomeModel {
  bool? status;
  Data? data;

  DoctorHomeModel({this.status, this.data});

  DoctorHomeModel.fromJson(Map<String, dynamic> json) {
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
  List<Doctors>? doctors;
  List<Appointments>? appointments;
  List<Earnings>? earnings;

  Data({this.doctors, this.appointments, this.earnings});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(Doctors.fromJson(v));
      });
    }
    if (json['appointments'] != null) {
      appointments = <Appointments>[];
      json['appointments'].forEach((v) {
        appointments!.add(Appointments.fromJson(v));
      });
    }
    if (json['earnings'] != null) {
      earnings = <Earnings>[];
      json['earnings'].forEach((v) {
        earnings!.add(Earnings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (doctors != null) {
      data['doctors'] = doctors!.map((v) => v.toJson()).toList();
    }
    if (appointments != null) {
      data['appointments'] = appointments!.map((v) => v.toJson()).toList();
    }
    if (earnings != null) {
      data['earnings'] = earnings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctors {
  int? doctorId;
  String? doctorName;
  String? qualification;
  String? email;
  String? imageUrl;
  String? experience;
  String? phoneNumber;
  String? gender;
  String? smcNumber;
  String? averageRating;
  int? specializationId;
  String? specializationName;
  int? sortNumber;
  dynamic mostBooked;
  dynamic topRated;
  String? signedImageUrl;

  Doctors(
      {this.doctorId,
        this.doctorName,
        this.qualification,
        this.email,
        this.imageUrl,
        this.experience,
        this.phoneNumber,
        this.gender,
        this.smcNumber,
        this.averageRating,
        this.specializationId,
        this.specializationName,
        this.sortNumber,
        this.mostBooked,
        this.topRated,
        this.signedImageUrl});

  Doctors.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    qualification = json['qualification'];
    email = json['email'];
    imageUrl = json['image_url'];
    experience = json['experience'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    smcNumber = json['smc_number'];
    averageRating = json['average_rating'];
    specializationId = json['specialization_id'];
    specializationName = json['specialization_name'];
    sortNumber = json['sort_number'];
    mostBooked = json['most_booked'];
    topRated = json['top_rated'];
    signedImageUrl = json['signedImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['doctor_name'] = doctorName;
    data['qualification'] = qualification;
    data['email'] = email;
    data['image_url'] = imageUrl;
    data['experience'] = experience;
    data['phone_number'] = phoneNumber;
    data['gender'] = gender;
    data['smc_number'] = smcNumber;
    data['average_rating'] = averageRating;
    data['specialization_id'] = specializationId;
    data['specialization_name'] = specializationName;
    data['sort_number'] = sortNumber;
    data['most_booked'] = mostBooked;
    data['top_rated'] = topRated;
    data['signedImageUrl'] = signedImageUrl;
    return data;
  }
}

class Appointments {
  int? appointmentId;
  int? patientId;
  int? doctorId;
  int? clinicId;
  String? appointmentDate;
  int? timeId;
  dynamic imageUrl;
  String? status;
  String? patientName;
  String? appointmentTime;
  dynamic signInImageUrl;

  Appointments(
      {this.appointmentId,
        this.patientId,
        this.doctorId,
        this.clinicId,
        this.appointmentDate,
        this.timeId,
        this.imageUrl,
        this.status,
        this.patientName,
        this.appointmentTime,
        this.signInImageUrl
      });

  Appointments.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
    appointmentDate = json['appointment_date'];
    timeId = json['time_id'];
    imageUrl = json['image_url'];
    status = json['status'];
    patientName = json['patient_name'];
    appointmentTime = json['appointment_time'];
    signInImageUrl = json['signedImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointment_id'] = appointmentId;
    data['patient_id'] = patientId;
    data['doctor_id'] = doctorId;
    data['clinic_id'] = clinicId;
    data['appointment_date'] = appointmentDate;
    data['time_id'] = timeId;
    data['image_url'] = imageUrl;
    data['status'] = status;
    data['patient_name'] = patientName;
    data['appointment_time'] = appointmentTime;
    data['signedImageUrl'] = signInImageUrl;
    return data;
  }
}

class Earnings {
  String? monthYear;
  String? totalAmount;
  String? totalamountformatted;

  

  Earnings({this.monthYear,
    this.totalAmount,
    this.totalamountformatted
  });

  Earnings.fromJson(Map<String, dynamic> json) {
    monthYear = json['month_year'];
    totalAmount = json['total_amount'];
    totalamountformatted = json['totalamountformatted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_year'] = monthYear;
    data['total_amount'] = totalAmount;
    data['totalamountformatted'] = totalamountformatted;
    return data;
  }
}
