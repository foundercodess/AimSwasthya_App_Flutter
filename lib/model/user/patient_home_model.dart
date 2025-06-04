// model/user/patient_home_model.dart
class PatientHomeModel {
  bool? status;
  Data? data;

  PatientHomeModel({this.status, this.data});

  PatientHomeModel.fromJson(Map<String, dynamic> json) {
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
  Patient? patient;
  List<Appointments>? appointments;
  List<Doctors>? doctors;
  List<SymptomsDetails>? symptomsDetails;
  List<Specializations>? specializations;
  List<Healthtips>? healthtips;
  List<FamilyMembers>? familyMembers;

  Data(
      {this.patient,
      this.appointments,
      this.doctors,
      this.symptomsDetails,
      this.specializations,
      this.healthtips,
      this.familyMembers
      });

  Data.fromJson(Map<String, dynamic> json) {
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    if (json['appointments'] != null) {
      appointments = <Appointments>[];
      json['appointments'].forEach((v) {
        appointments!.add(Appointments.fromJson(v));
      });
    }
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(Doctors.fromJson(v));
      });
    }
    if (json['symptoms_details'] != null) {
      symptomsDetails = <SymptomsDetails>[];
      json['symptoms_details'].forEach((v) {
        symptomsDetails!.add(SymptomsDetails.fromJson(v));
      });
    }
    if (json['specializations'] != null) {
      specializations = <Specializations>[];
      json['specializations'].forEach((v) {
        specializations!.add(Specializations.fromJson(v));
      });
    }
    if (json['healthtips'] != null) {
      healthtips = <Healthtips>[];
      json['healthtips'].forEach((v) {
        healthtips!.add(Healthtips.fromJson(v));
      });
    }
    if (json['family_members'] != null) {
      familyMembers = <FamilyMembers>[];
      json['family_members'].forEach((v) {
        familyMembers!.add(FamilyMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    if (appointments != null) {
      data['appointments'] = appointments!.map((v) => v.toJson()).toList();
    }
    if (doctors != null) {
      data['doctors'] = doctors!.map((v) => v.toJson()).toList();
    }
    if (symptomsDetails != null) {
      data['symptoms_details'] =
          symptomsDetails!.map((v) => v.toJson()).toList();
    }
    if (specializations != null) {
      data['specializations'] =
          specializations!.map((v) => v.toJson()).toList();
    }
    if (healthtips != null) {
      data['healthtips'] = healthtips!.map((v) => v.toJson()).toList();
    }
    if (familyMembers != null) {
      data['family_members'] =
          familyMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Patient {
  dynamic patientId;
  String? patientName;
  String? phoneNumber;
  dynamic email;
  String? height;
  String? weight;
  String? gender;
  String? latitude;
  String? longitude;

  Patient(
      {this.patientId,
      this.patientName,
      this.phoneNumber,
      this.email,
      this.height,
      this.weight,
      this.gender,
      this.latitude,
      this.longitude});

  Patient.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    height = json['height'];
    weight = json['weight'];
    gender = json['gender'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patient_id'] = patientId;
    data['patient_name'] = patientName;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['height'] = height;
    data['weight'] = weight;
    data['gender'] = gender;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Appointments {
  int? appointmentId;
  int? patientId;
  int? doctorId;
  String? doctorName;
  dynamic qualification;
  int? specializationId;
  String? specializationName;
  String? imageUrl;
  String? bookingDate;
  String? hour24Format;
  dynamic averageRating;
  String? experience;
  int? reviewCount;
  String? signedImageUrl;

  Appointments(
      {this.appointmentId,
      this.patientId,
      this.doctorId,
      this.doctorName,
      this.qualification,
      this.specializationId,
      this.specializationName,
      this.imageUrl,
      this.bookingDate,
      this.hour24Format,
      this.averageRating,
      this.experience,
      this.reviewCount,
      this.signedImageUrl});

  Appointments.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    qualification = json['qualification'];
    specializationId = json['specialization_id'];
    specializationName = json['specialization_name'];
    imageUrl = json['image_url'];
    bookingDate = json['booking_date'];
    hour24Format = json['hour_24_format'];
    averageRating = json['average_rating'];
    experience = json['experience'];
    reviewCount = json['review_count'];
    signedImageUrl = json['signedImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointment_id'] = appointmentId;
    data['patient_id'] = patientId;
    data['doctor_id'] = doctorId;
    data['doctor_name'] = doctorName;
    data['qualification'] = qualification;
    data['specialization_id'] = specializationId;
    data['specialization_name'] = specializationName;
    data['image_url'] = imageUrl;
    data['booking_date'] = bookingDate;
    data['hour_24_format'] = hour24Format;
    data['average_rating'] = averageRating;
    data['experience'] = experience;
    data['review_count'] = reviewCount;
    data['signedImageUrl'] = signedImageUrl;
    return data;
  }
}

class Doctors {
  dynamic doctorId;
  String? doctorName;
  dynamic qualification;
  String? doctorLatitude;
  String? doctorLongitude;
  String? email;
  String? imageUrl;
  String? experience;
  String? phoneNumber;
  String? gender;
  String? smcNumber;
  dynamic averageRating;
  dynamic topRated;
  String? consultationFeeType;
  String? consultationFee;
  dynamic locationId;
  String? locationName;
  String? locationLatitude;
  String? locationLongitude;
  String? distanceInKm;
  dynamic specializationId;
  String? specializationName;
  dynamic sortNumber;
  dynamic clinic_id;
  dynamic signedImageUrl;

  Doctors({
    this.doctorId,
    this.doctorName,
    this.qualification,
    this.doctorLatitude,
    this.doctorLongitude,
    this.email,
    this.imageUrl,
    this.experience,
    this.phoneNumber,
    this.gender,
    this.smcNumber,
    this.averageRating,
    this.topRated,
    this.consultationFeeType,
    this.consultationFee,
    this.locationId,
    this.locationName,
    this.locationLatitude,
    this.locationLongitude,
    this.distanceInKm,
    this.specializationId,
    this.specializationName,
    this.sortNumber,
    this.clinic_id,
    this.signedImageUrl,
  });

  Doctors.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name']??"not avl";
    qualification = json['qualification'];
    doctorLatitude = json['doctor_latitude'];
    doctorLongitude = json['doctor_longitude'];
    email = json['email'];
    imageUrl = json['image_url'];
    experience = json['experience'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    smcNumber = json['smc_number'];
    averageRating = json['average_rating'];
    topRated = json['top_rated'];
    consultationFeeType = json['consultation_fee_type'];
    consultationFee = json['consultation_fee'];
    locationId = json['location_id'];
    locationName = json['location_name'];
    locationLatitude = json['location_latitude'];
    locationLongitude = json['location_longitude'];
    distanceInKm = json['distance_in_km'];
    specializationId = json['specialization_id'];
    specializationName = json['specialization_name'];
    sortNumber = json['sort_number'];
    clinic_id = json['clinic_id'];
    signedImageUrl = json['signedImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['doctor_name'] = doctorName;
    data['qualification'] = qualification;
    data['doctor_latitude'] = doctorLatitude;
    data['doctor_longitude'] = doctorLongitude;
    data['email'] = email;
    data['image_url'] = imageUrl;
    data['experience'] = experience;
    data['phone_number'] = phoneNumber;
    data['gender'] = gender;
    data['smc_number'] = smcNumber;
    data['average_rating'] = averageRating;
    data['top_rated'] = topRated;
    data['consultation_fee_type'] = consultationFeeType;
    data['consultation_fee'] = consultationFee;
    data['location_id'] = locationId;
    data['location_name'] = locationName;
    data['location_latitude'] = locationLatitude;
    data['location_longitude'] = locationLongitude;
    data['distance_in_km'] = distanceInKm;
    data['specialization_id'] = specializationId;
    data['specialization_name'] = specializationName;
    data['sort_number'] = sortNumber;
    data['clinic_id'] = sortNumber;
    data['signedImageUrl'] = signedImageUrl;
    return data;
  }
}

class SymptomsDetails {
  dynamic symptomCategoryId;
  dynamic categoryName;
  dynamic categoryDescription;
  dynamic categorySortNumber;
  List<Symptom>? symptom;

  SymptomsDetails(
      {this.symptomCategoryId,
      this.categoryName,
      this.categoryDescription,
      this.categorySortNumber,
      this.symptom});

  SymptomsDetails.fromJson(Map<String, dynamic> json) {
    symptomCategoryId = json['symptom_category_id'];
    categoryName = json['category_name'];
    categoryDescription = json['category_description'];
    categorySortNumber = json['category_sort_number'];
    if (json['symptom'] != null) {
      symptom = <Symptom>[];
      json['symptom'].forEach((v) {
        symptom!.add(Symptom.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symptom_category_id'] = symptomCategoryId;
    data['category_name'] = categoryName;
    data['category_description'] = categoryDescription;
    data['category_sort_number'] = categorySortNumber;
    if (symptom != null) {
      data['symptom'] = symptom!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Symptom {
  dynamic symptomId;
  dynamic symptomName;
  dynamic symptomDescription;
  dynamic symptomSortNumber;

  Symptom(
      {this.symptomId,
      this.symptomName,
      this.symptomDescription,
      this.symptomSortNumber});

  Symptom.fromJson(Map<String, dynamic> json) {
    symptomId = json['symptom_id'];
    symptomName = json['symptom_name'];
    symptomDescription = json['symptom_description'];
    symptomSortNumber = json['symptom_sort_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symptom_id'] = symptomId;
    data['symptom_name'] = symptomName;
    data['symptom_description'] = symptomDescription;
    data['symptom_sort_number'] = symptomSortNumber;
    return data;
  }
}

class Specializations {
  dynamic specializationId;
  String? specializationName;
  dynamic sortNumber;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic sortNo;

  Specializations(
      {this.specializationId,
      this.specializationName,
      this.sortNumber,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.sortNo});

  Specializations.fromJson(Map<String, dynamic> json) {
    specializationId = json['specialization_id'];
    specializationName = json['specialization_name'];
    sortNumber = json['sort_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    sortNo = json['sort_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['specialization_id'] = specializationId;
    data['specialization_name'] = specializationName;
    data['sort_number'] = sortNumber;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['sort_no'] = sortNo;
    return data;
  }
}

class Healthtips {
  dynamic healthTipId;
  String? title;
  String? description;
  dynamic urlImage;
  dynamic urlArticle;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Healthtips(
      {this.healthTipId,
      this.title,
      this.description,
      this.urlImage,
      this.urlArticle,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Healthtips.fromJson(Map<String, dynamic> json) {
    healthTipId = json['health_tip_id'];
    title = json['title'];
    description = json['description'];
    urlImage = json['url_image'];
    urlArticle = json['url_article'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['health_tip_id'] = healthTipId;
    data['title'] = title;
    data['description'] = description;
    data['url_image'] = urlImage;
    data['url_article'] = urlArticle;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class FamilyMembers {
  int? familyMemberId;
  int? patientId;
  String? name;
  String? gender;
  String? email;
  String? phoneNumber;
  String? dateOfBirth;
  String? height;
  String? weight;
  String? relation;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  FamilyMembers(
      {this.familyMemberId,
      this.patientId,
      this.name,
      this.gender,
      this.email,
      this.phoneNumber,
      this.dateOfBirth,
      this.height,
      this.weight,
      this.relation,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  FamilyMembers.fromJson(Map<String, dynamic> json) {
    familyMemberId = json['family_member_id'];
    patientId = json['patient_id'];
    name = json['name'];
    gender = json['gender'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    height = json['height'];
    weight = json['weight'];
    relation = json['relation'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['family_member_id'] = familyMemberId;
    data['patient_id'] = patientId;
    data['name'] = name;
    data['gender'] = gender;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['height'] = height;
    data['weight'] = weight;
    data['relation'] = relation;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
