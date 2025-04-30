class DoctorProfileModel {
  bool? status;
  Data? data;

  DoctorProfileModel({this.status, this.data});

  DoctorProfileModel.fromJson(Map<String, dynamic> json) {
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
  List<Clinics>? clinics;

  Data({this.doctors, this.clinics});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(Doctors.fromJson(v));
      });
    }
    if (json['clinics'] != null) {
      clinics = <Clinics>[];
      json['clinics'].forEach((v) {
        clinics!.add(Clinics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (doctors != null) {
      data['doctors'] = doctors!.map((v) => v.toJson()).toList();
    }
    if (clinics != null) {
      data['clinics'] = clinics!.map((v) => v.toJson()).toList();
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
    data['signedImageUrl'] = signedImageUrl;
    return data;
  }
}

class Clinics {
  int? clinicId;
  int? doctorId;
  String? name;
  String? address;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? phoneNumber;
  String? latitude;
  String? longitude;
  String? landmark;
  int? locationId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Clinics(
      {this.clinicId,
        this.doctorId,
        this.name,
        this.address,
        this.city,
        this.state,
        this.postalCode,
        this.country,
        this.phoneNumber,
        this.latitude,
        this.longitude,
        this.landmark,
        this.locationId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Clinics.fromJson(Map<String, dynamic> json) {
    clinicId = json['clinic_id'];
    doctorId = json['doctor_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postal_code'];
    country = json['country'];
    phoneNumber = json['phone_number'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    landmark = json['landmark'];
    locationId = json['location_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clinic_id'] = clinicId;
    data['doctor_id'] = doctorId;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['postal_code'] = postalCode;
    data['country'] = country;
    data['phone_number'] = phoneNumber;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['landmark'] = landmark;
    data['location_id'] = locationId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
