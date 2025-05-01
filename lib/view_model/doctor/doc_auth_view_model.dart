import 'dart:async';
import 'dart:convert';
import 'package:aim_swasthya/repo/doctor/doc_auth_repo.dart';
import 'package:aim_swasthya/res/custom_loder.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/view_model/user/userRegisterCon.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

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
  bool isSigningIn = false;

  int _navType = 1;
  int get navType => _navType;

  setNavType(int type) {
    // 1-> login || 2-> signup
    _navType = type;
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
      isRegisterDocApi("", userCredential.user!.email, "email", context);
      return userCredential.user;
    } catch (e) {
      isSigningIn = false;
      setLoading(false);
      notifyListeners();
      print('Error during Google sign-in: $e');
      return null;
    }
  }

  Future<void> signOutFromGoogle(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      print('🚪 Signed out successfully');
    } catch (e) {
      print('❌ Error signing out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error during sign out')),
      );
    }
  }

  // OTP Registration Logic

  Future<void> isRegisterDocApi(
      dynamic phone, dynamic email, dynamic type, context) async {
    signOutFromGoogle(context);
    final authCon = Provider.of<UserRegisterViewModel>(context, listen: false);
    LoaderOverlay().show(context);
    setLoading(true);
    print("ffktgtr");
    Map data = {
      "phone": phone,
      "email": email,
      "type": type
    };
    print(jsonEncode(data));
    _doctorAuthRepo.isRegisterDocApi(data).then((value) {
      print(value);
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
            if (authCon.userRole == 1) {
              Navigator.pushNamed(context, RoutesName.registerScreen);
            } else {
              print("docSendklk;o;Otp--]=]");
              Navigator.pushNamed(context, RoutesName.userRegisterScreen);
            }
          } else {
            print("docSendOtp--]=]");
            Navigator.pushNamed(context, RoutesName.allSetDocScreen);
          }
        } else {
          print("docSendOtpApi");
          docSendOtpApi(context);
        }
      }
      LoaderOverlay().hide();
      // else if (value['status'] == true) {
      //   _senOtpData = {
      //     'isReg': value['is_registered'],
      //     "email": email,
      //     "type": type
      //   };
      // }
      // else{
      //   Navigator.pushNamed(context, RoutesName.userRegisterScreen);
      // }
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
      print(value);
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
    _timer?.cancel(); // Cancel any existing timer
    _seconds = 60; // Reset the counter
    _resendOtp = false;
    notifyListeners(); // Notify UI about reset
    print(":srfee");
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners();
      } else {
        _timer!.cancel();
        _resendOtp = true;
        notifyListeners();
      }
    });
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
          if (userRole == 1) {
            Navigator.pushNamed(context, RoutesName.registerScreen);
          } else {
            Navigator.pushNamed(context, RoutesName.userRegisterScreen);
          }
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
        "email": "priya.sharma@example.com",
        // "email": _senOtpData['email'],
      };
      print(jsonEncode(data));
      _doctorAuthRepo.doctorRegisterApi(data).then((value) {
        Utils.show(value['message'], context);
        if (value['status'] == true) {
          UserViewModel().saveUser(value['data']['doctor_id']);
          Navigator.pushNamed(context, RoutesName.allSetDocScreen);
          UserViewModel().saveRole(2);
        } else {
          Utils.show(value['message'], context);
        }
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
}
