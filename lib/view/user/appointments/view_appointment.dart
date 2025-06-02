import 'package:aim_swasthya/model/user/patient_Appointment_model.dart';
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view/user/secound_nav_bar.dart';
import 'package:aim_swasthya/view_model/user/patient_appointment_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../utils/show_server_error.dart';
import '../../../view_model/user/cancelAppointment_view_model.dart';
import '../../../view_model/user/update_appointment_view_model.dart';

class ViewAppointmentsScreen extends StatefulWidget {
  const ViewAppointmentsScreen({super.key});

  @override
  State<ViewAppointmentsScreen> createState() => _ViewAppointmentsScreenState();
}

class _ViewAppointmentsScreenState extends State<ViewAppointmentsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PatientAppointmentViewModel>(context, listen: false)
          .patientAppointmentApi(context);
    });
    super.initState();
  }

  int currentPage = 0;
  final ScrollController _upcomingScrollController = ScrollController();
  final ScrollController _pastScrollController = ScrollController();

  void _nextUpcomingPage() {
    if (_upcomingScrollController.hasClients) {
      _upcomingScrollController.animateTo(
        _upcomingScrollController.offset + 360,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextPastPage() {
    if (_pastScrollController.hasClients) {
      _pastScrollController.animateTo(
        _pastScrollController.offset + 360,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appointmentCon = Provider.of<PatientAppointmentViewModel>(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: appointmentCon.loading
          ? const Center(child: LoadData())
          : Column(
              children: [
                AppbarConst(title: AppLocalizations.of(context)!.appointments),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.screenWidth * 0.04,
                    vertical: Sizes.screenHeight * 0.001,
                  ),
                  child: Row(
                    children: [
                      TextConst(
                        AppLocalizations.of(context)!.upcoming,
                        size: Sizes.fontSizeFivePFive,
                        fontWeight: FontWeight.w500,
                      ),
                      Sizes.spaceWidth5,
                      appointmentCon.patientAppointmentModel?.data
                                  ?.upcomingAppointments?.isNotEmpty ??
                              false
                          ? Container(
                              height: 18,
                              width: 18,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.lightBlue,
                              ),
                              child: Center(
                                child: TextConst(
                                  appointmentCon.patientAppointmentModel!.data!
                                      .upcomingAppointments!.length
                                      .toString(),
                                  size: Sizes.fontSizeFour,
                                  color: AppColor.white,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      const Spacer(),
                      IconButton(
                        onPressed: _nextUpcomingPage,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Sizes.spaceHeight5,
                showUpcomingAppointments(),
                Sizes.spaceHeight30,
                Sizes.spaceHeight3,
                const Divider(
                  thickness: 5,
                  color: AppColor.docProfileColor,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.screenWidth * 0.04,
                    vertical: Sizes.screenHeight * 0.01,
                  ),
                  child: Row(
                    children: [
                      TextConst(
                        AppLocalizations.of(context)!.past,
                        size: Sizes.fontSizeFivePFive,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: _nextPastPage,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                showPastAppointments(),
              ],
            ),
      bottomNavigationBar: Container(
        height: 90,
        width: Sizes.screenWidth,
        color: AppColor.white,
        child: const CommenBottomNevBar(),
      ),
    );
  }

  Widget showUpcomingAppointments() {
    final appointmentCon = Provider.of<PatientAppointmentViewModel>(context);
    return SizedBox(
      height: Sizes.screenHeight * 0.27,
      child: appointmentCon.patientAppointmentModel != null &&
              appointmentCon.patientAppointmentModel!.data!
                  .upcomingAppointments!.isNotEmpty
          ? ListView.builder(
              controller: _upcomingScrollController,
              itemCount: appointmentCon
                  .patientAppointmentModel!.data!.upcomingAppointments!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final appointmentData = appointmentCon.patientAppointmentModel!
                    .data!.upcomingAppointments![index];
                return appointmentTile(appointmentData);
              },
            )
          : appointmentCon.patientAppointmentModel == null ||
                  appointmentCon.patientAppointmentModel!.data == null ||
                  appointmentCon.patientAppointmentModel!.data!
                          .upcomingAppointments ==
                      null ||
                  appointmentCon.patientAppointmentModel!.data!
                      .upcomingAppointments!.isEmpty
              ? const Center(child: NoDataMessages())
              : const Center(child: LoadData()),
    );
  }

  Widget showPastAppointments() {
    final appointmentCon = Provider.of<PatientAppointmentViewModel>(context);
    return SizedBox(
        height: Sizes.screenHeight * 0.27,
        child: appointmentCon.patientAppointmentModel != null &&
                appointmentCon
                    .patientAppointmentModel!.data!.pastAppointments!.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                controller: _pastScrollController,
                itemCount: appointmentCon
                    .patientAppointmentModel!.data!.pastAppointments!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final appointmentData = appointmentCon
                      .patientAppointmentModel!.data!.pastAppointments![index];
                  return appointmentTile(appointmentData,
                      isCancelAllowed: false);
                },
              )
            : appointmentCon.patientAppointmentModel == null ||
                    appointmentCon.patientAppointmentModel!.data == null ||
                    appointmentCon
                            .patientAppointmentModel!.data!.pastAppointments ==
                        null ||
                    appointmentCon.patientAppointmentModel!.data!
                        .pastAppointments!.isEmpty
                ? const Center(
                    child: NoDataMessages(
                      message: "Nothing in your history yet",
                      title: "Your past visits will appear here",
                    ),
                  )
                : const Center(child: LoadData()));
  }

  Widget appointmentTile(AppointmentsData appointmentData,
      {bool isCancelAllowed = true}) {
    final isCancelled = appointmentData.status.toLowerCase() == "cancelled";
    DateTime dateTime =
        DateFormat('dd-MM-yyyy').parse(appointmentData.bookingDate!);
    final formattedDate = DateFormat('d MMMM').format(dateTime);
    final cancelRescheduleAllowed = isMoreThanOneHourAway(
        appointmentData.bookingDate!, appointmentData.hour24Format!);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.screenWidth * 0.022,
        vertical: Sizes.screenHeight * 0.01,
      ),
      margin: const EdgeInsets.only(left: 14, right: 5),
      width: Sizes.screenWidth * 0.87,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffF5F5F5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(Assets.iconsCalander,
                  color: Colors.grey, width: Sizes.screenWidth * 0.05),
              Sizes.spaceWidth5,
              TextConst(formattedDate,
                  size: Sizes.fontSizeFive, fontWeight: FontWeight.w500),
              const Spacer(),
              const Icon(Icons.watch_later_outlined,
                  color: Colors.grey, size: 20),
              Sizes.spaceWidth5,
              TextConst(appointmentData.hour24Format!,
                  size: Sizes.fontSizeFive, fontWeight: FontWeight.w500),
            ],
          ),
          Sizes.spaceHeight10,

          // --- Middle Row: Image + Doctor Info + Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Doctor Image
              SizedBox(
                width: Sizes.screenWidth / 2.17,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: appointmentData.signedImageUrl != null
                          ? Image.network(
                              appointmentData.signedImageUrl!,
                              height: Sizes.screenHeight * 0.2,
                              width: Sizes.screenWidth / 2.5,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              Assets.logoDoctor,
                              height: Sizes.screenHeight * 0.2,
                              width: Sizes.screenWidth / 2.5,
                              fit: BoxFit.cover,
                            ),
                    ),
                    // Consultation Fee
                    Positioned(
                      top: 18,
                      left: 110,
                      child: Container(
                        height: Sizes.screenHeight * 0.025,
                        width: Sizes.screenWidth * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.blue,
                        ),
                        child: Center(
                          child: TextConst(
                            appointmentData.consultationFee.toString(),
                            size: Sizes.fontSizeThree,
                            fontWeight: FontWeight.w400,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Doctor Details + Action Button
              Container(
                width: Sizes.screenWidth / 2.8,
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextConst(
                      appointmentData.experience ?? "",
                      size: Sizes.fontSizeThree,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                    Sizes.spaceHeight3,
                    TextConst(
                      appointmentData.doctorName ?? "",
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w600,
                    ),
                    Sizes.spaceHeight3,
                    TextConst(
                      "${appointmentData.qualification} (${appointmentData.specializationName})",
                      size: Sizes.fontSizeFour,
                      fontWeight: FontWeight.w400,
                    ),
                    Sizes.spaceHeight10,

                    // --- Action Button: Re-book or Reschedule
                    AppBtn(
                      borderRadius: 12,
                      title: isCancelled || !isCancelAllowed
                          ? "Re-book"
                          : "Reschedule",
                      height: Sizes.screenHeight * 0.038,
                      width: Sizes.screenWidth * 0.37,
                      color: AppColor.blue,
                      onTap: () {
                        if (isCancelled || !isCancelAllowed) {
                          // Re-book action
                          Navigator.pushNamed(
                            context,
                            RoutesName.doctorProfileScreen,
                            arguments: {
                              "isNew": true,
                              "doctor_id": appointmentData.doctorId,
                              "clinic_id": appointmentData.clinicId,
                            },
                          );
                        } else {
                          // Reschedule action
                          if (!cancelRescheduleAllowed) {
                            showInfoOverlay(
                                title: "Info",
                                errorMessage:
                                    "Oops! You can’t reschedule appointments less than 1 hour before the scheduled time.");
                            return;
                          }
                          Provider.of<UpdateAppointmentViewModel>(context,
                                  listen: false)
                              .setRescheduleAppointmentID(
                                  appointmentData.appointmentId.toString());
                          Navigator.pushNamed(
                            context,
                            RoutesName.doctorProfileScreen,
                            arguments: {
                              "isNew": false,
                              "doctor_id": appointmentData.doctorId,
                              "clinic_id": "${appointmentData.clinicId}",
                            },
                          );
                        }
                      },
                    ),
                    Sizes.spaceHeight10,
                    // --- Cancel Option if not already cancelled
                    if (isCancelAllowed && !isCancelled)
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            if (cancelRescheduleAllowed) {
                              showCupertinoDialog(
                                context: context,
                                builder: (_) => ActionOverlay(
                                  text: "Cancel Appointment",
                                  subtext:
                                      "Are you sure you want to cancel\n your appointment?",
                                  onTap: () {
                                    Provider.of<CancelAppointmentViewModel>(
                                            context,
                                            listen: false)
                                        .cancelAppointmentApi(
                                            context,
                                            appointmentData.appointmentId
                                                .toString());
                                  },
                                ),
                              );
                            } else {
                              showInfoOverlay(
                                  title: "Info",
                                  errorMessage:
                                      "Oops! You can’t cancellation appointments less than 1 hour before the scheduled time.");
                            }
                          },
                          child: TextConst(
                            "Cancel",
                            color: Colors.red,
                            size: Sizes.fontSizeFive,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    if (isCancelled)
                      Center(
                        child: TextConst(
                          "Cancelled",
                          color: Colors.grey,
                          size: Sizes.fontSizeFive,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool isMoreThanOneHourAway(String bookingDate, String hour24Format) {
    // Combine date and time
    String dateTimeString = "$bookingDate $hour24Format";

    // Parse using the correct format
    DateFormat format = DateFormat("dd-MM-yyyy hh:mm a");
    DateTime bookingDateTime = format.parse(dateTimeString);

    // Get current time
    DateTime now = DateTime.now();

    // Calculate difference
    Duration difference = bookingDateTime.difference(now);

    // Return true if more than 1 hour away
    return difference.inMinutes > 60;
  }
}
