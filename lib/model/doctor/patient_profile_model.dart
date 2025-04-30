class PatientProfileModel {
  bool? status;
  String? message;
  List<Null>? patientProfile;
  List<MedicalRecords>? medicalRecords;

  PatientProfileModel(
      {this.status, this.message, this.patientProfile, this.medicalRecords});

  PatientProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['patient_profile'] != null) {
      patientProfile = <Null>[];
      // json['patient_profile'].forEach((v) {
      //   patientProfile!.add(new Null.fromJson(v));
      // });
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
    // if (this.patientProfile != null) {
    //   data['patient_profile'] =
    //       this.patientProfile!.map((v) => v.toJson()).toList();
    // }
    if (medicalRecords != null) {
      data['medical_records'] =
          medicalRecords!.map((v) => v.toJson()).toList();
    }
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
