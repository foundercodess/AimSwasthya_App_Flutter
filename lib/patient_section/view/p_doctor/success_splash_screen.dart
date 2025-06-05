import 'dart:async';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuccessSplashScreen extends StatefulWidget {
  const SuccessSplashScreen({super.key});

  @override
  State<SuccessSplashScreen> createState() => _SuccessSplashScreenState();
}

class _SuccessSplashScreenState extends State<SuccessSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      Navigator.pushReplacementNamed(context, RoutesName.viewAppointmentsScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.iconsCheckmark,
              width: 80,
              height: 80,
              fit: BoxFit.fitHeight,
            ),
            Sizes.spaceHeight10,
            Center(
              child: TextConst(
                AppLocalizations.of(context)!.thank_you,
                size: Sizes.fontSizeSix,
                fontWeight: FontWeight.w600,
              ),
            ),
            Sizes.spaceHeight10,
            TextConst(
              AppLocalizations.of(context)!.appointment_has_been_booked,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w400,
              color: AppColor.textfieldTextColor,
            ),
            TextConst(
              AppLocalizations.of(context)!.wishing_you_healthy,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w400,
              color: AppColor.textfieldTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
