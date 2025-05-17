class DeleteAccountModel {
  bool? status;
  String? message;
  Information? information;

  DeleteAccountModel({this.status, this.message, this.information});

  DeleteAccountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    information = json['information'] != null
        ? Information.fromJson(json['information'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (information != null) {
      data['information'] = information!.toJson();
    }
    return data;
  }
}

class Information {
  int? fieldCount;
  int? affectedRows;
  int? insertId;
  String? info;
  int? serverStatus;
  int? warningStatus;
  int? changedRows;

  Information(
      {this.fieldCount,
        this.affectedRows,
        this.insertId,
        this.info,
        this.serverStatus,
        this.warningStatus,
        this.changedRows});

  Information.fromJson(Map<String, dynamic> json) {
    fieldCount = json['fieldCount'];
    affectedRows = json['affectedRows'];
    insertId = json['insertId'];
    info = json['info'];
    serverStatus = json['serverStatus'];
    warningStatus = json['warningStatus'];
    changedRows = json['changedRows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fieldCount'] = fieldCount;
    data['affectedRows'] = affectedRows;
    data['insertId'] = insertId;
    data['info'] = info;
    data['serverStatus'] = serverStatus;
    data['warningStatus'] = warningStatus;
    data['changedRows'] = changedRows;
    return data;
  }
}
