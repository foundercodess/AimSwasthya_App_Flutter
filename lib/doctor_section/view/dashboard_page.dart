// doctor_section/view/dashboard_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui';

// Local imports
import 'package:aim_swasthya/res/border_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/doc_home_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/doctor_profile_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/revenue_doctor_view_model.dart';
import '../../patient_section/p_view_model/cancelAppointment_view_model.dart';

/// Doctor Dashboard Screen - Main dashboard view for doctors
/// Displays upcoming appointments, schedule management, profile, and earnings
class DoctorDashboardScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const DoctorDashboardScreen({
    super.key,
    this.scaffoldKey,
  });

  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  // MARK: - Lifecycle Methods

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  /// Initialize data by calling necessary APIs
  void _initializeData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DoctorHomeViewModel>(context, listen: false)
          .doctorHomeApi(context);
      Provider.of<DoctorProfileViewModel>(context, listen: false)
          .doctorProfileApi(context);
    });
  }

  // MARK: - Build Method

  @override
  Widget build(BuildContext context) {
    final docHomeCon = Provider.of<DoctorHomeViewModel>(context);

    if (docHomeCon.doctorHomeModel == null || docHomeCon.loading) {
      return const Center(child: LoadData());
    }

    return RefreshIndicator(
      color: AppColor.blue,
      onRefresh: _onRefresh,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBarContainer(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Sizes.spaceHeight20,
                    _buildSectionTitle(
                        AppLocalizations.of(context)!.upcoming_appointment),
                    Sizes.spaceHeight15,
                    _buildScheduleSection(),
                    Sizes.spaceHeight20,
                    _buildSectionTitle(
                        AppLocalizations.of(context)!.dash_board),
                    Sizes.spaceHeight15,
                    _buildDashboardGrid(),
                    Sizes.spaceHeight15,
                    _buildSectionTitle(
                        AppLocalizations.of(context)!.your_earnings),
                    Sizes.spaceHeight15,
                    _buildEarningDetails(),
                    SizedBox(height: Sizes.screenHeight * 0.13),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // MARK: - Helper Methods

  /// Refresh data by calling the doctor home API
  Future<void> _onRefresh() async {
    Provider.of<DoctorHomeViewModel>(context, listen: false)
        .doctorHomeApi(context);
  }

  /// Build section title with consistent styling
  Widget _buildSectionTitle(String title) {
    return TextConst(
      padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
      title,
      size: Sizes.fontSizeFivePFive,
      fontWeight: FontWeight.w500,
    );
  }

  // MARK: - App Bar Section

  /// Build the main app bar container with doctor profile
  Widget _buildAppBarContainer() {
    final docHomeCon =
        Provider.of<DoctorHomeViewModel>(context).doctorHomeModel;

    if (docHomeCon == null || docHomeCon.data!.doctors!.isEmpty) {
      return const Center(child: SizedBox());
    }

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top / 1.3,
      ),
      width: Sizes.screenWidth,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        gradient: LinearGradient(
          colors: [AppColor.naviBlue, AppColor.blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Sizes.spaceHeight30,
          _buildAppBarHeader(docHomeCon),
          const Divider(
            endIndent: 12,
            indent: 12,
            thickness: 0.2,
          ),
          _buildDoctorProfileSection(docHomeCon),
        ],
      ),
    );
  }

  /// Build app bar header with menu and notification
  Widget _buildAppBarHeader(dynamic docHomeCon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.03),
      child: Row(
        children: [
          _buildMenuButton(),
          Sizes.spaceWidth10,
          TextConst(
            "Welcome ${docHomeCon.data!.doctors![0].doctorName ?? ""}!",
            size: Sizes.fontSizeFive,
            fontWeight: FontWeight.w500,
            color: AppColor.white,
          ),
          const Spacer(),
          _buildNotificationButton(),
        ],
      ),
    );
  }

  /// Build menu button for drawer navigation
  Widget _buildMenuButton() {
    return GestureDetector(
      onTap: _toggleDrawer,
      child: Image.asset(
        Assets.iconsProfileIcon,
        height: 22,
        width: 22,
      ),
    );
  }

  /// Toggle drawer open/close
  void _toggleDrawer() {
    if (widget.scaffoldKey?.currentState != null) {
      if (widget.scaffoldKey!.currentState!.isDrawerOpen) {
        widget.scaffoldKey!.currentState!.closeDrawer();
      } else {
        widget.scaffoldKey!.currentState!.openDrawer();
      }
    } else {
      print("ScaffoldState is null!");
    }
  }

  /// Build notification button
  Widget _buildNotificationButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.notificationScreen);
      },
      child: Image(
        image: const AssetImage(Assets.iconsWellIcon),
        height: Sizes.screenHeight * 0.025,
      ),
    );
  }

  /// Build doctor profile section with image and details
  Widget _buildDoctorProfileSection(dynamic docHomeCon) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imagesPlusIcons),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildDoctorImage(docHomeCon),
          Sizes.spaceWidth10,
          _buildDoctorDetails(docHomeCon),
        ],
      ),
    );
  }

  /// Build doctor profile image
  Widget _buildDoctorImage(dynamic docHomeCon) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        bottomLeft: Radius.circular(40),
      ),
      child: docHomeCon.data!.doctors![0].signedImageUrl != null
          ? Image.network(
              docHomeCon.data!.doctors![0].signedImageUrl ?? "",
              height: Sizes.screenHeight * 0.155,
              width: Sizes.screenWidth * 0.4,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            )
          : Image(
              image: const AssetImage(Assets.logoDoctor),
              height: Sizes.screenHeight * 0.155,
              width: Sizes.screenWidth * 0.4,
              fit: BoxFit.fitWidth,
            ),
    );
  }

  /// Build doctor details section
  Widget _buildDoctorDetails(dynamic docHomeCon) {
    final doctor = docHomeCon.data!.doctors![0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextConst(
          doctor.experience ?? "5 years Experience",
          size: Sizes.fontSizeFour,
          fontWeight: FontWeight.w400,
          color: AppColor.white,
        ),
        Sizes.spaceHeight5,
        TextConst(
          doctor.doctorName ?? "",
          size: Sizes.fontSizeSix,
          fontWeight: FontWeight.w500,
          color: AppColor.white,
        ),
        SizedBox(
          width: Sizes.screenWidth * 0.55,
          child: TextConst(
            overflow: TextOverflow.ellipsis,
            '${doctor.qualification ?? ''} (${doctor.specializationName ?? "MBBS, MD (Cardiology)"})',
            size: Sizes.fontSizeFivePFive,
            fontWeight: FontWeight.w400,
            color: AppColor.white,
          ),
        ),
        Sizes.spaceHeight10,
        _buildDoctorBadges(doctor),
        Sizes.spaceHeight10,
      ],
    );
  }

  /// Build doctor badges (Top choice, Most booked)
  Widget _buildDoctorBadges(dynamic doctor) {
    return Row(
      children: [
        Image(
          image: const AssetImage(Assets.iconsReward),
          width: Sizes.screenWidth * 0.06,
          fit: BoxFit.cover,
        ),
        Sizes.spaceWidth5,
        Sizes.spaceWidth3,
        if (doctor.topRated.toUpperCase() == "Y")
          _buildProContainer(AppColor.lightGreen, 'Top choice'),
        Sizes.spaceWidth10,
        if (doctor.mostBooked.toUpperCase() == "Y")
          _buildProContainer(AppColor.conLightBlue, 'Most booked'),
      ],
    );
  }

  // MARK: - Schedule Section

  /// Build schedule section with upcoming appointments
  Widget _buildScheduleSection() {
    final docHomeCon = Provider.of<DoctorHomeViewModel>(context);

    if (docHomeCon.doctorHomeModel == null ||
        docHomeCon.doctorHomeModel!.data!.appointments!.isEmpty) {
      return const Center(child: NoDataMessages());
    }

    return SizedBox(
      height: Sizes.screenHeight * 0.1,
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: docHomeCon.doctorHomeModel!.data!.appointments!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final schedule =
              docHomeCon.doctorHomeModel!.data!.appointments![index];
          return _buildScheduleItem(schedule, index);
        },
      ),
    );
  }

  /// Build individual schedule item
  Widget _buildScheduleItem(dynamic schedule, int index) {
    final docHomeCon = Provider.of<DoctorHomeViewModel>(context);
    final cancelRescheduleAllowed = _isMoreThanOneHourAway(
      schedule.appointmentDate.toString(),
      schedule.appointmentTime.toString(),
    );
    final isCancelled = schedule.status!.toLowerCase() == "cancelled";
    final isRescheduled = schedule.status!.toLowerCase() == "reschduled";
    final isLastItem =
        index == docHomeCon.doctorHomeModel!.data!.appointments!.length - 1;

    return Container(
      margin: EdgeInsets.only(
        left: index == 0 ? Sizes.screenWidth * 0.06 : Sizes.screenWidth * 0.04,
        right: isLastItem ? Sizes.screenWidth * 0.06 : 0,
      ),
      padding: EdgeInsets.only(
        left: Sizes.screenWidth * 0.02,
        right: Sizes.screenWidth * 0.04,
        top: Sizes.screenHeight * 0.01,
        bottom: Sizes.screenHeight * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromRGBO(244, 244, 244, 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildPatientImage(schedule),
              Sizes.spaceWidth15,
              _buildPatientDetails(schedule, isCancelled, isRescheduled,
                  cancelRescheduleAllowed),
            ],
          ),
        ],
      ),
    );
  }

  /// Build patient image
  Widget _buildPatientImage(dynamic schedule) {
    return Container(
      height: Sizes.screenHeight * 0.073,
      width: Sizes.screenHeight * 0.073,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: schedule.signInImageUrl != null
              ? NetworkImage(schedule.signInImageUrl)
              : const AssetImage(Assets.logoDoctor),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Build patient details section
  Widget _buildPatientDetails(dynamic schedule, bool isCancelled,
      bool isRescheduled, bool cancelRescheduleAllowed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextConst(
          schedule.patientName ?? "",
          size: Sizes.fontSizeFour * 1.09,
          fontWeight: FontWeight.w400,
        ),
        Sizes.spaceHeight3,
        _buildAppointmentDateTime(schedule),
        Sizes.spaceHeight10,
        if (!isRescheduled && !isCancelled)
          _buildRescheduleButton(schedule, cancelRescheduleAllowed),
        if (isCancelled || isRescheduled)
          _buildStatusLabel(isCancelled ? "Cancelled" : "Rescheduled"),
      ],
    );
  }

  /// Build appointment date and time display
  Widget _buildAppointmentDateTime(dynamic schedule) {
    return Row(
      children: [
        Image.asset(
          Assets.iconsSolarCalendar,
          width: Sizes.screenWidth * 0.04,
        ),
        Sizes.spaceWidth5,
        TextConst(
          DateFormat('d MMM')
              .format(DateTime.parse(schedule.appointmentDate.toString())),
          size: Sizes.fontSizeThree * 1.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xff535353),
        ),
        Sizes.spaceWidth5,
        Image.asset(
          Assets.iconsMdiClock,
          width: Sizes.screenWidth * 0.041,
        ),
        Sizes.spaceWidth5,
        TextConst(
          schedule.appointmentTime.toString(),
          size: Sizes.fontSizeThree,
          fontWeight: FontWeight.w500,
          color: const Color(0xff535353),
        ),
      ],
    );
  }

  /// Build reschedule button
  Widget _buildRescheduleButton(
      dynamic schedule, bool cancelRescheduleAllowed) {
    return ButtonConst(
      title: "Reschedule",
      size: Sizes.fontSizeFour,
      fontWeight: FontWeight.w400,
      borderRadius: 5,
      height: Sizes.screenHeight * 0.026,
      width: Sizes.screenWidth * 0.33,
      color: AppColor.blue,
      onTap: () => _handleReschedule(schedule, cancelRescheduleAllowed),
    );
  }

  /// Handle reschedule action
  void _handleReschedule(dynamic schedule, bool cancelRescheduleAllowed) {
    if (cancelRescheduleAllowed) {
      showCupertinoDialog(
        context: context,
        builder: (_) => ActionOverlay(
          text: "Reschedule Appointment",
          subtext: "Are you sure you want to reschedule\n your appointment?",
          onTap: () {
            Provider.of<CancelAppointmentViewModel>(context, listen: false)
                .cancelAppointmentApi(
              status: 'reschduled',
              isDoctorCancel: true,
              context,
              schedule.appointmentId.toString(),
            );
          },
        ),
      );
    } else {
      showInfoOverlay(
        title: "Info",
        errorMessage:
            "Oops! You can't reschedule appointments less than 1 hour before the scheduled time.",
      );
    }
  }

  /// Build status label for cancelled/rescheduled appointments
  Widget _buildStatusLabel(String status) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 4),
        alignment: Alignment.center,
        child: TextConst(
          status,
          color: Colors.grey,
          size: Sizes.fontSizeFour,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // MARK: - Dashboard Grid Section

  /// Build dashboard grid with schedule and profile sections
  Widget _buildDashboardGrid() {
    return Container(
      height: Sizes.screenHeight / 2.65,
      padding: EdgeInsets.only(
        left: Sizes.screenWidth * 0.04,
        right: Sizes.screenWidth * 0.03,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDashSchedule(),
              _buildDashProfile(),
            ],
          ),
          _buildAppointmentSection(),
        ],
      ),
    );
  }

  /// Build dashboard schedule card
  Widget _buildDashSchedule() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.scheduleScreen);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.0,
          vertical: Sizes.screenHeight * 0.025,
        ),
        width: Sizes.screenWidth * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.blue,
        ),
        child: Column(
          children: [
            Image.asset(
              Assets.iconsCalendar,
              width: Sizes.screenWidth * 0.1,
              fit: BoxFit.fill,
              color: AppColor.lightBlue,
            ),
            TextConst(
              AppLocalizations.of(context)!.schedule,
              size: Sizes.fontSizeFourPFive,
              fontWeight: FontWeight.w500,
              color: AppColor.white,
            ),
            Sizes.spaceHeight3,
            TextConst(
              AppLocalizations.of(context)!.manage_your_appointments,
              size: Sizes.fontSizeThree,
              fontWeight: FontWeight.w400,
              color: AppColor.white.withOpacity(0.7),
            ),
            TextConst(
              AppLocalizations.of(context)!.and_schedule,
              size: Sizes.fontSizeThree,
              fontWeight: FontWeight.w400,
              color: AppColor.white.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }

  /// Build dashboard profile card
  Widget _buildDashProfile() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.userDocProfilePage);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.02,
          vertical: Sizes.screenHeight * 0.02,
        ),
        height: Sizes.screenHeight * 0.218,
        width: Sizes.screenWidth * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [AppColor.blue, AppColor.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextConst(
              AppLocalizations.of(context)!.profile,
              size: Sizes.fontSizeFourPFive,
              fontWeight: FontWeight.w500,
              color: AppColor.white,
            ),
            Sizes.spaceHeight5,
            TextConst(
              AppLocalizations.of(context)!.edit_personal_information,
              size: Sizes.fontSizeThree,
              fontWeight: FontWeight.w400,
              color: const Color(0xffD0D0D0),
            ),
            TextConst(
              AppLocalizations.of(context)!.and_clinic_details,
              size: Sizes.fontSizeThree,
              fontWeight: FontWeight.w400,
              color: const Color(0xffD0D0D0),
            ),
          ],
        ),
      ),
    );
  }

  /// Build appointment section with today's appointments
  Widget _buildAppointmentSection() {
    final docHomeCon =
        Provider.of<DoctorHomeViewModel>(context).doctorHomeModel;
    final todayAppointments = _getTodayAppointments(docHomeCon!);

    return Container(
      clipBehavior: Clip.none,
      width: Sizes.screenWidth / 1.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.textfieldGrayColor.withOpacity(0.3),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          todayAppointments.isEmpty
              ? _buildNoAppointmentsMessage()
              : _buildAppointmentsList(todayAppointments),
          _buildTodayAppointmentsLabel(),
        ],
      ),
    );
  }

  /// Get today's appointments
  List<dynamic> _getTodayAppointments(dynamic docHomeCon) {
    return docHomeCon.data!.appointments!.where((item) {
      final apptDate = DateTime.parse(item.appointmentDate.toString());
      final now = DateTime.now();
      return apptDate.year == now.year &&
          apptDate.month == now.month &&
          apptDate.day == now.day;
    }).toList();
  }

  /// Build no appointments message
  Widget _buildNoAppointmentsMessage() {
    return Center(
      child: TextConst(
        "No Today's Appointment",
        size: Sizes.fontSizeFour,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
    );
  }

  /// Build appointments list
  Widget _buildAppointmentsList(List<dynamic> todayAppointments) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 15, left: 4, right: 5),
      itemCount: todayAppointments.length,
      itemBuilder: (context, index) {
        final item = todayAppointments[index];
        return _buildAppointmentItem(item, index);
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  /// Build individual appointment item
  Widget _buildAppointmentItem(dynamic item, int index) {
    final appointmentDateTime = _parseAppointmentDateTime(item);
    final now = DateTime.now();
    final isInProgressByTime = now.isAfter(appointmentDateTime) &&
        now.isBefore(appointmentDateTime.add(const Duration(minutes: 15)));
    final isCompletedByTime =
        now.isAfter(appointmentDateTime.add(const Duration(minutes: 15)));

    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment:
                index == 0 ? MainAxisAlignment.end : MainAxisAlignment.center,
            children: [
              Sizes.spaceWidth5,
              _buildAppointmentCard(item),
              if (index == 0) _buildMoreIndicator(),
            ],
          ),
          _buildAppointmentStatus(item, isCompletedByTime, isInProgressByTime),
          if (isInProgressByTime) _buildProgressIndicator(),
        ],
      ),
    );
  }

  /// Parse appointment date and time
  DateTime _parseAppointmentDateTime(dynamic item) {
    final appointmentDateTimeString =
        "${item.appointmentDate} ${item.appointmentTime}";
    
    // Try different formats to handle various time formats
    List<DateFormat> formats = [
      DateFormat("yyyy-MM-dd HH:mm"), // 24-hour format without AM/PM
      DateFormat("yyyy-MM-dd hh:mm a"), // 12-hour format with AM/PM
      DateFormat("yyyy-MM-dd HH:mm a"), // 24-hour format with AM/PM (incorrect but might exist)
    ];
    
    for (DateFormat format in formats) {
      try {
        return format.parse(appointmentDateTimeString);
      } catch (e) {
        // Continue to next format
      }
    }
    
    // If all formats fail, try to manually parse the time
    try {
      final datePart = item.appointmentDate.toString();
      final timePart = item.appointmentTime.toString();
      
      // Parse the date
      final date = DateTime.parse(datePart);
      
      // Handle time formats like "14:00PM" or "14:00"
      String cleanTime = timePart.replaceAll(RegExp(r'[AP]M'), '').trim();
      final timeParts = cleanTime.split(':');
      
      if (timeParts.length == 2) {
        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);
        
        // If time has PM suffix and hour is 12 or less, add 12
        if (timePart.toUpperCase().contains('PM') && hour < 12) {
          hour += 12;
        }
        // If time has AM suffix and hour is 12, make it 0
        if (timePart.toUpperCase().contains('AM') && hour == 12) {
          hour = 0;
        }
        
        return DateTime(date.year, date.month, date.day, hour, minute);
      }
    } catch (e) {
      print("Error parsing datetime manually: $e");
    }
    
    print("Error parsing datetime: $appointmentDateTimeString");
    return DateTime.now();
  }

  /// Build appointment card
  Widget _buildAppointmentCard(dynamic item) {
    return Container(
      height: Sizes.screenHeight * 0.054,
      width: Sizes.screenWidth / 2.9,
      clipBehavior: Clip.none,
      padding: const EdgeInsets.only(
        left: 3,
        top: 2,
        bottom: 2,
        right: 3,
      ),
      decoration: BoxDecoration(
        // color: AppColor.lightSkyBlue.withOpacity(0.5),
        color: Color.fromRGBO(220, 242, 255, 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Sizes.spaceHeight3,
          TextConst(
            item.patientName ?? "",
            size: Sizes.fontSizeFour,
            fontWeight: FontWeight.w500,
          ),
          Sizes.spaceHeight5,
          _buildAppointmentDateTimeRow(item),
        ],
      ),
    );
  }

  /// Build appointment date and time row
  Widget _buildAppointmentDateTimeRow(dynamic item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Image.asset(
              Assets.iconsSolarCalendar,
              width: Sizes.screenWidth / 30,
            ),
            Sizes.spaceWidth3,
            TextConst(
              DateFormat('d MMM')
                  .format(DateTime.parse(item.appointmentDate.toString())),
              size: Sizes.fontSizeThree,
              fontWeight: FontWeight.w400,
              color: const Color(0xff535353),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              Assets.iconsMdiClock,
              width: Sizes.screenWidth / 30,
            ),
            Sizes.spaceWidth3,
            TextConst(
              item.appointmentTime.toString(),
              size: Sizes.fontSizeThree,
              fontWeight: FontWeight.w400,
              color: const Color(0xff535353),
            ),
          ],
        ),
      ],
    );
  }

  /// Build more appointments indicator
  Widget _buildMoreIndicator() {
    return SizedBox(
      height: Sizes.screenHeight * 0.054,
      width: Sizes.screenWidth * 0.06,
    );
  }

  /// Build appointment status
  Widget _buildAppointmentStatus(
      dynamic item, bool isCompletedByTime, bool isInProgressByTime) {
    return Positioned(
      top: 1,
      left: -1,
      child: SizedBox(
        width: Sizes.screenWidth / 7.6,
        child: Column(
          children: [
            TextConst(
              item.appointmentTime.toString(),
              size: Sizes.fontSizeThree,
            ),
            if (isCompletedByTime)
              _buildAppContainer(Colors.green, "Completed")
            else if (isInProgressByTime)
              _buildAppContainer(AppColor.blue, "In progress")
            else
              _buildAppContainer(AppColor.blue, "Upcoming"),
          ],
        ),
      ),
    );
  }

  /// Build progress indicator for in-progress appointments
  Widget _buildProgressIndicator() {
    return Positioned(
      top: 27.0,
      left: 0,
      right: 0,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(28, (index) {
            if (index == 0) {
              return Row(
                children: [
                  Image.asset(
                    Assets.iconsPlaySound,
                    height: 8,
                    color: AppColor.blue,
                  ),
                  Container(
                    width: 4,
                    height: 1,
                    color: AppColor.lightBlack,
                  ),
                ],
              );
            } else {
              return Container(
                width: 4,
                height: 1,
                color: AppColor.lightBlue,
              );
            }
          }),
        ),
      ),
    );
  }

  /// Build today appointments label
  Widget _buildTodayAppointmentsLabel() {
    return Positioned(
      top: -9.5,
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextConst(
          AppLocalizations.of(context)!.today_appointments,
          size: Sizes.fontSizeFour,
          fontWeight: FontWeight.w500,
          // color:AppColor.textGrayColor,
          color: const Color.fromRGBO(47, 47, 47, 1),
        ),
      ),
    );
  }

  // MARK: - Earnings Section

  /// Build earnings details section
  Widget _buildEarningDetails() {
    final docHomeCon = Provider.of<DoctorHomeViewModel>(context);

    return SizedBox(
      height: Sizes.screenHeight * 0.193,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          _buildEarningsContainer(docHomeCon),
          _buildViewEarningsButton(),
        ],
      ),
    );
  }

  /// Build earnings container
  Widget _buildEarningsContainer(dynamic docHomeCon) {
    return BorderContainer(
      margin: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.04),
      padding: const EdgeInsets.all(1),
      radius: 10,
      gradient: LinearGradient(
        colors: [const Color(0xff9FC1EF), AppColor.blue.withOpacity(0.7)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      child: Container(
        height: Sizes.screenHeight * 0.17,
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.04,
          vertical: Sizes.screenHeight * 0.01,
        ),
        width: Sizes.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xffC9E0FF), Color(0xffCAECFF)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            _buildEarningsHeader(docHomeCon),
            const Spacer(),
            _buildEarningsAmount(docHomeCon),
            const Spacer(),
            Sizes.spaceHeight10
          ],
        ),
      ),
    );
  }

  /// Build earnings header with month selector
  Widget _buildEarningsHeader(dynamic docHomeCon) {
    return Row(
      children: [
        TextConst(
          AppLocalizations.of(context)!.net_revenue,
          size: Sizes.fontSizeFour,
          fontWeight: FontWeight.w400,
        ),
        const Spacer(),
        TextConst(
          docHomeCon.selectedMonth,
          size: Sizes.fontSizeFour,
          fontWeight: FontWeight.w400,
          color: AppColor.textfieldTextColor,
        ),
        Sizes.spaceWidth5,
        _buildMonthSelector(docHomeCon),
      ],
    );
  }

  /// Build month selector dropdown
  Widget _buildMonthSelector(dynamic docHomeCon) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) =>
          _showMonthSelector(docHomeCon, details),
      child: Image.asset(
        Assets.iconsArrowDown,
        width: Sizes.screenWidth * 0.05,
        color: AppColor.textfieldTextColor,
      ),
    );
  }

  /// Show month selector popup
  Future<void> _showMonthSelector(
      dynamic docHomeCon, TapDownDetails details) async {
    final selected = await showMenu<Map<String, String>>(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: docHomeCon.doctorHomeModel!.data!.earnings!
          .map(
            (month) => PopupMenuItem<Map<String, String>>(
              value: {
                'monthYear': month.monthYear ?? '',
                'totalAmount': month.totalamountformatted?.toString() ?? '0',
              },
              child: Text(month.monthYear ?? ""),
            ),
          )
          .toList(),
    );

    if (selected != null) {
      docHomeCon.setSelectedMonthAndAmount(
        selected['monthYear']!,
        selected['totalAmount']!,
      );
    }
  }

  /// Build earnings amount display
  Widget _buildEarningsAmount(dynamic docHomeCon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.iconsRupees,
          width: Sizes.screenWidth * 0.16,
        ),
        Sizes.spaceWidth15,
        TextConst(
          docHomeCon.selectedAmount,
          size: Sizes.fontSizeFivePFive,
          fontWeight: FontWeight.w400,
          color: AppColor.black,
        ),
      ],
    );
  }

  /// Build view earnings button
  Widget _buildViewEarningsButton() {
    return Positioned(
      bottom: 0,
      child: ButtonConst(
        title: AppLocalizations.of(context)!.view,
        fontWeight: FontWeight.w500,
        size: Sizes.fontSizeFourPFive,
        borderRadius: 6,
        width: Sizes.screenWidth * 0.6,
        height: Sizes.screenHeight * 0.046,
        color: AppColor.lightBlue,
        onTap: _navigateToRevenueScreen,
      ),
    );
  }

  /// Navigate to revenue screen
  void _navigateToRevenueScreen() {
    Provider.of<RevenueDoctorViewModel>(context, listen: false)
        .revenueDoctorApi();
    Navigator.pushNamed(context, RoutesName.scheduleHoursScreen);
  }

  // MARK: - Utility Methods

  /// Build pro container for badges
  Widget _buildProContainer(Color color, dynamic label) {
    return Container(
      padding: const EdgeInsets.only(left: 4, right: 5, top: 3, bottom: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: Row(
        children: [
          Image(
            image: const AssetImage(Assets.iconsCheck),
            width: Sizes.screenWidth * 0.035,
            fit: BoxFit.fill,
          ),
          Sizes.spaceWidth3,
          TextConst(
            label,
            size: Sizes.fontSizeTwo,
            fontWeight: FontWeight.w700,
            color: AppColor.white,
          ),
        ],
      ),
    );
  }

  /// Build app container for status labels
  Widget _buildAppContainer(Color color, dynamic label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color,
      ),
      child: TextConst(
        textAlign: TextAlign.center,
        label,
        size: Sizes.fontSizeOne,
        fontWeight: FontWeight.w600,
        color: AppColor.white,
      ),
    );
  }

  /// Check if appointment is more than one hour away
  bool _isMoreThanOneHourAway(String bookingDate, String hour24Format) {
    String dateTimeString = "$bookingDate $hour24Format";
    print("date time : ${dateTimeString}");

    DateFormat format = DateFormat("yyyy-MM-dd hh:mm a");
    DateTime bookingDateTime = format.parse(dateTimeString);
    DateTime now = DateTime.now();
    Duration difference = bookingDateTime.difference(now);

    return difference.inMinutes > 60;
  }
}
