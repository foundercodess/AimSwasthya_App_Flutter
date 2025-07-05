// utils/routes/routes.dart
import 'package:aim_swasthya/patient_section/view/notification/user_notitification_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_auth/register/register_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_auth/register/sign_up_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_doctor/book_appointment_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_doctor/doctor_profile_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_doctor/success_splash_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_drawer/appointments/view_appointment.dart';
import 'package:aim_swasthya/patient_section/view/p_drawer/profile/your_profile_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_drawer/user_delete_account.dart';
import 'package:aim_swasthya/patient_section/view/p_drawer/wellness/wellness_library_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_home/user_home_screen.dart';
import 'package:aim_swasthya/common/auth/mobile_login_screen.dart';
import 'package:aim_swasthya/common/auth/otp_screen.dart';
import 'package:aim_swasthya/common/intro/about_us_screen.dart';
import 'package:aim_swasthya/doctor_section/view/bottom_nav_bar_screen.dart';
import 'package:aim_swasthya/doctor_section/view/dashboard_page.dart';
import 'package:aim_swasthya/doctor_section/view/drawer/delete_account_screen.dart';
import 'package:aim_swasthya/doctor_section/view/drawer/notification_screen.dart';
import 'package:aim_swasthya/doctor_section/view/patients/my_appointments.dart';
import 'package:aim_swasthya/doctor_section/view/patients/show_all_patient.dart';
import 'package:aim_swasthya/doctor_section/view/payout/payout_screen.dart';
import 'package:aim_swasthya/doctor_section/view/profile/doctor_profile_screen.dart';
import 'package:aim_swasthya/doctor_section/view/patients/patient_profile_screen.dart';
import 'package:aim_swasthya/doctor_section/view/transaction/revenue_screen.dart';
import 'package:aim_swasthya/doctor_section/view/schedule/schedule_screen.dart';
import 'package:aim_swasthya/doctor_section/view/test_project.dart';
import 'package:aim_swasthya/doctor_section/view/transaction/view_all_transaction_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_bottom_nav/bottom_nev_bar.dart';
import 'package:aim_swasthya/common/intro/splace_screen.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/common/auth/login_screen.dart';
import 'package:aim_swasthya/common/intro/all_set_doc_screen.dart';
import 'package:aim_swasthya/common/intro/auth_home_screen.dart';
import 'package:aim_swasthya/common/intro/intro_screen.dart';
import 'package:aim_swasthya/doctor_section/view/auth/register_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_doctor/all_specialist_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_doctor/search_doctor_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_doctor/all_doctors_screen.dart';
import 'package:aim_swasthya/patient_section/view/swasthya_sathi/speaker.dart';
import 'package:aim_swasthya/patient_section/view/p_doctor/show_doctors_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_drawer/med_reports/medical_reports_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_drawer/my_doctors/my_doctors_screen.dart';
import 'package:aim_swasthya/patient_section/view/p_bottom_nav/secound_nav_bar.dart';
import 'package:aim_swasthya/patient_section/view/symptoms/all_symptoms_screen.dart';
import 'package:flutter/material.dart';

import '../../doctor_section/view/medical_reports/medical_reports_screen.dart';
import '../../doctor_section/view/schedule/clinic_location_screen.dart';
import '../../patient_section/view/p_drawer/med_reports/uploaded_on.dart';

class Routers {
  static WidgetBuilder generateRoute(String routeName) {
    switch (routeName) {
      // common
      case RoutesName.onBodingScreen:
        return (context) => const AuthHomeScreen();
      case RoutesName.loginScreen:
        return (context) => const LoginScreen();
      case RoutesName.splashScreen:
        return (context) => const SplashScreen();
      // use
      case RoutesName.registerScreen:
        return (context) => const RegisterScreen();
      case RoutesName.allSetDocScreen:
        return (context) => const AllSetDocScreen();
      case RoutesName.dashboardPage:
        return (context) => const DoctorDashboardScreen();
      case RoutesName.introScreen:
        return (context) => const IntroScreen();
      // doctor
      case RoutesName.userRegisterScreen:
        return (context) =>  const UserRegisterScreen();
      case RoutesName.userHomeScreen:
        return (context) =>  const UserHomeScreen(
              scaffoldKey: null, invokeAllAPi: true,
            );
      case RoutesName.allSymptomsScreen:
        return (context) => const AllSymptomsScreen();
      case RoutesName.showDoctorsScreen:
        return (context) => const ShowDoctorsScreen();
      case RoutesName.allSpecialistScreen:
        return (context) => const AllSpecialistScreen();
      case RoutesName.bottomNavBar:
        return (context) => const BottomNevBar();
      case RoutesName.doctorSpeakerScreen:
        return (context) => const DoctorSpeakerScreen();
      case RoutesName.allDoctorsScreen:
        return (context) => const AllDoctorsScreen();
      case RoutesName.searchDoctorScreen:
        return (context) => const SearchDoctorScreen();
      case RoutesName.doctorProfileScreen:
        return (context) =>  const DoctorProfileScreen();
      case RoutesName.bookAppointmentScreen:
        return (context) =>  const BookAppointmentScreen();
      case RoutesName.successSplashScreen:
        return (context) =>  const SuccessSplashScreen();
      case RoutesName.viewAppointmentsScreen:
        return (context) =>  const ViewAppointmentsScreen();
      case RoutesName.medicalReportsScreen:
        return (context) => const MedicalReportsScreen();
      case RoutesName.myDoctorsScreen:
        return (context) => const MyDoctorsScreen();
      case RoutesName.mobileLoginScreen:
        return (context) => const MobileLoginScreen();
      case RoutesName.otpScreen:
        return (context) => const OtpScreen();
      case RoutesName.signUpScreen:
        return (context) =>  const SignUpScreen();
      case RoutesName.userDeleteAccountScreen:
        return (context) =>  const UserDeleteAccountScreen();
      case RoutesName.wellnesslibraryScreen:
        return (context) =>  const WellnesslibraryScreen();
      case RoutesName.userNotificationScreen:
        return (context) =>  const UserNotificationScreen();
        case RoutesName.yourProfileScreen:
        return (context) =>  const YourProfileScreen();




      case RoutesName.scheduleScreen:
        return (context) => const ScheduleScreen();
      case RoutesName.userDocProfilePage:
        return (context) => const UserDocProfilePage();
      case RoutesName.patientProfileScreen:
        return (context) => const PatientProfileScreen();

      case RoutesName.doctorBottomNevBar:
        return (context) => const DoctorBottomNevBar();
      case RoutesName.showAllPatient:
        return (context) => const ShowAllPatient();
      case RoutesName.scheduleHoursScreen:
        return (context) => const ScheduleHoursScreen();
      case RoutesName.viewAllTransactionScreen:
        return (context) => const ViewAllTransactionScreen();
      case RoutesName.payoutScreen:
        return (context) => const PayoutScreen();
      case RoutesName.myAppointmentsScreen:
        return (context) => const MyAppointmentsScreen();
      case RoutesName.uploadedOn:
        return (context) => const UploadedOn();
      case RoutesName.aboutUsScreen:
        return (context) => const AboutUsScreen();
      case RoutesName.clinicLocationScreen:
        return (context) => const ClinicLocationScreen();
      case RoutesName.docMedicalReportsScreen:
        return (context) => const DocMedicalReportsScreen();
      case RoutesName.notificationScreen:
        return (context) => const NotificationScreen();
      case RoutesName.deleteAccountScreen:
        return (context) => const DeleteAccountScreen();

      default:
        return (context) => const Scaffold(
              body: Center(
                child: Text(
                  'No Route Found!',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            );
    }
  }
}
