// res/api_urls.dart
class PatientApiUrl {
  static const String devUrl = 'http://3.7.71.4:3000/';
  static const String prodUrl = '3.7.71.4:3000/';
  static const String baseUrl = devUrl;
  static const String sendOtp = "${baseUrl}sendOTP";
  static const String verifyOtp = "${baseUrl}verifyOTP";
  static const String patientRegister = "${baseUrl}registerPatient";
  static const String getLocation = "${baseUrl}getLocation";
  static const String patientHome = "${baseUrl}getPatientHome";
  static const String isRegistered = "${baseUrl}isRegistered";
  static const String doctorDetailByLocation =
      "${baseUrl}getDoctorDetailsBylocation";
  static const String doctorDetailBySpecialization =
      "${baseUrl}getDoctorDetailsBySpecialisation";
  static const String getMedicalRecordsPatients = "${baseUrl}listMedicalRecord";
  // static const String getMedicalRecordsPatients = "${baseUrl}getMedicalRecordsPatients";
  static const String patientPreferredDoctor =
      "${baseUrl}getPatientPreferredDoctor";
  static const String patientAppointments = "${baseUrl}getPatientAppointments";
  static const String doctorAppointments =
      "${baseUrl}getDoctorAvailableAppointment";
  static const String getImageUrl = "${baseUrl}getS3SignedUrl";
  static const String addReviewUrl = "${baseUrl}addReview";
  static const String boolAppointmentUrl =
      "${baseUrl}bookAppointmentandPayment";
  static const String addPatientDoctorUrl =
      "${baseUrl}addPatientPreferredDoctor";
  static const String getAiDoctorSuggestion = "${baseUrl}getDoctorSuggestion";
  static const String cancelAppointment = "${baseUrl}updateAppointmentStatus";
  static const String updateAppointmentDetails =
      "${baseUrl}updateAppointmentDetails";
  static const String tcApiUrl = "https://uat.max11.org/api/get/settings/";
}

class DoctorApiUrl {
  static const String devUrl = 'http://3.7.71.4:3000/';
  static const String prodUrl = '3.7.71.4:3000/';
  static const String baseUrl = devUrl;
  static const String sendDoctorOtp = "${baseUrl}sendOTPDoctor";
  static const String isDoctorRegister = "${baseUrl}isRegisteredDoctor";
  static const String verifyOTPDoctor = "${baseUrl}verifyOTPDoctor";
  static const String registerDoctor = "${baseUrl}registerDoctor";
  static const String getProfileDoctor = "${baseUrl}getProfileDoctor";
  static const String updateProfileDoctor = "${baseUrl}updateDoctorProfile";
  static const String getHomeDoctor = "${baseUrl}getHomeDoctor";
  static const String getPatientAppointmentDoctor =
      "${baseUrl}getPatientAppointmentDoctor";
  static const String addClinicDoctor = "${baseUrl}addClinicDoctor";
  static const String getPatientProfileDoctor =
      "${baseUrl}getPatientProfileDoctor";
  static const String medicalHealthReportDoctor =
      "${baseUrl}getMedicalHealthReportDoctor";
  static const String revenueDoctor = "${baseUrl}getRevenueDoctor";
  static const String scheduleDoctor = "${baseUrl}getScheduleDoctor";
  static const String upsertScheduleDoctor = "${baseUrl}upsertScheduleDoctor";
  static const String upsertScheduleSlotTypeDoctor =
      "${baseUrl}upsertScheduleSlotTypeDoctor";
  static const String getAllSpecializationsDoctor =
      "${baseUrl}getAllSpecializationsDoctor";
  static const String upsertSmcNumberDoctor = "${baseUrl}upsertSmcNumberDoctor";
}
class CommonApiUrl{
  static const String devUrl = 'http://3.7.71.4:3000/';
  static const String prodUrl = '3.7.71.4:3000/';
  static const String baseUrl = devUrl;
  static const String addImage = "${baseUrl}addImage";
}
