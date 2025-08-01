// res/popUp_const.dart
import 'package:aim_swasthya/generated/assets.dart';
import 'package:aim_swasthya/res/color_const.dart';
import 'package:aim_swasthya/res/size_const.dart';
import 'package:aim_swasthya/res/text_const.dart' show TextConst;
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../utils/by_animation/mic_bg_animation.dart';
import '../patient_section/p_view_model/user_view_model.dart';
import '../patient_section/p_view_model/voice_search_view_model.dart';

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
  Widget build(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextConst(
                textAlign: TextAlign.center,
                subtext ?? 'Are you sure you want to Log out?',
                size: Sizes.fontSizeFourPFive,
                fontWeight: FontWeight.w400,
              ),
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
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: Sizes.screenHeight * 0.055,
                        // Removed fixed width
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
                  ),
                  Container(
                    height: Sizes.screenHeight * 0.055,
                    width: 1,
                    color: const Color(0xffEBEBEB),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onTap ??
                          () {
                            UserViewModel().remove();
                            Navigator.pushNamedAndRemoveUntil(context,
                                RoutesName.introScreen, (context) => false);
                          },
                      child: Container(
                        height: Sizes.screenHeight * 0.055,
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
//
// class VoiceSearchDialog extends StatefulWidget {
//   const VoiceSearchDialog({super.key});
//
//   @override
//   State<VoiceSearchDialog> createState() => _VoiceSearchDialogState();
// }
//
// class _VoiceSearchDialogState extends State<VoiceSearchDialog> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<VoiceSymptomSearchViewModel>(context, listen: false)
//           .clearInput();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final voiceSearchCon = Provider.of<VoiceSymptomSearchViewModel>(context);
//
//     return Dialog(
//       elevation: 3,
//       backgroundColor: Colors.grey[400],
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//       child: Container(
//         height: Sizes.screenHeight / 3.5,
//         padding: EdgeInsets.only(top: Sizes.screenHeight * 0.02),
//         width: Sizes.screenWidth,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           color: const Color(0xffF9F9F9),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Mic button / animation
//             GestureDetector(
//               onTap: () async {
//                 if (voiceSearchCon.isListening) {
//                   voiceSearchCon.stopListening();
//                 } else {
//                   voiceSearchCon
//                       .initSpeech(
//                     context,
//                   )
//                       .then((data) {
//                     if (data == true) {
//                       voiceSearchCon.isListening
//                           ? voiceSearchCon.stopListening()
//                           : voiceSearchCon.startListening(singleSearch: true);
//                       Navigator.pop(context);
//                     }
//                   });
//                 }
//
//                 // if (!voiceSearchCon.isListening) {
//                 //   bool initialized = await voiceSearchCon.initSpeech(context);
//                 //   if (initialized) {
//                 //     voiceSearchCon.startListening(
//                 //       singleSearch: true,
//                 //       onComplete: () {
//                 //         voiceSearchCon.setSearchedValAndPerformSearch();
//                 //         Navigator.pop(context);
//                 //       },
//                 //     );
//                 //   }
//                 // } else {
//                 //   voiceSearchCon.stopListening();
//                 // }
//               },
//               child: Container(
//                 height: Sizes.screenHeight * 0.15,
//                 width: Sizes.screenHeight * 0.15,
//                 alignment: Alignment.center,
//                 child: voiceSearchCon.isListening
//                     ? const SecMicAnimation() // animated widget
//                     : Image.asset(Assets.assetsMicc), // static mic image
//               ),
//             ),
//
//             Sizes.spaceHeight25,
//
//             // Live text update
//             TextConst(
//               voiceSearchCon.singleSearchWord.isEmpty
//                   ? ''
//                   : voiceSearchCon.singleSearchWord,
//               textAlign: TextAlign.center,
//               size: Sizes.fontSizeFourPFive,
//               fontWeight: FontWeight.w400,
//             ),
//
//             Sizes.spaceHeight10,
//
//             TextConst(
//               "Use your voice to search for a doctor or speciality.",
//               size: Sizes.fontSizeFour,
//               fontWeight: FontWeight.w400,
//             ),
//             Sizes.spaceHeight5,
//
//             TextConst(
//               "Just tap the mic and speak.",
//               size: Sizes.fontSizeFour,
//               fontWeight: FontWeight.w500,
//               color: AppColor.blue,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
        padding: EdgeInsets.only(
            top: Sizes.screenHeight * 0.02, bottom: Sizes.screenHeight * 0.02),
        width: Sizes.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xffF9F9F9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Mic button
            GestureDetector(
              onTap: () async {
                var status = await Permission.microphone.status;

                if (status.isGranted) {
                  voiceSearchCon.initSpeech(context).then((data) {
                    if (data == true) {
                      voiceSearchCon.isListening
                          ? voiceSearchCon.stopListening()
                          : voiceSearchCon.startListening(
                              singleSearch: true,
                              onSingleResult: () {
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.pop(context);
                                  voiceSearchCon
                                      .setSearchedValAndPerformSearch();
                                });
                              },
                            );
                    }
                  });
                } else {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return ActionOverlay(
                          height: Sizes.screenHeight / 5.2,
                          padding: EdgeInsets.only(
                              left: Sizes.screenWidth * 0.03,
                              right: Sizes.screenWidth * 0.05,
                              top: Sizes.screenHeight * 0.02),
                          text: "Mic Permission Required",
                          yesLabel: "Allow",
                          noLabel: "Deny",
                          subtext:
                              "We use your microphone so you can speak your symptoms instead of typing — making it faster and easier for you!",
                          onTap: () {
                            Navigator.pop(context);
                            voiceSearchCon.initSpeech(context).then((_) {
                              voiceSearchCon.isListening
                                  ? voiceSearchCon.stopListening()
                                  : voiceSearchCon.startListening(
                                      singleSearch: true,
                                      onSingleResult: () {
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          Navigator.pop(context);
                                          voiceSearchCon
                                              .setSearchedValAndPerformSearch();
                                        });
                                      },
                                    );
                            });
                          },
                        );
                      });
                }
              },

              // onTap: () async {
              //   // if (voiceSearchCon.isListening) {
              //   //   voiceSearchCon.stopListening();
              //   // } else {
              //   //   voiceSearchCon
              //   //       .initSpeech(
              //   //     context,
              //   //   )
              //   //       .then((data) {
              //   //     if (data == true) {
              //   //       voiceSearchCon.isListening
              //   //           ? voiceSearchCon.stopListening()
              //   //           : voiceSearchCon.startListening(singleSearch: true);
              //   //       // Navigator.pop(context);
              //   //     }
              //   //   });
              //   // }
              //   if (voiceSearchCon.isListening) {
              //     voiceSearchCon.stopListening();
              //   } else {
              //     bool initialized = await voiceSearchCon.initSpeech(context);
              //     if (initialized) {
              //       voiceSearchCon.startListening(
              //         singleSearch: true,
              //         onResult: () {
              //           // Close dialog and proceed after getting result
              //           voiceSearchCon.setSearchedValAndPerformSearch();
              //           Navigator.pop(context);
              //         },
              //       );
              //     }
              //   }
              // },

              child: Container(
                height: Sizes.screenHeight * 0.15,
                width: Sizes.screenHeight * 0.15,
                alignment: Alignment.center,
                child: voiceSearchCon.isListening
                    ? const SecMicAnimation()
                    : const Image(
                        image: AssetImage(Assets.assetsMicc),
                        // height: Sizes.screenWidth * 0.25,
                      ),
              ),
            ),

            // Sizes.spaceHeight25,
            // Display recognized text
            if (voiceSearchCon.singleSearchWord.isNotEmpty) ...[
              Sizes.spaceHeight10,
              TextConst(
                voiceSearchCon.singleSearchWord.isEmpty
                    ? ''
                    : voiceSearchCon.singleSearchWord,
                textAlign: TextAlign.center,
                size: Sizes.fontSizeFourPFive,
                fontWeight: FontWeight.w400,
              ),
            ],

            Sizes.spaceHeight10,

            TextConst(
              "Use your voice to search for a doctor or speciality.",
              size: Sizes.fontSizeFour,
              fontWeight: FontWeight.w400,
            ),
            Sizes.spaceHeight5,

            TextConst(
              "Just tap the mic and speak.",
              size: Sizes.fontSizeFour,
              fontWeight: FontWeight.w500,
              color: AppColor.blue,
            ),
          ],
        ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   final voiceSearchCon = Provider.of<VoiceSymptomSearchViewModel>(context);
  //   return Dialog(
  //     elevation: 3,
  //     backgroundColor: Colors.grey[400],
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //     child: Container(
  //       height: Sizes.screenHeight / 3.5,
  //       padding: EdgeInsets.only(
  //         top: Sizes.screenHeight * 0.02,
  //
  //       ),
  //       width: Sizes.screenWidth*1,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(30),
  //         color: const Color(0xffF9F9F9),),
  //       child: Column(
  //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           // TextConst(
  //           //   'Voice Search',
  //           //   size: Sizes.fontSizeSix,
  //           //   fontWeight: FontWeight.w500,
  //           // ),
  //           GestureDetector(
  //             onTap: (){
  //               if (voiceSearchCon.isListening) {
  //                 voiceSearchCon.stopListening();
  //               } else {
  //                 voiceSearchCon.initSpeech(context,).then((data) {
  //                   if (data == true) {
  //                     voiceSearchCon.isListening
  //                         ? voiceSearchCon.stopListening()
  //                         : voiceSearchCon.startListening(singleSearch: true);
  //                   }
  //                 });
  //               }
  //             },
  //             child: Image(
  //               image: const AssetImage(Assets.assetsMicc),
  //               height: Sizes.screenWidth * 0.25,
  //             ),
  //           ),
  //           Sizes.spaceHeight25,
  //           // Icon(
  //           //   voiceSearchCon.isListening ? Icons.mic : Icons.mic_none,
  //           //   size: Sizes.screenHeight * 0.05,
  //           //   color: voiceSearchCon.isListening ? Colors.red : Colors.black54,
  //           // ),
  //           TextConst(
  //             voiceSearchCon.singleSearchWord.isEmpty
  //                 ? ''
  //                 : voiceSearchCon.singleSearchWord,
  //             textAlign: TextAlign.center,
  //             size: Sizes.fontSizeFourPFive,
  //             fontWeight: FontWeight.w400,
  //           ),
  //           Sizes.spaceHeight10,
  //           TextConst(
  //             "Use your voice to search for a doctor or speciality.",
  //             size: Sizes.fontSizeFour,
  //             fontWeight: FontWeight.w400,
  //           ),
  //           Sizes.spaceHeight5,
  //           TextConst("Just tap the mic and speak.",size: Sizes.fontSizeFour,
  //             fontWeight: FontWeight.w500,
  //             color: AppColor.blue,),
  //
  //           // Row(
  //           //   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           //   children: [
  //           //     InkWell(
  //           //       onTap: () {
  //           //         if (voiceSearchCon.singleSearchWord.isEmpty) {
  //           //           Navigator.pop(context);
  //           //         } else {
  //           //           voiceSearchCon.setSearchedValAndPerformSearch();
  //           //           Navigator.pop(context);
  //           //         }
  //           //       },
  //           //       child: Container(
  //           //         height: Sizes.screenHeight * 0.055,
  //           //         width: Sizes.screenWidth / 2.6,
  //           //         decoration: const BoxDecoration(
  //           //           borderRadius:
  //           //               BorderRadius.only(bottomRight: Radius.circular(30)),
  //           //           border: Border(
  //           //             top: BorderSide(color: Color(0xffEBEBEB)),
  //           //           ),
  //           //         ),
  //           //         child: Center(
  //           //           child: TextConst(
  //           //             voiceSearchCon.singleSearchWord.isEmpty
  //           //                 ? "Cancel"
  //           //                 : "Search",
  //           //             size: Sizes.fontSizeFourPFive,
  //           //             fontWeight: FontWeight.w400,
  //           //             color: AppColor.lightBlue,
  //           //           ),
  //           //         ),
  //           //       ),
  //           //     ),
  //           //     Container(
  //           //       height: Sizes.screenHeight * 0.055,
  //           //       width: 1,
  //           //       color: const Color(0xffEBEBEB),
  //           //     ),
  //           //     InkWell(
  //           //       onTap: () {
  //           //         if (voiceSearchCon.isListening) {
  //           //           voiceSearchCon.stopListening();
  //           //         } else {
  //           //           voiceSearchCon.initSpeech(context,).then((data) {
  //           //             if (data == true) {
  //           //               voiceSearchCon.isListening
  //           //                   ? voiceSearchCon.stopListening()
  //           //                   : voiceSearchCon.startListening(singleSearch: true);
  //           //             }
  //           //           });
  //           //         }
  //           //       },
  //           //       child: Container(
  //           //         height: Sizes.screenHeight * 0.055,
  //           //         width: Sizes.screenWidth / 2.6,
  //           //         decoration: const BoxDecoration(
  //           //           borderRadius:
  //           //               BorderRadius.only(bottomRight: Radius.circular(30)),
  //           //           border: Border(
  //           //             top: BorderSide(color: Color(0xffEBEBEB)),
  //           //           ),
  //           //         ),
  //           //         child: Center(
  //           //           child: TextConst(
  //           //             voiceSearchCon.isListening
  //           //                 ? "Stop Listening"
  //           //                 : "Start Listening",
  //           //             size: Sizes.fontSizeFourPFive,
  //           //             fontWeight: FontWeight.w400,
  //           //             color: AppColor.lightBlue,
  //           //           ),
  //           //         ),
  //           //       ),
  //           //     ),
  //           //   ],
  //           // ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
