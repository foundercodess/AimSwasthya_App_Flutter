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
  bool viewAllStories = false;
  bool isAppointmentReschedule = false;
  dynamic doctorId;
  dynamic clinicId;
  // Add horizontal scroll controller and showNextIcon state
  final ScrollController _horizontalScrollController = ScrollController();
  bool showNextIcon = false;
  // Key for the grid area
  final GlobalKey _gridKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map?;
      if (arguments != null) {
        setState(() {
          doctorId = arguments["doctor_id"];
          clinicId = arguments["clinic_id"];
        });
        final docDCon =
            Provider.of<DoctorAvlAppointmentViewModel>(context, listen: false);
        docDCon.doctorAvlAppointmentApi(doctorId, clinicId, context);
        docDCon.setConfirmDialog(false);
        bool isNewBooking = arguments["isNew"] ?? false;
        setState(() {
          isAppointmentReschedule = !isNewBooking;
        });
      }
      // Listen to horizontal scroll changes
      _horizontalScrollController.addListener(_updateShowNextIcon);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateShowNextIcon();
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ensureShowNextIconAfterLayout();
    });
  }

  void _updateShowNextIcon() {
    if (!_horizontalScrollController.hasClients) return;
    final maxScroll = _horizontalScrollController.position.maxScrollExtent;
    final currentScroll = _horizontalScrollController.offset;
    final shouldShow = currentScroll < maxScroll - 8; // 8 px tolerance
    if (showNextIcon != shouldShow) {
      setState(() {
        showNextIcon = shouldShow;
      });
    }
  }

  // Robustly ensure next icon is shown after layout
  void _ensureShowNextIconAfterLayout() {
    if (!_horizontalScrollController.hasClients ||
        !_horizontalScrollController.position.hasContentDimensions) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _ensureShowNextIconAfterLayout();
      });
      return;
    }
    _updateShowNextIcon();
  }

  bool isMoreThanOneHourAway(String bookingDate, String time) {
    try {
      DateTime bookingDateTime;

      if (bookingDate.contains('T')) {
        // Case 1: ISO 8601 format
        DateTime parsed = DateTime.parse(bookingDate).toLocal();
        String formattedDate = DateFormat("dd-MM-yyyy").format(parsed);
        bookingDateTime =
            DateFormat("dd-MM-yyyy hh:mm a").parse("$formattedDate $time");
      } else {
        // Case 2: Already in dd-MM-yyyy format
        bookingDateTime =
            DateFormat("dd-MM-yyyy hh:mm a").parse("$bookingDate $time");
      }

      DateTime now = DateTime.now();
      Duration difference = bookingDateTime.difference(now);
      return difference.inMinutes > 60;
    } catch (e) {
      print("❌ Date parsing error: $e");
      return false;
    }
  }

  String timeAgo(String isoDateString) {
    final now = DateTime.now().toUtc();
    final past = DateTime.parse(isoDateString);
    final diff = now.difference(past);

    if (diff.inDays >= 7) {
      final weeks = diff.inDays ~/ 7;
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  String formatBookingDate(String inputDate) {
    DateTime dateTime;

    try {
      if (inputDate.contains('T')) {
        dateTime = DateTime.parse(inputDate);
      } else {
        dateTime = DateFormat('d-M-yyyy').parse(inputDate);
      }

      return DateFormat('d MMM').format(dateTime);
    } catch (e) {
      print("Date parsing error: $e");
      return 'Invalid Date';
    }
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
    _horizontalScrollController.dispose();
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
        backgroundColor: const Color(0xfffffffff),
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
              if (isAppointmentReschedule) ...[
                Sizes.spaceHeight25,
                clinicDetails(),
                Sizes.spaceHeight35,
                reviewsSection()
              ],
              if (!isAppointmentReschedule) ...[
                Sizes.spaceHeight35,
                reviewsSection()
              ],
              Sizes.spaceHeight10,
              specializationSection(),
              Sizes.spaceHeight15
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
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
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
                    maxLines: 1,
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
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            // color: AppColor.textGrayColor.withOpacity(.1)
            color: const Color(0xffFBFBFB)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          leading: Image.asset(
            Assets.iconsUimClinicMedical,
            width: Sizes.screenWidth / 8,
          ),
          title: TextConst(
            "${clinicData.name}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
        ),
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
                    image: DecorationImage(
                        image: AssetImage(Assets.allImagesViewMap),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter)),
              ),
            ),
            // Sizes.spaceHeight20,
            Container(
              padding: const EdgeInsets.only(bottom: 12, top: 20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Color(0xffFBFBFB)),
              child: Padding(
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
                            height: Sizes.screenHeight / 22,
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
                            height: Sizes.screenHeight / 22,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(bottom: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
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
          // --- Start Stack for horizontal list and next icon ---
          Stack(
            alignment: Alignment.centerRight,
            children: [
              SingleChildScrollView(
                controller: _horizontalScrollController,
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.hardEdge,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
                              Future.delayed(const Duration(milliseconds: 100),
                                  () {
                                final context = _gridKey.currentContext;
                                if (context != null) {
                                  Scrollable.ensureVisible(
                                    context,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                    alignment: .8,
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
                                                  bottomLeft:
                                                      Radius.circular(3))
                                              : i == lastIndex
                                                  ? const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(3),
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
                              width: Sizes.screenWidth / 10,
                              decoration: BoxDecoration(
                                  color: AppColor.textfieldGrayColor
                                      .withOpacity(0.5)),
                            )
                        ],
                      );
                    }),
                  ),
                ),
              ),
              // --- Next icon overlay ---
              if (showNextIcon)
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      if (_horizontalScrollController.hasClients) {
                        final maxScroll = _horizontalScrollController
                            .position.maxScrollExtent;
                        final current = _horizontalScrollController.offset;
                        final next = (current + 120.0)
                            .clamp(0, maxScroll); // scroll by 120 px
                        _horizontalScrollController.animateTo(
                          next.toDouble(),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                    child: Container(
                      width: 30,
                      // height: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.white.withOpacity(0.0), Colors.white],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: const Icon(Icons.arrow_forward_ios,
                          color: Color(0xffE7E7E7), size: 18),
                    ),
                  ),
                ),
            ],
          ),
          // --- End Stack ---
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
                    Future.delayed(const Duration(milliseconds: 100), () {
                      final context = _gridKey.currentContext;
                      if (context != null) {
                        Scrollable.ensureVisible(
                          context,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          alignment: .8,
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
          Container(
            key: _gridKey,
            child: dateWiseTimingGrid(),
          ),
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
                "doctor_id": doctorId.toString(),
                "clinic_id": clinicId.toString(),
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
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: AppColor.textfieldGrayColor.withOpacity(.5)))),
        width: Sizes.screenWidth,
        child: ExpansionTile(
            iconColor: AppColor.black,
            // initiallyExpanded: true,
            backgroundColor: Colors.transparent,
            collapsedBackgroundColor: Colors.transparent,
            tilePadding: const EdgeInsets.symmetric(horizontal: 15),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide.none,
            ),
            title: TextConst(
              "Patient stories (${reviewData!.length}+)",
              fontWeight: FontWeight.w500,
              size: Sizes.fontSizeSix,
            ),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              rateDoctor(averageRating.toString(), docID),
              Sizes.spaceHeight10,
              ListView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: viewAllStories
                      ? reviewData.length
                      : reviewData.length > 2
                          ? 2
                          : reviewData.length,
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
                            leading: Container(
                              height: Sizes.screenWidth * .1,
                              width: Sizes.screenWidth * .1,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.lightBlue),
                              child: ImageIcon(
                                const AssetImage(Assets.iconsProfileIcon),
                                color: AppColor.purple.withOpacity(.5),
                              ),
                            ),
                            title: TextConst(
                              "${review.name}",
                              fontWeight: FontWeight.w500,
                              size: Sizes.fontSizeFive,
                            ),
                            subtitle: TextConst(
                              timeAgo(review.createdAt.toString()),
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
                            padding:
                                const EdgeInsets.only(left: 18, bottom: 10),
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
                  }),
              Sizes.spaceHeight20,
              if (!viewAllStories && reviewData.length > 2) ...[
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        viewAllStories = true;
                      });
                    },
                    child: TextConst(
                      "Read All Stories",
                      color: AppColor.lightBlue,
                      fontWeight: FontWeight.w500,
                      size: Sizes.fontSizeFour,
                    ),
                  ),
                ),
                Sizes.spaceHeight30,
              ],
            ]),
      );
    });
  }

  Widget specializationSection() {
    return Consumer<DoctorAvlAppointmentViewModel>(builder: (context, dAVM, _) {
      return Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: AppColor.textfieldGrayColor.withOpacity(.5)),
                bottom: BorderSide(
                    color: AppColor.textfieldGrayColor.withOpacity(.5)))),
        width: Sizes.screenWidth,
        child: ExpansionTile(
          iconColor: AppColor.blackColor,
          // initiallyExpanded: true,
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          tilePadding: const EdgeInsets.symmetric(horizontal: 15),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide.none,
          ),
          title: TextConst(
            "Specialisation",
            fontWeight: FontWeight.w500,
            size: Sizes.fontSizeSix,
          ),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
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
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColor.textfieldGrayColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(5)),
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
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: .5, color: AppColor.lightBlue),
                              color: Colors.lightBlue.withOpacity(.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColor.lightBlue,
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

  Widget appointmentDateTimeWithStatus() {
    return Consumer<UpdateAppointmentViewModel>(builder: (context, uAVM, _) {
      final appointmentData = uAVM.rescheduleAppointmentData!;

      final formattedDate =
          formatBookingDate(appointmentData.bookingDate.toString());
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
                appointmentData.status == null
                    ? ""
                    : appointmentData.status == 'scheduled'
                        ? "Appointment Reschedule"
                        : appointmentData.status == 'reschduled'
                            ? "Appointent On Hold"
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
                TextConst(
                    appointmentData.status == 'reschduled'
                        ? "On hold"
                        : formattedDate.length > 8
                            ? formattedDate.substring(0, 6)
                            : formattedDate,
                    size: Sizes.fontSizeFive,
                    fontWeight: FontWeight.w500),
                Sizes.spaceWidth10,
                const Icon(Icons.watch_later_outlined,
                    color: Colors.grey, size: 20),
                Sizes.spaceWidth5,
                TextConst(
                    appointmentData.status == 'reschduled'
                        ? "-"
                        : appointmentData.hour24Format!,
                    size: Sizes.fontSizeFive,
                    fontWeight: FontWeight.w500),
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
                        maxLines: 1,
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
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          }
                        },
                        height: Sizes.screenWidth / 14,
                        borderRadius: 8,
                        color: const Color(0xffC10000),
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
