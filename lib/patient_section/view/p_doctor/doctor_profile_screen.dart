// patient_section/view/p_doctor/doctor_profile_screen.dart
import 'dart:ui';
import 'package:aim_swasthya/patient_section/p_view_model/add_review_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/update_appointment_view_model.dart';
import 'package:aim_swasthya/patient_section/view/p_doctor/select_change_clinic_overlay.dart';
import 'package:aim_swasthya/utils/const_config.dart';
import 'package:aim_swasthya/utils/google_map/view_static_location.dart';

import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/patient_section/p_view_model/doctor_avl_appointment_view_model.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../res/appbar_const.dart';
import '../../../res/popUp_const.dart';
import '../../p_view_model/cancelAppointment_view_model.dart';
import '../../p_view_model/user_view_model.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  bool viewAllSlots = false;
  bool isAppointmentReschedule = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map?;
      if (arguments != null) {
        final doctorId = arguments["doctor_id"];
        final clinicId = arguments["clinic_id"];
        final docDCon =
            Provider.of<DoctorAvlAppointmentViewModel>(context, listen: false);
        docDCon.doctorAvlAppointmentApi(doctorId, clinicId, context);
        docDCon.setConfirmDialog(false);
        bool isNewBooking = arguments["isNew"] ?? false;
        setState(() {
          isAppointmentReschedule = !isNewBooking;
        });
      }
    });
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

  void _scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorAvlAppointmentViewModel>(builder: (context, dAVM, _) {
      if (dAVM.loading) {
        return const Scaffold(
          body: Center(
            child: LoadData(),
          ),
        );
      } else if (dAVM.doctorAvlAppointmentModel == null ||
          dAVM.doctorAvlAppointmentModel!.data == null) {
        return const Scaffold(
            // body: ,
            );
      }
      return Scaffold(
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarConst(
                title: isAppointmentReschedule
                    ? "Reschedule appointment"
                    : "Appointment",
              ),
              Sizes.spaceHeight15,
              isAppointmentReschedule
                  ? resDocPersonalDetail()
                  : docPersonalDetail(),
              Sizes.spaceHeight15,
              selectedClinic(),
              if (!isAppointmentReschedule) ...[
                Sizes.spaceHeight25,
                clinicDetails(),
              ],
              Sizes.spaceHeight25,
              slotsSection(),
              if (!isAppointmentReschedule) ...[
                Sizes.spaceHeight35,
                reviewsSection()
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget docPersonalDetail() {
    return Consumer<DoctorAvlAppointmentViewModel>(builder: (context, dAVM, _) {
      final docData = dAVM.doctorAvlAppointmentModel!.data!.details![0];
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: Sizes.screenWidth,
        height: Sizes.screenWidth / 3.4,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              width: Sizes.screenWidth / 2.8,
              height: Sizes.screenWidth / 3.4,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  image: DecorationImage(
                      image: docData.signedImageUrl == null
                          ? const AssetImage(
                              Assets.logoDoctor,
                            )
                          : NetworkImage(docData.signedImageUrl ?? ""),
                      fit: BoxFit.cover)),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextConst(
                        "${docData.experience}",
                        fontWeight: FontWeight.w400,
                        size: Sizes.fontSizeFourPFive,
                        color: AppColor.textGrayColor,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFC700),
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppColor.whiteColor,
                              size: 10,
                            ),
                            Sizes.spaceWidth3,
                            TextConst(
                              "${docData.averageRating}",
                              size: Sizes.fontSizeFourPFive,
                              color: AppColor.whiteColor,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Sizes.spaceHeight3,
                  TextConst(
                    "${docData.doctorName}",
                    fontWeight: FontWeight.w500,
                    size: Sizes.fontSizeSeven,
                  ),
                  Sizes.spaceHeight3,
                  TextConst(
                    "${docData.qualification} (${docData.specializationName})",
                    fontWeight: FontWeight.w400,
                    size: Sizes.fontSizeFourPFive,
                    color: AppColor.textGrayColor,
                  ),
                  Sizes.spaceHeight3,
                  docData.preferredDoctorStatus.toLowerCase() == 'n'
                      ? AppBtn(
                          title: "Add to my doctors",
                          onTap: () {
                            final clinicId = dAVM.doctorAvlAppointmentModel!
                                .data!.clinics![0].clinicId
                                .toString();

                            dAVM.addDoctorToFavApi(
                                docData.doctorId.toString(),
                                clinicId: clinicId,
                                context);
                          },
                          height: Sizes.screenWidth / 14,
                          borderRadius: 8,
                          fontSize: Sizes.fontSizeFour,
                          fontWidth: FontWeight.w400,
                          padding: const EdgeInsets.all(0),
                        )
                      : Container(
                          height: Sizes.screenWidth / 14,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColor.blue)),
                          child: TextConst(
                            "Added to my doctors",
                            color: AppColor.blue,
                            size: Sizes.fontSizeFour,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget selectedClinic() {
    return Consumer<DoctorAvlAppointmentViewModel>(builder: (context, davm, _) {
      final clinicData = davm.doctorAvlAppointmentModel!.data!.clinics![0];
      final otherClinicLength =
          davm.doctorAvlAppointmentModel!.data!.otherClinic!.count ?? 0;
      return ListTile(
        leading: Image.asset(
          Assets.iconsUimClinicMedical,
          width: Sizes.screenWidth / 8,
        ),
        title: TextConst(
          "${clinicData.name}",
          fontWeight: FontWeight.w600,
          size: Sizes.fontSizeFive,
        ),
        subtitle: TextConst(
          clinicData.address!.trimLeft(),
          fontWeight: FontWeight.w400,
          size: Sizes.fontSizeFourPFive,
          color: AppColor.textGrayColor,
        ),
        // ignore: prefer_const_constructors
        trailing: otherClinicLength > 0
            ? GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        return const ChangeClinicOverlay();
                      });
                },
                child: TextConst(
                  "$otherClinicLength more clinics",
                  decoration: TextDecoration.underline,
                  color: AppColor.blue,
                  fontWeight: FontWeight.w400,
                  size: Sizes.fontSizeFour,
                ),
              )
            : const SizedBox.shrink(),
      );
    });
  }

  Widget clinicDetails() {
    return Consumer<DoctorAvlAppointmentViewModel>(builder: (context, dAVM, _) {
      final clinicData = dAVM.doctorAvlAppointmentModel!.data!.clinics![0];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextConst(
              "Clinic Details",
              fontWeight: FontWeight.w500,
              size: Sizes.fontSizeSix,
            ),
            Sizes.spaceHeight20,
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetLocationOnMap(
                            clinicName: clinicData.name.toString(),
                            address: clinicData.address.toString(),
                            latitude:
                                double.parse(clinicData.latitude.toString()),
                            longitude: double.parse(
                                clinicData.longitude.toString()))));
              },
              child: Container(
                height: Sizes.screenHeight / 7,
                width: Sizes.screenWidth,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.red,
                    image: DecorationImage(
                        image: AssetImage(Assets.allImagesViewMap),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter)),
              ),
            ),
            Sizes.spaceHeight20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextConst(
                    "${clinicData.name}",
                    fontWeight: FontWeight.w600,
                    size: Sizes.fontSizeFive,
                  ),
                  Sizes.spaceHeight3,
                  TextConst(
                    clinicData.address!.trimLeft(),
                    fontWeight: FontWeight.w400,
                    size: Sizes.fontSizeFourPFive,
                  ),
                  Sizes.spaceHeight10,
                  TextConst(
                    "Timings",
                    fontWeight: FontWeight.w600,
                    size: Sizes.fontSizeFive,
                  ),
                  Sizes.spaceHeight3,
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.clock,
                        size: 10,
                      ),
                      TextConst(
                        clinicData.city!.trimLeft(),
                        fontWeight: FontWeight.w400,
                        size: Sizes.fontSizeFourPFive,
                      ),
                    ],
                  ),
                  Sizes.spaceHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Config.launchDialer("${clinicData.phoneNumber}");
                        },
                        child: Container(
                          width: Sizes.screenWidth / 1.9,
                          height: 33,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColor.blue)),
                          child: TextConst(
                            "Contact",
                            color: AppColor.blue,
                          ),
                        ),
                      ),
                      Sizes.spaceWidth10,
                      Expanded(
                        child: Container(
                          height: 33,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              // border: Border.all(color: AppColor.blue)
                              color: AppColor.blue),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: const BoxDecoration(
                                    color: AppColor.whiteColor,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5))),
                                child: TextConst(
                                  "Consultation fee",
                                  fontWeight: FontWeight.w600,
                                  size: Sizes.fontSizeTwo * 1.1,
                                  color: AppColor.blue,
                                ),
                              ),
                              Sizes.spaceHeight3,
                              TextConst(
                                "Rs ${clinicData.fee}/-",
                                color: AppColor.white,
                                size: Sizes.fontSizeFourPFive,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget slotsSection() {
    final uAVM =
        Provider.of<UpdateAppointmentViewModel>(context, listen: false);

    return Consumer<DoctorAvlAppointmentViewModel>(builder: (context, dAVM, _) {
      if (dAVM.doctorAvlAppointmentModel == null ||
          dAVM.doctorAvlAppointmentModel!.data == null ||
          dAVM.doctorAvlAppointmentModel!.data!.slots == null ||
          dAVM.doctorAvlAppointmentModel!.data!.slots!.isEmpty) {
        return const Center(
          child: NoDataMessages(
            message: "No slots found for the doctor",
          ),
        );
      }
      final slots = dAVM.doctorAvlAppointmentModel!.data!.slots!;
      final lastIndex = slots.length - 1;
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(slots.length, (i) {
                  final slotData = slots[i];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          dAVM.setSelectedDate(slotData);
                          setState(() {
                            viewAllSlots = false;
                          });
                          Future.delayed(const Duration(milliseconds: 300), () {
                            if (scrollController.hasClients) {
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                              );
                            }
                          });
                        },
                        child: SizedBox(
                            width: Sizes.screenWidth / 4.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextConst(
                                  dAVM.getFormattedDate(
                                      slotData.availabilityDate),
                                  fontWeight: FontWeight.w500,
                                ),
                                TextConst(
                                  "(${slotData.availableSlots} Slots)",
                                  size: Sizes.fontSizeFive,
                                  color: slotData.availableSlots > 10
                                      ? AppColor.lightGreen
                                      : slotData.availableSlots > 5
                                          ? Colors.orange
                                          : Colors.red,
                                ),
                                Sizes.spaceHeight10,
                                Container(
                                  height: 3,
                                  decoration: BoxDecoration(
                                      color: (dAVM.selectedDate!
                                                  .availabilityDate ==
                                              slotData.availabilityDate)
                                          ? AppColor.lightBlue
                                          : AppColor.textfieldGrayColor
                                              .withOpacity(0.5),
                                      borderRadius: i == 0
                                          ? const BorderRadius.only(
                                              topLeft: Radius.circular(3),
                                              bottomLeft: Radius.circular(3))
                                          : i == lastIndex
                                              ? const BorderRadius.only(
                                                  topRight: Radius.circular(3),
                                                  bottomRight:
                                                      Radius.circular(3))
                                              : null),
                                )
                              ],
                            )),
                      ),
                      if (i != lastIndex)
                        Container(
                          height: 3,
                          width: Sizes.screenWidth / 8,
                          decoration: BoxDecoration(
                              color:
                                  AppColor.textfieldGrayColor.withOpacity(0.5)),
                        )
                    ],
                  );
                }),
              ),
            ),
          ),
          Sizes.spaceHeight25,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(dAVM.avlTimeType.length, (i) {
                final timing = dAVM.avlTimeType[i];
                return InkWell(
                  onTap: () {
                    dAVM.setSelectedTimeTypeData(timing);
                    setState(() {
                      viewAllSlots = false;
                    });
                    Future.delayed(const Duration(milliseconds: 300), () {
                      if (scrollController.hasClients) {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                        );
                      }
                    });
                  },
                  child: Container(
                    height: 30,
                    width: Sizes.screenWidth / 3.6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: dAVM.selectedTimeType == timing
                            ? AppColor.blue
                            : AppColor.textfieldGrayColor.withOpacity(0.3)),
                    alignment: Alignment.center,
                    child: TextConst(
                      timing,
                      size: Sizes.fontSizeFive,
                      color: dAVM.selectedTimeType == timing
                          ? AppColor.white
                          : AppColor.textGrayColor,
                    ),
                  ),
                );
              }),
            ),
          ),
          Sizes.spaceHeight35,
          dateWiseTimingGrid(),
          Sizes.spaceHeight30,
          AppBtn(
            title: isAppointmentReschedule
                ? "Reschedule"
                : "Book your appointment",
            onTap: () async {
              if (dAVM.selectedTime == null) {
                Utils.show("Please select time slot to proceed", context);
                return;
              }
              if (isAppointmentReschedule) {
                uAVM.updateAppointmentApi(context,
                    docId: dAVM
                        .doctorAvlAppointmentModel!.data!.details![0].doctorId,
                    clinicId: dAVM
                        .doctorAvlAppointmentModel!.data!.slots![0].clinicId,
                    bookingDate: dAVM.selectedDate!.availabilityDate,
                    timeId: dAVM.selectedTime!.timeId!,
                    appId: uAVM.rescheduleAppointmentData!.appointmentId
                        .toString());
                return;
              }
              final userId = await UserViewModel().getUser();
              final currentDate = DateTime.timestamp();
              dAVM.setRequestData({
                'patient_id': userId,
                "doctor_id": dAVM
                    .doctorAvlAppointmentModel!.data!.details![0].doctorId
                    .toString(),
                "clinic_id": dAVM
                    .doctorAvlAppointmentModel!.data!.clinics![0].clinicId
                    .toString(),
                "booking_date": dAVM.selectedDate!.availabilityDate,
                "time_id": dAVM.selectedTime!.timeId,
                "amount": dAVM.doctorAvlAppointmentModel!.data!.clinics![0].fee,
                "payment_status": "Completed",
                "payment_date": currentDate
              }, context);
            },
            padding: const EdgeInsets.all(0),
            height: 40,
            borderRadius: 10,
          ),
        ],
      );
    });
  }

  dateWiseTimingGrid() {
    return Consumer<DoctorAvlAppointmentViewModel>(builder: (context, dAVM, _) {
      final getSelectedTimeList = dAVM.selectedDate!.availableTime!
          .where((e) =>
              e.timeOfDay.toLowerCase() == dAVM.selectedTimeType.toLowerCase())
          .toList();
      if (getSelectedTimeList.isEmpty) {
        return Center(
          child: ConstText(
            title:
                "No Slots Found for ${dAVM.getFormattedDate(dAVM.selectedDate!.availabilityDate)} ${dAVM.selectedTimeType}",
          ),
        );
      }
      return Column(
        children: [
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 2.8,
            ),
            itemCount: viewAllSlots
                ? getSelectedTimeList.length
                : getSelectedTimeList.length > 8
                    ? 8
                    : getSelectedTimeList.length,
            itemBuilder: (context, index) {
              final appdata = getSelectedTimeList[index];
              String slotTimeStr = appdata.slotTime.toString();
              List<String> timeParts = slotTimeStr.split(':');
              int hour = int.parse(timeParts[0]);
              int minute = int.parse(timeParts[1]);

              String customDateStr =
                  dAVM.selectedDate!.availabilityDate.toString();
              DateTime selectedDate =
                  DateFormat("dd-MM-yyyy").parse(customDateStr);
              DateTime selectedDateLocal = selectedDate.toLocal();

              DateTime slotDateTime = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                hour,
                minute,
              );

              DateTime now = DateTime.now();
              bool isPast = slotDateTime.isBefore(now);

              debugPrint("Combined Slot Time: $slotDateTime");
              debugPrint("Is Past: $isPast");
              return GestureDetector(
                onTap: () {
                  if (isPast) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              "Looks like this time has already passed. Try picking a later slot!")),
                    );
                  } else if (appdata.slotAvailableFlag!.toLowerCase() ==
                      "scheduled") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              "Looks like this time has already booked. Try picking another slot!")),
                    );
                  } else {
                    dAVM.setSelectedTimeData(appdata);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: (dAVM.selectedTime != null &&
                            dAVM.selectedTime!.timeId == appdata.timeId)
                        ? Border.all(color: AppColor.blue)
                        : null,
                    borderRadius: BorderRadius.circular(6),
                    color: isPast ||
                            appdata.slotAvailableFlag!.toLowerCase() != "open"
                        ? Colors.grey.shade300
                        : appdata.slotAvailableFlag.toLowerCase() == 'open'
                            ? AppColor.lightSkyBlue.withOpacity(0.2)
                            : const Color(0xffececec),
                  ),
                  child: TextConst(
                    appdata.slotTime.toString(),
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
          Sizes.spaceHeight20,
          if (!viewAllSlots && getSelectedTimeList.length > 8)
            GestureDetector(
              onTap: () {
                setState(() {
                  viewAllSlots = true;
                });
              },
              child: TextConst(
                "View All Slots",
                color: AppColor.lightBlue,
                fontWeight: FontWeight.w500,
                size: Sizes.fontSizeFour,
              ),
            )
        ],
      );
    });
  }

  Widget reviewsSection() {
    return Consumer<DoctorAvlAppointmentViewModel>(builder: (context, dAVM, _) {
      final reviewData = dAVM.doctorAvlAppointmentModel!.data!.reviews;
      final averageRating =
          dAVM.doctorAvlAppointmentModel!.data!.details![0].averageRating;
      final docID =
          dAVM.doctorAvlAppointmentModel!.data!.details![0].doctorId.toString();
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: Sizes.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextConst(
              "Patient stories (${reviewData!.length}+)",
              fontWeight: FontWeight.w500,
              size: Sizes.fontSizeSix,
            ),
            Sizes.spaceHeight20,
            rateDoctor(averageRating.toString(), docID),
            Sizes.spaceHeight10,
            ListView.builder(
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: reviewData.length,
                itemBuilder: (context, int i) {
                  final review = reviewData[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.lightSkyBlue.withOpacity(0.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const CircleAvatar(
                            backgroundImage:
                                AssetImage(Assets.iconsProfileIcon),
                          ),
                          title: TextConst(
                            "${review.name}",
                            fontWeight: FontWeight.w500,
                            size: Sizes.fontSizeFive,
                          ),
                          subtitle: TextConst(
                            "7 week ago",
                            size: Sizes.fontSizeFour,
                            color: AppColor.textGrayColor,
                          ),
                          trailing: SizedBox(
                            width: 30,
                            height: 20,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: CupertinoColors.systemYellow,
                                  size: 12,
                                ),
                                Sizes.spaceWidth3,
                                TextConst(
                                  "${review.rating}",
                                  size: Sizes.fontSizeFourPFive,
                                  color: AppColor.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, bottom: 10),
                          child: TextConst(
                            textAlign: TextAlign.left,
                            "${review.review}",
                            size: Sizes.fontSizeFourPFive,
                            color: AppColor.textfieldTextColor,
                          ),
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      );
    });
  }

  Widget rateDoctor(String averageRating, String docID) {
    const fieldBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    );
    return Consumer<AddReviewViewModel>(builder: (context, aRVM, _) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: AppColor.grey),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Sizes.screenWidth / 4.5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextConst(
                    averageRating,
                    size: Sizes.fontSizeNine,
                    color: AppColor.black,
                  ),
                  Sizes.spaceWidth5,
                  Icon(
                    Icons.star,
                    color: CupertinoColors.systemYellow,
                    size: Sizes.fontSizeTen * 1.2,
                  ),
                  Sizes.spaceWidth3,
                ],
              ),
            ),
            SizedBox(
              width: Sizes.screenWidth / 1.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextConst(
                        "Rate your experience",
                        size: Sizes.fontSizeFour,
                        color: AppColor.textGrayColor,
                      ),
                      Sizes.spaceWidth10,
                      ...List.generate(5, (i) {
                        return GestureDetector(
                          onTap: () {
                            aRVM.updateRatingValue(i);
                          },
                          child: Icon(
                            Icons.star,
                            color: (i + 1) <= aRVM.ratingValue
                                ? CupertinoColors.systemYellow
                                : AppColor.textGrayColor,
                            size: Sizes.fontSizeSix,
                          ),
                        );
                      })
                    ],
                  ),
                  const Divider(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        height: Sizes.screenHeight / 12,
                        child: TextField(
                          controller: _controller,
                          maxLines: 5,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.fontSizeFour),
                          decoration: const InputDecoration(
                              hintText: '',
                              border: fieldBorder,
                              enabledBorder: fieldBorder,
                              focusedBorder: fieldBorder,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              isCollapsed: true,
                              filled: true,
                              fillColor: Colors.white),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      if (_controller.text.isEmpty)
                        Center(
                          child: TextConst(
                            'Enter your text here',
                            textAlign: TextAlign.center,
                            size: Sizes.fontSizeFour,
                            color: AppColor.textGrayColor,
                          ),
                        ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            aRVM.addReviewApi(docID, aRVM.ratingValue,
                                "not avl", _controller.text, context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Colors.lightBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  /// reschedule appointment cases:

  Widget appointmentDateTimeWithStatus() {
    return Consumer<UpdateAppointmentViewModel>(builder: (context, uAVM, _) {
      final appointmentData = uAVM.rescheduleAppointmentData!;
      DateTime dateTime =
          DateFormat('dd-MM-yyyy').parse(appointmentData.bookingDate!);
      final formattedDate = DateFormat('d MMMM').format(dateTime);
      return SizedBox(
        width: Sizes.screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              width: Sizes.screenWidth / 2.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.blue,
              ),
              child: TextConst(
                appointmentData.status == 'scheduled'
                    ? "Appointment Reschedule"
                    : appointmentData.status,
                color: AppColor.white,
                size: Sizes.fontSizeFour,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Image.asset(Assets.iconsCalander,
                    color: Colors.grey, width: Sizes.screenWidth * 0.05),
                Sizes.spaceWidth5,
                TextConst(formattedDate,
                    size: Sizes.fontSizeFive, fontWeight: FontWeight.w500),
                Sizes.spaceWidth10,
                const Icon(Icons.watch_later_outlined,
                    color: Colors.grey, size: 20),
                Sizes.spaceWidth5,
                TextConst(appointmentData.hour24Format!,
                    size: Sizes.fontSizeFive, fontWeight: FontWeight.w500),
              ],
            ),
          ],
        ),
      );
    });
  }

  resDocPersonalDetail() {
    return Consumer<DoctorAvlAppointmentViewModel>(builder: (context, dAVM, _) {
      final docData = dAVM.doctorAvlAppointmentModel!.data!.details![0];
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: Sizes.screenWidth,
        // height: Sizes.screenWidth / 2,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            appointmentDateTimeWithStatus(),
            Sizes.spaceHeight10,
            Row(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: Sizes.screenWidth / 2.4,
                      height: Sizes.screenWidth / 2.6,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: docData.signedImageUrl == null
                                  ? const AssetImage(
                                      Assets.logoDoctor,
                                    )
                                  : NetworkImage(docData.signedImageUrl ?? ""),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      top: 8,
                      right: 18,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 2),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFC700),
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppColor.whiteColor,
                              size: 10,
                            ),
                            Sizes.spaceWidth3,
                            TextConst(
                              "${docData.averageRating}",
                              size: Sizes.fontSizeFour,
                              color: AppColor.whiteColor,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextConst(
                            "${docData.experience}",
                            fontWeight: FontWeight.w400,
                            size: Sizes.fontSizeFourPFive,
                            color: AppColor.textGrayColor,
                          ),
                        ],
                      ),
                      Sizes.spaceHeight3,
                      TextConst(
                        "${docData.doctorName}",
                        fontWeight: FontWeight.w500,
                        size: Sizes.fontSizeSeven,
                      ),
                      Sizes.spaceHeight3,
                      TextConst(
                        "${docData.qualification} (${docData.specializationName})",
                        fontWeight: FontWeight.w400,
                        size: Sizes.fontSizeFourPFive,
                        color: AppColor.textGrayColor,
                      ),
                      Sizes.spaceHeight5,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColor.grey)),
                        child: TextConst(
                          textAlign: TextAlign.center,
                          "Please select a new slot to\nreschedule this appointment",
                          color: AppColor.textGrayColor,
                          size: Sizes.fontSizeFour,
                        ),
                      ),
                      Sizes.spaceHeight5,
                      AppBtn(
                        title: "Cancel appointment",
                        onTap: () {
                          final uAVM = Provider.of<UpdateAppointmentViewModel>(
                              context,
                              listen: false);

                          if (isMoreThanOneHourAway(
                              uAVM.rescheduleAppointmentData!.bookingDate
                                  .toString(),
                              uAVM.rescheduleAppointmentData!.hour24Format
                                  .toString())) {
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
                                          uAVM.rescheduleAppointmentData!
                                              .appointmentId
                                              .toString());
                                },
                              ),
                            );
                          }
                        },
                        height: Sizes.screenWidth / 14,
                        borderRadius: 8,
                        color: Color(0xffC10000),
                        fontSize: Sizes.fontSizeFour,
                        fontWidth: FontWeight.w500,
                        padding: const EdgeInsets.all(0),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}

// class DoctorProfileScreen extends StatefulWidget {
//   const DoctorProfileScreen({super.key});

//   @override
//   State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
// }

// class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
//   dynamic selectedAvlDate;

//   bool isReschedule = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final arguments = ModalRoute.of(context)!.settings.arguments as Map?;
//       if (arguments != null) {
//         final doctorId = arguments["doctor_id"];
//         final clinicId = arguments["clinic_id"];
//         final docDCon =
//             Provider.of<DoctorAvlAppointmentViewModel>(context, listen: false);
//         docDCon.doctorAvlAppointmentApi(doctorId, clinicId, context);
//         docDCon.setConfirmDailog(false);
//         bool isNewBooking = arguments["isNew"] ?? false;
//         setState(() {
//           isReschedule = !isNewBooking;
//         });
//       }
//     });
//   }

// void _scrollToTop() {
//   scrollController.animateTo(
//     0.0, // Top of the list
//     duration: const Duration(milliseconds: 500),
//     curve: Curves.easeInOut,
//   );
// }
//
// @override
// void dispose() {
//   scrollController.dispose();
//   super.dispose();
// }

// void launchDialer(String phoneNumber) async {
//   final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
//   if (await canLaunchUrl(phoneUri)) {
//     await launchUrl(phoneUri);
//   } else {
//     throw 'Could not launch $phoneUri';
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     final arguments =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
//     bool isNewBooking = arguments["isNew"] ?? false;
//     final appData = Provider.of<DoctorAvlAppointmentViewModel>(context);
//     final docAppointmentCon =
//         Provider.of<DoctorAvlAppointmentViewModel>(context);
//     return Scaffold(
//       body: docAppointmentCon.doctorAvlAppointmentModel == null ||
//               docAppointmentCon.doctorAvlAppointmentModel!.data == null
//           ? const Center(child: LoadData())
//           : SingleChildScrollView(
//               controller: scrollController,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   appBarContainer(),
//                   if (isNewBooking == true) patientReview(),
//                   Sizes.spaceHeight30,
//                   clinicDetails(),
//                   SizedBox(
//                     height: Sizes.screenHeight * 0.055,
//                   ),
//                   SizedBox(
//                     height: Sizes.screenHeight * 0.055,
//                   ),
//                   slotsList(),
//                   Sizes.spaceHeight35,
//                   selectTime(),
//                   Sizes.spaceHeight25,
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget appBarContainer() {
//     final arguments =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
//     bool isNewBooking = arguments["isNew"] ?? false;
//     final clinicId = arguments["clinic_id"];
//     final doctorId = arguments["doctor_id"];
// final docAppointmentCon =
//     Provider.of<DoctorAvlAppointmentViewModel>(context);
//     final addDoctor = Provider.of<AddDoctorViewModel>(context);
//     return Container(
//       width: Sizes.screenWidth,
//       decoration: BoxDecoration(
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(30),
//             bottomRight: Radius.circular(30),
//           ),
//           gradient: const LinearGradient(
//             colors: [AppColor.naviBlue, AppColor.blue],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           image: isNewBooking == true
//               ? const DecorationImage(
//                   image: AssetImage(Assets.imagesProfileLine),
//                   alignment: Alignment(0.9, 0.2),
//                   fit: BoxFit.contain,
//                 )
//               : null),
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.bottomCenter,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Stack(
//                 clipBehavior: Clip.none,
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: Sizes.screenHeight * 0.07,
//                         right: Sizes.screenWidth * 0.03),
//                     child: Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             topRight: Radius.circular(30),
//                             bottomLeft: Radius.circular(30),
//                           ),
//                           child: docAppointmentCon.doctorAvlAppointmentModel!
//                                       .data!.details![0].signedImageUrl !=
//                                   null
//                               ? Image.network(
//                                   docAppointmentCon.doctorAvlAppointmentModel!
//                                       .data!.details![0].signedImageUrl
//                                       .toString(),
//                                   height: kToolbarHeight * 2.6,
//                                   width: kToolbarHeight * 2.9,
//                                   fit: BoxFit.cover,
//                                 )
//                               : const Image(
//                                   image: AssetImage(Assets.logoDoctor),
//                                   height: kToolbarHeight * 2.6,
//                                   width: kToolbarHeight * 2.9,
//                                   fit: BoxFit.cover,
//                                 ),
//                         ),
//                         Sizes.spaceWidth15,
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             TextConst(
//                               docAppointmentCon.doctorAvlAppointmentModel!.data!
//                                       .details![0].doctorName ??
//                                   "",
//                               size: Sizes.fontSizeSix,
//                               fontWeight: FontWeight.w500,
//                               color: AppColor.white,
//                             ),
//                             SizedBox(
//                               width: Sizes.screenWidth * 0.5,
//                               child: TextConst(
//                                 overflow: TextOverflow.ellipsis,
//                                 "${docAppointmentCon.doctorAvlAppointmentModel!.data!.details![0].qualification ?? ""} (${docAppointmentCon.doctorAvlAppointmentModel!.data!.details![0].specializationName ?? ""})",
//                                 size: Sizes.fontSizeFive,
//                                 color: AppColor.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                       bottom: -30,
//                       child: ClipRect(
//                         child: BackdropFilter(
//                           filter: ImageFilter.blur(
//                             sigmaX: 5,
//                             sigmaY: 5,
//                           ),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: Sizes.screenWidth * 0.02,
//                                 vertical: Sizes.screenHeight * 0.01),
//                             width: Sizes.screenWidth * 0.9,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: const Color(0xffE3E3E3).withOpacity(0.6),
//                                 border: Border.all(
//                                     color: AppColor.lightSkyBlue, width: 0.5)),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Row(
//                                   children: [
//                                     const Image(
//                                       image: AssetImage(
//                                           Assets.imagesMaterialSymbol),
//                                       height: 30,
//                                     ),
//                                     SizedBox(
//                                       width: Sizes.screenWidth * 0.17,
//                                       child: TextConst(
//                                         docAppointmentCon
//                                                 .doctorAvlAppointmentModel!
//                                                 .data!
//                                                 .details![0]
//                                                 .experience ??
//                                             "",
//                                         size: Sizes.fontSizeFour,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                   width: 0.5,
//                                   height: 30,
//                                   color: Colors.grey.shade500,
//                                 ),
//                                 Row(
//                                   children: [
//                                     const Image(
//                                       image:
//                                           AssetImage(Assets.imagesCarbonStar),
//                                       height: 25,
//                                     ),
//                                     Sizes.spaceWidth5,
//                                     Column(
//                                       children: [
//                                         starRatings(
//                                           averageRating: double.parse(
//                                               docAppointmentCon
//                                                   .doctorAvlAppointmentModel!
//                                                   .data!
//                                                   .details![0]
//                                                   .averageRating
//                                                   .toString()),
//                                           size: 12.0,
//                                         ),
//                                         // starRating(
//                                         //   initialRating: 4,
//                                         //   size: 12.0,
//                                         //   onRatingChanged: (rating) {
//                                         //     print('New Rating: $rating');
//                                         //   },
//                                         // ),
//                                         // const StarRating(
//                                         //   initialRating: 4,
//                                         //   size: 12.0,
//                                         // ),
//                                         TextConst(
//                                           "${docAppointmentCon.doctorAvlAppointmentModel!.data!.details![0].reviewCount}+ Reviews",
//                                           // "100+ Reviews",
//                                           size: Sizes.fontSizeFour,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                   width: 0.5,
//                                   height: 30,
//                                   // color: Colors.grey.shade500,
//                                   color: Colors.grey.shade500,
//                                 ),
//                                 docAppointmentCon
//                                             .doctorAvlAppointmentModel!
//                                             .data!
//                                             .details![0]
//                                             .preferredDoctorStatus
//                                             ?.toLowerCase() ==
//                                         "Y".toLowerCase()
//                                     ? AddButton(
//                                         fontSize: Sizes.screenWidth / 60,
//                                         color: AppColor.white.withOpacity(0.9),
//                                         width: Sizes.screenWidth / 3.8,
//                                         height: Sizes.screenHeight * 0.035,
//                                         title: "Preferred Doctor!",
//                                         onTap: () {},
//                                       )
//                                     : GestureDetector(
//                                         onTap: () {
//                                           addDoctor.addDoctorApi(
//                                             doctorId,
//                                             context,
//                                             clinicId: clinicId,
//                                           );
//                                         },
//                                         child: Align(
//                                           alignment: Alignment.center,
//                                           child: AddButton(
//                                             fontSize: Sizes.screenWidth / 60,
//                                             color:
//                                                 AppColor.white.withOpacity(0.9),
//                                             width: Sizes.screenWidth / 3.8,
//                                             height: Sizes.screenHeight * 0.035,
//                                             title: "Add to your doctors",
//                                             // onTap: () {
//                                             //   addDoctor.addDoctorApi(
//                                             //     docAppointmentCon
//                                             //         .doctorAvlAppointmentModel!
//                                             //         .data!
//                                             //         .details![0]
//                                             //         .doctorId
//                                             //         .toString(),
//                                             //     context,
//                                             //     clinicId: docAppointmentCon
//                                             //         .doctorAvlAppointmentModel!
//                                             //         .data!
//                                             //         .location![0]
//                                             //         .clinicId
//                                             //         .toString(),
//                                             //   );
//                                             // },
//                                           ),
//                                         ),
//                                       )
//                               ],
//                             ),
//                           ),
//                         ),
//                       )),
//                 ],
//               ),
//               if (docAppointmentCon.showConfirmDailog) appointmentData()
//             ],
//           ),
//           Positioned(
//               top: 50,
//               left: -5,
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(Icons.arrow_back),
//                 color: AppColor.white,
//               )),
//           if (docAppointmentCon
//                   .doctorAvlAppointmentModel!.data!.details![0].topRated
//                   .toString()
//                   .toLowerCase() ==
//               'y')
//             Positioned(
//                 top: 70,
//                 left: 120,
//                 child: Column(
//                   children: [
//                     proContainer(AppColor.lightGreen, 'Top choice',
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 5, vertical: 3))
//                   ],
//                 )),
//         ],
//       ),
//     );
//   }

//   Widget proContainer(Color color, dynamic label,
//       {EdgeInsetsGeometry? padding}) {
//     return Container(
//       padding: padding ?? const EdgeInsets.symmetric(horizontal: 1),
//       height: Sizes.screenHeight * 0.02,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(3),
//         color: color,
//       ),
//       child: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Image(
//               image: AssetImage(Assets.iconsCheck),
//               height: 10,
//               width: 10,
//               fit: BoxFit.cover,
//             ),
//             Sizes.spaceWidth3,
//             // Sizes.spaceWidth5,
//             TextConst(
//               label,
//               size: Sizes.fontSizeTwo,
//               fontWeight: FontWeight.w400,
//               color: AppColor.white,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   String _convertTo24Hour(String time12h) {
//     final format = DateFormat.jm();
//     final dateTime = format.parse(time12h);
//     return DateFormat("HH:mm:ss").format(dateTime);
//   }

//   bool isTimeLessThanOneHour(String hour24Format) {
//     // Parse the string to DateTime
//     final now = DateTime.now();

//     // Use today's date + parsed time
//     final inputTime = DateTime.parse(
//       "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} "
//       "${_convertTo24Hour(hour24Format)}",
//     );

//     final difference = inputTime.difference(now).inMinutes;

//     return difference >= 0 && difference <= 60;
//   }

//   int currentRatingIndex = 0;
//   final PageController pageController = PageController();
//   Widget patientReview() {
//     final docAppointmentCon =
//         Provider.of<DoctorAvlAppointmentViewModel>(context);
//     if (docAppointmentCon.doctorAvlAppointmentModel!.data!.reviews == null ||
//         docAppointmentCon.doctorAvlAppointmentModel!.data!.reviews!.isEmpty) {
//       return Center(
//           child: Container(
//               alignment: Alignment.bottomCenter,
//               height: Sizes.screenHeight * 0.08,
//               child: const ConstText(title: "No Review founds")));
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: Sizes.screenHeight * 0.07,
//         ),
//         TextConst(
//           padding: const EdgeInsets.only(left: 15),
//           AppLocalizations.of(context)!.patient_reviews,
//           size: Sizes.fontSizeFivePFive,
//           fontWeight: FontWeight.w400,
//         ),
//         Sizes.spaceHeight15,
//         SizedBox(
//           height: Sizes.screenHeight * 0.15,
//           width: Sizes.screenWidth,
//           child: PageView.builder(
//             controller: pageController,
//             itemCount: docAppointmentCon
//                 .doctorAvlAppointmentModel!.data!.reviews!.length,
//             onPageChanged: (index) {
//               setState(() {
//                 currentRatingIndex = index;
//               });
//             },
//             itemBuilder: (BuildContext context, int index) {
//               final appData = docAppointmentCon
//                   .doctorAvlAppointmentModel!.data!.reviews![index];
//               return Container(
//                 margin: const EdgeInsets.only(left: 14, right: 10),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: Sizes.screenWidth * 0.03,
//                   vertical: Sizes.screenHeight * 0.008,
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: const Color(0xffececec),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         showCupertinoDialog(
//                             context: context,
//                             builder: (context) {
//                               return addReviews();
//                             });
//                       },
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Row(
//                             children: [
//                               TextConst(
//                                 appData.rating.toString(),
//                                 size: Sizes.fontSizeSeven,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               Sizes.spaceWidth3,
//                               const Icon(
//                                 Icons.star,
//                                 color: Color(0xffFFE500),
//                                 size: 25,
//                               )
//                             ],
//                           ),
//                           TextConst(
//                             "Write a review",
//                             size: Sizes.fontSizeFour,
//                             fontWeight: FontWeight.w400,
//                           )
//                         ],
//                       ),
//                     ),
//                     const VerticalDivider(
//                       color: Colors.grey,
//                       thickness: 1,
//                       indent: 3,
//                       endIndent: 3,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(7),
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: AppColor.lightBlue,
//                               ),
//                               child: Center(
//                                 child: TextConst(
//                                   appData.name != null &&
//                                           appData.name!.isNotEmpty
//                                       ? appData.name![0].toUpperCase()
//                                       : "",
//                                   color: AppColor.white,
//                                   size: Sizes.fontSizeFourPFive,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             Sizes.spaceWidth5,
//                             TextConst(
//                               appData.name ?? "",
//                               size: Sizes.fontSizeFourPFive,
//                               fontWeight: FontWeight.w400,
//                               color: AppColor.black,
//                             )
//                           ],
//                         ),
//                         TextConst(
//                           appData.consultedFor ?? "",
//                           size: Sizes.fontSizeFour,
//                           fontWeight: FontWeight.w500,
//                           color: AppColor.black,
//                         ),
//                         Sizes.spaceHeight3,
//                         SizedBox(
//                           width: Sizes.screenWidth * 0.6,
//                           child: TextConst(
//                             appData.review ?? "",
//                             size: Sizes.fontSizeThree,
//                             fontWeight: FontWeight.w400,
//                             color: AppColor.black,
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         Sizes.spaceHeight10,
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   docAppointmentCon.doctorAvlAppointmentModel!.data!.reviews!
//                               .length <
//                           5
//                       ? docAppointmentCon
//                           .doctorAvlAppointmentModel!.data!.reviews!.length
//                       : 5,
//                   (i) {
//                     return Container(
//                       height: 7,
//                       width: 7,
//                       margin: const EdgeInsets.only(left: 5),
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: currentRatingIndex == i
//                               ? AppColor.blue
//                               : Colors.grey),
//                     );
//                   },
//                 )),
//             if (docAppointmentCon
//                     .doctorAvlAppointmentModel!.data!.reviews!.length >
//                 5)
//               Padding(
//                 padding: const EdgeInsets.only(left: 3, right: 5, top: 1.5),
//                 child: TextConst(
//                   " +${docAppointmentCon.doctorAvlAppointmentModel!.data!.reviews!.length - 5}",
//                   size: Sizes.fontSizeThree,
//                 ),
//               )
//           ],
//         )
//       ],
//     );
//   }

//   Widget clinicDetails() {
//     final appData = Provider.of<DoctorAvlAppointmentViewModel>(context);
//     if (appData.doctorAvlAppointmentModel!.data!.location == null ||
//         appData.doctorAvlAppointmentModel!.data!.location == [] ||
//         appData.doctorAvlAppointmentModel!.data!.location!.isEmpty) {
//       return const SizedBox();
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextConst(
//           padding: const EdgeInsets.only(left: 15),
//           AppLocalizations.of(context)!.clinic_details,
//           size: Sizes.fontSizeFivePFive,
//           fontWeight: FontWeight.w400,
//         ),
//         Sizes.spaceHeight15,
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.04),
//           padding: const EdgeInsets.all(1),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             gradient: LinearGradient(
//               colors: [
//                 AppColor.conLightBlue.withOpacity(0.6),
//                 AppColor.darkBlack.withOpacity(0.6)
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 4,
//                 offset: const Offset(2, 4),
//               ),
//             ],
//           ),
//           child: Container(
//             padding: EdgeInsets.only(
//                 left: Sizes.screenWidth * 0.04,
//                 right: Sizes.screenWidth * 0.04,
//                 top: Sizes.screenHeight * 0.01,
//                 bottom: Sizes.screenHeight * 0.01),
//             // height: Sizes.screenHeight * 0.3,
//             width: Sizes.screenWidth,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: const Color(0xffececec),
//               // color: AppColor.textfieldGrayColor,
//             ),
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     print("Anshika");
//                     openGoogleMap(
//                         double.parse(appData.doctorAvlAppointmentModel!.data!
//                             .location![0].latitude
//                             .toString()),
//                         double.parse(appData.doctorAvlAppointmentModel!.data!
//                             .location![0].longitude
//                             .toString()));
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     height: Sizes.screenHeight / 6,
//                     child: IgnorePointer(
//                       child: GetLocationOnMap(
//                           latitude: double.parse(appData
//                               .doctorAvlAppointmentModel!
//                               .data!
//                               .location![0]
//                               .latitude
//                               .toString()),
//                           longitude: double.parse(appData
//                               .doctorAvlAppointmentModel!
//                               .data!
//                               .location![0]
//                               .longitude
//                               .toString())),
//                     ),
//                   ),
//                 ),
//                 Sizes.spaceHeight10,
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.only(right: 10),
//                       decoration: const BoxDecoration(
//                         // color: Colors.red,
//                         border: Border(
//                           top: BorderSide.none,
//                           left: BorderSide.none,
//                           bottom: BorderSide.none,
//                           right: BorderSide(
//                             color: Colors.grey,
//                             width: 0.5,
//                           ),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: Sizes.screenWidth * 0.66,
//                             child: TextConst(
//                               overflow: TextOverflow.ellipsis,
//                               "${appData.doctorAvlAppointmentModel!.data!.location![0].address},"
//                               "${appData.doctorAvlAppointmentModel!.data!.location![0].city},"
//                               "${appData.doctorAvlAppointmentModel!.data!.location![0].postalCode}",
//                               size: Sizes.fontSizeFivePFive,
//                               fontWeight: FontWeight.w400,
//                               color: AppColor.black,
//                             ),
//                           ),
//                           SizedBox(
//                             height: Sizes.screenHeight * 0.002,
//                           ),
//                           TextConst(
//                             "${appData.doctorAvlAppointmentModel!.data!.location![0].startTime} - ${appData.doctorAvlAppointmentModel!.data!.location![0].endTime}",
//                             size: Sizes.fontSizeFour,
//                             fontWeight: FontWeight.w400,
//                             color: AppColor.black,
//                           ),
//                           Sizes.spaceHeight5,
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: Sizes.screenHeight * 0.01,
//                                 horizontal: Sizes.screenWidth * 0.02),
//                             decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: AppColor.black.withOpacity(0.2),
//                                       offset: const Offset(0, 1),
//                                       spreadRadius: 0,
//                                       blurRadius: 2)
//                                 ],
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: AppColor.white),
//                             child: Center(
//                                 child: TextConst(
//                               "${appData.doctorAvlAppointmentModel!.data!.location![0].consultationFeeType ?? ""}: ${appData.doctorAvlAppointmentModel!.data!.location![0].consultationFee ?? ""}",
//                               size: Sizes.fontSizeFourPFive,
//                               fontWeight: FontWeight.w500,
//                               color: AppColor.black,
//                             )),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: Sizes.screenWidth * 0.01),
//                     GestureDetector(
//                       onTap: () {
//                         final phone = appData.doctorAvlAppointmentModel!.data!
//                             .details![0].phoneNumber
//                             .toString();
//                         if (phone.isNotEmpty) {
//                           launchDialer(phone);
//                         } else {
//                           print("No phone number available.");
//                         }
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(1.1),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           gradient: LinearGradient(
//                             colors: [
//                               AppColor.conLightBlue,
//                               AppColor.darkBlack.withOpacity(0.5)
//                             ],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               spreadRadius: 2,
//                               blurRadius: 2,
//                             ),
//                           ],
//                         ),
//                         child: Container(
//                           padding: EdgeInsets.all(Sizes.screenWidth / 39),
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AppColor.lightBlue,
//                           ),
//                           child: const Icon(
//                             Icons.call,
//                             color: AppColor.white,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   Widget slotsList() {
//     final docAppointmentCon =
//         Provider.of<DoctorAvlAppointmentViewModel>(context);
//     // List<String> weekdays = getWeekdaysForNextWeek();
//     if (docAppointmentCon.doctorAvlAppointmentModel!.data!.slots == null ||
//         docAppointmentCon.doctorAvlAppointmentModel!.data!.slots!.isEmpty) {
//       return const SizedBox.shrink();
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextConst(
//           padding: const EdgeInsets.only(left: 15),
//           AppLocalizations.of(context)!.available_slots,
//           size: Sizes.fontSizeFivePFive,
//           fontWeight: FontWeight.w400,
//         ),
//         Sizes.spaceHeight15,
//         Consumer<DoctorAvlAppointmentViewModel>(
//             builder: (context, docAppCon, _) {
//           if (docAppCon.doctorAvlAppointmentModel!.data!.slots == null) {
//             return const NoDataMessages(
//               title: "No slots found for the doctor",
//               message: "No available slots for this doctor at the moment.",
//             );
//             const ConstText(title: "No slots found for the doctor");
//           }
//           return SizedBox(
//             height: Sizes.screenHeight * 0.095,
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: docAppointmentCon
//                   .doctorAvlAppointmentModel!.data!.slots!.length,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 final docAppointment = docAppointmentCon
//                     .doctorAvlAppointmentModel!.data!.slots![index];
//                 DateTime dateTime =
//                     DateTime.parse(docAppointment.availabilityDate.toString());
//                 String formattedDate = DateFormat('d MMM').format(dateTime);
//                 return BorderContainer(
//                   margin: EdgeInsets.only(
//                     left: index == 0
//                         ? Sizes.screenWidth * 0.04
//                         : Sizes.screenWidth * 0.03,
//                     right: index ==
//                             docAppointmentCon.doctorAvlAppointmentModel!.data!
//                                     .slots!.length -
//                                 1
//                         ? Sizes.screenWidth * 0.03
//                         : Sizes.screenWidth * 0.012,
//                   ),
//                   padding: const EdgeInsets.all(1),
//                   child: Container(
//                       width: Sizes.screenWidth * 0.14,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: AppColor.white,
//                       ),
//                       child: Column(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               docAppointmentCon.setSelectedDate(docAppointment);
//                               Future.delayed(const Duration(milliseconds: 300),
//                                   () {
//                                 if (scrollController.hasClients) {
//                                   scrollController.animateTo(
//                                     scrollController.position.maxScrollExtent,
//                                     duration: const Duration(milliseconds: 500),
//                                     curve: Curves.easeOut,
//                                   );
//                                 }
//                               });
//                             },
//                             child: BorderContainer(
//                               padding: const EdgeInsets.only(bottom: 1),
//                               child: Container(
//                                 height: Sizes.screenHeight * 0.049,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     color: AppColor.lightBlue),
//                                 child: Center(
//                                     child: TextConst(
//                                   (docAppointment.day?.substring(0, 3) ?? ""),
//                                   color: docAppointmentCon.selectedDate!.day ==
//                                           docAppointment.day
//                                       ? AppColor.black
//                                       : AppColor.white,
//                                   size: Sizes.fontSizeFivePFive,
//                                   fontWeight: FontWeight.w500,
//                                 )),
//                               ),
//                             ),
//                           ),
//                           Sizes.spaceHeight5,
//                           TextConst(
//                             formattedDate,
//                             size: Sizes.fontSizeFive,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ],
//                       )),
//                 );
//               },
//             ),
//           );
//         }),
//       ],
//     );
//   }

//   final scrollController = ScrollController();
//   Widget selectTime() {
//     String currentDate = DateTime.now().toString().split(' ')[0];
//     return Consumer<DoctorAvlAppointmentViewModel>(
//         builder: (context, docAppCon, _) {
//       if (docAppCon.doctorAvlAppointmentModel!.data!.slots == null ||
//           docAppCon.doctorAvlAppointmentModel!.data!.slots!.isEmpty ||
//           docAppCon.selectedDate == null) {
//         return const Center(
//           child: NoDataMessages(
//             title: "No slots found for the doctor",
//             message: "No available slots for this doctor at the moment.",
//           ),
//         );
//       }
//       final getSelectedTimeList = docAppCon
//           .doctorAvlAppointmentModel!.data!.slots!
//           .where((e) => e.day == docAppCon.selectedDate!.day)
//           .first
//           .availableTime!
//           .where((e) => e.timeOfDay == docAppCon.selectedMonth.toString())
//           .toList();
//       return StatefulBuilder(
//         builder: (context, setState) => Container(
//           padding: EdgeInsets.symmetric(
//               horizontal: Sizes.screenWidth * 0.03,
//               vertical: Sizes.screenHeight * 0.012),
//           margin: const EdgeInsets.all(10),
//           width: Sizes.screenWidth,
//           decoration: BoxDecoration(
//               color: const Color(0xffececec),
//               borderRadius: BorderRadius.circular(15)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextConst(
//                 AppLocalizations.of(context)!.select_time,
//                 size: Sizes.fontSizeFivePFive,
//                 fontWeight: FontWeight.w400,
//               ),
//               Sizes.spaceHeight20,
//               Center(
//                 child: BorderContainer(
//                   radius: 50,
//                   padding: const EdgeInsets.only(
//                       left: 1, right: 1, top: 1, bottom: 0.5),
//                   child: Container(
//                     height: Sizes.screenHeight * 0.035,
//                     width: Sizes.screenWidth * 0.83,
//                     decoration: BoxDecoration(
//                         color: AppColor.blue,
//                         borderRadius: BorderRadius.circular(20)),
//                     child: Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             docAppCon.setSelectedMonthData(avlTimeType.Morning);
//                             Future.delayed(const Duration(milliseconds: 300),
//                                 () {
//                               if (scrollController.hasClients) {
//                                 scrollController.animateTo(
//                                   scrollController.position.maxScrollExtent,
//                                   duration: const Duration(milliseconds: 500),
//                                   curve: Curves.easeOut,
//                                 );
//                               }
//                             });
//                           },
//                           child: Container(
//                             height: Sizes.screenHeight * 0.035,
//                             width: Sizes.screenWidth * 0.27,
//                             decoration: BoxDecoration(
//                               color: docAppCon.selectedMonth ==
//                                       avlTimeType.Morning.toString()
//                                           .split('.')
//                                           .last
//                                   ? AppColor.lightBlue
//                                   : AppColor.blue.withOpacity(0.5),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Center(
//                               child: TextConst(
//                                 AppLocalizations.of(context)!.morning,
//                                 size: Sizes.fontSizeFour,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColor.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             docAppCon
//                                 .setSelectedMonthData(avlTimeType.Afternoon);
//                             Future.delayed(const Duration(milliseconds: 300),
//                                 () {
//                               if (scrollController.hasClients) {
//                                 scrollController.animateTo(
//                                   scrollController.position.maxScrollExtent,
//                                   duration: const Duration(milliseconds: 500),
//                                   curve: Curves.easeOut,
//                                 );
//                               }
//                             });
//                           },
//                           child: Container(
//                             height: Sizes.screenHeight * 0.035,
//                             width: Sizes.screenWidth * 0.28,
//                             decoration: BoxDecoration(
//                               color: docAppCon.selectedMonth ==
//                                       avlTimeType.Afternoon.toString()
//                                           .split('.')
//                                           .last
//                                   ? AppColor.lightBlue
//                                   : AppColor.blue,
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Center(
//                               child: TextConst(
//                                 AppLocalizations.of(context)!.afternoon,
//                                 size: Sizes.fontSizeFour,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColor.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             docAppCon.setSelectedMonthData(avlTimeType.Evening);
//                             Future.delayed(const Duration(milliseconds: 300),
//                                 () {
//                               if (scrollController.hasClients) {
//                                 scrollController.animateTo(
//                                   scrollController.position.maxScrollExtent,
//                                   duration: const Duration(milliseconds: 500),
//                                   curve: Curves.easeOut,
//                                 );
//                               }
//                             });
//                           },
//                           child: Container(
//                             height: Sizes.screenHeight * 0.035,
//                             width: Sizes.screenWidth * 0.28,
//                             decoration: BoxDecoration(
//                               color: docAppCon.selectedMonth ==
//                                       avlTimeType.Evening.toString()
//                                           .split('.')
//                                           .last
//                                   ? AppColor.lightBlue
//                                   : AppColor.blue,
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Center(
//                               child: TextConst(
//                                 AppLocalizations.of(context)!.evening,
//                                 size: Sizes.fontSizeFour,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColor.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               getSelectedTimeList.isEmpty
//                   ? const Center(
//                       child: ConstText(
//                         title: "No Slots Available",
//                       ),
//                     )
//                   : GridView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 8,
//                         childAspectRatio: 3.2,
//                       ),
//                       itemCount: getSelectedTimeList.length,
//                       itemBuilder: (context, index) {
//                         final appdata = getSelectedTimeList[index];
//                         // Slot time like "13:00"
//                         String slotTimeStr = appdata.slotTime.toString();
//                         List<String> timeParts = slotTimeStr.split(':');
//                         int hour = int.parse(timeParts[0]);
//                         int minute = int.parse(timeParts[1]);
//
//                         String isoDateStr =
//                             docAppCon.selectedDate!.availabilityDate.toString();
//                         DateTime selectedDateUtc = DateTime.parse(isoDateStr);
//                         DateTime selectedDateLocal = selectedDateUtc.toLocal();
//
//                         DateTime slotDateTime = DateTime(
//                           selectedDateLocal.year,
//                           selectedDateLocal.month,
//                           selectedDateLocal.day,
//                           hour,
//                           minute,
//                         );
//
//                         DateTime now = DateTime.now();
//                         bool isPast = slotDateTime.isBefore(now);
//                         debugPrint("Combined Slot Time: $slotDateTime");
//                         debugPrint("Is Past: $isPast");
//                         return BorderContainer(
//                           padding: const EdgeInsets.all(1),
//                           child: InkWell(
//                             onTap: () {
//                               if (isPast) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text(
//                                           "Looks like this time has already passed. Try picking a later slot!")),
//                                 );
//                                 // debugPrint(
//                                 //     "Past appointment booking not allowed");
//                               } else if (appdata.slotAvailableFlag!
//                                       .toLowerCase() ==
//                                   "scheduled") {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text(
//                                           "Looks like this time has already booked. Try picking another slot!")),
//                                 );
//                               } else {
//                                 // ScaffoldMessenger.of(context).showSnackBar(
//                                 //   const SnackBar(
//                                 //       content:
//                                 //           Text("Slot selected successfully.")),
//                                 // );
//                                 docAppCon.setSelectedTimeData(appdata);
//                               }
//                             },
//                             child: Container(
//                               height: Sizes.screenHeight * 0.037,
//                               width: Sizes.screenWidth * 0.26,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color:
//
//                                     // ? AppColor.lightBlue
//                                     // :
//                                     isPast ||
//                                             appdata.slotAvailableFlag!
//                                                     .toLowerCase() ==
//                                                 "scheduled"
//                                         ? Colors.grey.shade400
//                                         : docAppCon.selectedTime != null &&
//                                                 docAppCon
//                                                         .selectedTime!.timeId ==
//                                                     appdata.timeId
//                                             ? AppColor.lightSkyBlue
//                                             : const Color(0xffececec),
//                               ),
//                               child: Center(
//                                   child:
//                                       TextConst(appdata.slotTime.toString())),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//               Sizes.spaceHeight20,
//               Center(
//                 child: ButtonConst(
//                   width: Sizes.screenWidth * 0.84,
//                   height: Sizes.screenHeight * 0.055,
//                   title: AppLocalizations.of(context)!.book_your_appointment,
//                   onTap: () {
//                     //scrolling widget
//                     if (isReschedule) {
//                       docAppCon.setConfirmDailog(true);
//                       _scrollToTop();
//                     } else {
//                       final userId = UserViewModel().getUser();
//                       docAppCon.setRequestData({
//                         'patient_id': userId,
//                         "doctor_id": docAppCon.doctorAvlAppointmentModel!.data!
//                             .slots![0].doctorId,
//                         "clinic_id": docAppCon.doctorAvlAppointmentModel!.data!
//                             .slots![0].clinicId,
//                         "booking_date":
//                             docAppCon.selectedDate!.availabilityDate,
//                         "time_id": docAppCon.selectedTime!.timeId,
//                         "amount": docAppCon.doctorAvlAppointmentModel!.data!
//                             .location![0].consultationFee,
//                         "payment_status": "Completed",
//                         "payment_date": currentDate
//                       }, context);
//                       // Navigator.pushNamed(context, RoutesName.bookAppointmentScreen);
//
//                       print(docAppCon.requestData);
//                     }
//                   },
//                   color: docAppCon.selectedTime != null
//                       ? AppColor.blue
//                       : Colors.grey.shade400,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   Widget appointmentData() {
//     final updateAppDetails = Provider.of<UpdateAppointmentViewModel>(context);
//     final docAppointmentCon =
//         Provider.of<DoctorAvlAppointmentViewModel>(context);
//     final patientHomeCon = Provider.of<PatientHomeViewModel>(context);
//     DateTime dateTime = DateTime.parse(docAppointmentCon
//         .doctorAvlAppointmentModel!.data!.slots![0].availabilityDate
//         .toString());
//     String formattedDate = DateFormat('yyyy-dd-mm').format(dateTime);
//     String currentDate = DateTime.now().toString().split(' ')[0];
//     return SizedBox(
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: Sizes.screenWidth * 0.04,
//             vertical: Sizes.screenHeight * 0.026),
//         child: Column(
//           children: [
//             Sizes.spaceHeight20,
//             Container(
//               padding: EdgeInsets.symmetric(
//                   horizontal: Sizes.screenWidth * 0.04,
//                   vertical: Sizes.screenHeight * 0.01),
//               width: Sizes.screenWidth,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: AppColor.white),
//               child: Column(
//                 children: [
//                   TextConst(
//                     AppLocalizations.of(context)!.are_you_sure_you,
//                     size: Sizes.fontSizeFive,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   TextConst(
//                     AppLocalizations.of(context)!.reschedule_your_appointment,
//                     size: Sizes.fontSizeFive,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   Sizes.spaceHeight5,
//                   BorderContainer(
//                     padding: const EdgeInsets.all(1),
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: Sizes.screenWidth * 0.01,
//                           vertical: Sizes.screenHeight * 0.004),
//                       width: Sizes.screenWidth * 0.57,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: AppColor.lightSkyBlue),
//                       child: Column(
//                         children: [
//                           TextConst(
//                             AppLocalizations.of(context)!
//                                 .new_appointment_details,
//                             size: Sizes.fontSizeFour * 1.2,
//                             fontWeight: FontWeight.w400,
//                             color: AppColor.textfieldTextColor,
//                           ),
//                           Sizes.spaceHeight3,
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset(
//                                 Assets.iconsCalendar,
//                                 height: 25,
//                               ),
//                               Sizes.spaceWidth5,
//                               TextConst(
//                                 "${DateFormat('yyyy-MM-dd').format(DateTime.parse(docAppointmentCon.selectedDate!.availabilityDate.toString()))} at ${docAppointmentCon.selectedTime!.slotTime}",
//                                 size: Sizes.fontSizeFour * 1.2,
//                                 fontWeight: FontWeight.w500,
//                                 color: AppColor.black,
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Sizes.spaceHeight10,
//                   GestureDetector(
//                     onTap: () {
//                       updateAppDetails.updateAppointmentApi(context,
//                           docId: docAppointmentCon.doctorAvlAppointmentModel!
//                               .data!.details![0].doctorId,
//                           clinicId: docAppointmentCon.doctorAvlAppointmentModel!
//                               .data!.slots![0].clinicId,
//                           bookingDate:
//                               docAppointmentCon.selectedDate!.availabilityDate,
//                           timeId: docAppointmentCon.selectedTime!.timeId!,
//                           appId: patientHomeCon.patientHomeModel!.data!
//                               .appointments![0].appointmentId
//                               .toString());
//                     },
//                     child: Container(
//                       height: Sizes.screenHeight * 0.055,
//                       width: Sizes.screenWidth,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(40),
//                           color: AppColor.blue,
//                           border:
//                               Border.all(color: AppColor.lightBlue, width: 1)),
//                       child: Center(
//                         child: TextConst(
//                           AppLocalizations.of(context)!
//                               .confirm_your_appointment,
//                           size: Sizes.fontSizeFive,
//                           fontWeight: FontWeight.w500,
//                           color: AppColor.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Sizes.spaceHeight10,
//             GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, RoutesName.viewAppointmentsScreen);
//               },
//               child: TextConst(
//                 AppLocalizations.of(context)!.go_back,
//                 size: Sizes.fontSizeFive,
//                 fontWeight: FontWeight.w500,
//                 color: AppColor.white,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   int ratingValue = 4;
//   final TextEditingController reviewCon = TextEditingController();
//   final TextEditingController reviewDesCon = TextEditingController();
//   Widget addReviews() {
//     final docAppointmentCon =
//         Provider.of<DoctorAvlAppointmentViewModel>(context);
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       shadowColor: AppColor.black,
//       elevation: 10,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: const Color(0xffE3E3E3).withOpacity(0.8),
//         ),
//         height: Sizes.screenHeight * 0.3,
//         padding: EdgeInsets.symmetric(
//             horizontal: Sizes.screenWidth * 0.04,
//             vertical: Sizes.screenHeight * 0.02),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Row(
//               children: [
//                 TextConst(
//                   'Rate your experience',
//                   size: Sizes.fontSizeFour,
//                   fontWeight: FontWeight.w400,
//                   color: AppColor.black,
//                 ),
//                 Sizes.spaceWidth10,
//                 starRating(
//                   initialRating: 4,
//                   size: 20.0,
//                   onRatingChanged: (rating) {
//                     setState(() {
//                       ratingValue = rating;
//                     });
//                   },
//                 )
//               ],
//             ),
//             Sizes.spaceHeight10,
//             TextField(
//               controller: reviewCon,
//               decoration: InputDecoration(
//                 hintText: "Review title",
//                 hintStyle: TextStyle(
//                     color: const Color(0xffC5C5C5),
//                     fontWeight: FontWeight.w400,
//                     fontSize: Sizes.fontSizeThree),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none),
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none),
//                 fillColor: const Color(0xffF5F5F5),
//                 filled: true,
//                 contentPadding:
//                     const EdgeInsets.only(left: 7, right: 7, top: 6, bottom: 6),
//               ),
//               cursorColor: AppColor.textGrayColor,
//               cursorHeight: 20,
//               style: const TextStyle(color: AppColor.blue, fontSize: 14),
//             ),
//             Sizes.spaceHeight10,
//             TextField(
//               controller: reviewDesCon,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 hintText: "Review description",
//                 hintStyle: TextStyle(
//                     color: const Color(0xffC5C5C5),
//                     fontWeight: FontWeight.w400,
//                     fontSize: Sizes.fontSizeThree),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none),
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none),
//                 fillColor: const Color(0xffF5F5F5),
//                 filled: true,
//                 contentPadding:
//                     const EdgeInsets.only(left: 7, right: 7, top: 6, bottom: 6),
//               ),
//               cursorColor: AppColor.textGrayColor,
//               cursorHeight: 20,
//               style: const TextStyle(color: AppColor.blue, fontSize: 14),
//             ),
//             Sizes.spaceHeight10,
//             ButtonConst(
//               title: "Submit",
//               onTap: () {
//                 Provider.of<AddReviewViewModel>(context, listen: false)
//                     .addReviewApi(
//                         docAppointmentCon.doctorAvlAppointmentModel!.data!
//                             .details![0].doctorId,
//                         ratingValue,
//                         docAppointmentCon.doctorAvlAppointmentModel!.data!
//                             .reviews![0].consultedFor,
//                         reviewDesCon.text,
//                         context);
//               },
//               borderRadius: 8,
//               color: AppColor.blue,
//               height: Sizes.screenHeight * 0.035,
//               width: Sizes.screenWidth * 0.3,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget starRatings({
//     required double averageRating,
//     required double size,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(5, (index) {
//         if (averageRating >= index + 1) {
//           return Icon(
//             Icons.star,
//             color: const Color(0xffFFE500),
//             size: size,
//           );
//         } else if (averageRating > index && averageRating < index + 1) {
//           return Icon(
//             Icons.star_half,
//             color: const Color(0xffFFE500),
//             size: size,
//           );
//         } else {
//           // Empty star
//           return Icon(
//             Icons.star_border,
//             color: const Color(0xffFFE500),
//             size: size,
//           );
//         }
//       }),
//     );
//   }

//   Widget starRating({
//     required int initialRating,
//     required double size,
//     required Function(int) onRatingChanged,
//   }) {
//     int rating = initialRating;
//     return StatefulBuilder(
//       builder: (BuildContext context, setState) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(5, (index) {
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   rating = index + 1;
//                 });
//                 onRatingChanged(rating);
//               },
//               child: Icon(
//                 index < rating ? Icons.star : Icons.star_border,
//                 color: index < rating ? const Color(0xffFFE500) : Colors.white,
//                 size: size,
//               ),
//             );
//           }),
//         );
//       },
//     );
//   }
// }
