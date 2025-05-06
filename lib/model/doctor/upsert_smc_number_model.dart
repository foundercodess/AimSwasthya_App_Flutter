class UpsertSmcNumberModel {
  bool? status;
  String? message;
  String? verifiedFlag;

  UpsertSmcNumberModel({this.status, this.message, this.verifiedFlag});

  UpsertSmcNumberModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    verifiedFlag = json['verifiedFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['verifiedFlag'] = verifiedFlag;
    return data;
  }
}
