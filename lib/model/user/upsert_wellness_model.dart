class UpsertWellnessLibraryModel {
  bool? status;
  String? message;
  List<Data>? data;

  UpsertWellnessLibraryModel({this.status, this.message, this.data});

  UpsertWellnessLibraryModel.fromJson(Map<String, dynamic> json) {
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
  int? patientWellnessLibraryId;
  String? favouriteFlag;

  Data({this.patientWellnessLibraryId, this.favouriteFlag});

  Data.fromJson(Map<String, dynamic> json) {
    patientWellnessLibraryId = json['patient_wellness_library_id'];
    favouriteFlag = json['favourite_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patient_wellness_library_id'] = patientWellnessLibraryId;
    data['favourite_flag'] = favouriteFlag;
    return data;
  }
}
