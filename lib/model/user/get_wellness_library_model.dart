class GetWellnessLibraryModel {
  bool? status;
  String? message;
  List<Data>? data;

  GetWellnessLibraryModel({this.status, this.message, this.data});

  GetWellnessLibraryModel.fromJson(Map<String, dynamic> json) {
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
  int? patientId;
  int? healthTipId;
  String? favouriteFlag;
  String? title;
  String? description;
  String? urlImage;
  String? urlArticle;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Data(
      {this.patientWellnessLibraryId,
        this.patientId,
        this.healthTipId,
        this.favouriteFlag,
        this.title,
        this.description,
        this.urlImage,
        this.urlArticle,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    patientWellnessLibraryId = json['patient_wellness_library_id'];
    patientId = json['patient_id'];
    healthTipId = json['health_tip_id'];
    favouriteFlag = json['favourite_flag'];
    title = json['title'];
    description = json['description'];
    urlImage = json['url_image'];
    urlArticle = json['url_article'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patient_wellness_library_id'] = patientWellnessLibraryId;
    data['patient_id'] = patientId;
    data['health_tip_id'] = healthTipId;
    data['favourite_flag'] = favouriteFlag;
    data['title'] = title;
    data['description'] = description;
    data['url_image'] = urlImage;
    data['url_article'] = urlArticle;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
