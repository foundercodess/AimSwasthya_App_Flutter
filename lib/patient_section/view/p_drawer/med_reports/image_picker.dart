// patient_section/view/p_drawer/med_reports/image_picker.dart
// import 'dart:convert';
// import 'dart:io';
// import 'package:aim_swasthya/view/user/drawer/med_reports/medical_overlay_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../../res/color_const.dart';
//
// class ImagePickerHelper {
//   final ImagePicker _picker = ImagePicker();
//   String _base64Image = '';
//
//   Future<void> pickImageFromCamera(BuildContext context) async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       _convertToBase64(pickedFile);
//       showModalBottomSheet(
//           elevation: 10,
//           isScrollControlled: true,
//           context: context,
//           shape: const RoundedRectangleBorder(
//             borderRadius:
//             BorderRadius.vertical(top: Radius.circular(16.0)),
//           ),
//           backgroundColor: AppColor.white,
//           builder: (BuildContext context) {
//             return MedicalOverlayScreen(pickedFile: pickedFile,);
//           });
//     }
//   }
//
//   Future<void> pickImageFromGallery(BuildContext context) async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       _convertToBase64(pickedFile);
//       showModalBottomSheet(
//           elevation: 10,
//           isScrollControlled: true,
//           context: context,
//           shape: const RoundedRectangleBorder(
//             borderRadius:
//             BorderRadius.vertical(top: Radius.circular(16.0)),
//           ),
//           backgroundColor: AppColor.white,
//           builder: (BuildContext context) {
//             return MedicalOverlayScreen(pickedFile: pickedFile,);
//           });
//     }
//   }
//
//   Future<void> _convertToBase64(XFile imageFile) async {
//     try {
//       final bytes = await imageFile.readAsBytes();
//       String base64String = base64Encode(bytes);
//       _base64Image = base64String;
//     } catch (e) {
//       print("Error converting image to Base64: $e");
//     }
//   }
//
// }
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../res/color_const.dart';
import 'package:aim_swasthya/patient_section/view/p_drawer/med_reports/medical_overlay_screen.dart';

class ImagePickerHelper {
  final ImagePicker _picker = ImagePicker();
  String pickedImage = '';
  Future<XFile?> pickImageFromCamera(BuildContext context,
      {bool isProfileSelection = false}) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      String base64Image = await _convertToBase64(pickedFile);
      if (isProfileSelection) {
        return pickedFile;
      }
      showModalBottomSheet(
        elevation: 10,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        backgroundColor: AppColor.white,
        builder: (BuildContext context) {
          return MedicalOverlayScreen(pickedFile: [pickedFile.path]);
        },

      );

    }

  }

  Future<XFile?> pickImageFromGallery(BuildContext context,
      {bool allowMultiple = false, bool isProfileSelection = false}) async {
    if (isProfileSelection = true) {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      return pickedFile;
    }
    final List<XFile> pickedFileList = await _picker.pickMultiImage();

    if (pickedFileList.isNotEmpty) {
      List<String> base64Images = [];
      if (isProfileSelection) {
        return pickedFileList.first;
      }
      for (var file in pickedFileList) {
        String base64 = await _convertToBase64(file);
        base64Images.add(base64);
      }

      showModalBottomSheet(
        elevation: 10,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        backgroundColor: AppColor.white,
        builder: (BuildContext context) {
          return MedicalOverlayScreen(
              pickedFile:
                  pickedFileList.map((e) => e.path.toString()).toList());
        },
      );
    }
  }

  Future<void> pickSingleImageFromGallery(BuildContext context) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String base64Image = await _convertToBase64(pickedFile);

      showModalBottomSheet(
        elevation: 10,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        backgroundColor: AppColor.white,
        builder: (BuildContext context) {
          return MedicalOverlayScreen(
            pickedFile: [
              pickedFile.path
            ], // still pass as list for compatibility
          );
        },
      );
    }

  }

  Future<String> _convertToBase64(XFile imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      print("Error converting image to Base64: $e");
      return "";
    }
  }

  Future<void> pickDocument(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      // If you need file path: file.path
      showModalBottomSheet(
        elevation: 10,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        backgroundColor: AppColor.white,
        builder: (BuildContext context) {
          return MedicalOverlayScreen(pickedFile: [file.path.toString()]
              // .map((e)=>
              // e.path.toString()).toList()
              );
        },
      );
      // Provider.of<GetImageUrlViewModel>(context, listen: false).addMedicalRecord(filePath: file.path!, fileName: file.name);
      // showModalBottomSheet(
      //   elevation: 10,
      //   isScrollControlled: true,
      //   context: context,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      //   ),
      //   backgroundColor: AppColor.white,
      //   builder: (BuildContext context) {
      //     // You can create another OverlayScreen like MedicalOverlayScreen
      //     // return MedicalOverlayScreenForDocuments(file: file);
      //   },
      // );
    }
  }
}

// import 'dart:convert';
// import 'package:aim_swasthya/view/user/drawer/med_reports/medical_overlay_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../../res/color_const.dart';
//
// class ImagePickerHelper {
//   final ImagePicker _picker = ImagePicker();
//   String _base64Image = '';
//
//   Future<void> pickImageFromCamera(BuildContext context) async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       _convertToBase64(pickedFile);
//       showModalBottomSheet(
//           elevation: 10,
//           isScrollControlled: true,
//           context: context,
//           shape: const RoundedRectangleBorder(
//             borderRadius:
//             BorderRadius.vertical(top: Radius.circular(16.0)),
//           ),
//           backgroundColor: AppColor.white,
//           builder: (BuildContext context) {
//             return MedicalOverlayScreen(pickedFile: [pickedFile]);
//           });
//     }
//   }
//
//   Future<void> pickImageFromGallery(BuildContext context, {bool allowMultiple = false}) async {
//     final List<XFile>? pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles != null && pickedFiles.isNotEmpty) {
//       if (allowMultiple) {
//         List<String> base64Images = [];
//         for (var file in pickedFiles) {
//           await _convertToBase64(file);
//           base64Images.add(_base64Image);
//         }
//         showModalBottomSheet(
//             elevation: 10,
//             isScrollControlled: true,
//             context: context,
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
//             ),
//             backgroundColor: AppColor.white,
//             builder: (BuildContext context) {
//               return MedicalOverlayScreen( pickedFile:pickedFiles );
//             });
//
//       } else {
//         await _convertToBase64(pickedFiles.first);
//         showModalBottomSheet(
//             elevation: 10,
//             isScrollControlled: true,
//             context: context,
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
//             ),
//             backgroundColor: AppColor.white,
//             builder: (BuildContext context) {
//               return MedicalOverlayScreen(pickedFile: pickedFiles);
//             });
//       }
//     }
//   }
//
//   Future<void> _convertToBase64(XFile imageFile) async {
//     try {
//       final bytes = await imageFile.readAsBytes();
//       String base64String = base64Encode(bytes);
//       _base64Image = base64String;
//     } catch (e) {
//       print("Error converting image to Base64: $e");
//     }
//   }
// }
