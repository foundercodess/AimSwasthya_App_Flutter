import 'dart:io';
import 'package:aim_swasthya/generated/assets.dart';
import 'package:aim_swasthya/res/color_const.dart';
import 'package:aim_swasthya/res/size_const.dart';
import 'package:aim_swasthya/res/text_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/view_model/user/get_image_url_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicalOverlayScreen extends StatefulWidget {
  List<String> pickedFile;
  MedicalOverlayScreen({super.key, required this.pickedFile});

  @override
  State<MedicalOverlayScreen> createState() => _MedicalOverlayScreenState();
}

class _MedicalOverlayScreenState extends State<MedicalOverlayScreen> {
  final textController = TextEditingController();
  int selectedIndex = 0;

  List<dynamic> filesWithFileName = [];
  @override
  Widget build(BuildContext context) {
    if (isClicked == true) {
      return uploadedDocuments();
    }
    return medicalRecordsSec();
  }

  bool isClicked = false;
  Widget medicalRecordsSec() {
    return Container(
      padding: EdgeInsets.only(
        left: Sizes.screenWidth * 0.05,
        right: Sizes.screenWidth * 0.05,
        top: Sizes.screenHeight * 0.03,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      width: Sizes.screenWidth,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightBlue,
              ),
              child: Image.asset(Assets.imagesMedicalReports),
            ),
            Sizes.spaceHeight5,
            TextConst(
              "Tell us more about it",
              size: Sizes.fontSizeNine,
              fontWeight: FontWeight.w600,
            ),
            Sizes.spaceHeight5,
            TextConst(
              "Add a title to this medical record",
              size: Sizes.fontSizeFourPFive,
              fontWeight: FontWeight.w400,
            ),
            Sizes.spaceHeight25,
            Builder(builder: (context) {
              if (widget.pickedFile[selectedIndex].endsWith('.pdf')) {
                return Container(
                  height: Sizes.screenHeight * 0.165,
                  width: Sizes.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColor.blue, width: 1.5),
                    // image: DecorationImage(
                    //   image: FileImage(file),
                    //   fit: BoxFit.cover,
                    // )
                  ),
                  child: Container(
                    height: Sizes.screenHeight * 0.165,
                    width: Sizes.screenWidth,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.black.withOpacity(0.5),
                    ),
                    child: Text(widget.pickedFile[selectedIndex]),
                  ),
                );
              }
              final file = File(widget.pickedFile[selectedIndex]);
              return Container(
                height: Sizes.screenHeight * 0.165,
                width: Sizes.screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColor.blue, width: 1.5),
                    image: DecorationImage(
                      image: FileImage(file),
                      fit: BoxFit.cover,
                    )),
                child: Container(
                  height: Sizes.screenHeight * 0.165,
                  width: Sizes.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColor.black.withOpacity(0.5),
                  ),
                ),
              );
            }),
            Sizes.spaceHeight20,
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: "Enter a title",
                hintStyle: TextStyle(
                    color: const Color(0xffC3C3C3),
                    fontWeight: FontWeight.w400,
                    // fontSize: 12,
                    fontSize: Sizes.fontSizeFourPFive),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide:
                      const BorderSide(color: Color(0xffE5E5E5), width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide:
                      const BorderSide(color: Color(0xffE5E5E5), width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide:
                      const BorderSide(color: Color(0xffE5E5E5), width: 1.0),
                ),
                fillColor: const Color(0xffF5F5F5),
                filled: true,
                contentPadding: const EdgeInsets.only(
                  left: 10,
                ),
              ),
              cursorColor: AppColor.textGrayColor,
              style: const TextStyle(
                  color: AppColor.blue, fontWeight: FontWeight.w500),
            ),
            Sizes.spaceHeight20,
            ButtonConst(
              height: Sizes.screenHeight * 0.06,
              title: widget.pickedFile.length == 1 || ((widget.pickedFile.length) == selectedIndex + 1) ? 'Next' : "Next record",
              width: Sizes.screenWidth,
              onTap: () async {
                // print(object)
                if (textController.text.isEmpty) {
                  Utils.show("Please enter title to continue", context);
                  return;
                }
                if ((widget.pickedFile.length) == selectedIndex + 1) {
                  setState(() {
                    filesWithFileName.add({
                      'path': widget.pickedFile[selectedIndex],
                      'fileName': textController.text
                    });
                  });
                  for (var data in filesWithFileName) {
                    await Provider.of<GetImageUrlViewModel>(context,
                            listen: false)
                        .addMedicalRecord(context,
                            filePath: data['path'], fileName: data['fileName'])
                        .then((v) {
                      setState(() {
                        isClicked = v!;
                      });
                    });
                  }
                } else {
                  setState(() {
                    filesWithFileName.add({
                      'path': widget.pickedFile[selectedIndex],
                      'fileName': textController.text
                    });
                    textController.clear();
                    selectedIndex += 1;
                  });
                  if (kDebugMode) {
                    print(filesWithFileName);
                  }
                }
              },
              color: AppColor.blue,
            ),
            Sizes.spaceHeight30,
            Sizes.spaceHeight10,
          ],
        ),
      ),
    );
  }

  Widget uploadedDocuments() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      width: Sizes.screenWidth * 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColor.lightBlue),
            child: const Center(
                child: Icon(
              Icons.check,
              color: AppColor.blue,
            )),
          ),
          TextConst(
            "Uploaded",
            size: Sizes.fontSizeSix,
            fontWeight: FontWeight.w600,
          ),
          TextConst(
            "Your medical records are successfully uploaded",
            size: Sizes.fontSizeThree,
            fontWeight: FontWeight.w400,
          ),
          Sizes.spaceHeight5,
          SizedBox(
            height: Sizes.screenHeight * 0.27,
            child: imageListView(),
          ),
          Sizes.spaceHeight10,
          Padding(
            padding: EdgeInsets.only(
                right: Sizes.screenWidth * 0.04,
                left: Sizes.screenWidth * 0.04),
            child: ButtonConst(
              title: "Confirm",
              width: Sizes.screenWidth,
              onTap: () async {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget imageListView() {
    if (widget.pickedFile.isNotEmpty) {
      return ListView.builder(
        padding: EdgeInsets.only(
          left: Sizes.screenWidth * 0.02,
          right: Sizes.screenWidth * 0.02,
        ),
        shrinkWrap: true,
        itemCount: filesWithFileName.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Builder(builder: (context) {
                if (widget.pickedFile[selectedIndex].endsWith('.pdf')) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    height: Sizes.screenHeight * 0.3,
                    width: filesWithFileName.length == 1
                        ? Sizes.screenWidth * 0.9
                        : Sizes.screenWidth * 0.38,
                    decoration: BoxDecoration(
                      color: AppColor.grey,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColor.blue),
                    ),
                    child: Container(
                      height: Sizes.screenHeight * 0.3,
                      width: Sizes.screenWidth * 0.38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColor.lightBlack.withOpacity(0.7),
                      ),
                      child: Center(
                          child: TextConst(
                        textAlign: TextAlign.center,
                        filesWithFileName[index]['path'],
                        size: Sizes.fontSizeFourPFive,
                        color: AppColor.white,
                      )),
                    ),
                    // child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(30),
                    //   child: Image.file(
                    //     File(widget.pickedFile[index].path),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  );
                }
                return Container(
                  margin: const EdgeInsets.all(4),
                  height: Sizes.screenHeight * 0.3,
                  width: filesWithFileName.length == 1
                      ? Sizes.screenWidth * 0.9
                      : Sizes.screenWidth * 0.38,
                  decoration: BoxDecoration(
                    color: AppColor.grey,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColor.blue),
                    image: DecorationImage(
                      image: FileImage(File(filesWithFileName[index]['path'])),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    height: Sizes.screenHeight * 0.3,
                    width: Sizes.screenWidth * 0.38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColor.lightBlack.withOpacity(0.7),
                    ),
                    child: Center(
                        child: TextConst(
                      filesWithFileName[index]['fileName'],
                      size: Sizes.fontSizeFourPFive,
                      color: AppColor.white,
                    )),
                  ),
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.circular(30),
                  //   child: Image.file(
                  //     File(widget.pickedFile[index].path),
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                );
              }),
              Positioned(
                bottom: 1,
                right: 4,
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    color: AppColor.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Transform.rotate(
                    angle: -0.9,
                    child: const Icon(
                      Icons.arrow_forward,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      return const Center(
        child: Text("No image selected"),
      );
    }
  }
}
