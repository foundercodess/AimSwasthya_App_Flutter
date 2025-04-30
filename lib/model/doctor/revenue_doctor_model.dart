class RevenueDoctorModel {
  bool? status;
  String? message;
  List<Earning>? earning;
  List<SevenDaysEarning>? sevenDaysEarning;
  List<PatientPayment>? patientPayment;

  RevenueDoctorModel(
      {this.status,
        this.message,
        this.earning,
        this.sevenDaysEarning,
        this.patientPayment});

  RevenueDoctorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['earning'] != null) {
      earning = <Earning>[];
      json['earning'].forEach((v) {
        earning!.add(Earning.fromJson(v));
      });
    }
    if (json['seven_days_earning'] != null) {
      sevenDaysEarning = <SevenDaysEarning>[];
      json['seven_days_earning'].forEach((v) {
        sevenDaysEarning!.add(SevenDaysEarning.fromJson(v));
      });
    }
    if (json['patient_payment'] != null) {
      patientPayment = <PatientPayment>[];
      json['patient_payment'].forEach((v) {
        patientPayment!.add(PatientPayment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (earning != null) {
      data['earning'] = earning!.map((v) => v.toJson()).toList();
    }
    if (sevenDaysEarning != null) {
      data['seven_days_earning'] =
          sevenDaysEarning!.map((v) => v.toJson()).toList();
    }
    if (patientPayment != null) {
      data['patient_payment'] =
          patientPayment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Earning {
  String? monthYear;
  String? totalAmount;

  Earning({this.monthYear, this.totalAmount});

  Earning.fromJson(Map<String, dynamic> json) {
    monthYear = json['month_year'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_year'] = monthYear;
    data['total_amount'] = totalAmount;
    return data;
  }
}

class SevenDaysEarning {
  String? date;
  String? dayName;
  String? totalAmount;

  SevenDaysEarning({this.date, this.dayName, this.totalAmount});

  SevenDaysEarning.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dayName = json['day_name'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['day_name'] = dayName;
    data['total_amount'] = totalAmount;
    return data;
  }
}

class PatientPayment {
  String? name;
  String? amount;
  String? section;

  PatientPayment({this.name, this.amount, this.section});

  PatientPayment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['amount'] = amount;
    data['section'] = section;
    return data;
  }
}
