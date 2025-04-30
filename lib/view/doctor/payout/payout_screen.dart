import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/material.dart';

class PayoutScreen extends StatefulWidget {
  const PayoutScreen({super.key});

  @override
  State<PayoutScreen> createState() => _PayoutScreenState();
}

class _PayoutScreenState extends State<PayoutScreen> {
  int selectedIndex = 0;
  void toggleSelection(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppbarConst(
              title: 'Payment',
            ),
            TextConst(
              "Payment details",
              padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
              size: Sizes.fontSizeFivePFive,
              // size: 14,
              fontWeight: FontWeight.w400,
            ),
            Sizes.spaceHeight20,
            doctorSection(),
            Sizes.spaceHeight30,
            TextConst(
              "Select a payment method",
              padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
              size: Sizes.fontSizeFivePFive,
              fontWeight: FontWeight.w400,
            ),
            Sizes.spaceHeight20,
            paymentMethod("Use a card", Assets.iconsRazorpayIcon,
                "Debit/Credit cards", 0),
            Sizes.spaceHeight3,
            paymentMethod("Google pay", Assets.iconsGpayIcon, "", 1),
            // Sizes.spaceHeight3,
            // paymentMethod("PhonePe", Assets.iconsPaytmIcon, "", 2),
            // Sizes.spaceHeight3,
            // paymentMethod("Google pay", Assets.iconsPaytmIcon, "", 3),
            Sizes.spaceHeight30,
            TextConst(
              "Payment details",
              padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
              size: Sizes.fontSizeFivePFive,
              fontWeight: FontWeight.w400,
            ),
            Sizes.spaceHeight15,
            paymentDetails("Revenue", "24000"),
            Sizes.spaceHeight10,
            paymentDetails("(Platform fee)", "(4000)"),
            Sizes.spaceHeight15,
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
            // Sizes.spaceHeight3,
            paymentDetails("Net revenue", "2000"),
            SizedBox(height: Sizes.screenHeight * 0.06),
            Padding(
              padding: EdgeInsets.only(left: Sizes.screenWidth*0.06,right: Sizes.screenWidth*0.06,),
              child: AppBtn(
                width: Sizes.screenWidth,
                  title: "Proceed to payout",
                  color: AppColor.blue,
                  height: Sizes.screenHeight * 0.065,
                  onTap: () {}),
            ),
            // Padding(
            //   padding:
            //       EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.055),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black.withOpacity(0.2),
            //           blurRadius: 15,
            //           offset: const Offset(2, 0),
            //         ),
            //       ],
            //     ),
            //     child: CustomSliderButton(
            //       label: "Slide to withdraw",
            //       buttonColor: const Color(0xff004AAD),
            //       backgroundColor: const Color(0xffF3F3F3),
            //       width: Sizes.screenWidth,
            //       onSlideComplete: () {
            //         if (kDebugMode) {
            //           print("Slider action triggered!");
            //         }
            //       },
            //     ),
            //   ),
            // ),
            Sizes.spaceHeight15,
          ],
        ),
      ),
    );
  }

  Widget doctorSection() {
    return Container(
      margin: EdgeInsets.only(
          left: Sizes.screenWidth * 0.05, right: Sizes.screenWidth * 0.04),
      width: Sizes.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.whiteColor,
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
            width: Sizes.screenWidth * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                  ),
                  child: Image(
                    image: const AssetImage(Assets.imagesDocPatient),
                    width: Sizes.screenWidth * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: Sizes.screenWidth * 0.42,
                  padding: const EdgeInsets.only(left: 10, top: 4, bottom: 8),
                  decoration: const BoxDecoration(
                    color: AppColor.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Sizes.spaceHeight5,
                      TextConst(
                        "8 years experience",
                        size: Sizes.fontSizeThree,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                      Sizes.spaceHeight3,
                      TextConst(
                        "Dr. Vikram Batra",
                        size: Sizes.fontSizeFourPFive,
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                      // Sizes.spaceHeight5,
                      TextConst(
                        "MBBS, MD (Cardiology)",
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
          Container(
            padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextConst(
                  "Payout details :",
                  // size: 10,
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff959595),
                ),
                Sizes.spaceHeight10,
                TextConst("Rs. 20000/-",
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black),
                Sizes.spaceHeight10,
                TextConst(
                  "Time period :",
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff959595),
                ),
                Sizes.spaceHeight10,
                TextConst("1 Apr - 20 Apr",
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget paymentMethod(
      String title, String image, dynamic subtitle, int cutiePyi) {
    return Card(
      margin: EdgeInsets.only(
          left: Sizes.screenWidth * 0.05,
          right: Sizes.screenWidth * 0.04,
          bottom: Sizes.screenHeight * 0.006),
      color: AppColor.grey,
      elevation: 1,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.screenWidth * 0.04,
            vertical: Sizes.screenHeight * 0.01),
        width: Sizes.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              width: Sizes.screenWidth * 0.12,
              height: Sizes.screenWidth * 0.12,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextConst(
                    title,
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w400,
                  ),
                  if (subtitle != '')
                    TextConst(
                      subtitle,
                      size: Sizes.fontSizeFour,
                      fontWeight: FontWeight.w300,
                      color: AppColor.lightBlack,
                    ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => toggleSelection(cutiePyi),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.lightBlack, width: 0.5)),
                child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == cutiePyi
                        ? AppColor.lightBlue
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentDetails(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextConst(
          label,
          padding: EdgeInsets.only(left: Sizes.screenWidth * 0.05),
          size: Sizes.fontSizeFourPFive,
          color: AppColor.textfieldTextColor,
          fontWeight: FontWeight.w400,
        ),
        TextConst(
          amount,
          padding: EdgeInsets.only(right: Sizes.screenWidth * 0.04),
          size: Sizes.fontSizeFourPFive,
          color: AppColor.textfieldTextColor,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
