import 'package:flutter/material.dart';

import '../main.dart';
import '../res/color_const.dart';
import '../res/size_const.dart';
import '../res/text_const.dart';

Future<void> showInfoOverlay(
    {String? title,
    String? errorMessage,
    dynamic statusCode,
    void Function()? onTap}) async {
  final context = navigatorKey.currentState?.overlay?.context;
  if (context == null) return;

  showDialog(
      context: context,
      builder: (ctx) => Dialog(
            elevation: 3,
            backgroundColor: Colors.grey[400],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
                height: Sizes.screenHeight / 4.5,
                padding: EdgeInsets.only(
                    top: Sizes.screenHeight * 0.02, left: 10, right: 10),
                width: Sizes.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xffF9F9F9),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextConst(
                      title ?? "Server Error",
                      size: Sizes.fontSizeSix,
                      fontWeight: FontWeight.w500,
                    ),
                    Sizes.spaceHeight10,
                    TextConst(
                        textAlign: TextAlign.center,
                        size: Sizes.fontSizeFourPFive,
                        fontWeight: FontWeight.w400,
                        errorMessage ??
                            "We're having trouble connecting. Error accrued while communicating with server Please try again later"),
                    const Spacer(),
                    InkWell(
                      onTap: onTap ??
                          () {
                            Navigator.pop(context);
                          },
                      child: Container(
                        height: Sizes.screenHeight * 0.055,
                        width: Sizes.screenWidth / 1.3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30)),
                          border: Border(
                            top: BorderSide(color: Color(0xffEBEBEB)),
                          ),
                        ),
                        child: Center(
                          child: TextConst(
                            'Ok',
                            size: Sizes.fontSizeFourPFive,
                            fontWeight: FontWeight.w400,
                            color: AppColor.lightBlue,
                          ),
                        ),
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.of(ctx).pop();
                    //   },
                    //   child: const Text("OK"),
                    // ),
                  ],
                )),
          ));
}
