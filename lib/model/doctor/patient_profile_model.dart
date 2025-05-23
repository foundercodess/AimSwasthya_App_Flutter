// model/doctor/patient_profile_model.dart
// class PatientProfileModel {
//   bool? status;
//   String? message;
//   List<PatientProfile>? patientProfile;
//   List<MedicalRecords>? medicalRecords;

//   PatientProfileModel(
//       {this.status, this.message, this.patientProfile, this.medicalRecords});

//   PatientProfileModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['patient_profile'] != null) {
//       patientProfile = <PatientProfile>[];
//       json['patient_profile'].forEach((v) {
//         patientProfile!.add(PatientProfile.fromJson(v));
//       });
//     }
//     if (json['medical_records'] != null) {
//       medicalRecords = <MedicalRecords>[];
//       json['medical_records'].forEach((v) {
//         medicalRecords!.add(MedicalRecords.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (patientProfile != null) {
//       data['patient_profile'] =
//           patientProfile!.map((v) => v.toJson()).toList();
//     }
//     if (medicalRecords != null) {
//       data['medical_records'] =
//           medicalRecords!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class PatientProfile {
//   int? patientId;
//   String? name;
//   dynamic symptoms;
//   String? dateOfBirth;
//   String? height;
//   String? weight;
//   String? phoneNumber;
//   String? imageUrl;
//   String? signedImageUrl;

//   PatientProfile(
//       {this.patientId,
//         this.name,
//         this.symptoms,
//         this.dateOfBirth,
//         this.height,
//         this.weight,
//         this.phoneNumber,
//         this.imageUrl,
//         this.signedImageUrl});

//   PatientProfile.fromJson(Map<String, dynamic> json) {
//     patientId = json['patient_id'];
//     name = json['name'];
//     symptoms = json['symptoms'];
//     dateOfBirth = json['date_of_birth'];
//     height = json['height'];
//     weight = json['weight'];
//     phoneNumber = json['phone_number'];
//     imageUrl = json['image_url'];
//     signedImageUrl = json['signedImageUrl'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['patient_id'] = patientId;
//     data['name'] = name;
//     data['symptoms'] = symptoms;
//     data['date_of_birth'] = dateOfBirth;
//     data['height'] = height;
//     data['weight'] = weight;
//     data['phone_number'] = phoneNumber;
//     data['image_url'] = imageUrl;
//     data['signedImageUrl'] = signedImageUrl;
//     return data;
//   }
// }

// class MedicalRecords {
//   String? documentName;
//   String? documentUrl;
//   String? uploadedAt;

//   MedicalRecords({this.documentName, this.documentUrl, this.uploadedAt});

//   MedicalRecords.fromJson(Map<String, dynamic> json) {
//     documentName = json['document_name'];
//     documentUrl = json['document_url'];
//     uploadedAt = json['uploaded_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['document_name'] = documentName;
//     data['document_url'] = documentUrl;
//     data['uploaded_at'] = uploadedAt;
//     return data;
//   }
// }


class PatientProfileModel {
  bool? status;
  String? message;
  List<PatientProfile>? patientProfile;
  List<PatientSymptoms>? patientSymptoms;
  List<MedicalRecords>? medicalRecords;

  PatientProfileModel(
      {this.status,
      this.message,
      this.patientProfile,
      this.patientSymptoms,
      this.medicalRecords});

  PatientProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['patient_profile'] != null) {
      patientProfile = <PatientProfile>[];
      json['patient_profile'].forEach((v) {
        patientProfile!.add(new PatientProfile.fromJson(v));
      });
    }
    if (json['patient_symptoms'] != null) {
      patientSymptoms = <PatientSymptoms>[];
      json['patient_symptoms'].forEach((v) {
        patientSymptoms!.add(new PatientSymptoms.fromJson(v));
      });
    }
    if (json['medical_records'] != null) {
      medicalRecords = <MedicalRecords>[];
      json['medical_records'].forEach((v) {
        medicalRecords!.add(new MedicalRecords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.patientProfile != null) {
      data['patient_profile'] =
          this.patientProfile!.map((v) => v.toJson()).toList();
    }
    if (this.patientSymptoms != null) {
      data['patient_symptoms'] =
          this.patientSymptoms!.map((v) => v.toJson()).toList();
    }
    if (this.medicalRecords != null) {
      data['medical_records'] =
          this.medicalRecords!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatientProfile {
  int? patientId;
  int? doctorId;
  int? appointmentId;
  String? name;
  String? dateOfBirth;
  String? height;
  String? weight;
  String? imageUrl;
  String? bookingDate;
  String? bookingTime;
  String? signedImageUrl;

  PatientProfile(
      {this.patientId,
      this.doctorId,
      this.appointmentId,
      this.name,
      this.dateOfBirth,
      this.height,
      this.weight,
      this.imageUrl,
      this.bookingDate,
      this.bookingTime,
      this.signedImageUrl});

  PatientProfile.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    appointmentId = json['appointment_id'];
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
    height = json['height'];
    weight = json['weight'];
    imageUrl = json['image_url'];
    bookingDate = json['booking_date'];
    bookingTime = json['booking_time'];
    signedImageUrl = json['signedImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['doctor_id'] = this.doctorId;
    data['appointment_id'] = this.appointmentId;
    data['name'] = this.name;
    data['date_of_birth'] = this.dateOfBirth;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['image_url'] = this.imageUrl;
    data['booking_date'] = this.bookingDate;
    data['booking_time'] = this.bookingTime;
    data['signedImageUrl'] = this.signedImageUrl;
    return data;
  }
}

class PatientSymptoms {
  int? patientId;
  String? symptoms;

  PatientSymptoms({this.patientId, this.symptoms});

  PatientSymptoms.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    symptoms = json['symptoms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['symptoms'] = this.symptoms;
    return data;
  }
}

class MedicalRecords {
  int? entityId;
  String? imageUrl;
  String? uploadedAt;
  String? signedImageUrl;

  MedicalRecords({this.entityId, this.imageUrl, this.uploadedAt ,this.signedImageUrl});

  MedicalRecords.fromJson(Map<String, dynamic> json) {
    entityId = json['entity_id'];
    imageUrl = json['image_url'];
    uploadedAt = json['uploaded_at'];
    signedImageUrl = json['signedImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['entity_id'] = entityId;
    data['image_url'] = imageUrl;
    data['uploaded_at'] = uploadedAt;
    data['signedImageUrl'] = signedImageUrl;
    return data;
  }
}
