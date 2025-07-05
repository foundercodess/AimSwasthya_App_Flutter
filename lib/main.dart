// main.dart
import 'package:aim_swasthya/res/size_const.dart';
import 'package:aim_swasthya/patient_section/view/symptoms/dowenloade_image.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/add_clinic_doctor_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/all_specialization_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/delete_account_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/doc_auth_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/doc_health_report_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/doc_home_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/doc_map_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/doc_update_appointment_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/doctor_profile_view_model.dart'
    show DoctorProfileViewModel;
import 'package:aim_swasthya/doctor_section/d_view_model/language_change_view_model.dart';
import 'package:aim_swasthya/common/view_model/notification_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/patient_profile_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/revenue_doctor_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/schedule_doctor_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/upser_smc_number_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/add_review_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/auth_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/bottom_nav_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/cancelAppointment_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/doctor_avl_appointment_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/doctor_details_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/doctor_specialisation_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/get_image_url_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_appointment_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_home_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_medical_records_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_pref_doc_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_profile_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/services/payment_con.dart';
import 'package:aim_swasthya/patient_section/p_view_model/slot_schedule_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/tc_pp_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/update_appointment_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/upsert_family_member_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_role_view_model.dart';
import 'package:aim_swasthya/utils/routes/routes.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_delete_account_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/voice_search_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:aim_swasthya/l10n/app_localizations.dart';
import 'package:aim_swasthya/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'doctor_section/d_view_model/doc_reg_view_model.dart';
import 'doctor_section/d_view_model/doc_schedule_view_model.dart';
import 'patient_section/p_view_model/wellness_library_view_model.dart';

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
        ChangeNotifierProvider(create: (ctx) => UserRoleViewModel()),
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
        ChangeNotifierProvider(create: (ctx) => VoiceSymptomSearchViewModel()),
        ChangeNotifierProvider(create: (ctx) => UpdateAppointmentViewModel()),
        ChangeNotifierProvider(create: (ctx) => CancelAppointmentViewModel()),
        ChangeNotifierProvider(create: (ctx) => UserDeleteAccountViewModel()),
        ChangeNotifierProvider(create: (ctx) => UserPatientProfileViewModel()),
        ChangeNotifierProvider(create: (ctx) => UpsertFamilyMemberViewModel()),
        ChangeNotifierProvider(create: (ctx) => WellnessLibraryViewModel()),

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
        ChangeNotifierProvider(create: (ctx) => DeleteAccountViewModel()),
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


class MicWaveAnimation extends StatefulWidget {
  final bool isListening;
  const MicWaveAnimation({super.key, required this.isListening});

  @override
  State<MicWaveAnimation> createState() => _MicWaveAnimationState();
}

class _MicWaveAnimationState extends State<MicWaveAnimation> with TickerProviderStateMixin {
  static const int waveCount = 3;
  static const List<Color> waveColors = [
    Color(0xFF7B2FF2), // Purple
    Color(0xFF1A8FE3), // Blue
    Color(0xFF7B2FF2), // Purple
  ];

  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      waveCount,
          (i) => AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      ),
    );
    _animations = _controllers
        .map((controller) => Tween<double>(begin: 0.7, end: 1.6).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    ))
        .toList();

    if (widget.isListening) {
      _startAnimations();
    }
  }

  @override
  void didUpdateWidget(MicWaveAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isListening && !oldWidget.isListening) {
      _startAnimations();
    } else if (!widget.isListening && oldWidget.isListening) {
      _stopAnimations();
    }
  }

  void _startAnimations() {
    for (int i = 0; i < waveCount; i++) {
      Future.delayed(Duration(milliseconds: i * 400), () {
        if (mounted && widget.isListening) {
          _controllers[i]
            ..reset()
            ..repeat();
        }
      });
    }
  }

  void _stopAnimations() {
    for (final controller in _controllers) {
      controller.stop();
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated waves
          for (int i = 0; i < waveCount; i++)
            AnimatedBuilder(
              animation: _animations[i],
              builder: (context, child) {
                final scale = _animations[i].value;
                final opacity = 1.0 - (scale - 0.7) / (1.6 - 0.7);
                return Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity.clamp(0.0, 1.0),
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: waveColors[i].withOpacity(0.3),
                      ),
                    ),
                  ),
                );
              },
            ),
          // Mic icon
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.15),
            ),
            child: Center(
              child: Icon(Icons.mic, size: 48, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}