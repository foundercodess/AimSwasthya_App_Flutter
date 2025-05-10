// model/doctor/doc_schedule_model.dart
// class ScheduleDoctorModel {
//   bool? status;
//   String? message;
//   List<DoctorWorkingHours>? doctorWorkingHours;
//   List<SlotType>? slotType;

//   ScheduleDoctorModel(
//       {this.status, this.message, this.doctorWorkingHours, this.slotType});

//   ScheduleDoctorModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['doctorWorkingHours'] != null) {
//       doctorWorkingHours = <DoctorWorkingHours>[];
//       json['doctorWorkingHours'].forEach((v) {
//         doctorWorkingHours!.add(DoctorWorkingHours.fromJson(v));
//       });
//     }
//     if (json['slotType'] != null) {
//       slotType = <SlotType>[];
//       json['slotType'].forEach((v) {
//         slotType!.add(SlotType.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (doctorWorkingHours != null) {
//       data['doctorWorkingHours'] =
//           doctorWorkingHours!.map((v) => v.toJson()).toList();
//     }
//     if (slotType != null) {
//       data['slotType'] = slotType!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class DoctorWorkingHours {
//   int? doctorId;
//   int? clinicId;
//   String? availabilityDate;
//   String? ddMonthName;
//   String? startTime;
//   String? endTime;
//   String? availableFlag;

//   DoctorWorkingHours(
//       {this.doctorId,
//         this.clinicId,
//         this.availabilityDate,
//         this.ddMonthName,
//         this.startTime,
//         this.endTime,
//         this.availableFlag});

//   DoctorWorkingHours.fromJson(Map<String, dynamic> json) {
//     doctorId = json['doctor_id'];
//     clinicId = json['clinic_id'];
//     availabilityDate = json['availability_date'];
//     ddMonthName = json['dd_month_name'];
//     startTime = json['start_time'];
//     endTime = json['end_time'];
//     availableFlag = json['available_flag'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['doctor_id'] = doctorId;
//     data['clinic_id'] = clinicId;
//     data['availability_date'] = availabilityDate;
//     data['dd_month_name'] = ddMonthName;
//     data['start_time'] = startTime;
//     data['end_time'] = endTime;
//     data['available_flag'] = availableFlag;
//     return data;
//   }
// }

// class SlotType {
//   String? slotType;

//   SlotType({this.slotType});

//   SlotType.fromJson(Map<String, dynamic> json) {
//     slotType = json['slot_type'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['slot_type'] = slotType;
//     return data;
//   }
// }


class ScheduleDoctorModel {
  bool? status;
  String? message;
  List<Doctor>? doctor;
  List<SlotType>? slotType;
  List<Schedules>? schedules;

  ScheduleDoctorModel(
      {this.status, this.message, this.doctor, this.slotType, this.schedules});

  ScheduleDoctorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['doctor'] != null) {
      doctor = <Doctor>[];
      json['doctor'].forEach((v) {
        doctor!.add( Doctor.fromJson(v));
      });
    }
    if (json['slotType'] != null) {
      slotType = <SlotType>[];
      json['slotType'].forEach((v) {
        slotType!.add( SlotType.fromJson(v));
      });
    }
    if (json['schedules'] != null) {
      schedules = <Schedules>[];
      json['schedules'].forEach((v) {
        schedules!.add( Schedules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (doctor != null) {
      data['doctor'] = doctor!.map((v) => v.toJson()).toList();
    }
    if (slotType != null) {
      data['slotType'] = slotType!.map((v) => v.toJson()).toList();
    }
    if (schedules != null) {
      data['schedules'] = schedules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctor {
  String? doctorId;
  String? clinicId;

  Doctor({this.doctorId, this.clinicId});

  Doctor.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['doctor_id'] = doctorId;
    data['clinic_id'] = clinicId;
    return data;
  }
}

class SlotType {
  dynamic slotId;
  dynamic slotType;
  dynamic scheduleType;
  dynamic availableFlag;

  SlotType({this.slotId, this.slotType, this.scheduleType, this.availableFlag});

  SlotType.fromJson(Map<String, dynamic> json) {
    slotId = json['slot_id'];
    slotType = json['slot_type'];
    scheduleType = json['schedule_type'];
    availableFlag = json['available_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['slot_id'] = slotId;
    data['slot_type'] = slotType;
    data['schedule_type'] = scheduleType;
    data['available_flag'] = availableFlag;
    return data;
  }
}

class Schedules {
  dynamic availabilityDate;
  dynamic ddMonthName;
  dynamic availableFlag;
  List<Timings>? timings;

  Schedules(
      {this.availabilityDate,
      this.ddMonthName,
      this.availableFlag,
      this.timings});

  Schedules.fromJson(Map<String, dynamic> json) {
    availabilityDate = json['availability_date'];
    ddMonthName = json['dd_month_name'];
    availableFlag = json['available_flag'];
    if (json['timings'] != null) {
      timings = <Timings>[];
      json['timings'].forEach((v) {
        timings!.add( Timings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['availability_date'] = availabilityDate;
    data['dd_month_name'] = ddMonthName;
    data['available_flag'] = availableFlag;
    if (timings != null) {
      data['timings'] = timings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timings {
  dynamic startTime;
  dynamic endTime;

  Timings({this.startTime, this.endTime});

  Timings.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}
