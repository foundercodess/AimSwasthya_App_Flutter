import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/material.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppbarConst(title: 'Delete account'),
          Sizes.spaceHeight30,
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(10),
            width: Sizes.screenWidth,
            height: Sizes.screenHeight * 0.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.textfieldGrayColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/info.png",
                    height: Sizes.screenHeight * 0.03,
                    width: Sizes.screenHeight * 0.03,
                    color: Colors.red,
                  ),
                ),
                Sizes.spaceHeight20,
                Center(
                    child: TextConst(
                  "Are you sure you want to delete\n your account?",
                  size: Sizes.fontSizeFive,
                  fontWeight: FontWeight.w500,
                )),
                Sizes.spaceHeight20,
                // TextConst(
                //     "You're about to delete your AIMSwasthya Doctor Account.\nThis action is permanent and cannot be undone.\nDeleting your account will result in: Removal of your profile from the doctor directory Permanent loss of consultation history and patient interactions Inability to access earnings or settlement records after deletion For security and compliance reasons, certain transactional data may be retained in accordance with medical and legal regulations.")
                // ,
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
                TextConst(
                  "This action is permanent and cannot be undone.",
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                ),
                Sizes.spaceHeight15,
                Text.rich(
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
                        text: "your account will result in:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins-Bold',
                          )
                      ),
                      TextSpan(text: "."),
                    ],
                  ),
                ),
                Sizes.spaceHeight15,
                TextConst(
                  " . Removal of your profile from the doctor directory",
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                ),
                Sizes.spaceHeight5,
                TextConst(
                  " . Permanent loss of consultation history and patient interactions",
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
