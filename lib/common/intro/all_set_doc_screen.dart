// view/common/intro/all_set_doc_screen.dart
import 'dart:async';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_role_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllSetDocScreen extends StatefulWidget {
  const AllSetDocScreen({super.key});

  @override
  State<AllSetDocScreen> createState() => _AllSetDocScreenState();
}

class _AllSetDocScreenState extends State<AllSetDocScreen> {
  @override
  void initState() {
    final authCon = Provider.of<UserRoleViewModel>(context, listen: false);
    super.initState();
    if (authCon.userRole == 2) {}
    Timer(const Duration(milliseconds: 1500), () async {
      authCon.userRole == 1
          ? Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.doctorBottomNevBar, (context) => false)
          : Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.bottomNavBar, (context) => false,
              arguments: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Sizes.screenWidth,
      decoration: const BoxDecoration(
        gradient: AppColor.primaryBlueRadGradient,
      ),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextConst(
                AppLocalizations.of(context)!.all_set,
                size: Sizes.fontSizeFive,
                fontWeight: FontWeight.w500,
              ),
              TextConst(
                AppLocalizations.of(context)!.lets_aimswasthya,
                size: Sizes.fontSizeFive,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              )
            ]),
      ),
    ));
  }
}

// class AllSetDocScreenDone extends StatefulWidget {
//   const AllSetDocScreenDone({super.key});
//
//   @override
//   State<AllSetDocScreenDone> createState() => _AllSetDocScreenDoneState();
// }
//
// class _AllSetDocScreenDoneState extends State<AllSetDocScreenDone> {
//   @override
//   void initState() {
//     final authCon = Provider.of<UserRegisterViewModel>(context, listen: false);
//     super.initState();
//     if (authCon.userRole == 2) {}
//     Timer(const Duration(milliseconds: 1500), () async {
//       authCon.userRole == 1
//           ? Navigator.pushNamedAndRemoveUntil(
//               context, RoutesName.doctorBottomNevBar, (context) => false)
//           : Navigator.pushNamedAndRemoveUntil(
//               context, RoutesName.bottomNavBar, (context) => false);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       width: Sizes.screenWidth,
//       decoration: const BoxDecoration(
//         gradient: AppColor.primaryBlueRadGradient,
//       ),
//       child: Center(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextConst(
//                 AppLocalizations.of(context)!.all_set,
//                 size: Sizes.fontSizeFive,
//                 fontWeight: FontWeight.w500,
//               ),
//               TextConst(
//                 AppLocalizations.of(context)!.lets_aimswasthya,
//                 size: Sizes.fontSizeFive,
//                 fontWeight: FontWeight.w600,
//                 color: AppColor.white,
//               )
//             ]),
//       ),
//     ));
//   }
// }

// import 'dart:async';
// import 'package:aim_swasthya/local_db/download_image.dart';
// import 'package:aim_swasthya/res/common_material.dart';
// import 'package:aim_swasthya/utils/routes/routes_name.dart';
// import 'package:aim_swasthya/view_model/user/userRegisterCon.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// class AllSetDocScreen extends StatefulWidget {
//   const AllSetDocScreen({super.key});
//
//   @override
//   State<AllSetDocScreen> createState() => _AllSetDocScreenState();
// }
//
// class _AllSetDocScreenState extends State<AllSetDocScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLocationPermission();
//   }
//
//   Future<void> _checkLocationPermission() async {
//     final status = await Permission.location.request();
//     if (status.isGranted) {
//       _navigateToNextScreen();
//     } else {
//       // Permission denied, stay on the screen
//     }
//   }
//
//   void _navigateToNextScreen() {
//     final authCon = Provider.of<UserRegisterViewModel>(context, listen: false);
//     if (authCon.userRole == 2) {
//       ImageDownloader().fetchAndDownloadImages();
//     }
//     Timer(const Duration(milliseconds: 1500), () {
//       authCon.userRole == 1
//           ? Navigator.pushNamedAndRemoveUntil(context, RoutesName.doctorBottomNevBar, (context) => false)
//           : Navigator.pushNamedAndRemoveUntil(context, RoutesName.bottomNavBar, (context) => false);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: Sizes.screenWidth,
//         decoration: const BoxDecoration(
//           gradient: AppColor.primaryBlueRadGradient,
//         ),
//         child: Center(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextConst(
//                   AppLocalizations.of(context)!.all_set,
//                   size: Sizes.fontSizeFive,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 TextConst(
//                   AppLocalizations.of(context)!.lets_aimswasthya,
//                   size: Sizes.fontSizeFive,
//                   fontWeight: FontWeight.w600,
//                   color: AppColor.white,
//                 )
//               ]),
//         ),
//       ),
//     );
//   }
// }
