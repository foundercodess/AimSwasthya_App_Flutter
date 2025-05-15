// class MedicalHealthReportModel {
//   bool? status;
//   String? message;
//   List<PatientProfile>? patientProfile;
//   List<MedicalHealth>? medicalHealth;
//
//   MedicalHealthReportModel(
//       {this.status, this.message, this.patientProfile, this.medicalHealth});
//
//   MedicalHealthReportModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['patient_profile'] != null) {
//       patientProfile = <PatientProfile>[];
//       json['patient_profile'].forEach((v) {
//         patientProfile!.add(PatientProfile.fromJson(v));
//       });
//     }
//     if (json['medical_health'] != null) {
//       medicalHealth = <MedicalHealth>[];
//       json['medical_health'].forEach((v) {
//         medicalHealth!.add(MedicalHealth.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (patientProfile != null) {
//       data['patient_profile'] =
//           patientProfile!.map((v) => v.toJson()).toList();
//     }
//     if (medicalHealth != null) {
//       data['medical_health'] =
//           medicalHealth!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class PatientProfile {
//   int? patientId;
//   String? name;
//   String? dateOfBirth;
//   String? height;
//   String? weight;
//   String? phoneNumber;
//   String? imageUrl;
//
//   PatientProfile(
//       {this.patientId,
//         this.name,
//         this.dateOfBirth,
//         this.height,
//         this.weight,
//         this.phoneNumber,
//         this.imageUrl});
//
//   PatientProfile.fromJson(Map<String, dynamic> json) {
//     patientId = json['patient_id'];
//     name = json['name'];
//     dateOfBirth = json['date_of_birth'];
//     height = json['height'];
//     weight = json['weight'];
//     phoneNumber = json['phone_number'];
//     imageUrl = json['image_url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['patient_id'] = patientId;
//     data['name'] = name;
//     data['date_of_birth'] = dateOfBirth;
//     data['height'] = height;
//     data['weight'] = weight;
//     data['phone_number'] = phoneNumber;
//     data['image_url'] = imageUrl;
//     return data;
//   }
// }
//
// class MedicalHealth {
//   String? bloodGroup;
//   String? allergies;
//   String? currentMedications;
//   String? chronicIllnesses;
//   String? lifestyleHabbits;
//
//   MedicalHealth(
//       {this.bloodGroup,
//         this.allergies,
//         this.currentMedications,
//         this.chronicIllnesses,
//         this.lifestyleHabbits});
//
//   MedicalHealth.fromJson(Map<String, dynamic> json) {
//     bloodGroup = json['blood_group'];
//     allergies = json['allergies'];
//     currentMedications = json['current_medications'];
//     chronicIllnesses = json['chronic_illnesses'];
//     lifestyleHabbits = json['lifestyle_habbits'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['blood_group'] = bloodGroup;
//     data['allergies'] = allergies;
//     data['current_medications'] = currentMedications;
//     data['chronic_illnesses'] = chronicIllnesses;
//     data['lifestyle_habbits'] = lifestyleHabbits;
//     return data;
//   }
// }
