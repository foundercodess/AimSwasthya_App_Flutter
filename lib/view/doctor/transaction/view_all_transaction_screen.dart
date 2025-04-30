import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/view_model/doctor/revenue_doctor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllTransactionScreen extends StatefulWidget {
  const ViewAllTransactionScreen({super.key});

  @override
  State<ViewAllTransactionScreen> createState() =>
      _ViewAllTransactionScreenState();
}

class _ViewAllTransactionScreenState extends State<ViewAllTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final revenueDocCon = Provider.of<RevenueDoctorViewModel>(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      // appBar: appBarConstant(
      //   context,
      //   isBottomAllowed: true,
      // ),
      body: Padding(
        padding: EdgeInsets.only(
          left: Sizes.screenWidth * 0.05,
          right: Sizes.screenWidth * 0.05,
          top: Sizes.screenHeight * 0.03,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBarConstant(
                context,
                paddingAllowed: false,
                isBottomAllowed: true,
              ),
              Row(
                children: [
                  TextConst(
                    "Today",
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w400,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      TextConst(
                        "Sort",
                        size: Sizes.fontSizeFour,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightBlack,
                      ),
                      Sizes.spaceWidth5,
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        weight: 0.5,
                        color: AppColor.lightBlack,
                      )
                    ],
                  )
                ],
              ),
              Sizes.spaceHeight20,
              transaction(),
              Sizes.spaceHeight20,
              Row(
                children: [
                  TextConst(
                    "Today",
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w400,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      TextConst(
                        "Sort",
                        size: Sizes.fontSizeFour,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightBlack,
                      ),
                      Sizes.spaceWidth5,
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        weight: 0.5,
                        color: AppColor.lightBlack,
                      )
                    ],
                  )
                ],
              ),
              Sizes.spaceHeight20,
              transaction(),
            ],
          ),
        ),
      ),
    );
  }

  Widget transaction() {
    final revenueDocCon = Provider.of<RevenueDoctorViewModel>(context);
    return revenueDocCon.revenueDoctorModel != null &&
            revenueDocCon.revenueDoctorModel!.patientPayment!.isNotEmpty
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: revenueDocCon.revenueDoctorModel!.patientPayment!.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final revData =
                  revenueDocCon.revenueDoctorModel!.patientPayment![index];
              return Container(
                margin: EdgeInsets.only(bottom: Sizes.screenHeight * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.screenWidth * 0.04,
                ),
                width: Sizes.screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100
                    // color: AppColor.grey.withOpacity(0.8),
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
                    revData.name ?? "",
                    // "Kartik Mahajan",
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w400,
                  ),
                  subtitle: index == 1
                      ? TextConst(
                          "Cancellation charged",
                          size: Sizes.fontSizeTwo,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffB5B5B5),
                        )
                      : TextConst(
                          "Appointment booked  Payment mode : UPI",
                          size: Sizes.fontSizeTwo,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffB5B5B5),
                        ),
                  trailing: index == 1
                      ? TextConst(
                          revData.amount.toString(),
                          // "-50",
                          size: Sizes.fontSizeFourPFive,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffC10000),
                        )
                      : TextConst(
                          "+450",
                          size: Sizes.fontSizeFourPFive,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff36D000),
                        ),
                ),
              );
            })
        : const Center(child: NoDataMessages());
  }
}
