import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/view/user/secound_nav_bar.dart';
import 'package:aim_swasthya/view_model/user/user_delete_account_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDeleteAccountScreen extends StatefulWidget {
  const UserDeleteAccountScreen({super.key});

  @override
  State<UserDeleteAccountScreen> createState() =>
      _UserDeleteAccountScreenState();
}

class _UserDeleteAccountScreenState extends State<UserDeleteAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final deletePro = Provider.of<UserDeleteAccountViewModel>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppbarConst(title: 'Delete account'),
          Sizes.spaceHeight35,
          Sizes.spaceHeight35,
          Sizes.spaceHeight35,
          Container(
            margin: EdgeInsets.only(
                left: Sizes.screenWidth * 0.05,
                right: Sizes.screenWidth * 0.05),
            padding: const EdgeInsets.all(10),
            width: Sizes.screenWidth,
            // height: Sizes.screenHeight * 0.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.textfieldGrayColor.withOpacity(0.5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Sizes.spaceHeight10,
                Center(
                  child: Image.asset(
                    "assets/info.png",
                    height: Sizes.screenHeight * 0.03,
                    width: Sizes.screenHeight * 0.03,
                    color: Color(0xffC10000),
                  ),
                ),
                Sizes.spaceHeight10,
                Center(
                    child: TextConst(
                  textAlign: TextAlign.center,

                  "Are you sure you want to delete\n your account?",
                  size: Sizes.fontSizeFivePFive,
                  // size: 14,
                  fontWeight: FontWeight.w500,
                )),
                Sizes.spaceHeight25,
                const Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "Deleting your account will ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins-Bold',
                          )),
                      TextSpan(
                        text: "permanently ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: 'Poppins-Bold',
                        ),
                      ),
                      TextSpan(
                          text:
                              "remove all your personal data, including your medical history, symptom records, and any ongoing consultations. This action cannot be",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins-Bold',
                          )),
                      TextSpan(
                        children: [
                          TextSpan(
                            text: " undone.",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: 'Poppins-Bold',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Sizes.spaceHeight25,
                TextConst(
                  textAlign: TextAlign.center,
                  "If you're facing any issues or need assistance, please reach out to our support team before proceeding",
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                ),
                Sizes.spaceHeight20,
                Sizes.spaceHeight30,
                ButtonConst(
                  onTap: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return ActionOverlay(
                            text: "Delete account",
                            subtext:
                                "Are you sure you want to delete\n your appointment?",
                            onTap: () {
                              deletePro.userDeleteAccountApi(context);
                            },
                          );
                        });
                  },
                  title: 'Delete your account',
                  color: Color(0xffC10000),
                ),
                Sizes.spaceHeight10,
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 90,
        width: Sizes.screenWidth,
        color: AppColor.white,
        child: const CommenBottomNevBar(),
      ),
    );
  }
}
