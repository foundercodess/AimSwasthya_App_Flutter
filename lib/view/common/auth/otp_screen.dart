import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/view_model/doctor/doc_auth_view_model.dart';
import 'package:aim_swasthya/view_model/user/auth_view_model.dart';
import 'package:aim_swasthya/view_model/user/userRegisterCon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../info/terms_of_user.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final phone = arguments['phone'];
    final authCon = Provider.of<UserRegisterViewModel>(context, listen: false);
    final patientAuthCon = Provider.of<PatientAuthViewModel>(
      context,
    );
    final doctorAuthCon = Provider.of<DoctorAuthViewModel>(
      context,
    );
    debugPrint("patient ${patientAuthCon.seconds}");
    debugPrint("doctor: ${doctorAuthCon.seconds}");
    final navType = authCon.userRole;
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: Container()),
          const Center(
            child: Image(
              image: AssetImage(Assets.logoAppLogo),
              width: 270,
            ),
          ),
          const Spacer(),
          Container(
            width: Sizes.screenWidth,
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.screenWidth * 0.06,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Sizes.screenHeight * 0.035,
                ),
                TextConst(
                  AppLocalizations.of(context)!.enter_otp,
                  size: Sizes.fontSizeNine,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                ),
                Sizes.spaceHeight5,
                TextConst(
                  AppLocalizations.of(context)!.please_enter_otp_code,
                  size: Sizes.fontSizeFourPFive,
                  // size: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.white,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      TextConst(
                        "+91 $phone",
                        size: Sizes.fontSizeFourPFive,
                        // size: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.white,
                      ),
                      Sizes.spaceWidth5,
                      const Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Sizes.spaceHeight30,
                Center(
                  child: Pinput(
                    onChanged: (v) {
                      if (v.length == 4) {
                        if (authCon.userRole == 1) {
                          doctorAuthCon.verifyDocApi(
                              context, otpController.text, authCon.userRole);
                        } else {
                          patientAuthCon.verifyApi(
                              context, otpController.text, authCon.userRole);
                        }
                      } else {
                        debugPrint("otp must be 4 digit");
                      }
                    },
                    controller: otpController,
                    length: 4,
                    defaultPinTheme: PinTheme(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColor.textfieldGrayColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blue,
                      ),
                    ),
                    separatorBuilder: (index) => SizedBox(
                      width: Sizes.screenWidth * 0.03,
                    ),
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: Sizes.screenHeight * 0.01,
                          ),
                          width: Sizes.screenWidth * 0.004,
                          height: Sizes.screenHeight * 0.025,
                          color: AppColor.textGrayColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Sizes.spaceHeight30,
                navType == 1
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              if (doctorAuthCon.resendOtp) {
                                doctorAuthCon.docSendOtpApi(context,
                                    resendMode: true);
                              }
                              if (doctorAuthCon.resendOtp) {
                                doctorAuthCon.docSendOtpApi(context,
                                    resendMode: true);
                              } else {
                                debugPrint("not allowed at the moment");
                              }
                            },
                            child: RichText(
                                text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .did_not_receive_otp,
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: Sizes.fontSizeThree * 1.1,
                                      fontWeight: FontWeight.w400,
                                      color: doctorAuthCon.resendOtp
                                          ? AppColor.whiteColor
                                          : AppColor.grey),
                                ),
                                TextSpan(
                                  text: doctorAuthCon.resendOtp
                                      ? AppLocalizations.of(context)!.resend
                                      : "Resend in ${doctorAuthCon.seconds.toString()}",
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      decoration: doctorAuthCon.resendOtp
                                          ? TextDecoration.underline
                                          : null,
                                      decorationColor: AppColor.blue,
                                      fontSize: Sizes.fontSizeThree * 1.1,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.blue),
                                ),
                              ],
                            )),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              if (patientAuthCon.resendOtp) {
                                patientAuthCon.sendOtpApi(context,
                                    resendMode: true);
                              }
                              if (doctorAuthCon.resendOtp) {
                                doctorAuthCon.docSendOtpApi(context,
                                    resendMode: true);
                              } else {
                                debugPrint("not allowed at the moment");
                              }
                            },
                            child: RichText(
                                text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .did_not_receive_otp,
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: Sizes.fontSizeThree * 1.1,
                                      fontWeight: FontWeight.w400,
                                      color: patientAuthCon.resendOtp
                                          ? AppColor.whiteColor
                                          : AppColor.grey),
                                ),
                                TextSpan(
                                  text: patientAuthCon.resendOtp
                                      ? AppLocalizations.of(context)!.resend
                                      : "Resend in ${patientAuthCon.seconds.toString()}",
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      decoration: patientAuthCon.resendOtp
                                          ? TextDecoration.underline
                                          : null,
                                      decorationColor: AppColor.blue,
                                      fontSize: Sizes.fontSizeThree * 1.1,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.blue),
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                SizedBox(height: Sizes.screenHeight * 0.02),
                Container(
                  alignment: AlignmentDirectional.topStart,
                  width: Sizes.screenWidth,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: navType == 1
                            ? AppLocalizations.of(context)!.log_in
                            : AppLocalizations.of(context)!.by_signing_up,
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: Sizes.fontSizeThree * 1.1,
                          fontWeight: FontWeight.w400,
                          color: AppColor.white,
                        ),
                      ),
                      TextSpan(
                        text:
                            AppLocalizations.of(context)!.terms_and_conditions,
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          decoration: TextDecoration.underline,
                          decorationColor: AppColor.blue,
                          fontSize: Sizes.fontSizeThree * 1.1,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TermsOfUserScreen(
                                          type: '1',
                                        )));
                          },
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.and,
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: Sizes.fontSizeThree * 1.1,
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
                          fontSize: Sizes.fontSizeThree * 1.1,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TermsOfUserScreen(
                                          type: '3',
                                        )));
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
