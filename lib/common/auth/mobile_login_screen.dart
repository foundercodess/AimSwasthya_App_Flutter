// common/auth/mobile_login_screen.dart
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/common/info/terms_of_user.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/doc_auth_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/auth_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_role_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../local_db/download_image.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  final phoneController = TextEditingController();

  bool isChecked = false;
  @override
  void initState() {
        final patientAuthCon =
        Provider.of<UserRoleViewModel>(context, listen: false);
        if(patientAuthCon.userRole==2){
           ImageDownloader().fetchAndDownloadImages(context, folderName: 'logos/static_icons/');
        }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final patientAuthCon =
        Provider.of<PatientAuthViewModel>(context, listen: false);
    final doctorAuthCon =
        Provider.of<DoctorAuthViewModel>(context, listen: false);

    final authCon = Provider.of<UserRoleViewModel>(context, listen: false);
    final navType = authCon.navType;
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: Container()),
          const Center(
            child: Image(
              image: AssetImage(Assets.logoOnboadingAppLogo),
              width: 270,
            ),
          ),
          const Spacer(),
          Container(
            width: Sizes.screenWidth,
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.screenWidth * 0.08,
                vertical: Sizes.screenHeight * 0.017),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              gradient: AppColor().primaryGradient(
                colors: [AppColor.blue, AppColor.lightBlue],
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Sizes.screenHeight * 0.04,
                ),
                TextConst(
                  AppLocalizations.of(context)!.get_started_mobile,
                  size: Sizes.fontSizeFive,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                ),
                Sizes.spaceHeight20,
                CustomTextField(
                  cursorColor: AppColor.textGrayColor,
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  prefixIcon: Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: TextConst(
                        "+91",
                        size: Sizes.fontSizeFive,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blue,
                      )),
                  maxLength: 10,
                  fillColor: AppColor.textfieldGrayColor,
                  filled: true,
                  onChanged: (v) {
                    if (v.length == 10) {
                      FocusScope.of(context).unfocus();
                      if (authCon.userRole ==
                      2) {
                        patientAuthCon.isRegisterApi(
                            phoneController.text, "", "phone", context);
                      } else {
                        doctorAuthCon.isRegisterDocApi(
                            phoneController.text, "", "phone", context);
                      }
                    }
                  },
                ),
                Sizes.spaceHeight30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Sizes.screenWidth / 3.7,
                      height: 1.2,
                      color: AppColor.whiteColor,
                    ),
                    Sizes.spaceWidth5,
                    TextConst(
                      navType == 1
                          ? AppLocalizations.of(context)!.or_log_in_using
                          : AppLocalizations.of(context)!.or_signUp_using,
                      size: Sizes.fontSizeFour,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffEFEFEF),
                    ),
                    Sizes.spaceWidth5,
                    Container(
                      width: Sizes.screenWidth / 3.7,
                      height: 1.2,
                      color: AppColor.whiteColor,
                    ),
                  ],
                ),
                Sizes.spaceHeight25,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if(authCon.userRole==1){
                          User? user =
                          await doctorAuthCon.signInWithGoogle(context);
                        }else{
                          User? user =
                          await patientAuthCon.signInWithGoogle(context);
                        }

                      },
                      child: Image.asset(
                        Assets.iconsGoogle,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    Sizes.spaceWidth25,
                    GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          Assets.iconsFacebook,
                          width: 24,
                          height: 24,
                        ))
                  ],
                ),
                Sizes.spaceHeight25,
                Container(
                  alignment: AlignmentDirectional.center,
                  width: Sizes.screenWidth,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: navType == 1
                            ? AppLocalizations.of(context)!.log_in
                            : AppLocalizations.of(context)!.by_signing_up,
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: Sizes.fontSizeThree,
                          fontWeight: FontWeight.w400,
                          color: AppColor.white,
                        ),
                      ),
                      TextSpan(
                        text:
                            " ${AppLocalizations.of(context)!.terms_and_conditions}",
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          decoration: TextDecoration.underline,
                          decorationColor: AppColor.blue,
                          fontSize: Sizes.fontSizeThree,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const TermsOfUserScreen(type: '1',)));
                          },
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.and,
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: Sizes.fontSizeThree,
                          fontWeight: FontWeight.w400,
                          color: AppColor.white,
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.privacy_policy,
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          decoration: TextDecoration.underline,
                          decorationColor: AppColor.blue,
                          fontSize: Sizes.fontSizeThree,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const TermsOfUserScreen(type: '3',)));
                          },
                      ),
                    ]),
                  ),
                ),
                Sizes.spaceHeight30,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
