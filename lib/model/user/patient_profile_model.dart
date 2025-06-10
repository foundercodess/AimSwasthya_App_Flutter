// model/user/patient_profile_model.dart
class UserPatientProfileModel {
  bool? status;
  String? message;
  List<Data>? data;

  UserPatientProfileModel({this.status, this.message, this.data});

  UserPatientProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? gender;
  String? phoneNumber;
  dynamic email;
  String? dateOfBirth;
  String? height;
  String? weight;
  String? bloodGroup;
  String? allergies;
  String? currentMedications;
  String? chronicIllnesses;
  String? lifestyleHabbits;
  String? signedImageUrl;
  String? image_url;

  Data(
      {this.name,
        this.gender,
        this.phoneNumber,
        this.email,
        this.dateOfBirth,
        this.height,
        this.weight,
        this.bloodGroup,
        this.allergies,
        this.currentMedications,
        this.chronicIllnesses,
        this.lifestyleHabbits,
        this.signedImageUrl,
        this.image_url
      });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    height = json['height'];
    weight = json['weight'];
    bloodGroup = json['blood_group'];
    allergies = json['allergies'];
    currentMedications = json['current_medications'];
    chronicIllnesses = json['chronic_illnesses'];
    lifestyleHabbits = json['lifestyle_habbits'];
    signedImageUrl = json['signedImageUrl'];
    image_url = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['gender'] = gender;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['date_of_birth'] = dateOfBirth;
    data['height'] = height;
    data['weight'] = weight;
    data['blood_group'] = bloodGroup;
    data['allergies'] = allergies;
    data['current_medications'] = currentMedications;
    data['chronic_illnesses'] = chronicIllnesses;
    data['lifestyle_habbits'] = lifestyleHabbits;
    data['signedImageUrl'] = signedImageUrl;
    data['image_url'] = image_url;
    return data;
  }
}
