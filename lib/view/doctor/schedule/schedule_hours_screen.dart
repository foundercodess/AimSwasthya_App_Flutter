import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view_model/doctor/doc_graph_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/revenue_doctor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ScheduleHoursScreen extends StatefulWidget {
  const ScheduleHoursScreen({super.key});

  @override
  State<ScheduleHoursScreen> createState() => _ScheduleHoursScreenState();
}

class _ScheduleHoursScreenState extends State<ScheduleHoursScreen> {
  @override
  Widget build(BuildContext context) {
    final revenueDocCon = Provider.of<RevenueDoctorViewModel>(context);
    return revenueDocCon.revenueDoctorModel == null || revenueDocCon.loading
        ? const Center(child: LoadData())
        : Scaffold(
            backgroundColor: AppColor.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBarConstant(
                    context,
                    paddingAllowed: true,
                    isBottomAllowed: true,
                  ),
                  Sizes.spaceHeight5,
                  payoutSection(),
                  SizedBox(
                    height: Sizes.screenHeight * 0.05,
                  ),
                  scheduleGraph(),
                  SizedBox(
                    height: Sizes.screenHeight * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes.screenWidth * 0.05),
                    child: Row(
                      children: [
                        TextConst(
                          "Transactions",
                          size: Sizes.fontSizeFourPFive,
                          fontWeight: FontWeight.w400,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.viewAllTransactionScreen);
                          },
                          child: Row(
                            children: [
                              TextConst(
                                "View all",
                                size: Sizes.fontSizeFour,
                                fontWeight: FontWeight.w400,
                                color: AppColor.lightBlack,
                              ),
                              Sizes.spaceWidth5,
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: AppColor.lightBlack,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Sizes.spaceHeight10,
                  transaction()
                ],
              ),
            ),
          );
  }

  Widget payoutSection() {
    final revenueDocCon = Provider.of<RevenueDoctorViewModel>(context);
    return SizedBox(
      height: Sizes.screenHeight * 0.195,
      // color: Colors.red,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: Sizes.screenHeight * 0.17,
            margin: EdgeInsets.symmetric(
              horizontal: Sizes.screenWidth * 0.05,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.screenWidth * 0.04,
                vertical: Sizes.screenHeight * 0.015),
            width: Sizes.screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.grey.withOpacity(0.7)),
            child: Column(
              children: [
                Row(
                  children: [
                    TextConst(
                      "Net revenue :",
                      size: Sizes.fontSizeFourPFive,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textGrayColor,
                    ),
                    const Spacer(),
                    TextConst(
                      revenueDocCon.revenueDoctorModel!.earning![0].monthYear ??
                          "",
                      // "April",
                      size: Sizes.fontSizeFour,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textfieldTextColor,
                    ),
                    Sizes.spaceWidth5,
                    Image.asset(
                      Assets.iconsArrowDown,
                      width: Sizes.screenWidth * 0.05,
                      color: AppColor.textfieldTextColor,
                    )
                  ],
                ),
                Sizes.spaceHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.iconsRupees,
                      width: Sizes.screenWidth * 0.15,
                    ),
                    Sizes.spaceWidth10,
                    TextConst(
                      revenueDocCon.revenueDoctorModel!.earning![0].totalAmount
                          .toString(),
                      // 'Rs. 20,000/-',
                      size: Sizes.fontSizeFivePFive,
                      fontWeight: FontWeight.w400,
                      color: AppColor.black,
                    ),
                  ],
                ),
                Sizes.spaceHeight20,
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: ButtonConst(
                  title: "Payout",
                  fontWeight: FontWeight.w500,
                  size: Sizes.fontSizeFourPFive,
                  borderRadius: 8,
                  color: AppColor.blue,
                  width: Sizes.screenWidth * 0.55,
                  height: Sizes.screenHeight * 0.047,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.payoutScreen);
                  })),
        ],
      ),
    );
  }

  Widget scheduleGraph() {
    final weekdayAnalytics = Provider.of<DocGraphViewModel>(context);
    final PageController pageController = PageController();
    int itemCount = 2;
    return Column(
      children: [
        SizedBox(
          height: Sizes.screenHeight * 0.23,
          width: Sizes.screenWidth,
          child: PageView.builder(
              controller: pageController,
              itemCount: itemCount,
              onPageChanged: (index) {
                setState(() {});
              },
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(
                      right: Sizes.screenWidth * 0.05,
                      left: Sizes.screenWidth * 0.05),
                  padding: EdgeInsets.only(
                      left: Sizes.screenWidth * 0.04,
                      right: Sizes.screenWidth * 0.04,
                      // bottom: Sizes.screenHeight * 0.001,
                      top: Sizes.screenHeight * 0.015),
                  width: Sizes.screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.textfieldGrayColor.withOpacity(0.3)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextConst(
                            "Revenue analytics",
                            size: Sizes.fontSizeFourPFive,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textGrayColor,
                          ),
                          const Spacer(),
                          TextConst(
                            "Last 7 days",
                            size: Sizes.fontSizeFour,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textfieldTextColor,
                          ),
                          Sizes.spaceWidth5,
                          Image.asset(
                            Assets.iconsArrowDown,
                            width: Sizes.screenWidth * 0.05,
                            color: AppColor.textfieldTextColor,
                          )
                        ],
                      ),
                      SizedBox(
                        height: Sizes.screenHeight * 0.16,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: weekdayAnalytics.weekdayAnalytics.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final weekdays =
                                  weekdayAnalytics.weekdayAnalytics[index];
                              return SizedBox(
                                width: Sizes.screenWidth * 0.11,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RotatedBox(
                                      quarterTurns: -1,
                                      child: SizedBox(
                                        height: Sizes.screenHeight * 0.008,
                                        width: Sizes.screenWidth * 0.2,
                                        child: LinearProgressIndicator(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                          value: weekdays['value'] / 100,
                                          backgroundColor: Colors.transparent,
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(AppColor.lightBlue),
                                        ),
                                      ),
                                    ),
                                    Sizes.spaceHeight5,
                                    TextConst(
                                      weekdays["day"],
                                      size: Sizes.fontSizeFour,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.lightBlack,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                );
              }),
        ),
        Sizes.spaceHeight10,
        Center(
          child: SmoothPageIndicator(
            controller: pageController,
            count: itemCount,
            effect: const ScrollingDotsEffect(
              activeDotColor: AppColor.lightBlue,
              dotColor: Color(0xffececec),
              dotHeight: 6,
              dotWidth: 6,
            ),
          ),
        ),
      ],
    );
  }

  Widget transaction() {
    final revenueDocCon = Provider.of<RevenueDoctorViewModel>(context);
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: revenueDocCon.revenueDoctorModel!.patientPayment!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final paymentData =
              revenueDocCon.revenueDoctorModel!.patientPayment![index];
          return Container(
            margin: EdgeInsets.only(
                bottom: Sizes.screenHeight * 0.02,
                left: Sizes.screenWidth * 0.05,
                right: Sizes.screenWidth * 0.05),
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.screenWidth * 0.04,
                vertical: Sizes.screenHeight * 0.001),
            width: Sizes.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.grey,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 18,
                    width: 18,
                    color: index == 1
                        ? const Color(0xffC10000).withOpacity(0.2)
                        : const Color(0xff36D000).withOpacity(0.2),
                  ),
                  index == 1
                      ? const Icon(
                          Icons.remove,
                          size: 27,
                        )
                      : const Icon(
                          Icons.add,
                          size: 27,
                        ),
                ],
              ),
              title: TextConst(
                paymentData.name ?? "",
                // "Kartik Mahajan",
                // size: 12,
                size: Sizes.fontSizeFourPFive,
                fontWeight: FontWeight.w400,
              ),
              trailing: index == 1
                  ? TextConst(
                      paymentData.amount ?? "",
                      // "-50",
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffC10000),
                    )
                  : TextConst(
                      "+450",
                      // size: 12,
                      size: Sizes.fontSizeFourPFive,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff36D000),
                    ),
            ),
          );
        });
  }
}
