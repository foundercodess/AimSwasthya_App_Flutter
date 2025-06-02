// view/user/home/health_section_screen.dart
import 'dart:ui';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:aim_swasthya/view_model/user/wellness_library_view_model.dart';
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
    final wellnessCon = Provider.of<WellnessLibraryViewModel>(context);
    final model = wellnessCon.getWellnessLibraryModel;

    if (homeCon == null) {
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
                bool isAddedToMyWillness = model != null
                    ? model.data!.any((e) =>
                        e.healthTipId.toString() == data.healthTipId.toString())
                    : false;
                return Padding(
                  padding: EdgeInsets.only(bottom: Sizes.screenHeight * 0.025),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/health_yoga.png",
                          height: Sizes.screenHeight * 0.19,
                          width: Sizes.screenWidth,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xff889fab).withOpacity(0.6),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Sizes.screenWidth * 0.025,
                                    vertical: Sizes.screenHeight * 0.016,
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        spacing: 5,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: Sizes.screenWidth * 0.7,
                                            child: TextConst(
                                              overflow: TextOverflow.ellipsis,
                                              data.title ?? "",
                                              size: Sizes.fontSizeFourPFive,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Sizes.screenWidth * 0.7,
                                            child: TextConst(
                                              overflow: TextOverflow.ellipsis,
                                              data.description ?? "",
                                              size: Sizes.fontSizeThree,
                                              fontWeight: FontWeight.w300,
                                              color: AppColor.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Sizes.spaceWidth5,
                                      InkWell(
                                        onTap: () {
                                          if (isAddedToMyWillness) {
                                            wellnessCon.upsertWellnessApi(
                                                data.healthTipId.toString(),
                                                'N',
                                                context);
                                          } else {
                                            wellnessCon.upsertWellnessApi(
                                                data.healthTipId.toString(),
                                                'Y',
                                                context);
                                          }

                                          // final dataList = model?.data;
                                          // if (dataList == null ||
                                          //     dataList.isEmpty ||
                                          //     dataList[0].favouriteFlag !=
                                          //         "Y") {
                                          // wellnessCon.upsertWellnessApi(
                                          //     data.healthTipId.toString(),
                                          //     context);
                                          //   setState(() {
                                          //     wellnessCon
                                          //         .upsertWellnessLibraryModel
                                          //         ?.data?[0]
                                          //         .favouriteFlag = "Y";
                                          //   });
                                          // }
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          color: isAddedToMyWillness
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                      Sizes.spaceWidth10,
                                      InkWell(
                                        onTap: () {
                                          if (data.urlArticle != null &&
                                              data.urlArticle!.isNotEmpty) {
                                            Share.share(data.urlArticle!);
                                          } else {
                                            Share.share(
                                                'Check out this amazing app!');
                                          }
                                        },
                                        child: const Icon(
                                          Icons.share_outlined,
                                          color: AppColor.lightBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                //   Container(
                //   margin: const EdgeInsets.only(bottom: 10),
                //   padding: EdgeInsets.symmetric(
                //       horizontal: Sizes.screenWidth * 0.03,
                //       vertical: Sizes.screenHeight * 0.008),
                //   height: Sizes.screenHeight * 0.14,
                //   width: Sizes.screenWidth,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: AppColor.grey),
                //   child: Row(children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Sizes.spaceHeight5,
                //         TextConst(
                //           data.title ?? "",
                //           size: Sizes.fontSizeFour * 1.1,
                //           fontWeight: FontWeight.w500,
                //         ),
                //         Sizes.spaceHeight15,
                //         SizedBox(
                //           width: Sizes.screenWidth * 0.6,
                //           child: TextConst(
                //             data.description ?? "",
                //             size: Sizes.fontSizeThree * 1.05,
                //             fontWeight: FontWeight.w400,
                //           ),
                //         ),
                //       ],
                //     ),
                //     const Spacer(),
                //     Column(
                //       children: [
                //         Sizes.spaceHeight5,
                //         Container(
                //           height: Sizes.screenHeight * 0.075,
                //           width: Sizes.screenWidth * 0.25,
                //           child: ClipRRect(
                //             borderRadius: BorderRadius.circular(8),
                //             child:
                //                 // Image.network( doctor.imageUrl??"",
                //                 data.urlImage != null
                //                     ? Image.network(
                //                         data.urlImage!,
                //                         height: Sizes.screenHeight * 0.075,
                //                         width: Sizes.screenWidth * 0.25,
                //                         fit: BoxFit.cover,
                //                       )
                //                     : Image(
                //                         image:
                //                             const AssetImage(Assets.logoDoctor),
                //                         height: Sizes.screenHeight * 0.075,
                //                         width: Sizes.screenWidth * 0.25,
                //                         fit: BoxFit.fill,
                //                       ),
                //
                //           ),
                //         ),
                //         Sizes.spaceHeight5,
                //         Sizes.spaceHeight3,
                //         InkWell(
                //           onTap: () {
                //             if (data.urlArticle != null &&
                //                 data.urlArticle!.isNotEmpty) {
                //               Share.share(data.urlArticle!);
                //             } else {
                //               Share.share('Check out this amazing app!');
                //             }
                //           },
                //           child: const Icon(
                //             Icons.share_outlined,
                //             color: AppColor.lightBlue,
                //           ),
                //         )
                //       ],
                //     )
                //   ]),
                // );
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
