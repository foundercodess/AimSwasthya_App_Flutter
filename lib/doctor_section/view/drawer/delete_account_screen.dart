// doctor_section/view/drawer/delete_account_screen.dart
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/delete_account_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final deleteAco = Provider.of<DeleteAccountViewModel>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppbarConst(title: 'Delete account'),
          Sizes.spaceHeight35,
          Sizes.spaceHeight35,
          Sizes.spaceHeight15,
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
                  fontWeight: FontWeight.w500,
                )),
                Sizes.spaceHeight25,
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "You're about to delete your ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins-Bold',
                          )),
                      TextSpan(
                        text: "AIMSwasthya Doctor Account",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: 'Poppins-Bold',
                        ),
                      ),
                      TextSpan(text: "."),
                    ],
                  ),
                ),
                Sizes.spaceHeight3,
                TextConst(
                  "This action is permanent and cannot be undone.",
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                ),
                Sizes.spaceHeight20,
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "For security and compliance reasons, ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: 'Poppins-Bold',
                        ),
                      ),
                      TextSpan(
                          text: "your account will result in:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins-Bold',
                          )),
                      TextSpan(text: "."),
                    ],
                  ),
                ),
                Sizes.spaceHeight20,
                TextConst(
                  "  . Removal of your profile from the doctor directory",
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                ),
                Sizes.spaceHeight5,
                TextConst(
                  "  . Permanent loss of consultation history and patient\n   interactions",
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                ),
                Sizes.spaceHeight5,
                TextConst(
                  "  . Inability to access earnings or settlement records after\n   deletion",
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                ),
                Sizes.spaceHeight20,
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Deleting ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: 'Poppins-Bold',
                        ),
                      ),
                      TextSpan(
                          text:
                              "certain transactional data may be retained in accordance with medical and legal regulations.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins-Bold',
                          )),
                    ],
                  ),
                ),
                Sizes.spaceHeight20,
                ButtonConst(
                  onTap: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return ActionOverlay(
                            text: "Delete account",
                            subtext:
                                "Are you sure you want to delete\n your account?",
                            onTap: () {
                              deleteAco.deleteAccountApi(context);
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
    );
  }
}
