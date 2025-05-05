class RevenueDoctorModel {
  bool? status;
  String? message;
  List<EarningMonth>? earningMonth;
  List<RevenueAnalytics>? revenueAnalytics;
  List<PatientPayment>? patientPayment;

  RevenueDoctorModel(
      {this.status,
        this.message,
        this.earningMonth,
        this.revenueAnalytics,
        this.patientPayment});

  RevenueDoctorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['earningMonth'] != null) {
      earningMonth = <EarningMonth>[];
      json['earningMonth'].forEach((v) {
        earningMonth!.add(EarningMonth.fromJson(v));
      });
    }
    if (json['revenue_Analytics'] != null) {
      revenueAnalytics = <RevenueAnalytics>[];
      json['revenue_Analytics'].forEach((v) {
        revenueAnalytics!.add(RevenueAnalytics.fromJson(v));
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
    if (earningMonth != null) {
      data['earningMonth'] = earningMonth!.map((v) => v.toJson()).toList();
    }
    if (revenueAnalytics != null) {
      data['revenue_Analytics'] =
          revenueAnalytics!.map((v) => v.toJson()).toList();
    }
    if (patientPayment != null) {
      data['patient_payment'] =
          patientPayment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EarningMonth {
  String? monthYear;
  String? totalAmount;

  EarningMonth({this.monthYear, this.totalAmount});

  EarningMonth.fromJson(Map<String, dynamic> json) {
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

class RevenueAnalytics {
  String? date;
  String? dayName;
  String? totalAmount;

  RevenueAnalytics({this.date, this.dayName, this.totalAmount});

  RevenueAnalytics.fromJson(Map<String, dynamic> json) {
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
