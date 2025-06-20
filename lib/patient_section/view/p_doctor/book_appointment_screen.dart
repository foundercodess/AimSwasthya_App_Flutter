// patient_section/view/p_doctor/book_appointment_screen.dart
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/patient_section/p_view_model/doctor_avl_appointment_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/services/payment_con.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/google_map/view_static_location.dart';
import '../../p_view_model/patient_profile_view_model.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  bool isChecked = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final docAppointmentCon =
        Provider.of<DoctorAvlAppointmentViewModel>(context);
    final paymentCon = Provider.of<PaymentViewModel>(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppbarConst(
              title: AppLocalizations.of(context)!.back,
            ),
            Sizes.spaceHeight5,
            doctorSection(),
            Sizes.spaceHeight20,
            paymentSection(),
            Sizes.spaceHeight5,
            paymentHistory(),
            SizedBox(height: Sizes.screenHeight * 0.2),
          ],
        ),
      ),
      bottomSheet: Container(
        height: Sizes.screenHeight * 0.1,
        width: Sizes.screenWidth,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              // color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.screenWidth * 0.04,
              vertical: Sizes.screenHeight * 0.012),
          child: Column(
            children: [
              ButtonConst(
                title: AppLocalizations.of(context)!.book_an_appointment,
                fontWeight: FontWeight.w500,
                onTap: () {
                  final userProfileVm =
                      Provider.of<UserPatientProfileViewModel>(context,
                              listen: false)
                          .userPatientProfileModel!
                          .data![0];
                  if (_selectedPaymentIndex != null) {
                    final phone = userProfileVm.phoneNumber ?? "";
                    final email = userProfileVm.email ?? "";
                    final amount =
                        getPayableAmount().toString();

                    if (_selectedPaymentIndex == 0) {
                      paymentCon.payWithRazorpay(context, amount, phone, email);
                    } else if (_selectedPaymentIndex == 1) {
                      Utils.show(
                          "Phone-pe under maintenance! coming soon", context);
                    }
                  } else {
                    Utils.show("Choose payment method to proceed", context);
                  }
                },
                color:
                    _selectedPaymentIndex == null ? Colors.grey : AppColor.blue,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget doctorSection() {
    final docAppointmentCon =
        Provider.of<DoctorAvlAppointmentViewModel>(context);
    final formattedDate =
        docAppointmentCon.selectedDate!.availabilityDate.toString();
    final docData =
        docAppointmentCon.doctorAvlAppointmentModel!.data!.details![0];
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12),
      width: Sizes.screenWidth,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: AppColor.black.withOpacity(0.2),
              offset: const Offset(0, 1),
              spreadRadius: 0,
              blurRadius: 2)
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: Sizes.screenWidth * 0.42,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                  ),
                  child: docData.signedImageUrl != null
                      ? Image.network(
                          docData.signedImageUrl,
                          width: Sizes.screenWidth * 0.4,
                          height: Sizes.screenHeight / 7,
                          fit: BoxFit.cover,
                        )
                      : Image(
                          image: const AssetImage(Assets.logoDoctor),
                          width: Sizes.screenWidth * 0.4,
                          height: Sizes.screenHeight / 7,
                          fit: BoxFit.cover,
                        ),
                ),
                Container(
                  width: Sizes.screenWidth * 0.4,
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 8),
                  decoration: const BoxDecoration(
                    color: AppColor.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Sizes.spaceHeight5,
                      TextConst(
                        docData.experience ?? '',
                        size: Sizes.fontSizeThree,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                      Sizes.spaceHeight5,
                      TextConst(
                        maxLines: 1,
                        docAppointmentCon.doctorAvlAppointmentModel!.data!
                                .details![0].doctorName ??
                            '',
                        size: Sizes.fontSizeFourPFive,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                      ),
                      // Sizes.spaceHeight5,
                      TextConst(
                        "${docData.qualification} "
                        "(${docData.specializationName ?? ""})",
                        size: Sizes.fontSizeFour,
                        fontWeight: FontWeight.w400,
                        color: AppColor.white,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Sizes.spaceWidth3,
          Container(
            height: Sizes.screenHeight / 5,
            // color: Colors.green,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextConst(
                  AppLocalizations.of(context)!.appointment_details,
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff959595),
                ),
                FittedBox(
                  child: TextConst(
                      "$formattedDate at ${_formatTimeWithAmPm(docAppointmentCon.selectedTime!.slotTime!.toString())}",
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black),
                ),
                Sizes.spaceHeight10,
                TextConst(
                  AppLocalizations.of(context)!.clinic_details,
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff959595),
                ),
                // Sizes.spaceHeight5,
                GestureDetector(
                  onTap: () {
                    final dAVM = Provider.of<DoctorAvlAppointmentViewModel>(
                        context,
                        listen: false);
                    final clinicData =
                        dAVM.doctorAvlAppointmentModel!.data!.clinics![0];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GetLocationOnMap(
                                clinicName: clinicData.name.toString(),
                                address: clinicData.address.toString(),
                                latitude: double.parse(
                                    clinicData.latitude.toString()),
                                longitude: double.parse(
                                    clinicData.longitude.toString()))));
                  },
                  child: Container(
                    width: Sizes.screenWidth * 0.47,
                    height: Sizes.screenWidth*0.18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(image: AssetImage(Assets.allImagesViewMap), fit: BoxFit.fitHeight)
                    ),

                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget paymentSection() {
    final paymentCon = Provider.of<PaymentViewModel>(context);
    final docAppointmentCon =
        Provider.of<DoctorAvlAppointmentViewModel>(context);
    List payments = [
      {'image': Assets.iconsRazorpayIcon, 'name': 'Razor pay'},
      {'image': Assets.iconsPhonepeIcon, 'name': 'PhonePe'},
    ];
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.03,
          vertical: Sizes.screenHeight * 0.013),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextConst(
            "Choose payment method",
            size: Sizes.fontSizeFivePFive,
            fontWeight: FontWeight.w400,
          ),
          Sizes.spaceHeight15,
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.screenWidth * 0.03,
                vertical: Sizes.screenHeight * 0.02),
            width: Sizes.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppColor.blue,
            ),
            child: Column(
              children: [
                PaymentOptionWidget(
                  image: payments[0]['image'],
                  name: payments[0]['name'],
                  isSelected: _selectedPaymentIndex == 0,
                  onSelect: () {
                    setState(() {
                      _selectedPaymentIndex = 0;
                    });
                  },
                ),
                PaymentOptionWidget(
                  image: payments[1]['image'],
                  name: payments[1]['name'],
                  isSelected: _selectedPaymentIndex == 1,
                  onSelect: () {
                    setState(() {
                      _selectedPaymentIndex = 1;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentScreen() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Sizes.screenWidth * 0.03,
              vertical: Sizes.screenHeight * 0.004),
          height: Sizes.screenHeight * 0.3,
          width: Sizes.screenWidth,
          child: const Image(
            image: AssetImage(
              Assets.imagesPaymentHis,
            ),
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
            top: 17,
            child: Container(
              height: Sizes.screenHeight * 0.035,
              width: Sizes.screenWidth * 0.82,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [AppColor.lightPurpleColor, AppColor.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              // alignment: Alignment.center,
              child: Center(
                child: TextConst(
                  // textAlign: TextAlign.center,
                  AppLocalizations.of(context)!.get_digiSwasthya_card,
                  size: Sizes.screenWidth / 46,
                  // size:  Sizes.screenWidth ,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                ),
              ),
            ))
      ],
    );
  }

  Widget paymentHistory() {
    final docAppointmentCon =
        Provider.of<DoctorAvlAppointmentViewModel>(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.04,
          vertical: Sizes.screenHeight * 0.02),
      margin: const EdgeInsets.all(10),
      // height: Sizes.screenHeight * 0.34,
      width: Sizes.screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: AppColor.docProfileColor.withOpacity(0.7)
          color: Colors.grey.shade100.withOpacity(0.8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextConst(
            AppLocalizations.of(context)!.total_amount,
            size: Sizes.fontSizeFive,
            fontWeight: FontWeight.w400,
            color: const Color(0xff9D9696),
          ),
          Sizes.spaceHeight5,
          Row(
            children: [
              textConstent(),
              TextConst(
                "${getFee().toStringAsFixed(2)}",
                size: Sizes.fontSizeTen,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
            ],
          ),
          Sizes.spaceHeight15,
          TextConst(
            AppLocalizations.of(context)!.payment_details,
            size: Sizes.fontSizeFive,
            fontWeight: FontWeight.w600,
            color: AppColor.black,
          ),
          Sizes.spaceHeight5,
          dataField(
            AppLocalizations.of(context)!.appointment_fee,
            getFee().toStringAsFixed(2),
          ),
          dataField("Discount", "₹ ${getDiscountAmount().toStringAsFixed(2)}"),
          dataField(AppLocalizations.of(context)!.tax, ""),
          const Divider(),
          dataField(AppLocalizations.of(context)!.amount_payable,
              "₹ ${getPayableAmount().toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  double getFee() {
    final docAppointmentCon = Provider.of<DoctorAvlAppointmentViewModel>(context, listen: false);
    return double.tryParse(docAppointmentCon.doctorAvlAppointmentModel!.data!.clinics![0].fee.toString()) ?? 0.0;
  }

  double getDiscountPercent() {
    final docAppointmentCon = Provider.of<DoctorAvlAppointmentViewModel>(context, listen: false);
    return double.tryParse(docAppointmentCon.doctorAvlAppointmentModel!.data!.discountPercent![0].discount.toString()) ?? 0.0;
  }

  double getDiscountAmount() {
    return (getFee() * getDiscountPercent()) / 100;
  }

  double getPayableAmount() {
    double amount = getFee() - getDiscountAmount();
    return amount < 0 ? 0.0 : amount;
  }

  Widget dataField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          TextConst(label,
              size: Sizes.fontSizeFour,
              fontWeight: FontWeight.w400,
              color: AppColor.textfieldTextColor),
          const Spacer(),
          TextConst(
            value,
            size: Sizes.fontSizeFive,
            fontWeight: FontWeight.w400,
            color: AppColor.textfieldTextColor,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget textConstent() {
    return Text(
      "₹ ",
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: Sizes.fontSizeTen,
        color: const Color(0xff9D9696),
      ),
    );
  }

  int? _selectedPaymentIndex;

  String _formatTimeWithAmPm(String time24) {
    if (time24.isEmpty) return '';
    final parts = time24.split(":");
    if (parts.length < 2) return time24;
    int hour = int.tryParse(parts[0]) ?? 0;
    int minute = int.tryParse(parts[1]) ?? 0;
    final dt = DateTime(0, 1, 1, hour, minute);
    return TimeOfDay(hour: dt.hour, minute: dt.minute).format(context);
  }
}

class PaymentOptionWidget extends StatelessWidget {
  final String image;
  final String name;
  final bool isSelected;
  final VoidCallback onSelect;

  const PaymentOptionWidget({
    super.key,
    required this.image,
    required this.name,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Row(
        children: [
          Image.asset(image, width: 40, height: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                  color: AppColor.white, fontWeight: FontWeight.w400),
            ),
          ),
          Checkbox(
              value: isSelected,
              onChanged: (_) => onSelect(),
              activeColor: AppColor.blue,
              hoverColor: Colors.red),
        ],
      ),
    );
  }
}
