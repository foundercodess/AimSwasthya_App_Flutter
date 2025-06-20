// doctor_section/d_view_model/doc_auth_view_model.dart
import 'dart:async';
import 'dart:convert';
import 'package:aim_swasthya/doctor_section/d_repo/doc_auth_repo.dart';
import 'package:aim_swasthya/res/custom_loder.dart';
import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_role_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../patient_section/p_view_model/get_image_url_view_model.dart';
import 'doc_reg_view_model.dart';

class DoctorAuthViewModel extends ChangeNotifier {
  final _doctorAuthRepo = DoctorAuthRepo();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  bool _isApplicationSetupProcessing = false;
  bool get isApplicationSetupProcessing => _isApplicationSetupProcessing;

  setApplicationSetupProcessing(bool val) {
    _isApplicationSetupProcessing = val;
    notifyListeners();
  }

  dynamic _senOtpData;
  dynamic get senOtpData => _senOtpData;
  bool isSigningIn = false;

  int _navType = 1;
  int get navType => _navType;

  setNavType(int type) {
    // 1-> login || 2-> signup
    _navType = type;
    notifyListeners();
  }

  XFile? _profileImage;
  XFile? get profileImage => _profileImage;
  setProfileImage(XFile? image) async {
    _profileImage = image;
    notifyListeners();
    // final entityType=
    // await addImageApi('doctor', image!.name,);
  }

  XFile? _identityImage;
  XFile? get identityImage => _identityImage;
  setIdentityImage(XFile? image) {
    _identityImage = image;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Google Sign-In Logic
  Future<User?> signInWithGoogle(BuildContext context) async {
    setLoading(true);
    isSigningIn = true;
    notifyListeners();
    signOutFromGoogle(context);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isSigningIn = false;
        setLoading(false);
        notifyListeners();
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      isSigningIn = false;
      setLoading(false);
      notifyListeners();
      // isRegisterDocApi("", "tripathiji183@gmail.com", "email", context);
      isRegisterDocApi("", userCredential.user!.email, "email", context);
      return userCredential.user;
    } catch (e) {
      isSigningIn = false;
      setLoading(false);
      notifyListeners();
      debugPrint('Error during Google sign-in: $e');
      return null;
    }
  }

  Future<void> signOutFromGoogle(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      if (kDebugMode) {
        print('🚪 Signed out successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error signing out: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error during sign out')),
      );
    }
  }

  // OTP Registration Logic

  Future<void> isRegisterDocApi(
      dynamic phone, dynamic email, dynamic type, context) async {
    final authCon = Provider.of<UserRoleViewModel>(context, listen: false);
    LoaderOverlay().show(context);
    setLoading(true);
    Map data = {"phone": phone, "email": email, "type": type};
    debugPrint(jsonEncode(data));
    _doctorAuthRepo.isRegisterDocApi(data).then((value) {
      // debugPrint(value);
      Utils.show(value['message'], context);
      if (value['status'] == true) {
        _senOtpData = {
          'isReg': value['is_registered'],
          "phone": phone,
          "email": email,
          "type": type
        };
        if (type == "email") {
          if (!value['is_registered']) {
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return ActionOverlay(
                    text: "User not found",
                    subtext:
                        "Looks like you don't have an account yet. Let's get you registered!",
                    noLabel: "Cancel",
                    yesLabel: "Continue",
                    onTap: () {
                      Navigator.pop(context);
                      if (authCon.userRole == 1) {
                        Navigator.pushNamed(context, RoutesName.registerScreen);
                      } else {
                        Navigator.pushNamed(
                            context, RoutesName.userRegisterScreen);
                      }
                    },
                  );
                });
          } else {
            UserViewModel().saveUser(value['doctor_id']);
            Navigator.pushNamed(context, RoutesName.allSetDocScreen);
          }
        } else {
          docSendOtpApi(context);
        }
      } else {
        _senOtpData = {
          'isReg': value['is_registered'],
          "phone": phone,
          "email": email,
          "type": type
        };
        if (type == "email") {
          if (!value['is_registered']) {
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return ActionOverlay(
                    text: "User not found",
                    subtext:
                        "Looks like you don't have an account yet. Let's get you registered!",
                    noLabel: "Cancel",
                    yesLabel: "Continue",
                    onTap: () {
                      Navigator.pop(context);
                      if (authCon.userRole == 1) {
                        Navigator.pushNamed(context, RoutesName.registerScreen);
                      } else {
                        Navigator.pushNamed(
                            context, RoutesName.userRegisterScreen);
                      }
                    },
                  );
                });
          }
          // if (!value['is_registered']) {
          //   if (authCon.userRole == 1) {
          //     Navigator.pushNamed(context, RoutesName.registerScreen);
          //   } else {
          //     Navigator.pushNamed(context, RoutesName.userRegisterScreen);
          //   }
          // }
          else {
            UserViewModel().saveUser(value['doctor_id']);
            Navigator.pushNamed(context, RoutesName.allSetDocScreen);
          }
        } else {
          docSendOtpApi(context);
        }
      }
      LoaderOverlay().hide();
    }).onError((error, stackTrace) {
      LoaderOverlay().hide();
      setLoading(false);
      notifyListeners();
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

  //send otp Logic
  Future<void> docSendOtpApi(context, {bool resendMode = false}) async {
    setLoading(true);
    Map data = {
      "phone": _senOtpData['phone'],
      "email": _senOtpData['email'],
      "type": _senOtpData['type']
    };

    print(data);
    _doctorAuthRepo.docSendOtpApi(data).then((value) {
      Utils.show(value['message'], context);
      print("anshii${value}");
      if (value['status'] == true) {
        _senOtpData['id'] = value['user']['doctor_id'];
        if (_senOtpData['email'] != null && _senOtpData['email'] != "") {
          UserViewModel().saveUser(2);
        }
        LoaderOverlay().hide();
        startTimer();
        if (!resendMode) {
          Navigator.pushNamed(
            context,
            RoutesName.otpScreen,
            arguments: {
              'phone': _senOtpData['phone'],
              'id': value['user']['doctor_id']
            },
          );
        }
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

  int _seconds = 60;
  int get seconds => _seconds;
  Timer? _timer;
  bool _resendOtp = false;
  bool get resendOtp => _resendOtp;

  void startTimer() {
    print("fun invoked");
    _timer?.cancel();
    _seconds = 60;
    _resendOtp = false;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print("jljnkjjnjnj");
      if (_seconds > 0) {
        print("effre");
        _seconds--;
        notifyListeners();
      } else {
        print("sds");
        _timer!.cancel();
        _resendOtp = true;
        notifyListeners();
      }
    });
    print(_resendOtp);
  }

  clearOtpTimer() {
    _timer!.cancel();
    _resendOtp = false;
  }

  // verify otp Logic
  Future<void> verifyDocApi(
      BuildContext context, String otp, int userRole) async {
    LoaderOverlay().show(context);
    setLoading(true);
    Map data = {
      "doctor_id": _senOtpData['id'],
      "enteredOtp": otp,
      "type": "phone"
    };
    _doctorAuthRepo.verifyDocOtpApi(data).then((value) {
      Utils.show(value['message'], context);
      if (value['success'] == true) {
        LoaderOverlay().hide();
        UserViewModel().saveBeToken(value['accessToken']);
        if (!_senOtpData['isReg']) {
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return ActionOverlay(
                  text: "User not found",
                  subtext:
                      "Looks like you don't have an account yet. Let's get you registered!",
                  noLabel: "Cancel",
                  yesLabel: "Continue",
                  onTap: () {
                    Navigator.pop(context);
                    if (userRole == 1) {
                      Navigator.pushNamed(context, RoutesName.registerScreen);
                    } else {
                      Navigator.pushNamed(
                          context, RoutesName.userRegisterScreen);
                    }
                  },
                );
              });
          Utils.show(value['message'], context);
        } else {
          LoaderOverlay().hide();
          UserViewModel().saveUser(_senOtpData['id']);
          Navigator.pushNamed(context, RoutesName.allSetDocScreen);
          UserViewModel().saveRole(userRole);
          Utils.show(value['message'], context);
        }
      }
      LoaderOverlay().hide();
    }).onError((error, stackTrace) {
      setLoading(false);
      notifyListeners();
      if (kDebugMode) {
        print('error: $error');
      }
      LoaderOverlay().hide();
    });
  }

  //patient Register api
  Future<void> doctorRegisterApi(
    dynamic name,
    dynamic gender,
    dynamic speId,
    dynamic praYear,
    context,
  ) async {
    try {
      setLoading(true);
      Map data = {
        "name": name,
        "gender": gender.toString().trim(),
        "phone": _senOtpData['phone'],
        "specialization_id": speId,
        "practice_start_year": praYear,
        "email": _senOtpData['email'],
        // "email": _senOtpData['email'],
      };
      print("reg payload: ${jsonEncode(data)}");
      _doctorAuthRepo.doctorRegisterApi(data).then((value) {
        Utils.show(value['message'], context);
        if (value['status'] == true) {
          final registerCon =
              Provider.of<RegisterViewModel>(context, listen: false);
          registerCon.changeWidget(false);
          UserViewModel().saveUser(value['data']['doctor']['doctor_id']);
          UserViewModel().saveRole(1);
          // Navigator.push(
          //     context, cupertinoTopToBottomRoute(const AllSetDocScreen()));
        } else {
          UserViewModel().saveUser(value['data']['doctor']['doctor_id']);
        }
        UserViewModel().saveRole(1);
        // Navigator.push(
        //     context, cupertinoTopToBottomRoute(const AllSetDocScreen()));
        Utils.show(value['message'], context);
        // else {
        //   Utils.show(value['message'], context);
        // }
      }).onError((error, stackTrace) {
        setLoading(false);
        notifyListeners();
        if (kDebugMode) {
          print('error: $error');
        }
      });
    } catch (error) {
      setLoading(false);
      notifyListeners();
      if (kDebugMode) {
        print('Error getting location: $error');
      }
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
      dynamic imagePath, dynamic fileTypeName, BuildContext context) async {
    setLoading(true);
    final userId = await UserViewModel().getUser();
    final fileType = getImageType(imageName);
    Map data = {
      "entity_id": userId,
      "entity_type": entityType,
      "image_name":
          "${fileTypeName == 'profile_photo' ? 'profile' : 'id_prood'}.$fileType",
      "file_type": fileTypeName
    };
    print("xfghjk" + jsonEncode(data));
    _doctorAuthRepo.addImageUrlApi(data).then((value) {
      print(value);
      Utils.show(value['message'], context);
      if (value['status'] == true) {
        Provider.of<GetImageUrlViewModel>(context, listen: false)
            .uploadFile(context,
                filePath: imagePath,
                // filePath: value['image_url']);
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
