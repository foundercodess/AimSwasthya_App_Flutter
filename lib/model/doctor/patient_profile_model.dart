class PatientProfileModel {
  bool? status;
  String? message;
  List<PatientProfile>? patientProfile;
  List<MedicalRecords>? medicalRecords;

  PatientProfileModel(
      {this.status, this.message, this.patientProfile, this.medicalRecords});

  PatientProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['patient_profile'] != null) {
      patientProfile = <PatientProfile>[];
      json['patient_profile'].forEach((v) {
        patientProfile!.add(PatientProfile.fromJson(v));
      });
    }
    if (json['medical_records'] != null) {
      medicalRecords = <MedicalRecords>[];
      json['medical_records'].forEach((v) {
        medicalRecords!.add(MedicalRecords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (patientProfile != null) {
      data['patient_profile'] =
          patientProfile!.map((v) => v.toJson()).toList();
    }
    if (medicalRecords != null) {
      data['medical_records'] =
          medicalRecords!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatientProfile {
  int? patientId;
  String? name;
  dynamic symptoms;
  String? dateOfBirth;
  String? height;
  String? weight;
  String? phoneNumber;
  String? imageUrl;
  String? signedImageUrl;

  PatientProfile(
      {this.patientId,
        this.name,
        this.symptoms,
        this.dateOfBirth,
        this.height,
        this.weight,
        this.phoneNumber,
        this.imageUrl,
        this.signedImageUrl});

  PatientProfile.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    name = json['name'];
    symptoms = json['symptoms'];
    dateOfBirth = json['date_of_birth'];
    height = json['height'];
    weight = json['weight'];
    phoneNumber = json['phone_number'];
    imageUrl = json['image_url'];
    signedImageUrl = json['signedImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patient_id'] = patientId;
    data['name'] = name;
    data['symptoms'] = symptoms;
    data['date_of_birth'] = dateOfBirth;
    data['height'] = height;
    data['weight'] = weight;
    data['phone_number'] = phoneNumber;
    data['image_url'] = imageUrl;
    data['signedImageUrl'] = signedImageUrl;
    return data;
  }
}

class MedicalRecords {
  String? documentName;
  String? documentUrl;
  String? uploadedAt;

  MedicalRecords({this.documentName, this.documentUrl, this.uploadedAt});

  MedicalRecords.fromJson(Map<String, dynamic> json) {
    documentName = json['document_name'];
    documentUrl = json['document_url'];
    uploadedAt = json['uploaded_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['document_name'] = documentName;
    data['document_url'] = documentUrl;
    data['uploaded_at'] = uploadedAt;
    return data;
  }
}
