// import 'dart:async';
// import 'package:aim_swasthya/res/common_material.dart';
// import 'package:aim_swasthya/utils/routes/routes_name.dart';
// import 'package:aim_swasthya/view_model/user/user_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     Timer( const Duration(seconds: 3), () async {
//     Navigator.pushNamed(context, RoutesName.introScreen);
//     });
//     _checkSessionAndNavigate();
//   }
//
//   Future<void> _checkSessionAndNavigate() async {
//     // Get instance of UserViewModel
//     final userViewModel = Provider.of<UserViewModel>(context, listen: false);
//
//     // Get saved userId and role from SharedPreferences
//     int? userId = await userViewModel.getUser();
//     int? role = await userViewModel.getRole();
//
//     // Navigate based on userId and role values
//     Timer(const Duration(seconds: 3), () {
//       if (userId == null || userId == 0) {
//         // No userId (not logged in), go to the intro screen
//         Navigator.pushReplacementNamed(context, RoutesName.introScreen);
//       } else if (role == 1) {
//         // If user is a Doctor (role == 1), navigate to the Doctor section
//         Navigator.pushReplacementNamed(context, RoutesName.doctorBottomNevBar);
//       } else {
//         // If user is a Patient (role != 1), navigate to the Patient section
//         Navigator.pushReplacementNamed(context, RoutesName.bottomNavBar);
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.white,
//       body: Center(
//         child: Container(
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(Assets.logoAppLogo),
//               )),
//         ),
//       ),
//     );
//   }
// }
//
import 'dart:async';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }
  void _showPermissionRationaleDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return ActionOverlay(
          height: Sizes.screenHeight / 5.2,
          padding: EdgeInsets.only(
            left: Sizes.screenWidth * 0.03,
            right: Sizes.screenWidth * 0.03,
            top: Sizes.screenHeight * 0.02,
          ),
          text: "Permission Required",
          subtext: "We use your location to show doctors near you and help you book appointments more easily.",
          onTap: () async {
            Navigator.pop(context);
            final permissionStatus = await Permission.location.request();
            if (permissionStatus.isGranted) {
              _checkAndEnableLocation();
            } else if (permissionStatus.isPermanentlyDenied) {
              _showPermissionDeniedDialog();
            }
          },
        );
      },
    );
  }

  // Future<void> _checkLocationPermission() async {
  //   final status = await Permission.location.status;
  //
  //   if (status.isGranted) {
  //     _checkAndEnableLocation();
  //   }
  //   else {
  //     showCupertinoDialog(
  //         context: context,
  //         builder: (context) {
  //           return LogoutSection(
  //             height: Sizes.screenHeight/5.2,
  //             padding: EdgeInsets.only(left: Sizes.screenWidth*0.03,right:Sizes.screenWidth*0.05,top: Sizes.screenHeight*0.02),
  //             text: "Permission Required",
  //             subtext:
  //             "We use your location to show doctors near you and help you book appointments more easily.",
  //             onTap: () {
  //               Navigator.pop(context);
  //               _checkAndEnableLocation();
  //               // voiceSearchCon.initSpeech().then((_) {
  //               //   voiceSearchCon.isListenklklkllkjjkljklljkling
  //               //       ? voiceSearchCon.stopListening()
  //               //       : voiceSearchCon.startListening();
  //               // });
  //             },
  //           );
  //         });
  //   }
  //   // final status = await Permission.location.request();
  //   // if (status.isGranted) {
  //   //   _checkAndEnableLocation();
  //   // } else {
  //   //   // Stay on the splash screen if permission is denied
  //   //   _showPermissionDeniedDialog();
  //   // }
  // }

  Future<void> _checkLocationPermission() async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      _checkAndEnableLocation();
    } else if (status.isPermanentlyDenied) {
      _showPermissionDeniedDialog();
    } else {
      _showPermissionRationaleDialog(); // your custom dialog to explain purpose
    }
  }


  Future<void> _checkAndEnableLocation() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {

      await Geolocator.openLocationSettings();
    }
    while (!await Geolocator.isLocationServiceEnabled()) {
      await Future.delayed(const Duration(seconds: 1));
    }
    _checkSessionAndNavigate();
  }

  Future<void> _checkSessionAndNavigate() async {
    final userViewModel =UserViewModel();
    int? userId = await userViewModel.getUser();
    int? role = await userViewModel.getRole();
    print("object: $userId");
    if (mounted) {
      Future.delayed(const Duration(seconds: 1), () {
        if (userId == null || userId == 0) {
          Navigator.pushReplacementNamed(context, RoutesName.introScreen);
        } else {
          if (role == 1) {
            Navigator.pushReplacementNamed(context, RoutesName.doctorBottomNevBar);
          } else {
            Navigator.pushReplacementNamed(context, RoutesName.bottomNavBar, arguments: true);
          }
        }
      });
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Location Permission Required"),
          content: const Text("This app requires location permission to proceed. Please enable it in settings."),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await openAppSettings();
              },
              child: const Text("Open Settings"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.logoAppLogo),
              )),
        ),
      ),
    );
  }
}


