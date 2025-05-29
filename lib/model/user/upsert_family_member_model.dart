class UpsertFamilyMemberModel {
  bool? status;
  String? message;
  List<Data>? data;

  UpsertFamilyMemberModel({this.status, this.message, this.data});

  UpsertFamilyMemberModel.fromJson(Map<String, dynamic> json) {
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
  int? familyMemberId;
  int? patientId;
  String? name;
  String? gender;
  String? email;
  String? phoneNumber;
  String? dateOfBirth;
  String? height;
  String? weight;
  String? relation;

  Data(
      {this.familyMemberId,
        this.patientId,
        this.name,
        this.gender,
        this.email,
        this.phoneNumber,
        this.dateOfBirth,
        this.height,
        this.weight,
        this.relation});

  Data.fromJson(Map<String, dynamic> json) {
    familyMemberId = json['family_member_id'];
    patientId = json['patient_id'];
    name = json['name'];
    gender = json['gender'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    height = json['height'];
    weight = json['weight'];
    relation = json['relation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['family_member_id'] = familyMemberId;
    data['patient_id'] = patientId;
    data['name'] = name;
    data['gender'] = gender;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['height'] = height;
    data['weight'] = weight;
    data['relation'] = relation;
    return data;
  }
}
