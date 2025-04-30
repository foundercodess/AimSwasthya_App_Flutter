class DoctorAvlAppointmentModel {
  bool? status;
  Data? data;
  String? message;

  DoctorAvlAppointmentModel({this.status, this.data,this.message});

  DoctorAvlAppointmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message=json['message']??'';
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
  List<Details>? details;
  List<Reviews>? reviews;
  List<Location>? location;
  List<Slots>? slots;

  Data({this.details, this.reviews, this.location, this.slots});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Details'] != null) {
      details = <Details>[];
      json['Details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    if (json['Reviews'] != null || json['Reviews'] !=[]) {
      reviews = <Reviews>[];
      json['Reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }if(json['Reviews'] ==[]){
      reviews = <Reviews>[];
    }
    if (json['Location'] != null) {
      location = <Location>[];
      json['Location'].forEach((v) {
        location!.add(Location.fromJson(v));
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
    if (reviews != null) {
      data['Reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (location != null) {
      data['Location'] = location!.map((v) => v.toJson()).toList();
    }
    if (slots != null) {
      data['Slots'] = slots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? doctorId;
  String? doctorName;
  dynamic qualification;
  String? email;
  String? imageUrl;
  String? experience;
  String? phoneNumber;
  String? smcNumber;
  dynamic averageRating;
  dynamic topRated;
  int? reviewCount;
  int? specializationId;
  String? specializationName;
  dynamic signedImageUrl;
  dynamic preferredDoctorStatus;

  Details(
      {this.doctorId,
        this.doctorName,
        this.qualification,
        this.email,
        this.imageUrl,
        this.experience,
        this.phoneNumber,
        this.smcNumber,
        this.averageRating,
        this.topRated,
        this.reviewCount,
        this.specializationId,
        this.specializationName,
        this.signedImageUrl,
        this.preferredDoctorStatus
      });

  Details.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    qualification = json['qualification'];
    email = json['email'];
    imageUrl = json['image_url'];
    experience = json['experience'];
    phoneNumber = json['phone_number'];
    smcNumber = json['smc_number'];
    averageRating = json['average_rating'];
    topRated = json['top_rated'];
    reviewCount = json['review_count'];
    specializationId = json['specialization_id'];
    specializationName = json['specialization_name'];
    signedImageUrl = json['signedImageUrl'];
    preferredDoctorStatus = json['preferredDoctorStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['doctor_name'] = doctorName;
    data['qualification'] = qualification;
    data['email'] = email;
    data['image_url'] = imageUrl;
    data['experience'] = experience;
    data['phone_number'] = phoneNumber;
    data['smc_number'] = smcNumber;
    data['average_rating'] = averageRating;
    data['top_rated'] = topRated;
    data['review_count'] = reviewCount;
    data['specialization_id'] = specializationId;
    data['specialization_name'] = specializationName;
    data['signedImageUrl'] = signedImageUrl;
    data['preferredDoctorStatus'] = preferredDoctorStatus;
    return data;
  }
}

class Reviews {
  int? reviewId;
  int? rating;
  String? consultedFor;
  String? review;
  int? patientId;
  String? name;

  Reviews(
      {this.reviewId,
        this.rating,
        this.consultedFor,
        this.review,
        this.patientId,
        this.name});

  Reviews.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    rating = json['rating'];
    consultedFor = json['consulted_for'];
    review = json['review'];
    patientId = json['patient_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review_id'] = reviewId;
    data['rating'] = rating;
    data['consulted_for'] = consultedFor;
    data['review'] = review;
    data['patient_id'] = patientId;
    data['name'] = name;
    return data;
  }
}

class Location {
  int? doctorId;
  int? clinicId;
  String? consultationFeeType;
  String? consultationFee;
  int? fee;
  String? digiswasthyaDiscount;
  String? address;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? phoneNumber;
  String? latitude;
  String? longitude;
  String? distanceInKm;
  String? startTime;
  String? endTime;

  Location(
      {this.doctorId,
      this.clinicId,
        this.consultationFeeType,
        this.consultationFee,
        this.fee,
        this.digiswasthyaDiscount,
        this.address,
        this.city,
        this.state,
        this.postalCode,
        this.country,
        this.phoneNumber,
        this.latitude,
        this.longitude,
        this.distanceInKm, this.startTime,this.endTime});

  Location.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
    consultationFeeType = json['consultation_fee_type'];
    consultationFee = json['consultation_fee'];
    fee = json['fee'];
    digiswasthyaDiscount = json['digiswasthya_discount'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postal_code'];
    country = json['country'];
    phoneNumber = json['phone_number'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distanceInKm = json['distance_in_km'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['clinic_id'] = clinicId;
    data['consultation_fee_type'] = consultationFeeType;
    data['consultation_fee'] = consultationFee;
    data['fee'] = fee;
    data['digiswasthya_discount'] = digiswasthyaDiscount;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['postal_code'] = postalCode;
    data['country'] = country;
    data['phone_number'] = phoneNumber;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['distance_in_km'] = distanceInKm;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}

class Slots {
  int? doctorId;
  int? clinicId;
  String? availabilityDate;
  String? day;
  List<AvailableTime>? availableTime;

  Slots(
      {this.doctorId,
        this.clinicId,
        this.availabilityDate,
        this.day,
        this.availableTime});

  Slots.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
    availabilityDate = json['availability_date'];
    day = json['day'];
    if (json['available_time'] != null) {
      availableTime = <AvailableTime>[];
      json['available_time'].forEach((v) {
        availableTime!.add(AvailableTime.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['clinic_id'] = clinicId;
    data['availability_date'] = availabilityDate;
    data['day'] = day;
    if (availableTime != null) {
      data['available_time'] =
          availableTime!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailableTime {
  int? timeId;
  String? slotTime;
  String? timeOfDay;
  String? slotAvailableFlag;

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
