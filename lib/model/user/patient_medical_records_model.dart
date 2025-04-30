class PatientMedicalRecordsModel {
  bool? status;
  Data? data;

  PatientMedicalRecordsModel({this.status, this.data});

  PatientMedicalRecordsModel.fromJson(Map<String, dynamic> json) {
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
  List<Medicalrecords>? medicalrecords;

  Data({this.medicalrecords});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['medicalrecords'] != null) {
      medicalrecords = <Medicalrecords>[];
      json['medicalrecords'].forEach((v) {
        medicalrecords!.add(Medicalrecords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medicalrecords != null) {
      data['medicalrecords'] =
          medicalrecords!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicalrecords {
  int? documentId;
  int? patientId;
  String? name;
  dynamic email;
  String? phoneNumber;
  String? dateOfBirth;
  String? height;
  String? weight;
  String? gender;
  String? documentName;
  String? documentType;
  String? documentUrl;
  String? uploadedAt;

  Medicalrecords(
      {this.documentId,
        this.patientId,
        this.name,
        this.email,
        this.phoneNumber,
        this.dateOfBirth,
        this.height,
        this.weight,
        this.gender,
        this.documentName,
        this.documentType,
        this.documentUrl,
        this.uploadedAt});

  Medicalrecords.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'];
    patientId = json['patient_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    height = json['height'];
    weight = json['weight'];
    gender = json['gender'];
    documentName = json['document_name'];
    documentType = json['document_type'];
    documentUrl = json['document_url'];
    uploadedAt = json['uploaded_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['document_id'] = documentId;
    data['patient_id'] = patientId;
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['height'] = height;
    data['weight'] = weight;
    data['gender'] = gender;
    data['document_name'] = documentName;
    data['document_type'] = documentType;
    data['document_url'] = documentUrl;
    data['uploaded_at'] = uploadedAt;
    return data;
  }
}

class GetMedicalRecordData {
  bool? status;
  MedicalData? data;

  GetMedicalRecordData({this.status, this.data});

  GetMedicalRecordData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? MedicalData.fromJson(json['data']) : null;
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

class MedicalData {
  List<MedicalRecord>? medicalRecord;

  MedicalData({this.medicalRecord});

  MedicalData.fromJson(Map<String, dynamic> json) {
    if (json['medicalRecord'] != null) {
      medicalRecord = <MedicalRecord>[];
      json['medicalRecord'].forEach((v) {
        medicalRecord!.add(MedicalRecord.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medicalRecord != null) {
      data['medicalRecord'] =
          medicalRecord!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicalRecord {
  int? imageId;
  int? entityId;
  String? entityType;
  String? fileType;
  String? imageUrl;
  String? createdAt;
  String? filename;
  String? signedImageUrl;

  MedicalRecord(
      {this.imageId,
        this.entityId,
        this.entityType,
        this.fileType,
        this.imageUrl,
        this.createdAt,
        this.filename,
        this.signedImageUrl});

  MedicalRecord.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    entityId = json['entity_id'];
    entityType = json['entity_type'];
    fileType = json['file_type'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
    filename = json['filename'];
    signedImageUrl = json['signedImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_id'] = imageId;
    data['entity_id'] = entityId;
    data['entity_type'] = entityType;
    data['file_type'] = fileType;
    data['image_url'] = imageUrl;
    data['created_at'] = createdAt;
    data['filename'] = filename;
    data['signedImageUrl'] = signedImageUrl;
    return data;
  }
}
