class ScheduleDoctorModel {
  bool? status;
  String? message;
  List<DoctorWorkingHours>? doctorWorkingHours;
  List<SlotType>? slotType;

  ScheduleDoctorModel(
      {this.status, this.message, this.doctorWorkingHours, this.slotType});

  ScheduleDoctorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['doctorWorkingHours'] != null) {
      doctorWorkingHours = <DoctorWorkingHours>[];
      json['doctorWorkingHours'].forEach((v) {
        doctorWorkingHours!.add(DoctorWorkingHours.fromJson(v));
      });
    }
    if (json['slotType'] != null) {
      slotType = <SlotType>[];
      json['slotType'].forEach((v) {
        slotType!.add(SlotType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (doctorWorkingHours != null) {
      data['doctorWorkingHours'] =
          doctorWorkingHours!.map((v) => v.toJson()).toList();
    }
    if (slotType != null) {
      data['slotType'] = slotType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoctorWorkingHours {
  int? doctorId;
  int? clinicId;
  String? availabilityDate;
  String? ddMonthName;
  String? startTime;
  String? endTime;
  String? availableFlag;

  DoctorWorkingHours(
      {this.doctorId,
        this.clinicId,
        this.availabilityDate,
        this.ddMonthName,
        this.startTime,
        this.endTime,
        this.availableFlag});

  DoctorWorkingHours.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
    availabilityDate = json['availability_date'];
    ddMonthName = json['dd_month_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    availableFlag = json['available_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['clinic_id'] = clinicId;
    data['availability_date'] = availabilityDate;
    data['dd_month_name'] = ddMonthName;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['available_flag'] = availableFlag;
    return data;
  }
}

class SlotType {
  String? slotType;

  SlotType({this.slotType});

  SlotType.fromJson(Map<String, dynamic> json) {
    slotType = json['slot_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slot_type'] = slotType;
    return data;
  }
}
