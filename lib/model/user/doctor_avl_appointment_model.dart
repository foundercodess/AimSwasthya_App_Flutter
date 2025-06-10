// model/user/doctor_avl_appointment_model.dart
// class DoctorAvlAppointmentModel {
//   bool? status;
//   Data? data;
//   String? message;

//   DoctorAvlAppointmentModel({this.status, this.data,this.message});

//   DoctorAvlAppointmentModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message=json['message']??'';
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   List<Details>? details;
//   List<Reviews>? reviews;
//   List<Location>? location;
//   List<Slots>? slots;

//   Data({this.details, this.reviews, this.location, this.slots});

//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['Details'] != null) {
//       details = <Details>[];
//       json['Details'].forEach((v) {
//         details!.add(Details.fromJson(v));
//       });
//     }
//     if (json['Reviews'] != null || json['Reviews'] !=[]) {
//       reviews = <Reviews>[];
//       json['Reviews'].forEach((v) {
//         reviews!.add(Reviews.fromJson(v));
//       });
//     }if(json['Reviews'] ==[]){
//       reviews = <Reviews>[];
//     }
//     if (json['Location'] != null) {
//       location = <Location>[];
//       json['Location'].forEach((v) {
//         location!.add(Location.fromJson(v));
//       });
//     }
//     if (json['Slots'] != null) {
//       slots = <Slots>[];
//       json['Slots'].forEach((v) {
//         slots!.add(Slots.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (details != null) {
//       data['Details'] = details!.map((v) => v.toJson()).toList();
//     }
//     if (reviews != null) {
//       data['Reviews'] = reviews!.map((v) => v.toJson()).toList();
//     }
//     if (location != null) {
//       data['Location'] = location!.map((v) => v.toJson()).toList();
//     }
//     if (slots != null) {
//       data['Slots'] = slots!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Details {
//   int? doctorId;
//   String? doctorName;
//   dynamic qualification;
//   String? email;
//   String? imageUrl;
//   String? experience;
//   String? phoneNumber;
//   String? smcNumber;
//   dynamic averageRating;
//   dynamic topRated;
//   int? reviewCount;
//   int? specializationId;
//   String? specializationName;
//   dynamic signedImageUrl;
//   dynamic preferredDoctorStatus;

//   Details(
//       {this.doctorId,
//         this.doctorName,
//         this.qualification,
//         this.email,
//         this.imageUrl,
//         this.experience,
//         this.phoneNumber,
//         this.smcNumber,
//         this.averageRating,
//         this.topRated,
//         this.reviewCount,
//         this.specializationId,
//         this.specializationName,
//         this.signedImageUrl,
//         this.preferredDoctorStatus
//       });

//   Details.fromJson(Map<String, dynamic> json) {
//     doctorId = json['doctor_id'];
//     doctorName = json['doctor_name'];
//     qualification = json['qualification'];
//     email = json['email'];
//     imageUrl = json['image_url'];
//     experience = json['experience'];
//     phoneNumber = json['phone_number'];
//     smcNumber = json['smc_number'];
//     averageRating = json['average_rating'];
//     topRated = json['top_rated'];
//     reviewCount = json['review_count'];
//     specializationId = json['specialization_id'];
//     specializationName = json['specialization_name'];
//     signedImageUrl = json['signedImageUrl'];
//     preferredDoctorStatus = json['preferredDoctorStatus'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['doctor_id'] = doctorId;
//     data['doctor_name'] = doctorName;
//     data['qualification'] = qualification;
//     data['email'] = email;
//     data['image_url'] = imageUrl;
//     data['experience'] = experience;
//     data['phone_number'] = phoneNumber;
//     data['smc_number'] = smcNumber;
//     data['average_rating'] = averageRating;
//     data['top_rated'] = topRated;
//     data['review_count'] = reviewCount;
//     data['specialization_id'] = specializationId;
//     data['specialization_name'] = specializationName;
//     data['signedImageUrl'] = signedImageUrl;
//     data['preferredDoctorStatus'] = preferredDoctorStatus;
//     return data;
//   }
// }

// class Reviews {
//   int? reviewId;
//   int? rating;
//   String? consultedFor;
//   String? review;
//   int? patientId;
//   String? name;

//   Reviews(
//       {this.reviewId,
//         this.rating,
//         this.consultedFor,
//         this.review,
//         this.patientId,
//         this.name});

//   Reviews.fromJson(Map<String, dynamic> json) {
//     reviewId = json['review_id'];
//     rating = json['rating'];
//     consultedFor = json['consulted_for'];
//     review = json['review'];
//     patientId = json['patient_id'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['review_id'] = reviewId;
//     data['rating'] = rating;
//     data['consulted_for'] = consultedFor;
//     data['review'] = review;
//     data['patient_id'] = patientId;
//     data['name'] = name;
//     return data;
//   }
// }

// class Location {
//   int? doctorId;
//   int? clinicId;
//   String? consultationFeeType;
//   String? consultationFee;
//   int? fee;
//   String? digiswasthyaDiscount;
//   String? address;
//   String? city;
//   String? state;
//   String? postalCode;
//   String? country;
//   String? phoneNumber;
//   String? latitude;
//   String? longitude;
//   String? distanceInKm;
//   String? startTime;
//   String? endTime;

//   Location(
//       {this.doctorId,
//       this.clinicId,
//         this.consultationFeeType,
//         this.consultationFee,
//         this.fee,
//         this.digiswasthyaDiscount,
//         this.address,
//         this.city,
//         this.state,
//         this.postalCode,
//         this.country,
//         this.phoneNumber,
//         this.latitude,
//         this.longitude,
//         this.distanceInKm, this.startTime,this.endTime});

//   Location.fromJson(Map<String, dynamic> json) {
//     doctorId = json['doctor_id'];
//     clinicId = json['clinic_id'];
//     consultationFeeType = json['consultation_fee_type'];
//     consultationFee = json['consultation_fee'];
//     fee = json['fee'];
//     digiswasthyaDiscount = json['digiswasthya_discount'];
//     address = json['address'];
//     city = json['city'];
//     state = json['state'];
//     postalCode = json['postal_code'];
//     country = json['country'];
//     phoneNumber = json['phone_number'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     distanceInKm = json['distance_in_km'];
//     startTime = json['start_time'];
//     endTime = json['end_time'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['doctor_id'] = doctorId;
//     data['clinic_id'] = clinicId;
//     data['consultation_fee_type'] = consultationFeeType;
//     data['consultation_fee'] = consultationFee;
//     data['fee'] = fee;
//     data['digiswasthya_discount'] = digiswasthyaDiscount;
//     data['address'] = address;
//     data['city'] = city;
//     data['state'] = state;
//     data['postal_code'] = postalCode;
//     data['country'] = country;
//     data['phone_number'] = phoneNumber;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['distance_in_km'] = distanceInKm;
//     data['start_time'] = startTime;
//     data['end_time'] = endTime;
//     return data;
//   }
// }

// class Slots {
//   int? doctorId;
//   int? clinicId;
//   String? availabilityDate;
//   String? day;
//   List<AvailableTime>? availableTime;

//   Slots(
//       {this.doctorId,
//         this.clinicId,
//         this.availabilityDate,
//         this.day,
//         this.availableTime});

//   Slots.fromJson(Map<String, dynamic> json) {
//     doctorId = json['doctor_id'];
//     clinicId = json['clinic_id'];
//     availabilityDate = json['availability_date'];
//     day = json['day'];
//     if (json['available_time'] != null) {
//       availableTime = <AvailableTime>[];
//       json['available_time'].forEach((v) {
//         availableTime!.add(AvailableTime.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['doctor_id'] = doctorId;
//     data['clinic_id'] = clinicId;
//     data['availability_date'] = availabilityDate;
//     data['day'] = day;
//     if (availableTime != null) {
//       data['available_time'] =
//           availableTime!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class AvailableTime {
//   int? timeId;
//   String? slotTime;
//   String? timeOfDay;
//   String? slotAvailableFlag;

//   AvailableTime(
//       {this.timeId, this.slotTime, this.timeOfDay, this.slotAvailableFlag});

//   AvailableTime.fromJson(Map<String, dynamic> json) {
//     timeId = json['time_id'];
//     slotTime = json['slot_time'];
//     timeOfDay = json['time_of_day'];
//     slotAvailableFlag = json['slot_available_flag'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['time_id'] = timeId;
//     data['slot_time'] = slotTime;
//     data['time_of_day'] = timeOfDay;
//     data['slot_available_flag'] = slotAvailableFlag;
//     return data;
//   }
// }


class DoctorAvlAppointmentModel {
  bool? status;
  Data? data;

  DoctorAvlAppointmentModel({this.status, this.data});

  DoctorAvlAppointmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    if (data != null) {
      json['data'] = data!.toJson();
    }
    return json;
  }
}

class Data {
  List<Details>? details;
  List<Clinics>? clinics;
  OtherClinic? otherClinic;
  List<Reviews>? reviews;
  List<Slots>? slots;

  Data(
      {this.details, this.clinics, this.otherClinic, this.reviews, this.slots});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Details'] != null) {
      details = <Details>[];
      json['Details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    if (json['Clinics'] != null) {
      clinics = <Clinics>[];
      json['Clinics'].forEach((v) {
        clinics!.add(Clinics.fromJson(v));
      });
    }
    otherClinic = json['OtherClinic'] != null
        ? OtherClinic.fromJson(json['OtherClinic'])
        : null;
    if (json['Reviews'] != null) {
      reviews = <Reviews>[];
      json['Reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    if (json['Slots'] != null) {
      slots = <Slots>[];
      json['Slots'].forEach((v) {
        slots!.add(Slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['Details'] = details!.map((v) => v.toJson()).toList();
    }
    if (clinics != null) {
      data['Clinics'] = clinics!.map((v) => v.toJson()).toList();
    }
    if (otherClinic != null) {
      data['OtherClinic'] = otherClinic!.toJson();
    }
    if (reviews != null) {
      data['Reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (slots != null) {
      data['Slots'] = slots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  dynamic doctorId;
  dynamic doctorName;
  dynamic qualification;
  dynamic email;
  dynamic imageUrl;
  dynamic experience;
  dynamic smcNumber;
  dynamic averageRating;
  dynamic topRated;
  dynamic reviewCount;
  dynamic specializationId;
  dynamic specializationName;
  dynamic preferredDoctorStatus;
  dynamic signedImageUrl;

  Details(
      {this.doctorId,
      this.doctorName,
      this.qualification,
      this.email,
      this.imageUrl,
      this.experience,
      this.smcNumber,
      this.averageRating,
      this.topRated,
      this.reviewCount,
      this.specializationId,
      this.specializationName,
      this.preferredDoctorStatus,
      this.signedImageUrl,
      });

  Details.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    qualification = json['qualification'];
    email = json['email'];
    imageUrl = json['image_url'];
    experience = json['experience'];
    smcNumber = json['smc_number'];
    averageRating = json['average_rating'];
    topRated = json['top_rated'];
    reviewCount = json['review_count'];
    specializationId = json['specialization_id'];
    specializationName = json['specialization_name'];
    preferredDoctorStatus = json['preferredDoctorStatus'];
    signedImageUrl = json['signedImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['doctor_name'] = doctorName;
    data['qualification'] = qualification;
    data['email'] = email;
    data['image_url'] = imageUrl;
    data['experience'] = experience;
    data['smc_number'] = smcNumber;
    data['average_rating'] = averageRating;
    data['top_rated'] = topRated;
    data['review_count'] = reviewCount;
    data['specialization_id'] = specializationId;
    data['specialization_name'] = specializationName;
    data['preferredDoctorStatus'] = preferredDoctorStatus;
    data['signedImageUrl'] = signedImageUrl;
    return data;
  }
}

class Clinics {
  dynamic clinicId;
  dynamic doctorId;
  dynamic name;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic postalCode;
  dynamic country;
  dynamic phoneNumber;
  dynamic type;
  dynamic fee;
  dynamic landmark;
  dynamic latitude;
  dynamic longitude;
  dynamic distanceInKm;

  Clinics(
      {this.clinicId,
      this.doctorId,
      this.name,
      this.address,
      this.city,
      this.state,
      this.postalCode,
      this.country,
      this.phoneNumber,
      this.type,
      this.fee,
      this.landmark,
      this.latitude,
      this.longitude,
      this.distanceInKm});

  Clinics.fromJson(Map<String, dynamic> json) {
    clinicId = json['clinic_id'];
    doctorId = json['doctor_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postal_code'];
    country = json['country'];
    phoneNumber = json['phone_number'];
    type = json['type'];
    fee = json['fee'];
    landmark = json['landmark'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distanceInKm = json['distance_in_km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clinic_id'] = clinicId;
    data['doctor_id'] = doctorId;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['postal_code'] = postalCode;
    data['country'] = country;
    data['phone_number'] = phoneNumber;
    data['type'] = type;
    data['fee'] = fee;
    data['landmark'] = landmark;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['distance_in_km'] = distanceInKm;
    return data;
  }
}

class OtherClinic {
  int? count;
  List<OtherClinicData>? data;

  OtherClinic({this.count, this.data});

  OtherClinic.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <OtherClinicData>[];
      json['data'].forEach((v) {
        data!.add(OtherClinicData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['count'] = count;
    if (data != null) {
      json['data'] = data!.map((v) => v.toJson()).toList();
    }
    return json;
  }
}

class OtherClinicData {
  dynamic clinicId;
  dynamic doctorId;
  dynamic name;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic postalCode;
  dynamic country;
  dynamic phoneNumber;
  dynamic landmark;
  dynamic latitude;
  dynamic longitude;
  dynamic distanceInKm;

  OtherClinicData(
      {this.clinicId,
      this.doctorId,
      this.name,
      this.address,
      this.city,
      this.state,
      this.postalCode,
      this.country,
      this.phoneNumber,
      this.landmark,
      this.latitude,
      this.longitude,
      this.distanceInKm});

  OtherClinicData.fromJson(Map<String, dynamic> json) {
    clinicId = json['clinic_id'];
    doctorId = json['doctor_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postal_code'];
    country = json['country'];
    phoneNumber = json['phone_number'];
    landmark = json['landmark'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distanceInKm = json['distance_in_km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['clinic_id'] = clinicId;
    json['doctor_id'] = doctorId;
    json['name'] = name;
    json['address'] = address;
    json['city'] = city;
    json['state'] = state;
    json['postal_code'] = postalCode;
    json['country'] = country;
    json['phone_number'] = phoneNumber;
    json['landmark'] = landmark;
    json['latitude'] = latitude;
    json['longitude'] = longitude;
    json['distance_in_km'] = distanceInKm;
    return json;
  }
}

class Reviews {
  dynamic reviewId;
  dynamic rating;
  dynamic consultedFor;
  dynamic review;
  dynamic patientId;
  dynamic name;
  dynamic createdAt;

  Reviews(
      {this.reviewId,
      this.rating,
      this.consultedFor,
      this.review,
      this.patientId,
      this.name,
      this.createdAt
      });

  Reviews.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    rating = json['rating'];
    consultedFor = json['consulted_for'];
    review = json['review'];
    patientId = json['patient_id'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review_id'] = reviewId;
    data['rating'] = rating;
    data['consulted_for'] = consultedFor;
    data['review'] = review;
    data['patient_id'] = patientId;
    data['name'] = name;
    data['created_at'] = createdAt;
    return data;
  }
}

class Slots {
  dynamic doctorId;
  dynamic clinicId;
  dynamic availabilityDate;
  dynamic day;
  dynamic totalSlots;
  dynamic availableSlots;
  dynamic rbg;
  List<AvailableTime>? availableTime;

  Slots(
      {this.doctorId,
      this.clinicId,
      this.availabilityDate,
      this.day,
      this.totalSlots,
      this.availableSlots,
      this.rbg,
      this.availableTime});

  Slots.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
    availabilityDate = json['availability_date'];
    day = json['day'];
    totalSlots = json['total_slots'];
    availableSlots = json['available_slots'];
    rbg = json['rbg'];
    if (json['available_time'] != null) {
      availableTime = <AvailableTime>[];
      json['available_time'].forEach((v) {
        availableTime!.add( AvailableTime.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['clinic_id'] = clinicId;
    data['availability_date'] = availabilityDate;
    data['day'] = day;
    data['total_slots'] = totalSlots;
    data['available_slots'] = availableSlots;
    data['rbg'] = rbg;
    if (availableTime != null) {
      data['available_time'] =
          availableTime!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailableTime {
  dynamic timeId;
  dynamic slotTime;
  dynamic timeOfDay;
  dynamic slotAvailableFlag;

  AvailableTime(
      {this.timeId, this.slotTime, this.timeOfDay, this.slotAvailableFlag});

  AvailableTime.fromJson(Map<String, dynamic> json) {
    timeId = json['time_id'];
    slotTime = json['slot_time'];
    timeOfDay = json['time_of_day'];
    slotAvailableFlag = json['slot_available_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time_id'] = timeId;
    data['slot_time'] = slotTime;
    data['time_of_day'] = timeOfDay;
    data['slot_available_flag'] = slotAvailableFlag;
    return data;
  }
}
