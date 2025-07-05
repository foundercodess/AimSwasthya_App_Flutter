// patient_section/view/p_drawer/med_reports/medical_reports_screen.dart
import 'dart:io';
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/patient_section/view/p_drawer/med_reports/image_picker.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_medical_records_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../local_db/download_image.dart';
import '../../../../model/user/patient_medical_records_model.dart';
import '../../../p_view_model/bottom_nav_view_model.dart';
import 'package:aim_swasthya/l10n/app_localizations.dart';

import '../../symptoms/dowenloade_image.dart';

class MedicalReportsScreen extends StatefulWidget {
  const MedicalReportsScreen({super.key});

  @override
  State<MedicalReportsScreen> createState() => _MedicalReportsScreenState();
}

class _MedicalReportsScreenState extends State<MedicalReportsScreen> {
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  int currentPage = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PatientMedicalRecordsViewModel>(context, listen: false)
          .patientMedRecApi(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomCon = Provider.of<BottomNavProvider>(context);
    return PopScope(
      onPopInvokedWithResult: (val, _) {},
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarConst(
                onPressed: () {
                  if (bottomCon.currentIndex == 1) {
                    bottomCon.setIndex(0);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                title: AppLocalizations.of(context)!.medical_records,
              ),
              Sizes.spaceHeight10,
              showReports(),
              Sizes.spaceHeight30,
              TextConst(
                padding: const EdgeInsets.only(left: 15),
                AppLocalizations.of(context)!.uploaded_medical_records,
                size: Sizes.fontSizeFivePFive,
                fontWeight: FontWeight.w500,
              ),
              Sizes.spaceHeight5,
              uploadedRecords(),
              Sizes.spaceHeight25,
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.04),
                child: ButtonConst(
                    onTap: () {
                      showModalBottomSheet(
                        elevation: 10,
                        isScrollControlled: true,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16.0)),
                        ),
                        backgroundColor: AppColor.white,
                        builder: (BuildContext context) {
                          return showImageBottomSheet();
                        },
                      );
                    },
                    color: AppColor.blue,
                    title: AppLocalizations.of(context)!
                        .upload_your_medical_records),
              ),
              SizedBox(
                height: Sizes.screenHeight * 0.16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showReports() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Sizes.screenWidth * 0.04,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.04,
          vertical: Sizes.screenHeight * 0.03),
      // height: Sizes.screenHeight * 0.2,
      width: Sizes.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor.grey,
      ),
      child: Column(
        children: [
          Image.asset(
            Assets.imagesMedicalDocument,
            height: 45,
          ),
          Sizes.spaceHeight15,
          TextConst(
            "Add your latest medical records",
            size: Sizes.fontSizeFivePFive,
            fontWeight: FontWeight.w500,
          ),
          Container(
            width: Sizes.screenWidth / 1.3,
            alignment: Alignment.center,
            child: TextConst(
              textAlign: TextAlign.center,
              "Medical records help your doctor for an accurate diagnosis",
              size: Sizes.fontSizeFour,
              fontWeight: FontWeight.w500,
              // size: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget dataField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 5),
            alignment: Alignment.centerRight,
            // color: Colors.red,
            width: Sizes.screenWidth * 0.2,
            child: TextConst(label,
                size: Sizes.fontSizeFour * 1.1,
                fontWeight: FontWeight.w400,
                color: AppColor.black),
          ),
          TextConst(":",
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w400,
              color: AppColor.black),
          Sizes.spaceWidth10,
          SizedBox(
            // color: AppColor.blue,
            width: Sizes.screenWidth * 0.3,
            child: TextConst(
              value,
              size: Sizes.fontSizeFour * 1.1,
              fontWeight: FontWeight.w400,
              color: AppColor.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadedRecords() {
    final medRecCon = Provider.of<PatientMedicalRecordsViewModel>(context);
    return Container(
      margin: const EdgeInsets.all(12),
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.05,
          vertical: Sizes.screenHeight * 0.015),
      width: Sizes.screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColor.grey),
      child: Consumer<PatientMedicalRecordsViewModel>(
          builder: (context, medRecCon, _) {
        if (medRecCon.patientMedicalRecordsModel == null ||
            medRecCon.patientMedicalRecordsModel!.data == null ||
            medRecCon.patientMedicalRecordsModel!.data!.medicalRecord == null ||
            medRecCon
                .patientMedicalRecordsModel!.data!.medicalRecord!.isEmpty) {
          return Center(
            child: NoDataMessages(
              height: Sizes.screenHeight * 0.33,
              message: "No records added yet",
              title:
                  "you can store prescription,lab results and medical history securely here",
            ),
            // ConstText(title: "No Medical Record Found")
          );
        }
        return Column(
          children: [
            Row(
              children: [
                TextConst(
                  "Medical record",
                  size: Sizes.fontSizeThree,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffBBBBBB),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    print("sdds");
                    var documentUrl = medRecCon.patientMedicalRecordsModel!
                            .data!.medicalRecord![0].imageUrl ??
                        "";
                    Navigator.pushNamed(
                      context,
                      RoutesName.uploadedOn,
                      arguments: documentUrl,
                    );
                  },
                  child: TextConst(
                    "Uploaded on",
                    size: Sizes.fontSizeThree,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xffBBBBBB),
                  ),
                )
              ],
            ),
            SizedBox(
              child: medRecCon.patientMedicalRecordsModel != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: medRecCon.patientMedicalRecordsModel!.data!
                          .medicalRecord!.length,
                      itemBuilder: (context, index) {
                        final medRecData = medRecCon.patientMedicalRecordsModel!
                            .data!.medicalRecord![index];
                        DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(
                            medRecData.createdAt
                                .toString());
                        String formattedDate =
                            DateFormat("dd/MM/yyyy").format(parsedDate);
                        return ListTile(
                          onTap: () async {
                            final userId = await UserViewModel().getUser();
                            ImageDownloader()
                                .fetchAndDownloadImages(context,
                                    folderName:
                                        'patient/$userId/medical_record/',
                                    fileNames: medRecData.filename,
                                    matchName: medRecData.imageUrl,
                                    loopAllowed: false)
                                .then((_) {});
                            await Future.delayed(const Duration(seconds: 3));
                            LocalImageHelper.instance.loadingComplete.then((_) {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (_) {
                                    return showImage(medRecData);
                                  });
                            });
                          },
                          contentPadding: const EdgeInsets.all(0),
                          leading: Image.asset(
                            Assets.imagesMedicalReports,
                            width: Sizes.screenWidth * 0.09,
                            fit: BoxFit.cover,
                          ),
                          title: TextConst(
                            medRecData.filename ?? "",
                            // size: 10,
                            size: Sizes.fontSizeFour,
                            fontWeight: FontWeight.w400,
                          ),
                          trailing: TextConst(
                            formattedDate,
                            size: Sizes.fontSizeFour,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    )
                  : medRecCon.patientMedicalRecordsModel == null ||
                          medRecCon.patientMedicalRecordsModel!.data == null ||
                          medRecCon.patientMedicalRecordsModel!.data!
                              .medicalRecord!.isEmpty
                      ? Center(
                          child: TextConst(
                            "Doctor Not Available",
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF004AAD)),
                          ),
                        ),
            ),
          ],
        );
      }),
    );
  }

  Widget showImage(MedicalRecord medRecData) {
    String? imagePath =
        LocalImageHelper.instance.getImagePath(medRecData.filename ?? "");
    print(imagePath);
    if (imagePath == null) {
      return const CircularProgressIndicator();
    }
    if (medRecData.imageUrl!.endsWith('.pdf')) {
      print("pdfcase");
      return Stack(
        children: [
          Container(
            width: Sizes.screenWidth,
            height: Sizes.screenHeight,
            child: imagePath.toLowerCase().endsWith('.pdf')
                ? PDFView(filePath: imagePath)
                : Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(imagePath)),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
          ),
          Positioned(
              top: 40,
              left: 16,
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back, color: Colors.black))),
        ],
      );
    }

    return Stack(
      children: [
        Container(
          width: Sizes.screenWidth,
          height: Sizes.screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(imagePath.toString())),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back, color: Colors.black))),
      ],
    );

    // return Container(
    //   width: Sizes.screenWidth,
    //   height: Sizes.screenHeight,
    //   decoration: BoxDecoration(
    //       image: DecorationImage(image: FileImage(File(imagePath.toString())))),
    // );
  }

  Widget showImageBottomSheet() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              _imagePickerHelper.pickImageFromCamera(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              // _imagePickerHelper.pickImageFromGallery(context);
              _imagePickerHelper.pickSingleImageFromGallery(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('File'),
            onTap: () {
              Navigator.pop(context);
              _imagePickerHelper.pickDocument(context);
            },
          ),
        ],
      ),
    );
  }
}
