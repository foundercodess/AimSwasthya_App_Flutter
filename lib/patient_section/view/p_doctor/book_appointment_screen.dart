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

import '../../p_view_model/patient_profile_view_model.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  bool isChecked = false;

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
                  final userProfileVm= Provider.of<UserPatientProfileViewModel>(context,listen: false).userPatientProfileModel!.data![0];
                  if (_selectedPaymentIndex != null) {
                    final phone = userProfileVm.phoneNumber ??
                        "";
                    final email = userProfileVm.email ??
                        "";
                    final amount =
                        docAppointmentCon.payableAmountAfterDiscount.toString();

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
            color: Colors.transparent,
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
                // Sizes.spaceHeight10,
                TextConst(
                    "$formattedDate at ${docAppointmentCon.selectedTime!.slotTime!.toString()} AM",
                    //   "01/06/2024 at 12:30 pm",
                    size: Sizes.fontSizeFive,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black),
                // Sizes.spaceHeight10,
                TextConst(
                  AppLocalizations.of(context)!.clinic_details,
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff959595),
                ),
                // Sizes.spaceHeight5,
                SizedBox(
                  width: Sizes.screenWidth * 0.47,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      Assets.imagesMapImg,
                      fit: BoxFit.contain,
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

  bool isExpended = false;

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
            // height: Sizes.screenHeight*0.2,
            width: Sizes.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppColor.blue,
            ),
            child: Column(
              children: [
                paymentOptionWidget(
                  image: payments[0]['image'],
                  name: payments[0]['name'],
                  isSelected: _selectedPaymentIndex == 0,
                  onSelect: () {
                    setState(() {
                      _selectedPaymentIndex = 0;
                    });
                  },
                  onTap: () {},
                ),
                paymentOptionWidget(
                  image: payments[1]['image'],
                  name: payments[1]['name'],
                  isSelected: _selectedPaymentIndex == 1,
                  onSelect: () {
                    setState(() {
                      _selectedPaymentIndex = 1;
                    });
                  },
                  onTap: () {
                    // optional
                  },
                ),
              ],
            ),
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(40),
          //   child: ExpansionTile(
          //     onExpansionChanged: (v) {
          //       setState(() {
          //         isExpended = v;
          //       });
          //     },
          //     collapsedBackgroundColor: AppColor.blue,
          //     backgroundColor: AppColor.blue,
          //     leading: Image.asset(
          //       Assets.logoRupayLogo,
          //       height: 20,
          //     ),
          //     title: TextConst(
          //       'Debit card : **** **** 0056',
          //       size: Sizes.fontSizeFivePFive,
          //       fontWeight: FontWeight.w400,
          //       color: AppColor.white,
          //     ),
          //     trailing: Icon(
          //       isExpended ? Icons.keyboard_arrow_up : Icons.expand_more,
          //       color: AppColor.white,
          //     ),
          //     children: [
          //       Container(
          //         margin: EdgeInsets.symmetric(
          //             horizontal: Sizes.screenWidth * 0.04,
          //             vertical: Sizes.screenHeight * 0.015),
          //         padding: EdgeInsets.symmetric(
          //             horizontal: Sizes.screenWidth * 0.04,
          //             vertical: Sizes.screenHeight * 0.015),
          //         // height: Sizes.screenHeight * 0.3,
          //         width: Sizes.screenWidth,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(40),
          //             color: const Color(0xff015cd6)),
          //         child: Column(
          //           children: [
          //             Container(
          //               width: Sizes.screenWidth,
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(30),
          //                   color: AppColor.lightBlue),
          //               child: Center(
          //                 child: ListTile(
          //                   title: TextConst(
          //                     AppLocalizations.of(context)!
          //                         .added_debit_credit_Cards,
          //                     size: Sizes.fontSizeFive,
          //                     fontWeight: FontWeight.w400,
          //                     color: AppColor.white,
          //                   ),
          //                   trailing: const Icon(
          //                     Icons.expand_more,
          //                     color: AppColor.white,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Sizes.spaceHeight10,
          //             Row(
          //               children: [
          //                 Expanded(
          //                   child: Divider(
          //                     color: AppColor.lightSkyBlue.withOpacity(0.4),
          //                     thickness: 0.8,
          //                   ),
          //                 ),
          //                 Container(
          //                   padding: const EdgeInsets.symmetric(
          //                       horizontal: 8, vertical: 2),
          //                   decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(5),
          //                       color: Colors.white.withOpacity(0.1)),
          //                   child: Center(
          //                     child: TextConst(
          //                       AppLocalizations.of(context)!.other_methods,
          //                       size: Sizes.fontSizeThree,
          //                       fontWeight: FontWeight.w300,
          //                       color: AppColor.grey.withOpacity(0.8),
          //                     ),
          //                   ),
          //                 ),
          //                 Expanded(
          //                   child: Divider(
          //                     color: AppColor.lightSkyBlue.withOpacity(0.4),
          //                     thickness: 0.8,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             // paymentOptionWidget(
          //             //     image: payments[0]['image'],
          //             //     name: payments[0]['name'],
          //             //     onTap: () {
          //             //       paymentCon.payWithRazorpay(
          //             //           context,
          //             //           docAppointmentCon.payableAmountAfterDiscount
          //             //               .toString(),
          //             //           docAppointmentCon.doctorAvlAppointmentModel!
          //             //               .data!.details![0].phoneNumber
          //             //               .toString(),
          //             //           docAppointmentCon.doctorAvlAppointmentModel!
          //             //               .data!.details![0].email);
          //             //     }),
          //             // paymentOptionWidget(
          //             //     image: payments[1]['image'],
          //             //     name: payments[1]['name'],
          //             //     onTap: () {
          //             //       paymentCon.payWithPhonePe(
          //             //         context,
          //             //         docAppointmentCon.payableAmountAfterDiscount
          //             //             .toString(),
          //             //         docAppointmentCon.doctorAvlAppointmentModel!.data!
          //             //             .details![0].phoneNumber
          //             //             .toString(),
          //             //       );
          //             //     }),
          //             paymentOptionWidget(
          //               image: payments[0]['image'],
          //               name: payments[0]['name'],
          //               isSelected: _selectedPaymentIndex == 0,
          //               onSelect: () {
          //                 setState(() {
          //                   _selectedPaymentIndex = 0;
          //                 });
          //               },
          //               onTap: () {
          //               },
          //             ),
          //             paymentOptionWidget(
          //               image: payments[1]['image'],
          //               name: payments[1]['name'],
          //               isSelected: _selectedPaymentIndex == 1,
          //               onSelect: () {
          //                 setState(() {
          //                   _selectedPaymentIndex = 1;
          //                 });
          //               },
          //               onTap: () {
          //                 // optional
          //               },
          //             ),
          //
          //             // ListView.builder(
          //             //   padding: const EdgeInsets.all(0),
          //             //   itemCount: payments.length,
          //             //   shrinkWrap: true,
          //             //   itemBuilder: (context, index) {
          //             //     final payment = payments[index];
          //             //     return Padding(
          //             //       padding: EdgeInsets.symmetric(
          //             //           horizontal: Sizes.screenWidth * 0.02,
          //             //           vertical: Sizes.screenHeight * 0.005),
          //             //       child: Row(
          //             //         children: [
          //             //           InkWell(
          //             //             onTap: () {
          //             //               if (payment['name'] == 'Razor Pay') {
          //             //                 print("fbyferrytgr");
          //             //                 paymentCon.initiatePayment(
          //             //                   context,
          //             //                   docAppointmentCon
          //             //                       .doctorAvlAppointmentModel!.data!.location![0].consultationFee
          //             //                       .toString(),
          //             //                   docAppointmentCon
          //             //                       .doctorAvlAppointmentModel!.data!.details![0].phoneNumber
          //             //                       .toString(),
          //             //                   docAppointmentCon.doctorAvlAppointmentModel!.data!.details![0].email,
          //             //                 );}
          //             //               else if (payment['name'] == 'Google Pay') {
          //             //                 print("ansjsji");
          //             //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>MerchantApp()));
          //             //                 // paymentCon.initiateGooglePayPayment(
          //             //                 //   context,
          //             //                 //   docAppointmentCon
          //             //                 //       .doctorAvlAppointmentModel!.data!.location![0].consultationFee
          //             //                 //       .toString(),
          //             //                 //   docAppointmentCon
          //             //                 //       .doctorAvlAppointmentModel!.data!.details![0].phoneNumber
          //             //                 //       .toString(),
          //             //                 //   docAppointmentCon.doctorAvlAppointmentModel!.data!.details![0].email,
          //             //                 // );
          //             //               }
          //             //
          //             //               paymentCon.initiatePayment(
          //             //                   context,
          //             //                   docAppointmentCon
          //             //                       .doctorAvlAppointmentModel!
          //             //                       .data!
          //             //                       .location![0]
          //             //                       .consultationFee
          //             //                       .toString(),
          //             //                   docAppointmentCon
          //             //                       .doctorAvlAppointmentModel!
          //             //                       .data!
          //             //                       .details![0]
          //             //                       .phoneNumber
          //             //                       .toString(),
          //             //                   docAppointmentCon
          //             //                       .doctorAvlAppointmentModel!
          //             //                       .data!
          //             //                       .details![0]
          //             //                       .email);
          //             //             },
          //             //             child: Container(
          //             //               width: 32,
          //             //               height: 32,
          //             //               decoration: BoxDecoration(
          //             //                 shape: BoxShape.circle,
          //             //                 image: DecorationImage(
          //             //                   image: AssetImage(payment['image']),
          //             //                   fit: BoxFit.cover,
          //             //                 ),
          //             //               ),
          //             //             ),
          //             //           ),
          //             //           Sizes.spaceWidth10,
          //             //           TextConst(
          //             //             payment['name'],
          //             //             size: Sizes.fontSizeFour,
          //             //             fontWeight: FontWeight.w400,
          //             //             color: AppColor.white,
          //             //           ),
          //             //         ],
          //             //       ),
          //             //     );
          //             //   },
          //             // )
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
                "${docAppointmentCon.doctorAvlAppointmentModel!.data!.clinics![0].fee.toString()}.00",
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
            docAppointmentCon.doctorAvlAppointmentModel!.data!.clinics![0].fee
                .toString(),
          ),
          // dataField(
          //     AppLocalizations.of(context)!.digiSwasthya_discount,
          //     docAppointmentCon.doctorAvlAppointmentModel!.data!.location![0]
          //         .digiswasthyaDiscount
          //         .toString()),
          dataField(AppLocalizations.of(context)!.tax, ""),
          const Divider(),
          dataField(AppLocalizations.of(context)!.amount_payable,
              docAppointmentCon.payableAmountAfterDiscount.toString()
              // calculateAmountPayable(
              //   docAppointmentCon
              //       .doctorAvlAppointmentModel!.data!.location![0].fee,
              //   docAppointmentCon
              //       .doctorAvlAppointmentModel!.data!.location![0].digiswasthyaDiscount,
              // ).toString(),
              ),
        ],
      ),
    );
  }

  double calculateAmountPayable(double fee, double digiswasthyaDiscount) {
    double totalAmount = fee - digiswasthyaDiscount;
    if (totalAmount < 0) {
      totalAmount = 0.0;
    }

    return totalAmount;
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
  Widget paymentOptionWidget({
    required String image,
    required String name,
    required bool isSelected,
    required VoidCallback onTap,
    required VoidCallback onSelect,
  }) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        // padding: const EdgeInsets.all(12),
        // decoration: BoxDecoration(
        //   border: Border.all(
        //     color: isSelected ? AppColor.blue : Colors.grey,
        //     width: 2,
        //   ),
        //   borderRadius: BorderRadius.circular(10),
        // ),
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
      ),
    );
  }

// Widget paymentOptionWidget({
  //   required String image,
  //   required String name,
  //   required VoidCallback onTap,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  //     child: GestureDetector(
  //       onTap: onTap,
  //       child: Row(
  //         children: [
  //           Container(
  //             width: 32,
  //             height: 32,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               image: DecorationImage(
  //                 image: AssetImage(image),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(width: 10),
  //           TextConst(
  //             name,
  //             size: Sizes.fontSizeFour,
  //             fontWeight: FontWeight.w400,
  //             color: AppColor.white,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
