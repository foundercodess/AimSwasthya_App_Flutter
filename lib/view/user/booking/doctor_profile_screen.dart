// view/user/booking/doctor_profile_screen.dart
import 'dart:ui';
import 'package:aim_swasthya/res/border_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/google_map/open_google_map.dart';
import 'package:aim_swasthya/utils/google_map/view_static_location.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view_model/user/add_doctor_view_model.dart';
import 'package:aim_swasthya/view_model/user/add_review_view_model.dart';
import 'package:aim_swasthya/view_model/user/doctor_avl_appointment_view_model.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:aim_swasthya/view_model/user/update_appointment_view_model.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  dynamic selectedAvlDate;

  bool isReschedule = false;

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
        docDCon.setConfirmDailog(false);
        bool isNewBooking = arguments["isNew"] ?? false;
        setState(() {
          isReschedule = !isNewBooking;
        });
      }
    });
  }

  void _scrollToTop() {
    scrollController.animateTo(
      0.0, // Top of the list
      duration:const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void launchDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    bool isNewBooking = arguments["isNew"] ?? false;
    final appData = Provider.of<DoctorAvlAppointmentViewModel>(context);

    final docAppointmentCon =
        Provider.of<DoctorAvlAppointmentViewModel>(context);
    return Scaffold(
      body: docAppointmentCon.doctorAvlAppointmentModel == null ||
              docAppointmentCon.doctorAvlAppointmentModel!.data == null
          ? const Center(child: LoadData())
          : SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBarContainer(),
                  if (isNewBooking == true) patientReview(),
                  Sizes.spaceHeight30,
                  clinicDetails(),
                  SizedBox(
                    height: Sizes.screenHeight * 0.055,
                  ),
                  SizedBox(
                    height: Sizes.screenHeight * 0.055,
                  ),
                  slotsList(),
                  Sizes.spaceHeight35,
                  selectTime(),
                  Sizes.spaceHeight25,
                ],
              ),
            ),
    );
  }

  Widget appBarContainer() {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    bool isNewBooking = arguments["isNew"] ?? false;
    final docAppointmentCon =
        Provider.of<DoctorAvlAppointmentViewModel>(context);
    final addDoctor = Provider.of<AddDoctorViewModel>(context);
    return Container(
      width: Sizes.screenWidth,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          gradient: const LinearGradient(
            colors: [AppColor.naviBlue, AppColor.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: isNewBooking == true
              ? const DecorationImage(
                  image: AssetImage(Assets.imagesProfileLine),
                  alignment: Alignment(0.9, 0.2),
                  fit: BoxFit.contain,
                )
              : null),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: Sizes.screenHeight * 0.07,
                        right: Sizes.screenWidth * 0.03),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          child: docAppointmentCon.doctorAvlAppointmentModel!
                                      .data!.details![0].signedImageUrl !=
                                  null
                              ? Image.network(
                                  docAppointmentCon.doctorAvlAppointmentModel!
                                      .data!.details![0].signedImageUrl
                                      .toString(),
                                  height: kToolbarHeight * 2.6,
                                  width: kToolbarHeight * 2.9,
                                  fit: BoxFit.cover,
                                )
                              : const Image(
                                  image: AssetImage(Assets.logoDoctor),
                                  height: kToolbarHeight * 2.6,
                                  width: kToolbarHeight * 2.9,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Sizes.spaceWidth15,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextConst(
                              docAppointmentCon.doctorAvlAppointmentModel!.data!
                                      .details![0].doctorName ??
                                  "",
                              size: Sizes.fontSizeSix,
                              fontWeight: FontWeight.w500,
                              color: AppColor.white,
                            ),
                            SizedBox(
                              width: Sizes.screenWidth * 0.5,
                              child: TextConst(
                                overflow: TextOverflow.ellipsis,
                                "${docAppointmentCon.doctorAvlAppointmentModel!.data!.details![0].qualification ?? ""} (${docAppointmentCon.doctorAvlAppointmentModel!.data!.details![0].specializationName ?? ""})",
                                size: Sizes.fontSizeFive,
                                color: AppColor.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: -30,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5,
                            sigmaY: 5,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Sizes.screenWidth * 0.02,
                                vertical: Sizes.screenHeight * 0.01),
                            width: Sizes.screenWidth * 0.9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xffE3E3E3).withOpacity(0.6),
                                border: Border.all(
                                    color: AppColor.lightSkyBlue, width: 0.5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          Assets.imagesMaterialSymbol),
                                      height: 30,
                                    ),
                                    SizedBox(
                                      width: Sizes.screenWidth * 0.17,
                                      child: TextConst(
                                        docAppointmentCon
                                                .doctorAvlAppointmentModel!
                                                .data!
                                                .details![0]
                                                .experience ??
                                            "",
                                        size: Sizes.fontSizeFour,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 0.5,
                                  height: 30,
                                  color: Colors.grey.shade500,
                                ),
                                Row(
                                  children: [
                                    const Image(
                                      image:
                                          AssetImage(Assets.imagesCarbonStar),
                                      height: 25,
                                    ),
                                    Sizes.spaceWidth5,
                                    Column(
                                      children: [
                                        starRatings(
                                          averageRating: double.parse(
                                              docAppointmentCon
                                                  .doctorAvlAppointmentModel!
                                                  .data!
                                                  .details![0]
                                                  .averageRating
                                                  .toString()),
                                          size: 12.0,
                                        ),
                                        // starRating(
                                        //   initialRating: 4,
                                        //   size: 12.0,
                                        //   onRatingChanged: (rating) {
                                        //     print('New Rating: $rating');
                                        //   },
                                        // ),
                                        // const StarRating(
                                        //   initialRating: 4,
                                        //   size: 12.0,
                                        // ),
                                        TextConst(
                                          "${docAppointmentCon.doctorAvlAppointmentModel!.data!.details![0].reviewCount}+ Reviews",
                                          // "100+ Reviews",
                                          size: Sizes.fontSizeFour,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 0.5,
                                  height: 30,
                                  // color: Colors.grey.shade500,
                                  color: Colors.grey.shade500,
                                ),
                                docAppointmentCon
                                            .doctorAvlAppointmentModel!
                                            .data!
                                            .details![0]
                                            .preferredDoctorStatus
                                            ?.toLowerCase() ==
                                        "Y".toLowerCase()
                                    ? AddButton(
                                           fontSize: Sizes.screenWidth / 60,
                                           color: AppColor.white.withOpacity(0.9),
                                           width: Sizes.screenWidth / 3.8,
                                           height: Sizes.screenHeight * 0.035,
                                           title: "Preferred Doctor!",
                                           onTap: () {},
                                         )
                                    : GestureDetector(
                                        onTap: () {
                                          addDoctor.addDoctorApi(
                                            docAppointmentCon
                                                .doctorAvlAppointmentModel!
                                                .data!
                                                .details![0]
                                                .doctorId
                                                .toString(),
                                            context,
                                            clinicId: docAppointmentCon
                                                .doctorAvlAppointmentModel!
                                                .data!
                                                .location![0]
                                                .clinicId
                                                .toString(),
                                          );
                                        },
                                        child:Align(
                                          alignment: Alignment.center,
                                          child: AddButton(
                                            fontSize: Sizes.screenWidth / 60,
                                            color:
                                                AppColor.white.withOpacity(0.9),
                                            width: Sizes.screenWidth / 3.8,
                                            height: Sizes.screenHeight * 0.035,
                                            title: "Add to your doctors",
                                            // onTap: () {
                                            //   addDoctor.addDoctorApi(
                                            //     docAppointmentCon
                                            //         .doctorAvlAppointmentModel!
                                            //         .data!
                                            //         .details![0]
                                            //         .doctorId
                                            //         .toString(),
                                            //     context,
                                            //     clinicId: docAppointmentCon
                                            //         .doctorAvlAppointmentModel!
                                            //         .data!
                                            //         .location![0]
                                            //         .clinicId
                                            //         .toString(),
                                            //   );
                                            // },
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              if (docAppointmentCon.showConfirmDailog) appointmentData()
            ],
          ),
          Positioned(
              top: 50,
              left: -5,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: AppColor.white,
              )),
          if (docAppointmentCon
                  .doctorAvlAppointmentModel!.data!.details![0].topRated
                  .toString()
                  .toLowerCase() ==
              'y')
            Positioned(
                top: 70,
                left: 120,
                child: Column(
                  children: [
                    proContainer(AppColor.lightGreen, 'Top choice',
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3))
                  ],
                )),
        ],
      ),
    );
  }

  Widget proContainer(Color color, dynamic label,
      {EdgeInsetsGeometry? padding}) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 1),
      height: Sizes.screenHeight * 0.02,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: color,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Image(
              image: AssetImage(Assets.iconsCheck),
              height: 10,
              width: 10,
              fit: BoxFit.cover,
            ),
            Sizes.spaceWidth3,
            // Sizes.spaceWidth5,
            TextConst(
              label,
              size: Sizes.fontSizeTwo,
              fontWeight: FontWeight.w400,
              color: AppColor.white,
            )
          ],
        ),
      ),
    );
  }

  String _convertTo24Hour(String time12h) {
    final format = DateFormat.jm();
    final dateTime = format.parse(time12h);
    return DateFormat("HH:mm:ss").format(dateTime);
  }

  bool isTimeLessThanOneHour(String hour24Format) {
    // Parse the string to DateTime
    final now = DateTime.now();

    // Use today's date + parsed time
    final inputTime = DateTime.parse(
      "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} "
      "${_convertTo24Hour(hour24Format)}",
    );

    final difference = inputTime.difference(now).inMinutes;

    return difference >= 0 && difference <= 60;
  }

  int currentRatingIndex = 0;
  final PageController pageController = PageController();
  Widget patientReview() {
    final docAppointmentCon =
        Provider.of<DoctorAvlAppointmentViewModel>(context);
    if (docAppointmentCon.doctorAvlAppointmentModel!.data!.reviews == null ||
        docAppointmentCon.doctorAvlAppointmentModel!.data!.reviews!.isEmpty) {
      return Center(
          child: Container(
              alignment: Alignment.bottomCenter,
              height: Sizes.screenHeight * 0.08,
              child: const ConstText(title: "No Review founds")));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Sizes.screenHeight * 0.07,
        ),
        TextConst(
          padding: const EdgeInsets.only(left: 15),
          AppLocalizations.of(context)!.patient_reviews,
          size: Sizes.fontSizeFivePFive,
          fontWeight: FontWeight.w400,
        ),
        Sizes.spaceHeight15,
        SizedBox(
          height: Sizes.screenHeight * 0.15,
          width: Sizes.screenWidth,
          child: PageView.builder(
            controller: pageController,
            itemCount: docAppointmentCon
                .doctorAvlAppointmentModel!.data!.reviews!.length,
            onPageChanged: (index) {
              setState(() {
                currentRatingIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              final appData = docAppointmentCon
                  .doctorAvlAppointmentModel!.data!.reviews![index];
              return Container(
                margin: const EdgeInsets.only(left: 14, right: 10),
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.screenWidth * 0.03,
                  vertical: Sizes.screenHeight * 0.008,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffececec),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return addReviews();
                            });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              TextConst(
                                appData.rating.toString(),
                                size: Sizes.fontSizeSeven,
                                fontWeight: FontWeight.w400,
                              ),
                              Sizes.spaceWidth3,
                              const Icon(
                                Icons.star,
                                color: Color(0xffFFE500),
                                size: 25,
                              )
                            ],
                          ),
                          TextConst(
                            "Write a review",
                            size: Sizes.fontSizeFour,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 3,
                      endIndent: 3,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(7),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.lightBlue,
                              ),
                              child: Center(
                                child: TextConst(
                                  appData.name != null &&
                                          appData.name!.isNotEmpty
                                      ? appData.name![0].toUpperCase()
                                      : "",
                                  color: AppColor.white,
                                  size: Sizes.fontSizeFourPFive,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Sizes.spaceWidth5,
                            TextConst(
                              appData.name ?? "",
                              size: Sizes.fontSizeFourPFive,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            )
                          ],
                        ),
                        TextConst(
                          appData.consultedFor ?? "",
                          size: Sizes.fontSizeFour,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                        ),
                        Sizes.spaceHeight3,
                        SizedBox(
                          width: Sizes.screenWidth * 0.6,
                          child: TextConst(
                            appData.review ?? "",
                            size: Sizes.fontSizeThree,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Sizes.spaceHeight10,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  docAppointmentCon.doctorAvlAppointmentModel!.data!.reviews!
                              .length <
                          5
                      ? docAppointmentCon
                          .doctorAvlAppointmentModel!.data!.reviews!.length
                      : 5,
                  (i) {
                    return Container(
                      height: 7,
                      width: 7,
                      margin: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentRatingIndex == i
                              ? AppColor.blue
                              : Colors.grey),
                    );
                  },
                )),
            if (docAppointmentCon
                    .doctorAvlAppointmentModel!.data!.reviews!.length >
                5)
              Padding(
                padding: const EdgeInsets.only(left: 3, right: 5, top: 1.5),
                child: TextConst(
                  " +${docAppointmentCon.doctorAvlAppointmentModel!.data!.reviews!.length - 5}",
                  size: Sizes.fontSizeThree,
                ),
              )
          ],
        )
      ],
    );
  }

  Widget clinicDetails() {
    final appData = Provider.of<DoctorAvlAppointmentViewModel>(context);
    if (appData.doctorAvlAppointmentModel!.data!.location == null ||
        appData.doctorAvlAppointmentModel!.data!.location == [] ||
        appData.doctorAvlAppointmentModel!.data!.location!.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextConst(
          padding: const EdgeInsets.only(left: 15),
          AppLocalizations.of(context)!.clinic_details,
          size: Sizes.fontSizeFivePFive,
          fontWeight: FontWeight.w400,
        ),
        Sizes.spaceHeight15,
        Container(
          margin: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.04),
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                AppColor.conLightBlue.withOpacity(0.6),
                AppColor.darkBlack.withOpacity(0.6)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.only(
                left: Sizes.screenWidth * 0.04,
                right: Sizes.screenWidth * 0.04,
                top: Sizes.screenHeight * 0.01,
                bottom: Sizes.screenHeight * 0.01),
            // height: Sizes.screenHeight * 0.3,
            width: Sizes.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffececec),
              // color: AppColor.textfieldGrayColor,
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    print("Anshika");
                    openGoogleMap(
                        double.parse(appData.doctorAvlAppointmentModel!.data!
                            .location![0].latitude
                            .toString()),
                        double.parse(appData.doctorAvlAppointmentModel!.data!
                            .location![0].longitude
                            .toString()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: Sizes.screenHeight / 6,
                    child: IgnorePointer(
                      child: GetLocationOnMap(
                          latitude: double.parse(appData
                              .doctorAvlAppointmentModel!
                              .data!
                              .location![0]
                              .latitude
                              .toString()),
                          longitude: double.parse(appData
                              .doctorAvlAppointmentModel!
                              .data!
                              .location![0]
                              .longitude
                              .toString())),
                    ),
                  ),
                ),
                Sizes.spaceHeight10,
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                        // color: Colors.red,
                        border: Border(
                          top: BorderSide.none,
                          left: BorderSide.none,
                          bottom: BorderSide.none,
                          right: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Sizes.screenWidth * 0.66,
                            child: TextConst(
                              overflow: TextOverflow.ellipsis,
                              "${appData.doctorAvlAppointmentModel!.data!.location![0].address},"
                              "${appData.doctorAvlAppointmentModel!.data!.location![0].city},"
                              "${appData.doctorAvlAppointmentModel!.data!.location![0].postalCode}",
                              size: Sizes.fontSizeFivePFive,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                          SizedBox(
                            height: Sizes.screenHeight * 0.002,
                          ),
                          TextConst(
                            "${appData.doctorAvlAppointmentModel!.data!.location![0].startTime} - ${appData.doctorAvlAppointmentModel!.data!.location![0].endTime}",
                            size: Sizes.fontSizeFour,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                          ),
                          Sizes.spaceHeight5,
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Sizes.screenHeight * 0.01,
                                horizontal: Sizes.screenWidth * 0.02),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.black.withOpacity(0.2),
                                      offset: const Offset(0, 1),
                                      spreadRadius: 0,
                                      blurRadius: 2)
                                ],
                                borderRadius: BorderRadius.circular(12),
                                color: AppColor.white),
                            child: Center(
                                child: TextConst(
                              "${appData.doctorAvlAppointmentModel!.data!.location![0].consultationFeeType ?? ""}: ${appData.doctorAvlAppointmentModel!.data!.location![0].consultationFee ?? ""}",
                              size: Sizes.fontSizeFourPFive,
                              fontWeight: FontWeight.w500,
                              color: AppColor.black,
                            )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Sizes.screenWidth * 0.01),
                    GestureDetector(
                      onTap: () {
                        final phone = appData.doctorAvlAppointmentModel!.data!
                            .details![0].phoneNumber
                            .toString();
                        if (phone.isNotEmpty) {
                          launchDialer(phone);
                        } else {
                          print("No phone number available.");
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(1.1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            colors: [
                              AppColor.conLightBlue,
                              AppColor.darkBlack.withOpacity(0.5)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.all(Sizes.screenWidth / 39),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.lightBlue,
                          ),
                          child: const Icon(
                            Icons.call,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget slotsList() {
    final docAppointmentCon =
        Provider.of<DoctorAvlAppointmentViewModel>(context);
    // List<String> weekdays = getWeekdaysForNextWeek();
    if (docAppointmentCon.doctorAvlAppointmentModel!.data!.slots == null ||
        docAppointmentCon.doctorAvlAppointmentModel!.data!.slots!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextConst(
          padding: const EdgeInsets.only(left: 15),
          AppLocalizations.of(context)!.available_slots,
          size: Sizes.fontSizeFivePFive,
          fontWeight: FontWeight.w400,
        ),
        Sizes.spaceHeight15,
        Consumer<DoctorAvlAppointmentViewModel>(
            builder: (context, docAppCon, _) {
          if (docAppCon.doctorAvlAppointmentModel!.data!.slots == null) {
            return const NoDataMessages(
              title:  "No slots found for the doctor",
              message: "No available slots for this doctor at the moment.",
            );
            const ConstText(title: "No slots found for the doctor");
          }
          return SizedBox(
            height: Sizes.screenHeight * 0.095,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: docAppointmentCon
                  .doctorAvlAppointmentModel!.data!.slots!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final docAppointment = docAppointmentCon
                    .doctorAvlAppointmentModel!.data!.slots![index];
                DateTime dateTime =
                    DateTime.parse(docAppointment.availabilityDate.toString());
                String formattedDate = DateFormat('d MMM').format(dateTime);
                return BorderContainer(
                  margin: EdgeInsets.only(
                    left: index == 0
                        ? Sizes.screenWidth * 0.04
                        : Sizes.screenWidth * 0.03,
                    right: index ==
                            docAppointmentCon.doctorAvlAppointmentModel!.data!
                                    .slots!.length -
                                1
                        ? Sizes.screenWidth * 0.03
                        : Sizes.screenWidth * 0.012,
                  ),
                  padding: const EdgeInsets.all(1),
                  child: Container(
                      width: Sizes.screenWidth * 0.14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.white,
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              docAppointmentCon.setSelectedDate(docAppointment);
                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                if (scrollController.hasClients) {
                                  scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOut,
                                  );
                                }
                              });
                            },
                            child: BorderContainer(
                              padding: const EdgeInsets.only(bottom: 1),
                              child: Container(
                                height: Sizes.screenHeight * 0.049,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColor.lightBlue),
                                child: Center(
                                    child: TextConst(
                                  (docAppointment.day?.substring(0, 3) ?? ""),
                                  color: docAppointmentCon.selectedDate!.day ==
                                          docAppointment.day
                                      ? AppColor.black
                                      : AppColor.white,
                                  size: Sizes.fontSizeFivePFive,
                                  fontWeight: FontWeight.w500,
                                )),
                              ),
                            ),
                          ),
                          Sizes.spaceHeight5,
                          TextConst(
                            formattedDate,
                            size: Sizes.fontSizeFive,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      )),
                );
              },
            ),
          );
        }),
      ],
    );
  }

  final scrollController = ScrollController();
  Widget selectTime() {
    String currentDate = DateTime.now().toString().split(' ')[0];
    return Consumer<DoctorAvlAppointmentViewModel>(
        builder: (context, docAppCon, _) {
      if (docAppCon.doctorAvlAppointmentModel!.data!.slots == null ||
          docAppCon.doctorAvlAppointmentModel!.data!.slots!.isEmpty ||
          docAppCon.selectedDate == null) {
        return const Center(
          child: NoDataMessages(
            title:  "No slots found for the doctor",
            message: "No available slots for this doctor at the moment.",
          ),
        );
      }
      final getSelectedTimeList = docAppCon
          .doctorAvlAppointmentModel!.data!.slots!
          .where((e) => e.day == docAppCon.selectedDate!.day)
          .first
          .availableTime!
          .where((e) => e.timeOfDay == docAppCon.selectedMonth.toString())
          .toList();
      return StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.screenWidth * 0.03,
              vertical: Sizes.screenHeight * 0.012),
          margin: const EdgeInsets.all(10),
          width: Sizes.screenWidth,
          decoration: BoxDecoration(
              color: const Color(0xffececec),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextConst(
                AppLocalizations.of(context)!.select_time,
                size: Sizes.fontSizeFivePFive,
                fontWeight: FontWeight.w400,
              ),
              Sizes.spaceHeight20,
              Center(
                child: BorderContainer(
                  radius: 50,
                  padding: const EdgeInsets.only(
                      left: 1, right: 1, top: 1, bottom: 0.5),
                  child: Container(
                    height: Sizes.screenHeight * 0.035,
                    width: Sizes.screenWidth * 0.83,
                    decoration: BoxDecoration(
                        color: AppColor.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            docAppCon.setSelectedMonthData(avlTimeType.Morning);
                            Future.delayed(const Duration(milliseconds: 300),
                                () {
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
                            height: Sizes.screenHeight * 0.035,
                            width: Sizes.screenWidth * 0.27,
                            decoration: BoxDecoration(
                              color: docAppCon.selectedMonth ==
                                      avlTimeType.Morning.toString()
                                          .split('.')
                                          .last
                                  ? AppColor.lightBlue
                                  : AppColor.blue.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: TextConst(
                                AppLocalizations.of(context)!.morning,
                                size: Sizes.fontSizeFour,
                                fontWeight: FontWeight.w400,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            docAppCon
                                .setSelectedMonthData(avlTimeType.Afternoon);
                            Future.delayed(const Duration(milliseconds: 300),
                                () {
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
                            height: Sizes.screenHeight * 0.035,
                            width: Sizes.screenWidth * 0.28,
                            decoration: BoxDecoration(
                              color: docAppCon.selectedMonth ==
                                      avlTimeType.Afternoon.toString()
                                          .split('.')
                                          .last
                                  ? AppColor.lightBlue
                                  : AppColor.blue,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: TextConst(
                                AppLocalizations.of(context)!.afternoon,
                                size: Sizes.fontSizeFour,
                                fontWeight: FontWeight.w400,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            docAppCon.setSelectedMonthData(avlTimeType.Evening);
                            Future.delayed(const Duration(milliseconds: 300),
                                () {
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
                            height: Sizes.screenHeight * 0.035,
                            width: Sizes.screenWidth * 0.28,
                            decoration: BoxDecoration(
                              color: docAppCon.selectedMonth ==
                                      avlTimeType.Evening.toString()
                                          .split('.')
                                          .last
                                  ? AppColor.lightBlue
                                  : AppColor.blue,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: TextConst(
                                AppLocalizations.of(context)!.evening,
                                size: Sizes.fontSizeFour,
                                fontWeight: FontWeight.w400,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              getSelectedTimeList.isEmpty
                  ? const Center(
                      child: ConstText(
                        title: "No Slots Available",
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 3.2,
                      ),
                      itemCount: getSelectedTimeList.length,
                      itemBuilder: (context, index) {
                        final appdata = getSelectedTimeList[index];
                        // Slot time like "13:00"
                        String slotTimeStr = appdata.slotTime.toString();
                        List<String> timeParts = slotTimeStr.split(':');
                        int hour = int.parse(timeParts[0]);
                        int minute = int.parse(timeParts[1]);

                        String isoDateStr =
                            docAppCon.selectedDate!.availabilityDate.toString();
                        DateTime selectedDateUtc = DateTime.parse(isoDateStr);
                        DateTime selectedDateLocal = selectedDateUtc.toLocal();

                        DateTime slotDateTime = DateTime(
                          selectedDateLocal.year,
                          selectedDateLocal.month,
                          selectedDateLocal.day,
                          hour,
                          minute,
                        );

                        DateTime now = DateTime.now();
                        bool isPast = slotDateTime.isBefore(now);
                        debugPrint("Combined Slot Time: $slotDateTime");
                        debugPrint("Is Past: $isPast");
                        return BorderContainer(
                          padding: const EdgeInsets.all(1),
                          child: InkWell(
                            onTap: () {
                              if (isPast) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Looks like this time has already passed. Try picking a later slot!")),
                                );
                                // debugPrint(
                                //     "Past appointment booking not allowed");
                              } else if (appdata.slotAvailableFlag!
                                      .toLowerCase() ==
                                  "scheduled") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Looks like this time has already booked. Try picking another slot!")),
                                );
                              } else {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //       content:
                                //           Text("Slot selected successfully.")),
                                // );
                                docAppCon.setSelectedTimeData(appdata);
                              }
                            },
                            child: Container(
                              height: Sizes.screenHeight * 0.037,
                              width: Sizes.screenWidth * 0.26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color:

                                    // ? AppColor.lightBlue
                                    // :
                                    isPast ||
                                            appdata.slotAvailableFlag!
                                                    .toLowerCase() ==
                                                "scheduled"
                                        ? Colors.grey.shade400
                                        : docAppCon.selectedTime != null &&
                                                docAppCon
                                                        .selectedTime!.timeId ==
                                                    appdata.timeId
                                            ? AppColor.lightSkyBlue
                                            : const Color(0xffececec),
                              ),
                              child: Center(
                                  child:
                                      TextConst(appdata.slotTime.toString())),
                            ),
                          ),
                        );
                      },
                    ),
              Sizes.spaceHeight20,
              Center(
                child: ButtonConst(
                  width: Sizes.screenWidth * 0.84,
                  height: Sizes.screenHeight * 0.055,
                  title: AppLocalizations.of(context)!.book_your_appointment,
                  onTap: () {
                    //scrolling widget
                    if (isReschedule) {
                      docAppCon.setConfirmDailog(true);
                      _scrollToTop();
                    } else {
                      final userId = UserViewModel().getUser();
                      docAppCon.setRequestData({
                        'patient_id': userId,
                        "doctor_id": docAppCon.doctorAvlAppointmentModel!.data!
                            .slots![0].doctorId,
                        "clinic_id": docAppCon.doctorAvlAppointmentModel!.data!
                            .slots![0].clinicId,
                        "booking_date":
                            docAppCon.selectedDate!.availabilityDate,
                        "time_id": docAppCon.selectedTime!.timeId,
                        "amount": docAppCon.doctorAvlAppointmentModel!.data!
                            .location![0].consultationFee,
                        "payment_status": "Completed",
                        "payment_date": currentDate
                      }, context);
                      // Navigator.pushNamed(context, RoutesName.bookAppointmentScreen);

                      print(docAppCon.requestData);
                    }
                  },
                  color: docAppCon.selectedTime != null
                      ? AppColor.blue
                      : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget appointmentData() {
    final updateAppDetails = Provider.of<UpdateAppointmentViewModel>(context);
    final docAppointmentCon =
        Provider.of<DoctorAvlAppointmentViewModel>(context);
    final patientHomeCon = Provider.of<PatientHomeViewModel>(context);
    DateTime dateTime = DateTime.parse(docAppointmentCon
        .doctorAvlAppointmentModel!.data!.slots![0].availabilityDate
        .toString());
    String formattedDate = DateFormat('yyyy-dd-mm').format(dateTime);
    String currentDate = DateTime.now().toString().split(' ')[0];
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.screenWidth * 0.04,
            vertical: Sizes.screenHeight * 0.026),
        child: Column(
          children: [
            Sizes.spaceHeight20,
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.screenWidth * 0.04,
                  vertical: Sizes.screenHeight * 0.01),
              width: Sizes.screenWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColor.white),
              child: Column(
                children: [
                  TextConst(
                    AppLocalizations.of(context)!.are_you_sure_you,
                    size: Sizes.fontSizeFive,
                    fontWeight: FontWeight.w400,
                  ),
                  TextConst(
                    AppLocalizations.of(context)!.reschedule_your_appointment,
                    size: Sizes.fontSizeFive,
                    fontWeight: FontWeight.w400,
                  ),
                  Sizes.spaceHeight5,
                  BorderContainer(
                    padding: const EdgeInsets.all(1),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.screenWidth * 0.01,
                          vertical: Sizes.screenHeight * 0.004),
                      width: Sizes.screenWidth * 0.57,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.lightSkyBlue),
                      child: Column(
                        children: [
                          TextConst(
                            AppLocalizations.of(context)!
                                .new_appointment_details,
                            size: Sizes.fontSizeFour * 1.2,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textfieldTextColor,
                          ),
                          Sizes.spaceHeight3,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.iconsCalendar,
                                height: 25,
                              ),
                              Sizes.spaceWidth5,
                              TextConst(
                                "${DateFormat('yyyy-MM-dd').format(DateTime.parse(docAppointmentCon.selectedDate!.availabilityDate.toString()))} at ${docAppointmentCon.selectedTime!.slotTime}",
                                size: Sizes.fontSizeFour * 1.2,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Sizes.spaceHeight10,
                  GestureDetector(
                    onTap: () {
                      updateAppDetails.updateAppointmentApi(
                        context,
                        docId: docAppointmentCon.doctorAvlAppointmentModel!
                            .data!.details![0].doctorId,
                        clinicId: docAppointmentCon.doctorAvlAppointmentModel!
                            .data!.slots![0].clinicId,
                        bookingDate:
                            docAppointmentCon.selectedDate!.availabilityDate,
                        timeId: docAppointmentCon.selectedTime!.timeId!,
                      );
                    },
                    child: Container(
                      height: Sizes.screenHeight * 0.055,
                      width: Sizes.screenWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: AppColor.blue,
                          border:
                              Border.all(color: AppColor.lightBlue, width: 1)),
                      child: Center(
                        child: TextConst(
                          AppLocalizations.of(context)!
                              .confirm_your_appointment,
                          size: Sizes.fontSizeFive,
                          fontWeight: FontWeight.w500,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Sizes.spaceHeight10,
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.viewAppointmentsScreen);
              },
              child: TextConst(
                AppLocalizations.of(context)!.go_back,
                size: Sizes.fontSizeFive,
                fontWeight: FontWeight.w500,
                color: AppColor.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  int ratingValue = 4;
  final TextEditingController reviewCon = TextEditingController();
  final TextEditingController reviewDesCon = TextEditingController();
  Widget addReviews() {
    final docAppointmentCon =
        Provider.of<DoctorAvlAppointmentViewModel>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: AppColor.black,
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffE3E3E3).withOpacity(0.8),
        ),
        height: Sizes.screenHeight * 0.3,
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.screenWidth * 0.04,
            vertical: Sizes.screenHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                TextConst(
                  'Rate your experience',
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
                Sizes.spaceWidth10,
                starRating(
                  initialRating: 4,
                  size: 20.0,
                  onRatingChanged: (rating) {
                    setState(() {
                      ratingValue = rating;
                    });
                  },
                )
              ],
            ),
            Sizes.spaceHeight10,
            TextField(
              controller: reviewCon,
              decoration: InputDecoration(
                hintText: "Review title",
                hintStyle: TextStyle(
                    color: const Color(0xffC5C5C5),
                    fontWeight: FontWeight.w400,
                    fontSize: Sizes.fontSizeThree),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                fillColor: const Color(0xffF5F5F5),
                filled: true,
                contentPadding:
                    const EdgeInsets.only(left: 7, right: 7, top: 6, bottom: 6),
              ),
              cursorColor: AppColor.textGrayColor,
              cursorHeight: 20,
              style: const TextStyle(color: AppColor.blue, fontSize: 14),
            ),
            Sizes.spaceHeight10,
            TextField(
              controller: reviewDesCon,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Review description",
                hintStyle: TextStyle(
                    color: const Color(0xffC5C5C5),
                    fontWeight: FontWeight.w400,
                    fontSize: Sizes.fontSizeThree),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                fillColor: const Color(0xffF5F5F5),
                filled: true,
                contentPadding:
                    const EdgeInsets.only(left: 7, right: 7, top: 6, bottom: 6),
              ),
              cursorColor: AppColor.textGrayColor,
              cursorHeight: 20,
              style: const TextStyle(color: AppColor.blue, fontSize: 14),
            ),
            Sizes.spaceHeight10,
            ButtonConst(
              title: "Submit",
              onTap: () {
                Provider.of<AddReviewViewModel>(context, listen: false)
                    .addReviewApi(
                        docAppointmentCon.doctorAvlAppointmentModel!.data!
                            .details![0].doctorId,
                        ratingValue,
                        docAppointmentCon.doctorAvlAppointmentModel!.data!
                            .reviews![0].consultedFor,
                        reviewDesCon.text,
                        context);
              },
              borderRadius: 8,
              color: AppColor.blue,
              height: Sizes.screenHeight * 0.035,
              width: Sizes.screenWidth * 0.3,
            )
          ],
        ),
      ),
    );
  }

  Widget starRatings({
    required double averageRating,
    required double size,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if (averageRating >= index + 1) {
          return Icon(
            Icons.star,
            color: const Color(0xffFFE500),
            size: size,
          );
        } else if (averageRating > index && averageRating < index + 1) {
          return Icon(
            Icons.star_half,
            color: const Color(0xffFFE500),
            size: size,
          );
        } else {
          // Empty star
          return Icon(
            Icons.star_border,
            color: const Color(0xffFFE500),
            size: size,
          );
        }
      }),
    );
  }

  Widget starRating({
    required int initialRating,
    required double size,
    required Function(int) onRatingChanged,
  }) {
    int rating = initialRating;
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  rating = index + 1;
                });
                onRatingChanged(rating);
              },
              child: Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: index < rating ? const Color(0xffFFE500) : Colors.white,
                size: size,
              ),
            );
          }),
        );
      },
    );
  }
}
