import 'package:aim_swasthya/view/common/auth/mobile_login_screen.dart';
import 'package:aim_swasthya/view/common/auth/otp_screen.dart';
import 'package:aim_swasthya/view/common/intro/about_us_screen.dart';
import 'package:aim_swasthya/view/doctor/bottom_nav_bar_screen.dart';
import 'package:aim_swasthya/view/doctor/dashboard_page.dart';
import 'package:aim_swasthya/view/doctor/drawer/delete_account_screen.dart';
import 'package:aim_swasthya/view/doctor/drawer/notification_screen.dart';
import 'package:aim_swasthya/view/doctor/patients/my_appointments.dart';
import 'package:aim_swasthya/view/doctor/patients/show_all_patient.dart';
import 'package:aim_swasthya/view/doctor/payout/payout_screen.dart';
import 'package:aim_swasthya/view/doctor/profile/doctor_profile_screen.dart';
import 'package:aim_swasthya/view/doctor/patients/patient_profile_screen.dart';
import 'package:aim_swasthya/view/doctor/schedule/schedule_hours_screen.dart';
import 'package:aim_swasthya/view/doctor/schedule/schedule_screen.dart';
import 'package:aim_swasthya/view/doctor/test_project.dart';
import 'package:aim_swasthya/view/doctor/transaction/view_all_transaction_screen.dart';
import 'package:aim_swasthya/view/user/add_screens/wellness_library_screen.dart';
import 'package:aim_swasthya/view/user/drawer/your_profile_screen.dart';
import 'package:aim_swasthya/view/user/appointments/view_appointment.dart';
import 'package:aim_swasthya/view/user/auth/register/register_screen.dart';
import 'package:aim_swasthya/view/user/auth/register/sign_up_screen.dart';
import 'package:aim_swasthya/view/user/booking/book_appointment_screen.dart';
import 'package:aim_swasthya/view/user/booking/doctor_profile_screen.dart';
import 'package:aim_swasthya/view/user/booking/success_splash_screen.dart';
import 'package:aim_swasthya/view/user/bottom_nev_bar.dart';
import 'package:aim_swasthya/splace_screen.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view/common/auth/login_screen.dart';
import 'package:aim_swasthya/view/common/intro/all_set_doc_screen.dart';
import 'package:aim_swasthya/view/common/intro/auth_home_screen.dart';
import 'package:aim_swasthya/view/common/intro/intro_screen.dart';
import 'package:aim_swasthya/view/doctor/auth/register_screen.dart';
import 'package:aim_swasthya/view/user/doctors/all_specialist_screen.dart';
import 'package:aim_swasthya/view/user/doctors/search_doctor_screen.dart';
import 'package:aim_swasthya/view/user/doctors/show_doc/all_doctors_screen.dart';
import 'package:aim_swasthya/view/user/doctors/show_doc/speaker.dart';
import 'package:aim_swasthya/view/user/doctors/show_doctors_screen.dart';
import 'package:aim_swasthya/view/user/drawer/med_reports/medical_reports_screen.dart';
import 'package:aim_swasthya/view/user/drawer/my_doctors/my_doctors_screen.dart';
import 'package:aim_swasthya/view/user/drawer/user_delete_account.dart';
import 'package:aim_swasthya/view/user/secound_nav_bar.dart';
import 'package:aim_swasthya/view/user/symptoms/all_symptoms_screen.dart';
import 'package:aim_swasthya/view/user/user_home_screen.dart';
import 'package:flutter/material.dart';

import '../../view/doctor/medical_reports/medical_reports_screen.dart';
import '../../view/doctor/schedule/clinic_location_screen.dart';
import '../../view/user/drawer/med_reports/uploaded_on.dart';
import '../../view/user/drawer/user_notification_screen.dart';

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
        return (context) => const UserRegisterScreen();
      case RoutesName.userHomeScreen:
        return (context) => const UserHomeScreen(
              scaffoldKey: null,
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
        return (context) => const DoctorProfileScreen();
      case RoutesName.bookAppointmentScreen:
        return (context) => const BookAppointmentScreen();
      case RoutesName.successSplashScreen:
        return (context) => const SuccessSplashScreen();
      case RoutesName.viewAppointmentsScreen:
        return (context) => const ViewAppointmentsScreen();
      case RoutesName.medicalReportsScreen:
        return (context) => const MedicalReportsScreen();
      case RoutesName.myDoctorsScreen:
        return (context) => const MyDoctorsScreen();
      case RoutesName.mobileLoginScreen:
        return (context) => const MobileLoginScreen();
      case RoutesName.otpScreen:
        return (context) => const OtpScreen();
      case RoutesName.signUpScreen:
        return (context) => const SignUpScreen();
      case RoutesName.userDeleteAccountScreen:
        return (context) => const UserDeleteAccountScreen();
      case RoutesName.wellnesslibraryScreen:
        return (context) => const WellnesslibraryScreen();
      case RoutesName.userNotificationScreen:
        return (context) => const UserNotificationScreen();
        case RoutesName.yourProfileScreen:
        return (context) => const YourProfileScreen();




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
      // case RoutesName.secoundBottomNevBar:
      // return (context) => const SecoundBottomNevBar();
      case RoutesName.myAppointmentsScreen:
        return (context) => const MyAppointmentsScreen();
      case RoutesName.uploadedOn:
        return (context) => const UploadedOn();
      case RoutesName.aboutUsScreen:
        return (context) => const AboutUsScreen();
      case RoutesName.clinicLocationScreen:
        return (context) => const ClinicLocationScreen();
      case RoutesName.fullScreenMapPage:
        return (context) => FullScreenMapPage();
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
