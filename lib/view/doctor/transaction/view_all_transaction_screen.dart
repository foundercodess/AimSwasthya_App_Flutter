// view/doctor/transaction/view_all_transaction_screen.dart
// Flutter imports
import 'package:flutter/material.dart';

// Third party imports
import 'package:provider/provider.dart';

// Local imports
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/view_model/doctor/revenue_doctor_view_model.dart';

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
              if (revenueDocCon.revenueDoctorModel != null &&
                  revenueDocCon.revenueDoctorModel!.patientPayment!.isNotEmpty) ...[
                _buildSection("Today", "today"),
                _buildSection("Yesterday", "yesterday"),
                _buildSection("History", "history"),
              ] else
                 Center(child: Container(
                   alignment: Alignment.bottomCenter,
                   height: Sizes.screenHeight*0.5,
                  child: const NoDataMessages(
                    message: "No transactions found",
                    title:
                    "You haven't recived any transactions yet",
                  ),
                )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String section) {
    final revenueDocCon = Provider.of<RevenueDoctorViewModel>(context);
    final sectionTransactions = revenueDocCon.revenueDoctorModel!.patientPayment!
        .where((payment) => payment.section == section)
        .toList();

    if (sectionTransactions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextConst(
              title,
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
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: sectionTransactions.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final revData = sectionTransactions[index];
            return Container(
              margin: EdgeInsets.only(bottom: Sizes.screenHeight * 0.02),
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.screenWidth * 0.04,
              ),
              width: Sizes.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 18,
                      width: 18,
                      color: revData.amount.toString().startsWith('-')
                          ? const Color(0xffC10000).withOpacity(0.2)
                          : const Color(0xff36D000).withOpacity(0.2),
                    ),
                    revData.amount.toString().startsWith('-')
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
                  size: Sizes.fontSizeFourPFive,
                  fontWeight: FontWeight.w400,
                ),
                subtitle: TextConst(
                  revData.amount.toString().startsWith('-')
                      ? "Cancellation charged"
                      : "Appointment booked  Payment mode : UPI",
                  size: Sizes.fontSizeTwo,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffB5B5B5),
                ),
                trailing: TextConst(
                  revData.amount.toString(),
                  size: Sizes.fontSizeFourPFive,
                  fontWeight: FontWeight.w400,
                  color: revData.amount.toString().startsWith('-')
                      ? const Color(0xffC10000)
                      : const Color(0xff36D000),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
