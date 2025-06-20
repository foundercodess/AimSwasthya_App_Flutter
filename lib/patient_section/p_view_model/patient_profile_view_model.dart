// patient_section/p_view_model/patient_profile_view_model.dart
import 'dart:convert';
import 'package:aim_swasthya/model/user/patient_profile_model.dart';
import 'package:aim_swasthya/patient_section/p_repo/patient_profile_repo.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_home_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../res/custom_loder.dart' show LoaderOverlay;
import 'get_image_url_view_model.dart';

class UserPatientProfileViewModel extends ChangeNotifier {
  final _userPatientProfileRepo = UserPatientAppointmentRepo();

  bool _loading = false;
  bool get loading => _loading;

  bool _isEditMode = false;
  bool get isEditMode => _isEditMode;

  void setEditMode(bool value) {
    _isEditMode = value;
    notifyListeners();
  }

  XFile? _profileImage;
  XFile? get profileImage => _profileImage;
  setProfileImage(XFile? image) async {
    _profileImage = image;
    notifyListeners();
  }

  UserPatientProfileModel? _userPatientProfileModel;
  UserPatientProfileModel? get userPatientProfileModel =>
      _userPatientProfileModel;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setUserPatientProfileData(UserPatientProfileModel value) {
    _userPatientProfileModel = value;
    notifyListeners();
  }

  Future<void> userPatientProfileApi(BuildContext context,
      {bool isLoad = true}) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "patient_id": "$userId",
      // "patient_id": 20,
    };
    _userPatientProfileRepo.userPatientProfileApi(data).then((value) {
      if (value.status == true) {
        setUserPatientProfileData(value);
      } else {
        setUserPatientProfileData(value);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

  Future<bool> updatePatientProfileApi(
    BuildContext context, {
    required String name,
    required String gender,
    required String phone,
    required String email,
    required String dob,
    required String height,
    required String weight,
    required String bloodGroup,
    required String allergies,
    required String currentMed,
    required String chronicIll,
    required String lifestyleHab,
  }) async {
    try {
      final userId = await UserViewModel().getUser();

      // Clean height and weight values by removing units and any non-numeric characters
      String cleanHeight = height
          .replaceAll(' Cm', '')
          .replaceAll('cm', '')
          .replaceAll('CM', '')
          .replaceAll(RegExp(r'[^0-9.]'), '')
          .trim();

      String cleanWeight = weight
          .replaceAll(' Kg', '')
          .replaceAll('kg', '')
          .replaceAll('KG', '')
          .replaceAll(RegExp(r'[^0-9.]'), '')
          .trim();

      Map data = {
        "patient_id": "$userId",
        "name": name,
        "gender": gender,
        "phone_number": phone,
        "email": email,
        "date_of_birth": dob,
        "height": cleanHeight,
        "weight": cleanWeight,
        "blood_group": bloodGroup,
        "allergies": allergies,
        "current_medications": currentMed,
        "chronic_illnesses": chronicIll,
        "lifestyle_habbits": lifestyleHab
      };
      debugPrint("bodyff: ${jsonEncode(data)}");
      final response =
          await _userPatientProfileRepo.updatePatientProfileApi(data);
      if (response['status'] == true) {
        await userPatientProfileApi(context, isLoad: false);
        Provider.of<PatientHomeViewModel>(context, listen: false)
            .patientHomeApi(context);
        Utils.show(response['message'], context);
        return true;
      } else {
        Utils.show(response['message'] ?? "Update failed", context);
        return false;
      }
    } catch (error) {
      if (kDebugMode) {
        print('error: $error');
      }
      Utils.show("Something went wrong. Please try again.", context);
      return false;
    }
  }

  String? getImageType(String fileName) {
    if (fileName.endsWith('.png')) {
      return 'png';
    } else if (fileName.endsWith('.jpg') || fileName.endsWith('.jpeg')) {
      return 'jpg';
    } else {
      return 'png';
    }
  }

  Future<void> addImageApi(dynamic entityType, dynamic imageName,
      dynamic imagePath, dynamic fileTypeName, BuildContext context,
      {bool isDirectUpdate = false}) async {
    setLoading(true);
    print("dkdmdkmflmfdm $fileTypeName");
    final userId = await UserViewModel().getUser();
    final fileType = getImageType(imageName);
    Map data = {
      "entity_id": userId,
      "entity_type": entityType,
      "image_name":
          "${fileTypeName == 'profile_photo' ? 'profile' : 'id_prood'}.$fileType",
      "file_type": fileTypeName
    };

    print("body: $data");
    if (isDirectUpdate) {
      print("ewewweiwehoei");
      Provider.of<GetImageUrlViewModel>(context, listen: false).uploadFile(
          context,
          filePath: imagePath,
          fileName: "patient/$userId/profile.$fileType");
      return;
    }
    print("continueeeeeeeeee");
    _userPatientProfileRepo.addImageUrlApi(data).then((value) {
      debugPrint("response: $value");
      Utils.show(value['message'], context);
      if (value['status'] == true) {
        Provider.of<GetImageUrlViewModel>(context, listen: false).uploadFile(
            context,
            filePath: imagePath,
            fileName: value['image_url']);
        Utils.show(value['message'], context);
      }
    }).onError((error, stackTrace) {
      LoaderOverlay().hide();
      setLoading(false);
      notifyListeners();
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
