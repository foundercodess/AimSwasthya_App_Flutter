import 'package:aim_swasthya/model/user/patient_home_model.dart';

class GetAiSuggestionModel {
  bool? success;
  List<Doctors>? data;
  List<String>? specialist;

  GetAiSuggestionModel({this.success, this.data, this.specialist});

  GetAiSuggestionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Doctors>[];
      json['data'].forEach((v) {
        data!.add(Doctors.fromJson(v));
      });
    }
    specialist = json['specialist'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['specialist'] = specialist;
    return data;
  }
}

// class Data {
//   int? doctorId;
//   int? clinicId;
//   String? doctorName;
//   String? clinicLatitude;
//   String? clinicLongitude;
//   String? email;
//   String? imageUrl;
//   String? experience;
//   String? phoneNumber;
//   String? gender;
//   String? smcNumber;
//   int? averageRating;
//   String? topRated;
//   String? consultationFeeType;
//   String? consultationFee;
//   int? locationId;
//   String? locationName;
//   String? locationLatitude;
//   String? locationLongitude;
//   String? distanceInKm;
//   int? specializationId;
//   String? specializationName;
//   int? sortNumber;
//   String? signedImageUrl;
//
//   Data(
//       {this.doctorId,
//         this.clinicId,
//         this.doctorName,
//         this.clinicLatitude,
//         this.clinicLongitude,
//         this.email,
//         this.imageUrl,
//         this.experience,
//         this.phoneNumber,
//         this.gender,
//         this.smcNumber,
//         this.averageRating,
//         this.topRated,
//         this.consultationFeeType,
//         this.consultationFee,
//         this.locationId,
//         this.locationName,
//         this.locationLatitude,
//         this.locationLongitude,
//         this.distanceInKm,
//         this.specializationId,
//         this.specializationName,
//         this.sortNumber,
//         this.signedImageUrl});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     doctorId = json['doctor_id'];
//     clinicId = json['clinic_id'];
//     doctorName = json['doctor_name'];
//     clinicLatitude = json['clinic_latitude'];
//     clinicLongitude = json['clinic_longitude'];
//     email = json['email'];
//     imageUrl = json['image_url'];
//     experience = json['experience'];
//     phoneNumber = json['phone_number'];
//     gender = json['gender'];
//     smcNumber = json['smc_number'];
//     averageRating = json['average_rating'];
//     topRated = json['top_rated'];
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
//     signedImageUrl = json['signedImageUrl'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['doctor_id'] = doctorId;
//     data['clinic_id'] = clinicId;
//     data['doctor_name'] = doctorName;
//     data['clinic_latitude'] = clinicLatitude;
//     data['clinic_longitude'] = clinicLongitude;
//     data['email'] = email;
//     data['image_url'] = imageUrl;
//     data['experience'] = experience;
//     data['phone_number'] = phoneNumber;
//     data['gender'] = gender;
//     data['smc_number'] = smcNumber;
//     data['average_rating'] = averageRating;
//     data['top_rated'] = topRated;
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
//     data['signedImageUrl'] = signedImageUrl;
//     return data;
//   }
// }
