import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @started.
  ///
  /// In en, this message translates to:
  /// **'Get started!'**
  String get started;

  /// No description provided for @are_doctor.
  ///
  /// In en, this message translates to:
  /// **'Are you a doctor?'**
  String get are_doctor;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Are you looking\nfor a doctor?'**
  String get doctor;

  /// No description provided for @chooselanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooselanguage;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @an_account.
  ///
  /// In en, this message translates to:
  /// **'Do you already have an account?'**
  String get an_account;

  /// No description provided for @super_quick.
  ///
  /// In en, this message translates to:
  /// **'Else, sign up super quick!'**
  String get super_quick;

  /// No description provided for @super_register.
  ///
  /// In en, this message translates to:
  /// **'Else, register super quick!'**
  String get super_register;

  /// No description provided for @your_account.
  ///
  /// In en, this message translates to:
  /// **'Log into your account'**
  String get your_account;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @log_in.
  ///
  /// In en, this message translates to:
  /// **'By logging in, you accept the '**
  String get log_in;

  /// No description provided for @hello_introduction.
  ///
  /// In en, this message translates to:
  /// **'Hello! Let’s start by introducing yourself'**
  String get hello_introduction;

  /// No description provided for @tell_name.
  ///
  /// In en, this message translates to:
  /// **'Tell us your name'**
  String get tell_name;

  /// No description provided for @enter_full_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enter_full_name;

  /// No description provided for @step_1.
  ///
  /// In en, this message translates to:
  /// **'Step 1'**
  String get step_1;

  /// No description provided for @hi_prashant.
  ///
  /// In en, this message translates to:
  /// **'Hi, '**
  String get hi_prashant;

  /// No description provided for @gender_identify.
  ///
  /// In en, this message translates to:
  /// **'Which gender do you identify with?'**
  String get gender_identify;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @step_2.
  ///
  /// In en, this message translates to:
  /// **'Step 2'**
  String get step_2;

  /// No description provided for @great.
  ///
  /// In en, this message translates to:
  /// **'Great!'**
  String get great;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'When is your birthday?'**
  String get birthday;

  /// No description provided for @step_3.
  ///
  /// In en, this message translates to:
  /// **'Step 3'**
  String get step_3;

  /// No description provided for @awesome.
  ///
  /// In en, this message translates to:
  /// **'Awesome!'**
  String get awesome;

  /// No description provided for @height_weight.
  ///
  /// In en, this message translates to:
  /// **'What’s your height and weight?'**
  String get height_weight;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @cm.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get cm;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @kg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get kg;

  /// No description provided for @all_set.
  ///
  /// In en, this message translates to:
  /// **'All set!'**
  String get all_set;

  /// No description provided for @lets_aimswasthya.
  ///
  /// In en, this message translates to:
  /// **'Let’s AIMSwasthya!'**
  String get lets_aimswasthya;

  /// No description provided for @get_started_mobile.
  ///
  /// In en, this message translates to:
  /// **'Get started! Enter your mobile number'**
  String get get_started_mobile;

  /// No description provided for @or_log_in_using.
  ///
  /// In en, this message translates to:
  /// **'Or log in using'**
  String get or_log_in_using;

  /// No description provided for @or_signUp_using.
  ///
  /// In en, this message translates to:
  /// **'Or sign up using'**
  String get or_signUp_using;

  /// No description provided for @by_signing_up.
  ///
  /// In en, this message translates to:
  /// **'By signing up, you accept the '**
  String get by_signing_up;

  /// No description provided for @terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get terms_and_conditions;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get and;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy '**
  String get privacy_policy;

  /// No description provided for @enter_otp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enter_otp;

  /// No description provided for @please_enter_otp_code.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 4 digit code we sent to'**
  String get please_enter_otp_code;

  /// No description provided for @otp_digit_error.
  ///
  /// In en, this message translates to:
  /// **'OTP must be 4 digits'**
  String get otp_digit_error;

  /// No description provided for @did_not_receive_otp.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive the OTP? '**
  String get did_not_receive_otp;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @upcoming_appointment.
  ///
  /// In en, this message translates to:
  /// **'Upcoming appointments'**
  String get upcoming_appointment;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'7 June'**
  String get june;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'100% Reviews'**
  String get reviews;

  /// No description provided for @dr_vikram_batra.
  ///
  /// In en, this message translates to:
  /// **'Dr. Vikram Batra'**
  String get dr_vikram_batra;

  /// No description provided for @mbbs_md_cardiology.
  ///
  /// In en, this message translates to:
  /// **'MBBS, MD (Cardiology)'**
  String get mbbs_md_cardiology;

  /// No description provided for @years_experience.
  ///
  /// In en, this message translates to:
  /// **' years experience'**
  String get years_experience;

  /// No description provided for @reschedule.
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get reschedule;

  /// No description provided for @choose_symptoms.
  ///
  /// In en, this message translates to:
  /// **'Choose your symptoms'**
  String get choose_symptoms;

  /// No description provided for @choose_specialisation.
  ///
  /// In en, this message translates to:
  /// **'Choose a specialisation'**
  String get choose_specialisation;

  /// No description provided for @view_more.
  ///
  /// In en, this message translates to:
  /// **'View more'**
  String get view_more;

  /// No description provided for @top_specialist_near_you.
  ///
  /// In en, this message translates to:
  /// **'Top specialists near you'**
  String get top_specialist_near_you;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get view_all;

  /// No description provided for @keeping_you_healthy.
  ///
  /// In en, this message translates to:
  /// **'Keeping you healthy'**
  String get keeping_you_healthy;

  /// No description provided for @specialist.
  ///
  /// In en, this message translates to:
  /// **'Specialist'**
  String get specialist;

  /// No description provided for @specialties.
  ///
  /// In en, this message translates to:
  /// **'Specialties'**
  String get specialties;

  /// No description provided for @top_specialists.
  ///
  /// In en, this message translates to:
  /// **'Top specialists'**
  String get top_specialists;

  /// No description provided for @near_you.
  ///
  /// In en, this message translates to:
  /// **'Near you'**
  String get near_you;

  /// No description provided for @symptoms.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get symptoms;

  /// No description provided for @choose_your_symptoms.
  ///
  /// In en, this message translates to:
  /// **'Choose your symptoms'**
  String get choose_your_symptoms;

  /// No description provided for @did_find_your_symptoms.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t find your symptoms? Add your symptoms below'**
  String get did_find_your_symptoms;

  /// No description provided for @add_symptoms.
  ///
  /// In en, this message translates to:
  /// **'Add symptoms'**
  String get add_symptoms;

  /// No description provided for @continue_con.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_con;

  /// No description provided for @patient_reviews.
  ///
  /// In en, this message translates to:
  /// **'Patient location'**
  String get patient_reviews;

  /// No description provided for @clinic_details.
  ///
  /// In en, this message translates to:
  /// **'Clinic details'**
  String get clinic_details;

  /// No description provided for @available_slots.
  ///
  /// In en, this message translates to:
  /// **'Available slots'**
  String get available_slots;

  /// No description provided for @select_time.
  ///
  /// In en, this message translates to:
  /// **'Select time'**
  String get select_time;

  /// No description provided for @morning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get morning;

  /// No description provided for @afternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get afternoon;

  /// No description provided for @evening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get evening;

  /// No description provided for @book_your_appointment.
  ///
  /// In en, this message translates to:
  /// **'Book your appointment'**
  String get book_your_appointment;

  /// No description provided for @are_you_sure_you.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to'**
  String get are_you_sure_you;

  /// No description provided for @reschedule_your_appointment.
  ///
  /// In en, this message translates to:
  /// **'reschedule your appointment?'**
  String get reschedule_your_appointment;

  /// No description provided for @new_appointment_details.
  ///
  /// In en, this message translates to:
  /// **'New appointment details'**
  String get new_appointment_details;

  /// No description provided for @confirm_your_appointment.
  ///
  /// In en, this message translates to:
  /// **'Confirm your appointment'**
  String get confirm_your_appointment;

  /// No description provided for @go_back.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get go_back;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @appointment_details.
  ///
  /// In en, this message translates to:
  /// **'Appointment details :'**
  String get appointment_details;

  /// No description provided for @clinic_location.
  ///
  /// In en, this message translates to:
  /// **'Clinic location :'**
  String get clinic_location;

  /// No description provided for @choose_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Choose payment method'**
  String get choose_payment_method;

  /// No description provided for @added_debit_credit_Cards.
  ///
  /// In en, this message translates to:
  /// **'Added Debit/Credit Cards'**
  String get added_debit_credit_Cards;

  /// No description provided for @other_methods.
  ///
  /// In en, this message translates to:
  /// **'Other Methods'**
  String get other_methods;

  /// No description provided for @get_digiSwasthya_card.
  ///
  /// In en, this message translates to:
  /// **'Get DigiSwasthya card and avail FLAT 30% on all your appointments'**
  String get get_digiSwasthya_card;

  /// No description provided for @total_amount.
  ///
  /// In en, this message translates to:
  /// **'Total amount'**
  String get total_amount;

  /// No description provided for @payment_details.
  ///
  /// In en, this message translates to:
  /// **'Payment details'**
  String get payment_details;

  /// No description provided for @appointment_fee.
  ///
  /// In en, this message translates to:
  /// **'Appointment fee'**
  String get appointment_fee;

  /// No description provided for @digiSwasthya_discount.
  ///
  /// In en, this message translates to:
  /// **'DigiSwasthya discount'**
  String get digiSwasthya_discount;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @amount_payable.
  ///
  /// In en, this message translates to:
  /// **'Amount payable'**
  String get amount_payable;

  /// No description provided for @pay_using_digiSwasthya_card.
  ///
  /// In en, this message translates to:
  /// **'Pay using DigiSwasthya Card'**
  String get pay_using_digiSwasthya_card;

  /// No description provided for @book_an_appointment.
  ///
  /// In en, this message translates to:
  /// **'Book an appointment'**
  String get book_an_appointment;

  /// No description provided for @thank_you.
  ///
  /// In en, this message translates to:
  /// **'Thank you!'**
  String get thank_you;

  /// No description provided for @appointment_has_been_booked.
  ///
  /// In en, this message translates to:
  /// **'Your appointment has been booked.'**
  String get appointment_has_been_booked;

  /// No description provided for @wishing_you_healthy.
  ///
  /// In en, this message translates to:
  /// **'Wishing you healthy and speedy diagnosis'**
  String get wishing_you_healthy;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @what_symptoms_are_you.
  ///
  /// In en, this message translates to:
  /// **'What symptoms are you experiencing?'**
  String get what_symptoms_are_you;

  /// No description provided for @try_one_by_one_such_as.
  ///
  /// In en, this message translates to:
  /// **'Try speaking your symptoms one by one, such as'**
  String get try_one_by_one_such_as;

  /// No description provided for @based_on_your_symptoms.
  ///
  /// In en, this message translates to:
  /// **'Based on your symptoms, here are some'**
  String get based_on_your_symptoms;

  /// No description provided for @top_rated_specialists_for_you.
  ///
  /// In en, this message translates to:
  /// **'top rated specialists for you!'**
  String get top_rated_specialists_for_you;

  /// No description provided for @you_can_choose_a_specialist.
  ///
  /// In en, this message translates to:
  /// **'Or else, you can choose a specialist'**
  String get you_can_choose_a_specialist;

  /// No description provided for @select_a_specialists.
  ///
  /// In en, this message translates to:
  /// **'Select a specialists'**
  String get select_a_specialists;

  /// No description provided for @medical_records.
  ///
  /// In en, this message translates to:
  /// **'Medical Records'**
  String get medical_records;

  /// No description provided for @uploaded_medical_records.
  ///
  /// In en, this message translates to:
  /// **'Uploaded medical records'**
  String get uploaded_medical_records;

  /// No description provided for @upload_your_medical_records.
  ///
  /// In en, this message translates to:
  /// **'Upload your medical records'**
  String get upload_your_medical_records;

  /// No description provided for @my_doctors.
  ///
  /// In en, this message translates to:
  /// **'My Doctors'**
  String get my_doctors;

  /// No description provided for @your_health_is_our_priority.
  ///
  /// In en, this message translates to:
  /// **'Your health is our priority, your trust is our foundation!'**
  String get your_health_is_our_priority;

  /// No description provided for @about_Us.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get about_Us;

  /// No description provided for @log_Out.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get log_Out;

  /// No description provided for @personal_information.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get personal_information;

  /// No description provided for @please_provide_your_details.
  ///
  /// In en, this message translates to:
  /// **'Please provide your details to\ncreate your account'**
  String get please_provide_your_details;

  /// No description provided for @identity_verification.
  ///
  /// In en, this message translates to:
  /// **'Identity verification'**
  String get identity_verification;

  /// No description provided for @identity_proof.
  ///
  /// In en, this message translates to:
  /// **'Identity proof'**
  String get identity_proof;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @profile_photo.
  ///
  /// In en, this message translates to:
  /// **'Profile photo'**
  String get profile_photo;

  /// No description provided for @add_a_profile_photo_for.
  ///
  /// In en, this message translates to:
  /// **'Add a profile photo for your profile'**
  String get add_a_profile_photo_for;

  /// No description provided for @dash_board.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dash_board;

  /// No description provided for @your_earnings.
  ///
  /// In en, this message translates to:
  /// **'Your earnings'**
  String get your_earnings;

  /// No description provided for @welcome_Vikram.
  ///
  /// In en, this message translates to:
  /// **'Welcome, Dr. Vikram!'**
  String get welcome_Vikram;

  /// No description provided for @net_revenue.
  ///
  /// In en, this message translates to:
  /// **'Net revenue :'**
  String get net_revenue;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @today_appointments.
  ///
  /// In en, this message translates to:
  /// **'Today’s appointments'**
  String get today_appointments;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @edit_personal_information.
  ///
  /// In en, this message translates to:
  /// **'Edit personal information'**
  String get edit_personal_information;

  /// No description provided for @and_clinic_details.
  ///
  /// In en, this message translates to:
  /// **'and clinic details'**
  String get and_clinic_details;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @manage_your_appointments.
  ///
  /// In en, this message translates to:
  /// **'Manage your appointments'**
  String get manage_your_appointments;

  /// No description provided for @and_schedule.
  ///
  /// In en, this message translates to:
  /// **'and schedule'**
  String get and_schedule;

  /// No description provided for @manage_your_schedule.
  ///
  /// In en, this message translates to:
  /// **'Manage your schedule'**
  String get manage_your_schedule;

  /// No description provided for @select_maximum_days.
  ///
  /// In en, this message translates to:
  /// **'Select maximum of 7 days'**
  String get select_maximum_days;

  /// No description provided for @appointment_duration.
  ///
  /// In en, this message translates to:
  /// **'Appointment duration'**
  String get appointment_duration;

  /// No description provided for @data_range.
  ///
  /// In en, this message translates to:
  /// **'Date range'**
  String get data_range;

  /// No description provided for @within_a_range.
  ///
  /// In en, this message translates to:
  /// **'Within a range'**
  String get within_a_range;

  /// No description provided for @continue_indefinitely.
  ///
  /// In en, this message translates to:
  /// **'Continue indefinitely'**
  String get continue_indefinitely;

  /// No description provided for @working_hours.
  ///
  /// In en, this message translates to:
  /// **'Working hours'**
  String get working_hours;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
