// doctor_section/view/patients/my_appointments.dart
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/doc_update_appointment_view_model.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/patient_profile_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/bottom_nav_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:url_launcher/url_launcher.dart';
import '../../../res/common_material.dart';
import '../../../res/popUp_const.dart';
import '../../../utils/show_server_error.dart';
import '../../../patient_section/p_view_model/cancelAppointment_view_model.dart';
import '../../../patient_section/p_view_model/update_appointment_view_model.dart';

/// My Appointments Screen - Displays active and past appointments for doctors.
class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  // MARK: - Lifecycle Methods

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  /// Initializes data by calling the doctor patient appointment API.
  void _initializeData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DocPatientAppointmentViewModel>(context, listen: false)
          .docPatientAppointmentApi();
    });
  }

  // MARK: - Build Method

  @override
  Widget build(BuildContext context) {
    final appointmentCon = Provider.of<DocPatientAppointmentViewModel>(context);
    final bottomCon = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      extendBody: true,
      primary: false,
      body: appointmentCon.loading
          ? const Center(child: LoadData())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(bottomCon),
                  Sizes.spaceHeight20,
                  _buildSectionTitle("Active appointments"),
                  Sizes.spaceHeight20,
                  _buildActiveAppointmentSection(),
                  Sizes.spaceHeight30,
                  _buildSectionTitle("Past history"),
                  Sizes.spaceHeight20,
                  _buildPastAppointmentSection(),
                  Sizes.spaceHeight30,
                  const SizedBox(
                    height: kBottomNavigationBarHeight,
                  )
                ],
              )),
    );
  }

  // MARK: - App Bar Section

  /// Builds the custom app bar for the appointments screen.
  Widget _buildAppBar(BottomNavProvider bottomCon) {
    return appBarConstant(
      context,
      onTap: () {
        if (bottomCon.currentIndex == 2) {
          bottomCon.setIndex(0);
        } else {
          Navigator.pop(context);
        }
      },
      child: Center(
        child: TextConst(
          "Appointments",
          size: Sizes.fontSizeSix * 1.1,
          fontWeight: FontWeight.w500,
        ),
      ),
      isBottomAllowed: true,
    );
  }

  // MARK: - Section Titles

  /// Builds a standardized section title text widget.
  Widget _buildSectionTitle(String title) {
    return TextConst(
      padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
      title,
      size: Sizes.fontSizeFourPFive,
      fontWeight: FontWeight.w500,
      color: AppColor.textfieldTextColor,
    );
  }

  // MARK: - Active Appointments Section

  /// Builds the active appointments list.
  Widget _buildActiveAppointmentSection({bool isCancelAllowed = true}) {
    final appointmentCon = Provider.of<DocPatientAppointmentViewModel>(context);

    if (appointmentCon.docPatientAppointmentModel == null ||
        appointmentCon.docPatientAppointmentModel!.activeAppointments!.isEmpty) {
      return const Center(child: NoDataMessages());
    }

    return SizedBox(
      height: Sizes.screenHeight * 0.2,
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: appointmentCon.docPatientAppointmentModel!.activeAppointments!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final appointmentData = appointmentCon.docPatientAppointmentModel!.activeAppointments![index];
          return _buildActiveAppointmentItem(appointmentData, isCancelAllowed);
        },
      ),
    );
  }

  /// Builds an individual active appointment item.
  Widget _buildActiveAppointmentItem(dynamic appointmentData, bool isCancelAllowed) {
    debugPrint("udysue${appointmentData.status}");
    final cancelRescheduleAllowed = _isMoreThanOneHourAway(
      appointmentData.appointmentDate.toString(),
      appointmentData.appointmentTime.toString(),
    );
    final isCancelled = appointmentData.status!.toLowerCase() == "cancelled";
    final isRescheduled = appointmentData.status!.toLowerCase() == "reschduled";

    return Container(
      margin: EdgeInsets.only(
        left: Sizes.screenWidth * 0.05,
        right: Sizes.screenWidth * .03,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.grey.withOpacity(0.5),
      ),
      child: Row(
        children: [
          _buildPatientImage(appointmentData.signedImageUrl),
          Sizes.spaceWidth10,
          SizedBox(
            width: Sizes.screenWidth / 2.44,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppointmentDateTimeRow(appointmentData),
                Sizes.spaceHeight15,
                _buildPatientName(appointmentData.patientName),
                Sizes.spaceHeight10,
                _buildPatientInfo("Date of birth", DateFormat('dd/MM/yyyy').format(DateTime.parse(appointmentData.dateOfBirth.toString()))),
                Sizes.spaceHeight5,
                _buildPatientInfo("Weight", appointmentData.weight.toString()),
                Sizes.spaceHeight5,
                _buildPatientInfo("Height", appointmentData.height.toString()),
                _buildActiveAppointmentActions(appointmentData, isCancelled, isRescheduled, cancelRescheduleAllowed, isCancelAllowed),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the patient image circular container.
  Widget _buildPatientImage(String? imageUrl) {
    return Container(
      width: Sizes.screenWidth / 5,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        image: DecorationImage(
          image: imageUrl != null
              ? NetworkImage(imageUrl)
              : const AssetImage(Assets.logoDoctor) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Builds the appointment date and time row for active appointments.
  Widget _buildAppointmentDateTimeRow(dynamic appointmentData) {
    return Padding(
      padding: EdgeInsets.only(right: Sizes.screenWidth * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            Assets.iconsSolarCalendar,
            width: Sizes.screenWidth * 0.035,
          ),
          Sizes.spaceWidth3,
          TextConst(
            DateFormat('d MMM').format(DateTime.parse(appointmentData.appointmentDate.toString())),
            size: Sizes.fontSizeTwo,
            fontWeight: FontWeight.w500,
          ),
          Sizes.spaceWidth10,
          Image.asset(
            Assets.iconsMdiClock,
            width: Sizes.screenWidth * 0.04,
          ),
          Sizes.spaceWidth3,
          TextConst(
            appointmentData.appointmentTime.toString(),
            size: Sizes.fontSizeTwo,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  /// Builds the patient name text.
  Widget _buildPatientName(String? name) {
    return TextConst(
      name ?? "",
      size: Sizes.fontSizeFive,
      fontWeight: FontWeight.w500,
    );
  }

  /// Builds a row for patient information (e.g., Date of birth, Weight, Height).
  Widget _buildPatientInfo(String label, String value) {
    return TextConst(
      "$label : $value",
      size: Sizes.fontSizeThree,
      fontWeight: FontWeight.w400,
    );
  }

  /// Builds the action buttons (Reschedule, Cancel) for active appointments.
  Widget _buildActiveAppointmentActions(
    dynamic appointmentData,
    bool isCancelled,
    bool isRescheduled,
    bool cancelRescheduleAllowed,
    bool isCancelAllowed,
  ) {
    return Row(
      children: [
        if (!isRescheduled && !isCancelled)
          _buildRescheduleButton(appointmentData, cancelRescheduleAllowed),
        if (isCancelled || isRescheduled)
          _buildStatusLabel(isCancelled ? "Cancelled" : "Rescheduled"),
        Sizes.spaceWidth5,
        if (isCancelAllowed && !isCancelled)
          _buildCancelButton(appointmentData, cancelRescheduleAllowed),
      ],
    );
  }

  /// Builds the Reschedule button for active appointments.
  Widget _buildRescheduleButton(dynamic appointmentData, bool cancelRescheduleAllowed) {
    return ButtonConst(
      title: "Reschedule",
      size: Sizes.fontSizeThree,
      fontWeight: FontWeight.w400,
      borderRadius: 6,
      height: Sizes.screenHeight * 0.025,
      width: Sizes.screenWidth * 0.23,
      color: AppColor.blue,
      onTap: () {
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
                  appointmentData.appointmentId.toString(),
                );
              },
            ),
          );
        } else {
          showInfoOverlay(
            title: "Info",
            errorMessage: "Oops! You can't reschedule appointments less than 1 hour before the scheduled time.",
          );
        }
      },
    );
  }

  /// Builds the Cancel button for active appointments.
  Widget _buildCancelButton(dynamic appointmentData, bool cancelRescheduleAllowed) {
    return Center(
      child: GestureDetector(
        child: SizedBox(
          height: Sizes.screenHeight * 0.06,
          child: TextButton(
            onPressed: () {
              if (cancelRescheduleAllowed) {
                showCupertinoDialog(
                  context: context,
                  builder: (_) => ActionOverlay(
                    text: "Cancel Appointment",
                    subtext: "Are you sure you want to cancel\n your appointment?",
                    onTap: () {
                      Provider.of<CancelAppointmentViewModel>(context, listen: false)
                          .cancelAppointmentApi(
                        isDoctorCancel: true,
                        context,
                        appointmentData.appointmentId.toString(),
                      );
                    },
                  ),
                );
              } else {
                showInfoOverlay(
                  title: "Info",
                  errorMessage: "Oops! You can't cancellation appointments less than 1 hour before the scheduled time.",
                );
              }
            },
            child: TextConst(
              "Cancel",
              size: Sizes.fontSizeFour,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the status label for cancelled or rescheduled appointments.
  Widget _buildStatusLabel(String status) {
    return Container(
      alignment: Alignment.center,
      height: Sizes.screenHeight * 0.06,
      child: TextConst(
        status,
        color: Colors.grey,
        size: Sizes.fontSizeFour,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // MARK: - Past Appointments Section

  /// Builds the past appointments list.
  Widget _buildPastAppointmentSection() {
    final appointmentCon = Provider.of<DocPatientAppointmentViewModel>(context);
    final patientProfileData = Provider.of<PatientProfileViewModel>(context);

    if (appointmentCon.docPatientAppointmentModel == null ||
        appointmentCon.docPatientAppointmentModel!.pastAppointments == null ||
        appointmentCon.docPatientAppointmentModel!.pastAppointments!.isEmpty) {
      return const Center(child: NoDataMessages(message: "No past Appointment yet"));
    }

    return SizedBox(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: appointmentCon.docPatientAppointmentModel!.pastAppointments!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final scheduleData = appointmentCon.docPatientAppointmentModel!.pastAppointments![index];
          return _buildPastAppointmentItem(scheduleData, patientProfileData, appointmentCon);
        },
      ),
    );
  }

  /// Builds an individual past appointment item.
  Widget _buildPastAppointmentItem(dynamic scheduleData, PatientProfileViewModel patientProfileData, DocPatientAppointmentViewModel appointmentCon) {
    return Container(
      margin: EdgeInsets.only(bottom: Sizes.screenHeight * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: Sizes.screenWidth * 0.07,
            ),
            padding: EdgeInsets.only(
                left: Sizes.screenWidth * 0.026,
                right: Sizes.screenWidth * 0.037,
                top: Sizes.screenHeight * 0.006,
                bottom: Sizes.screenHeight * 0.01),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.grey.withOpacity(0.8)),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildPatientInitialCircle(scheduleData.patientName),
                    Sizes.spaceWidth10,
                    _buildPastAppointmentDetails(scheduleData, patientProfileData, appointmentCon),
                  ],
                ),
              ],
            ),
          ),
          _buildCallButton(scheduleData.phoneNumber),
        ],
      ),
    );
  }

  /// Builds the circular container with patient's initial.
  Widget _buildPatientInitialCircle(String? patientName) {
    return Container(
      height: Sizes.screenHeight * 0.067,
      width: Sizes.screenWidth * 0.167,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.lightBlue),
      child: Center(
        child: TextConst(
          patientName == null
              ? ""
              : patientName.substring(0, 1).toUpperCase(),
          size: Sizes.fontSizeTen,
          fontWeight: FontWeight.w700,
          color: AppColor.white,
        ),
      ),
    );
  }

  /// Builds the details section for a past appointment item.
  Widget _buildPastAppointmentDetails(dynamic scheduleData, PatientProfileViewModel patientProfileData, DocPatientAppointmentViewModel appointmentCon) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextConst(
            scheduleData.name ?? "",
            size: Sizes.fontSizeFourPFive,
            fontWeight: FontWeight.w400,
          ),
          Sizes.spaceHeight3,
          _buildPastAppointmentDateTimeRow(scheduleData),
          Sizes.spaceHeight5,
          _buildViewButton(scheduleData, patientProfileData, appointmentCon),
        ],
      ),
    );
  }

  /// Builds the appointment date and time row for past appointments.
  Widget _buildPastAppointmentDateTimeRow(dynamic scheduleData) {
    return Row(
      children: [
        Image.asset(
          Assets.iconsSolarCalendar,
          width: Sizes.screenWidth * 0.035,
        ),
        Sizes.spaceWidth5,
        TextConst(
          DateFormat('d MMM').format(DateTime.parse(scheduleData.appointmentDate.toString())),
          size: Sizes.fontSizeThree,
          fontWeight: FontWeight.w500,
          color: const Color(0xff535353),
        ),
        Sizes.spaceWidth5,
        Image.asset(
          Assets.iconsMdiClock,
          width: Sizes.screenWidth * 0.04,
        ),
        Sizes.spaceWidth5,
        TextConst(
          scheduleData.appointmentTime.toString(),
          size: Sizes.fontSizeThree,
          fontWeight: FontWeight.w500,
          color: const Color(0xff535353),
        ),
      ],
    );
  }

  /// Builds the 'View' button for past appointments.
  Widget _buildViewButton(dynamic scheduleData, PatientProfileViewModel patientProfileData, DocPatientAppointmentViewModel appointmentCon) {
    return ButtonConst(
      title: "View",
      size: Sizes.fontSizeFour,
      fontWeight: FontWeight.w400,
      borderRadius: 5,
      height: Sizes.screenHeight * 0.025,
      width: Sizes.screenWidth * 0.37,
      color: AppColor.blue,
      onTap: () {
        appointmentCon.setDoctorsAppointmentsData(scheduleData, true);
        patientProfileData.patientProfileApi(
          scheduleData.patientId.toString(),
          scheduleData.appointmentId.toString(),
          context,
        );
        Navigator.pushNamed(context, RoutesName.patientProfileScreen);
      },
    );
  }

  /// Builds the call button for past appointments.
  Widget _buildCallButton(String? phoneNumber) {
    return GestureDetector(
      onTap: () {
        if (phoneNumber != null && phoneNumber.isNotEmpty) {
          _launchDialer(phoneNumber);
        } else {
          debugPrint("No phone number available.");
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: Sizes.screenWidth * 0.07),
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.053,
          vertical: Sizes.screenHeight * 0.032,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.grey.withOpacity(0.8),
        ),
        child: const Icon(
          Icons.call,
          color: AppColor.lightBlue,
          size: 23,
        ),
      ),
    );
  }

  // MARK: - Utility Methods

  /// Launches the device dialer with the given phone number.
  void _launchDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  /// Checks if the appointment is more than one hour away from the current time.
  bool _isMoreThanOneHourAway(String bookingDate, String hour24Format) {
    String dateTimeString = "$bookingDate $hour24Format";
    DateFormat format = DateFormat("yyyy-MM-dd hh:mm a");
    DateTime bookingDateTime = format.parse(dateTimeString);
    DateTime now = DateTime.now();
    Duration difference = bookingDateTime.difference(now);
    return difference.inMinutes > 60;
  }
}
