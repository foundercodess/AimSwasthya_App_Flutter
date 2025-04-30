import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HealthSectionScreen extends StatefulWidget {
  const HealthSectionScreen({super.key});

  @override
  State<HealthSectionScreen> createState() => _HealthSectionScreenState();
}

class _HealthSectionScreenState extends State<HealthSectionScreen> {
  bool _showAllTips = false;
  @override
  Widget build(BuildContext context) {
    final homeCon = Provider.of<PatientHomeViewModel>(context).patientHomeModel;
    if(homeCon==null){
      return const SizedBox();
    }
    final tipsToShow = _showAllTips
        ? homeCon.data!.healthtips!
        : homeCon.data!.healthtips!.take(2).toList();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.screenWidth * .04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextConst(
            AppLocalizations.of(context)!.keeping_you_healthy,
            size: Sizes.fontSizeFivePFive,
            fontWeight: FontWeight.w500,
          ),
          Sizes.spaceHeight20,
          if (homeCon.data!.healthtips!.isEmpty ||
              homeCon.data!.healthtips == null)
            const Center(child: NoDataFound()),
          if (homeCon.data != null && homeCon.data!.healthtips != null) ...[
            ListView.builder(
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tipsToShow.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final data = tipsToShow[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.screenWidth * 0.03,
                      vertical: Sizes.screenHeight * 0.008),
                  height: Sizes.screenHeight * 0.14,
                  width: Sizes.screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.grey),
                  child: Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Sizes.spaceHeight5,
                        TextConst(
                          data.title ?? "",
                          size: Sizes.fontSizeFour * 1.1,
                          fontWeight: FontWeight.w500,
                        ),
                        Sizes.spaceHeight15,
                        SizedBox(
                          width: Sizes.screenWidth * 0.6,
                          child: TextConst(
                            data.description ?? "",
                            size: Sizes.fontSizeThree * 1.05,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Sizes.spaceHeight5,
                        Container(
                          height: Sizes.screenHeight * 0.075,
                          width: Sizes.screenWidth * 0.25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:
                                // Image.network( doctor.imageUrl??"",
                                data.urlImage != null
                                    ? Image.network(
                                        data.urlImage!,
                                        height: Sizes.screenHeight * 0.075,
                                        width: Sizes.screenWidth * 0.25,
                                        fit: BoxFit.cover,
                                      )
                                    : Image(
                                        image:
                                            const AssetImage(Assets.logoDoctor),
                                        height: Sizes.screenHeight * 0.075,
                                        width: Sizes.screenWidth * 0.25,
                                        fit: BoxFit.fill,
                                      ),
                            // Image.network(
                            //   doctor.imageUrl != null && doctor.imageUrl!.isNotEmpty
                            //       ? doctor.imageUrl!
                            //       : "assets/images/doctorImg.jpg",
                            //   height: Sizes.screenHeight * 0.13,
                            //   width: double.infinity,
                            //   fit: BoxFit.fill,
                            // )
                          ),
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(8),
                          //     image:
                          //     DecorationImage(
                          //         image: AssetImage(Assets.logoDoctor),
                          //         fit: BoxFit.cover)),
                          // child: Image.asset(Assets.logoDoctor,fit: BoxFit.cover,),
                        ),
                        Sizes.spaceHeight5,
                        Sizes.spaceHeight3,
                        InkWell(
                          onTap: () {
                            if (data.urlArticle != null &&
                                data.urlArticle!.isNotEmpty) {
                              Share.share(data.urlArticle!);
                            } else {
                              Share.share('Check out this amazing app!');
                            }
                          },
                          child: const Icon(
                            Icons.share_outlined,
                            color: AppColor.lightBlue,
                          ),
                        )
                      ],
                    )
                  ]),
                );
              },
            ),
            SizedBox(
              height: Sizes.screenHeight * 0.02,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _showAllTips = !_showAllTips;
                  });
                },
                child: TextConst(
                  _showAllTips
                      ? AppLocalizations.of(context)!.view_all
                      : AppLocalizations.of(context)!.view_all,
                  size: Sizes.fontSizeFourPFive,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
