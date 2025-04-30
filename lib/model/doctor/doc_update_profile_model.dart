import 'doctor_profile_model.dart';

class DocUpdateProfileModel {
  bool? status;
  Data? data;

  DocUpdateProfileModel({this.status, this.data});

  DocUpdateProfileModel.fromJson(Map<String, dynamic> json) {
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
