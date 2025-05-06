class AllSpecializationDocModel {
  bool? status;
  String? message;
  List<Specializations>? specializations;

  AllSpecializationDocModel({this.status, this.message, this.specializations});

  AllSpecializationDocModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['specializations'] != null) {
      specializations = <Specializations>[];
      json['specializations'].forEach((v) {
        specializations!.add(Specializations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (specializations != null) {
      data['specializations'] =
          specializations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Specializations {
  int? specializationId;
  String? specializationName;

  Specializations({this.specializationId, this.specializationName});

  Specializations.fromJson(Map<String, dynamic> json) {
    specializationId = json['specialization_id'];
    specializationName = json['specialization_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['specialization_id'] = specializationId;
    data['specialization_name'] = specializationName;
    return data;
  }
}
