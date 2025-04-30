import 'package:aim_swasthya/model/user/patient_home_model.dart';

class DoctorDetailsModel {
  bool? status;
  Data? data;

  DoctorDetailsModel({this.status, this.data});

  DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Doctors>? doctors;

  Data({this.doctors});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(Doctors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (doctors != null) {
      data['doctors'] = doctors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Doctors {
//   int? doctorId;
//   String? doctorName;
//   String? doctorLatitude;
//   String? doctorLongitude;
//   String? email;
//   int? practiceStartYear;
//   String? phoneNumber;
//   String? gender;
//   String? smcNumber;
//   String? averageRating;
//   String? consultationFeeType;
//   String? consultationFee;
//   int? locationId;
//   String? locationName;
//   String? locationLatitude;
//   String? locationLongitude;
//   double? distanceInKm;
//   int? specializationId;
//   String? specializationName;
//   int? sortNumber;
//
//   Doctors(
//       {this.doctorId,
//         this.doctorName,
//         this.doctorLatitude,
//         this.doctorLongitude,
//         this.email,
//         this.practiceStartYear,
//         this.phoneNumber,
//         this.gender,
//         this.smcNumber,
//         this.averageRating,
//         this.consultationFeeType,
//         this.consultationFee,
//         this.locationId,
//         this.locationName,
//         this.locationLatitude,
//         this.locationLongitude,
//         this.distanceInKm,
//         this.specializationId,
//         this.specializationName,
//         this.sortNumber});
//
//   Doctors.fromJson(Map<String, dynamic> json) {
//     doctorId = json['doctor_id'];
//     doctorName = json['doctor_name'];
//     doctorLatitude = json['doctor_latitude'];
//     doctorLongitude = json['doctor_longitude'];
//     email = json['email'];
//     practiceStartYear = json['practice_start_year'];
//     phoneNumber = json['phone_number'];
//     gender = json['gender'];
//     smcNumber = json['smc_number'];
//     averageRating = json['average_rating'];
//     consultationFeeType = json['consultation_fee_type'];
//     consultationFee = json['consultation_fee'];
//     locationId = json['location_id'];
//     locationName = json['location_name'];
//     locationLatitude = json['location_latitude'];
//     locationLongitude = json['location_longitude'];
//     distanceInKm = json['distance_in_km'];
//     specializationId = json['specialization_id'];
//     specializationName = json['specialization_name'];
//     sortNumber = json['sort_number'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['doctor_id'] = doctorId;
//     data['doctor_name'] = doctorName;
//     data['doctor_latitude'] = doctorLatitude;
//     data['doctor_longitude'] = doctorLongitude;
//     data['email'] = email;
//     data['practice_start_year'] = practiceStartYear;
//     data['phone_number'] = phoneNumber;
//     data['gender'] = gender;
//     data['smc_number'] = smcNumber;
//     data['average_rating'] = averageRating;
//     data['consultation_fee_type'] = consultationFeeType;
//     data['consultation_fee'] = consultationFee;
//     data['location_id'] = locationId;
//     data['location_name'] = locationName;
//     data['location_latitude'] = locationLatitude;
//     data['location_longitude'] = locationLongitude;
//     data['distance_in_km'] = distanceInKm;
//     data['specialization_id'] = specializationId;
//     data['specialization_name'] = specializationName;
//     data['sort_number'] = sortNumber;
//     return data;
//   }
// }
