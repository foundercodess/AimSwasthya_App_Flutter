import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view_model/doctor/language_change_view_model.dart';
import 'package:aim_swasthya/view_model/user/userRegisterCon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show SystemChrome, SystemUiMode, SystemUiOverlay, SystemUiOverlayStyle;
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

enum Language { english, spanish }

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: Sizes.screenHeight * 0.08,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 15),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return showLanguageBottomSheet();
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Image(
                    image: AssetImage(Assets.iconsLanguage),
                    height: 20,
                  ),
                  Sizes.spaceWidth5,
                  TextConst(
                    AppLocalizations.of(context)!.english,
                    // "English",
                    size: Sizes.fontSizeFive,
                    fontWeight: FontWeight.w500,
                  ),
                  Sizes.spaceWidth5,
                  Image.asset(
                    Assets.iconsArrowDown,
                    width: 20,
                    color: AppColor.black,
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          Image(
            image: const AssetImage(Assets.logoOnboadingAppLogo),
            width: Sizes.screenWidth * 0.78,
            height: Sizes.screenHeight * 0.41,
          ),
          Container(
            width: Sizes.screenWidth,
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.screenWidth * 0.09,
                vertical: Sizes.screenHeight * 0.07),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.uiBgIntroBg), fit: BoxFit.fill),
            ),
            child: Column(
              children: [
                TextConst(AppLocalizations.of(context)!.started,
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w400,
                    color: AppColor.white),
                Sizes.spaceHeight15,
                Consumer<UserRegisterViewModel>(
                    builder: (context, authCon, child) {
                  return Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, RoutesName.doctorBottomNevBar, (context) => false);
                          authCon.setUserRole(1);
                          Navigator.pushNamed(
                            context,
                            RoutesName.onBodingScreen,
                          );
                        },
                        child: TextConst(AppLocalizations.of(context)!.are_doctor,
                            size: Sizes.fontSizeFourPFive,
                            fontWeight: FontWeight.w500,
                            color: AppColor.white),
                      ),
                      SizedBox(
                        height: Sizes.screenHeight * 0.12,
                        child: const VerticalDivider(
                          color: AppColor.white,
                          thickness: 1.2,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          authCon.setUserRole(2);
                          Navigator.pushNamed(
                              context, RoutesName.onBodingScreen);
                        },
                        child: TextConst(AppLocalizations.of(context)!.doctor,
                            textAlign: TextAlign.center,
                            size: Sizes.fontSizeFourPFive,
                            fontWeight: FontWeight.w500,
                            color: AppColor.white),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget showLanguageBottomSheet() {
  //   final List<String> languages = [
  //     'English',
  //     'Spanish',
  //     'Hindi',
  //     'Bengali',
  //     'Telugu',
  //     'Marathi',
  //     'Tamil',
  //     'Odia',
  //     'Punjabi',
  //     'Assamese',
  //   ];
  //   // int? selectedIndex;
  //   return Container(
  //     width: Sizes.screenWidth,
  //     padding: EdgeInsets.only(
  //         left: Sizes.screenWidth * 0.04,
  //         right: Sizes.screenWidth * 0.04,
  //         top: Sizes.screenHeight * 0.04),
  //     decoration: BoxDecoration(
  //       borderRadius: const BorderRadius.only(
  //         topLeft: Radius.circular(25),
  //         topRight: Radius.circular(25),
  //       ),
  //       gradient: AppColor().primaryGradient(
  //         colors: [AppColor.naviBlue, AppColor.blue],
  //       ),
  //     ),
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Row(
  //             children: [
  //               const Image(
  //                   image: AssetImage(Assets.iconsLanguage),
  //                   color: AppColor.white),
  //               Sizes.spaceWidth10,
  //               TextConst( AppLocalizations.of(context)!.chooseLang,
  //                   size: Sizes.fontSizeSix,
  //                   fontWeight: FontWeight.w500,
  //                   color: AppColor.white),
  //             ],
  //           ),
  //           Sizes.spaceHeight25,
  //           TextField(
  //             decoration: InputDecoration(
  //               hintText: "Search",
  //               hintStyle: TextStyle(
  //                   color: Colors.grey,
  //                   fontWeight: FontWeight.w400,
  //                   fontSize: Sizes.fontSizeSix),
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(12),
  //                 borderSide: BorderSide.none,
  //               ),
  //               prefixIcon: const Icon(
  //                 Icons.search,
  //                 color: Colors.grey,
  //               ),
  //               suffixIcon: const Icon(Icons.mic, color: AppColor.blue),
  //               fillColor: AppColor.white,
  //               filled: true,
  //               contentPadding: const EdgeInsets.symmetric(
  //                 vertical: 9.0,
  //                 // horizontal: 11.0,
  //               ),
  //             ),
  //           ),
  //           Sizes.spaceHeight20,
  //           const Divider(),
  //           Sizes.spaceHeight10,
  //           Consumer<ChangeLanguageViewModel>(builder: (context, provider, child) {
  //             return ListView.builder(
  //               physics: const NeverScrollableScrollPhysics(),
  //               shrinkWrap: true,
  //               itemCount: languages.length,
  //               itemBuilder: (context, index) {
  //                 final item = languages[index];
  //                 return ListTile(
  //                   contentPadding: const EdgeInsets.all(0),
  //                   leading: const Image(
  //                       image: AssetImage(Assets.iconsLanguage),
  //                       color: AppColor.white),
  //                   title: TextConst(
  //                     // Language.english,
  //                     languages[index],
  //                     size: Sizes.fontSizeFive,
  //                     fontWeight: FontWeight.w400,
  //                     color: 0 == index ? AppColor.blue : AppColor.white,
  //                   ),
  //
  //                   // onLongPress: (Language item) {
  //                   //   if(Language.english == item){
  //                   //     provider.changeLanguage(const Locale("en"));
  //                   //   }else{
  //                   //     print("spans");
  //                   //     provider.changeLanguage(const Locale("es"));
  //                   //   }
  //                   // },
  //                   onTap: () {
  //                    if(Language.english == item){
  //                      provider.changeLanguage(const Locale("en"));
  //                    }else{
  //                      print("spans");
  //                      provider.changeLanguage(const Locale("es"));
  //                    }
  //                   },
  //                 );
  //               },
  //             );
  //           })
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget showLanguageBottomSheet() {
    final List<String> languages = [
      'English',
      'Hindi',
      'Bengali',
      'Telugu',
      'Marathi',
      'Tamil',
      'Odia',
      'Punjabi',
      'Assamese',
    ];

    return Container(
      width: Sizes.screenWidth,
      padding: EdgeInsets.only(
          left: Sizes.screenWidth * 0.04,
          right: Sizes.screenWidth * 0.04,
          top: Sizes.screenHeight * 0.04),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        gradient: AppColor().primaryGradient(
          colors: [AppColor.naviBlue, AppColor.blue],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Image(
                    image: AssetImage(Assets.iconsLanguage),
                    color: AppColor.white),
                Sizes.spaceWidth10,
                TextConst(
                  AppLocalizations.of(context)!.chooselanguage,
                  size: Sizes.fontSizeSix,
                  fontWeight: FontWeight.w500,
                  color: AppColor.white,
                ),
              ],
            ),
            Sizes.spaceHeight25,
            TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.search,
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: Sizes.fontSizeSix),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(Icons.mic, color: AppColor.blue),
                fillColor: AppColor.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 9.0,
                ),
              ),
            ),
            Sizes.spaceHeight20,
            const Divider(),
            Sizes.spaceHeight10,
            Consumer<ChangeLanguageViewModel>(builder: (context, provider, child) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final item = languages[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Image(
                        image: AssetImage(Assets.iconsLanguage),
                        color: AppColor.white),
                    title: TextConst(
                      item,
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w400,
                      color: 0 == index ? AppColor.blue : AppColor.white,
                    ),
                    onTap: () {
                      if (item == 'English') {
                        provider.changeLanguage(const Locale("en"));
                      } else if (item == 'Hindi') {
                        provider.changeLanguage(const Locale("es"));
                      }
                    },
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

}


