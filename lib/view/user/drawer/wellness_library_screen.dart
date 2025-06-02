// view/user/add_screens/wellness_library_screen.dart
import 'dart:ui';
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/view/user/secound_nav_bar.dart';
import 'package:aim_swasthya/view_model/user/wellness_library_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../res/common_material.dart';

class WellnesslibraryScreen extends StatefulWidget {
  const WellnesslibraryScreen({super.key});

  @override
  State<WellnesslibraryScreen> createState() => _WellnesslibraryScreenState();
}

class _WellnesslibraryScreenState extends State<WellnesslibraryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WellnessLibraryViewModel>(context, listen: false)
          .getPatientWellnessApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final healthTipCon = Provider.of<WellnessLibraryViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppbarConst(title: 'My wellness library'),
                  Sizes.spaceHeight10,
                  TextConst(
                    "My favourites",
                    size: Sizes.fontSizeFive,
                    fontWeight: FontWeight.w500,
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.screenWidth * 0.05,
                    ),
                  ),
                  (healthTipCon == null ||
                          healthTipCon.getWellnessLibraryModel == null ||
                          healthTipCon.getWellnessLibraryModel!.data!.isEmpty)
                      ? Container(
                    alignment: Alignment.bottomCenter,
                                          height: Sizes.screenHeight*0.6,
                      child: wellnessEmpty())
                      : ListView.builder(
                          padding: EdgeInsets.only(
                            left: Sizes.screenWidth * 0.05,
                            right: Sizes.screenWidth * 0.05,
                            top: Sizes.screenHeight * 0.03,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              healthTipCon.getWellnessLibraryModel!.data!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final items = healthTipCon
                                .getWellnessLibraryModel!.data![index];
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: Sizes.screenHeight * 0.025),
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
                                          filter: ImageFilter.blur(
                                              sigmaX: 3, sigmaY: 3),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xff889fab)
                                                  .withOpacity(0.6),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                bottomRight: Radius.circular(16),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Sizes.screenWidth * 0.03,
                                                vertical:
                                                    Sizes.screenHeight * 0.016,
                                              ),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: Sizes.screenWidth *
                                                            0.75,
                                                        child: TextConst(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          items.title ??
                                                              "Learn how Yoga can change your life",
                                                          size: Sizes
                                                              .fontSizeFourPFive,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColor.white,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Sizes.screenWidth *
                                                            0.75,
                                                        child: TextConst(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          items.description ??
                                                              "In this article, you will learn the various Yoga asanas that could...",
                                                          size:
                                                              Sizes.fontSizeThree,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: AppColor.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  InkWell(
                                                    onTap: () {
                                                      if (items.urlArticle != null &&
                                                          items.urlArticle!.isNotEmpty) {
                                                        Share.share(items.urlArticle!);
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
                          },
                        ),
                ],
              ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        width: Sizes.screenWidth,
        color: AppColor.white,
        child: const CommenBottomNevBar(),
      ),
    );
  }

  Widget wellnessEmpty() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.05),
        height: Sizes.screenHeight * 0.4,
        width: Sizes.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xffF5F5F5),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/info.png",
                  height: Sizes.screenHeight * 0.03,
                  width: Sizes.screenHeight * 0.03),
              Sizes.spaceHeight10,
              TextConst(
                "Nothing Here Yet",
                size: Sizes.fontSizeFive,
                textAlign: TextAlign.center,
                // size: 14,
                fontWeight: FontWeight.w500,
              ),
              Sizes.spaceHeight10,
              TextConst(
                "Your wellness library is waiting to be filled.",
                size: Sizes.fontSizeFour,
                textAlign: TextAlign.center,
                // size: 14,
                fontWeight: FontWeight.w400,
              ),
              Sizes.spaceHeight15,
              TextConst(
                "Save helpful articles and health tips so you can revisit\n them anytime",
                size: Sizes.fontSizeFour,
                textAlign: TextAlign.center,
                // size: 14,
                fontWeight: FontWeight.w400,
              ),
              Sizes.spaceHeight15,
              TextConst(
                "Found something useful? Just tap the ❤️ icon to save it",
                size: Sizes.fontSizeFour,
                textAlign: TextAlign.center,
                // size: 14,
                fontWeight: FontWeight.w400,
              ),
            ]),
      ),
    );
  }
}
