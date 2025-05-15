// main.dart
import 'package:aim_swasthya/res/size_const.dart';
import 'package:aim_swasthya/view/animation_con.dart';
import 'package:aim_swasthya/view/user/symptoms/dowenloade_image.dart';
import 'package:aim_swasthya/view/user/user_home_screen.dart';
import 'package:aim_swasthya/view_model/doctor/add_clinic_doctor_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/all_specialization_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_auth_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_graph_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_health_report_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_home_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_map_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_update_appointment_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doctor_profile_view_model.dart'
    show DoctorProfileViewModel;
import 'package:aim_swasthya/view_model/doctor/language_change_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/notification_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/patient_profile_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/revenue_doctor_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/schedule_doctor_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/upser_smc_number_view_model.dart';
import 'package:aim_swasthya/view_model/user/add_doctor_view_model.dart';
import 'package:aim_swasthya/view_model/user/add_review_view_model.dart';
import 'package:aim_swasthya/view_model/user/auth_view_model.dart';
import 'package:aim_swasthya/view_model/user/bottom_nav_view_model.dart';
import 'package:aim_swasthya/view_model/user/cancelAppointment_view_model.dart';
import 'package:aim_swasthya/view_model/user/doctor_avl_appointment_view_model.dart';
import 'package:aim_swasthya/view_model/user/doctor_details_view_model.dart';
import 'package:aim_swasthya/view_model/user/doctor_specialisation_view_model.dart';
import 'package:aim_swasthya/view_model/user/get_image_url_view_model.dart';
import 'package:aim_swasthya/view_model/user/patient_appointment_view_model.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:aim_swasthya/view_model/user/patient_medical_records_view_model.dart';
import 'package:aim_swasthya/view_model/user/patient_pref_doc_view_model.dart';
import 'package:aim_swasthya/view_model/user/services/payment_con.dart';
import 'package:aim_swasthya/view_model/user/slot_schedule_view_model.dart';
import 'package:aim_swasthya/view_model/user/tc_pp_view_model.dart';
import 'package:aim_swasthya/view_model/user/update_appointment_view_model.dart';
import 'package:aim_swasthya/view_model/user/userRegisterCon.dart';
import 'package:aim_swasthya/utils/routes/routes.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:aim_swasthya/view_model/user/voice_search_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'view_model/doctor/doc_reg_view_model.dart';
import 'view_model/doctor/doc_schedule_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalImageHelper.instance.loadImages();
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languageCode = sp.getString('language_code') ?? "";
  runApp(MyApp(
    locale: languageCode,
  ));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final String locale;
  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    Sizes.init(context);
    return MultiProvider(
      providers: [
        //patient view models
        ChangeNotifierProvider(create: (ctx) => RegisterViewModel()),
        ChangeNotifierProvider(create: (ctx) => ScheduleViewModel()),
        ChangeNotifierProvider(create: (ctx) => UserRegisterViewModel()),
        // ChangeNotifierProvider(create: (ctx) => DocGraphViewModel()),
        ChangeNotifierProvider(create: (ctx) => ChangeLanguageViewModel()),
        ChangeNotifierProvider(create: (ctx) => BottomNavProvider()),
        ChangeNotifierProvider(create: (ctx) => PatientAuthViewModel()),
        ChangeNotifierProvider(create: (ctx) => PatientHomeViewModel()),
        ChangeNotifierProvider(create: (ctx) => DoctorDetailsViewModel()),
        ChangeNotifierProvider(
            create: (ctx) => DoctorSpecialisationViewModel()),
        ChangeNotifierProvider(
            create: (ctx) => PatientMedicalRecordsViewModel()),
        ChangeNotifierProvider(create: (ctx) => PatientPrefDocViewModel()),
        ChangeNotifierProvider(create: (ctx) => PatientAppointmentViewModel()),
        ChangeNotifierProvider(
            create: (ctx) => DoctorAvlAppointmentViewModel()),
        ChangeNotifierProvider(create: (ctx) => PaymentViewModel()),
        ChangeNotifierProvider(create: (ctx) => AddReviewViewModel()),
        ChangeNotifierProvider(create: (ctx) => GetImageUrlViewModel()),
        ChangeNotifierProvider(create: (ctx) => AddDoctorViewModel()),
        ChangeNotifierProvider(create: (ctx) => VoiceSymptomSearchViewModel()),
        ChangeNotifierProvider(create: (ctx) => UpdateAppointmentViewModel()),
        ChangeNotifierProvider(create: (ctx) => CancelAppointmentViewModel()),

        // doctor view models
        ChangeNotifierProvider(create: (ctx) => DoctorAuthViewModel()),
        ChangeNotifierProvider(create: (ctx) => DoctorProfileViewModel()),
        ChangeNotifierProvider(create: (ctx) => DoctorHomeViewModel()),
        ChangeNotifierProvider(
            create: (ctx) => DocPatientAppointmentViewModel()),
        ChangeNotifierProvider(create: (ctx) => AddClinicDoctorViewModel()),
        ChangeNotifierProvider(create: (ctx) => PatientProfileViewModel()),
        ChangeNotifierProvider(create: (ctx) => RevenueDoctorViewModel()),
        ChangeNotifierProvider(create: (ctx) => DocHealthReportViewModel()),
        ChangeNotifierProvider(create: (ctx) => ScheduleDoctorViewModel()),
        ChangeNotifierProvider(create: (ctx) => TCPPViewModel()),
        ChangeNotifierProvider(create: (ctx) => SlotScheduleViewModel()),
        ChangeNotifierProvider(create: (ctx) => MapViewModel()),
        ChangeNotifierProvider(create: (ctx) => AllSpecializationViewModel()),
        ChangeNotifierProvider(create: (ctx) => UpsertSmcNumberViewModel()),
        ChangeNotifierProvider(create: (ctx) => NotificationViewModel()),
      ],
      child: Consumer<ChangeLanguageViewModel>(
          builder: (context, provider, child) {
        if (locale.isEmpty) {
          provider.changeLanguage(const Locale("en"));
        }
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'AIM Swasthya',
          locale: locale == ""
              ? const Locale("en")
              : provider.appLocal ?? const Locale("en"),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: const [
            Locale("en"),
            // Locale("es"),
          ],
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
          ),
          initialRoute: RoutesName.splashScreen,
          onGenerateRoute: (settings) {
            if (settings.name != null) {
              return CupertinoPageRoute(
                builder: Routers.generateRoute(settings.name!),
                settings: settings,
              );
            }
            return null;
          },
          // home: UploadFileToS3(),
        );
      }),
    );
  }
}
