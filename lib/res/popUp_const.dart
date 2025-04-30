import 'package:aim_swasthya/res/color_const.dart';
import 'package:aim_swasthya/res/size_const.dart';
import 'package:aim_swasthya/res/text_const.dart' show TextConst;
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/user/user_view_model.dart';
import '../view_model/user/voice_search_view_model.dart';

class ActionOverlay extends StatelessWidget {
  final Color? color;
  final String? text;
  final String? subtext;
  final Widget? child;
  final dynamic textConst;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final String? yesLabel;
  final String? noLabel;
  final void Function()? onTap;

  const ActionOverlay(
      {super.key,
      this.color,
      this.text,
      this.subtext,
      this.child,
      this.onTap,
      this.textConst,
      this.height,
      this.padding,
      this.yesLabel,
      this.noLabel});
  @override
  Widget build(BuildContext context ) {
    return Dialog(
      elevation: 5,
      surfaceTintColor: AppColor.black,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: height ?? Sizes.screenHeight / 5.5,
        padding: padding ??
            EdgeInsets.only(
              top: Sizes.screenHeight * 0.02,
            ),
        // height: Sizes.screenHeight * 0.18,
        width: Sizes.screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color ?? const Color(0xffF9F9F9)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextConst(
              text ?? 'Log out',
              size: Sizes.fontSizeSix,
              fontWeight: FontWeight.w500,
            ),
            // Sizes.spaceHeight5,
            const Spacer(),
            TextConst(
              textAlign: TextAlign.center,
              subtext ?? 'Are you sure you want to Log out?',
              size: Sizes.fontSizeFourPFive,
              fontWeight: FontWeight.w400,
            ),
            const Spacer(),
            Sizes.spaceHeight10,
            Container(
              height: Sizes.screenHeight * 0.055,
              // width: Sizes.screenWidth * 0.78,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xffEBEBEB),
                  ),
                ),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: Sizes.screenHeight * 0.055,
                      width: Sizes.screenWidth * 0.38,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(30)),
                        border: Border(
                            right: BorderSide(
                          color: Color(0xffEBEBEB),
                        )),
                      ),
                      child: Center(
                        child: TextConst(
                          noLabel ?? "No",
                          size: Sizes.fontSizeFourPFive,
                          fontWeight: FontWeight.w400,
                          color: AppColor.lightBlue,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onTap ??
                        () {
                          print("smd dm");
                          UserViewModel().remove();
                          // Navigator.pushNamed(
                          //     context, RoutesName.introScreen);
                          Navigator.pushNamedAndRemoveUntil(context,
                              RoutesName.introScreen, (context) => false);
                        },
                    child: Container(
                      height: Sizes.screenHeight * 0.055,
                      width: Sizes.screenWidth * 0.33,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(30)),
                      ),
                      child: Center(
                        child: textConst ??
                            TextConst(
                              yesLabel ?? "Yes",
                              size: Sizes.fontSizeFourPFive,
                              fontWeight: FontWeight.w400,
                              color: AppColor.lightBlue,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VoiceSearchDialog extends StatefulWidget {
  const VoiceSearchDialog({
    super.key,
  });

  @override
  State<VoiceSearchDialog> createState() => _VoiceSearchDialogState();
}

class _VoiceSearchDialogState extends State<VoiceSearchDialog> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VoiceSymptomSearchViewModel>(context, listen: false)
          .clearInput();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final voiceSearchCon = Provider.of<VoiceSymptomSearchViewModel>(context);
    return Dialog(
      elevation: 3,
      backgroundColor: Colors.grey[400],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: Sizes.screenHeight / 5,
        padding: EdgeInsets.only(
          top: Sizes.screenHeight * 0.02,
        ),
        width: Sizes.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xffF9F9F9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextConst(
              'Voice Search',
              size: Sizes.fontSizeSix,
              fontWeight: FontWeight.w500,
            ),
            Icon(
              voiceSearchCon.isListening ? Icons.mic : Icons.mic_none,
              size: Sizes.screenHeight * 0.05,
              color: voiceSearchCon.isListening ? Colors.red : Colors.black54,
            ),
            TextConst(
              voiceSearchCon.singleSearchWord.isEmpty
                  ? 'Say something...'
                  : voiceSearchCon.singleSearchWord,
              textAlign: TextAlign.center,
              size: Sizes.fontSizeFourPFive,
              fontWeight: FontWeight.w400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    if (voiceSearchCon.singleSearchWord.isEmpty) {
                      Navigator.pop(context);
                    } else {
                      voiceSearchCon.setSearchedValAndPerformSearch();
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: Sizes.screenHeight * 0.055,
                    width: Sizes.screenWidth / 2.6,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30)),
                      border: Border(
                        top: BorderSide(color: Color(0xffEBEBEB)),
                      ),
                    ),
                    child: Center(
                      child: TextConst(
                        voiceSearchCon.singleSearchWord.isEmpty
                            ? "Cancel"
                            : "Search",
                        size: Sizes.fontSizeFourPFive,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightBlue,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: Sizes.screenHeight * 0.055,
                  width: 1,
                  color: const Color(0xffEBEBEB),
                ),
                InkWell(
                  onTap: () {
                    if (voiceSearchCon.isListening) {
                      voiceSearchCon.stopListening();
                    } else {
                      voiceSearchCon.initSpeech(context).then((_) {
                        voiceSearchCon.startListening();
                        voiceSearchCon.isListening
                            ? voiceSearchCon.stopListening()
                            : voiceSearchCon.startListening();
                      });
                    }
                  },
                  child: Container(
                    height: Sizes.screenHeight * 0.055,
                    width: Sizes.screenWidth / 2.6,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30)),
                      border: Border(
                        top: BorderSide(color: Color(0xffEBEBEB)),
                      ),
                    ),
                    child: Center(
                      child: TextConst(
                        voiceSearchCon.isListening
                            ? "Stop Listening"
                            : "Start Listening",
                        size: Sizes.fontSizeFourPFive,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
