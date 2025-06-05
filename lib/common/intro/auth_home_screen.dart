// view/common/intro/auth_home_screen.dart
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/patient_section/p_view_model/auth_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_role_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthHomeScreen extends StatefulWidget {
  const AuthHomeScreen({super.key});

  @override
  State<AuthHomeScreen> createState() => _AuthHomeScreenState();
}

class _AuthHomeScreenState extends State<AuthHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authCon = Provider.of<UserRoleViewModel>(context, listen: false);
    return BackGroundPage(
      children: [
        TextConst(AppLocalizations.of(context)!.an_account,
            size: Sizes.fontSizeFive,
            fontWeight: FontWeight.w600,
            color: AppColor.white),
        SizedBox(
          height: Sizes.screenHeight * 0.003,
        ),
        TextConst(
            authCon.userRole == 1
                ? "Else, register super quick!"
                : "Else, sign up super quick!",
            size: Sizes.fontSizeFour,
            fontWeight: FontWeight.w500,
            color: AppColor.primaryGray),
        SizedBox(height: Sizes.screenHeight * 0.05),
        AppBtn(
          fontWidth: FontWeight.w500,
          padding: const EdgeInsets.all(1.4),
          borderGradient: authCon.userRole == 1
              ? [AppColor.primaryBlue, AppColor.black]
              : [AppColor.lightBlue, AppColor.blue],
          title: AppLocalizations.of(context)!.your_account,
          onTap: () {
            Provider.of<UserRoleViewModel>(context, listen: false).setNavType(1);
            Navigator.pushNamed(context, RoutesName.mobileLoginScreen,);
          },
          isShadowEnable: true,
        ),
        Sizes.spaceHeight20,
        AppBtn(
          padding: const EdgeInsets.all(1.4),
          fontWidth: FontWeight.w500,
          borderGradient: authCon.userRole == 1
              ? [AppColor.primaryBlue, AppColor.black]
              : [AppColor.lightBlue, AppColor.blue],
          title: AppLocalizations.of(context)!.sign_up,
          isShadowEnable: true,
          onTap: () {
            Provider.of<UserRoleViewModel>(context, listen: false).setNavType(2);
            Navigator.pushNamed(context, RoutesName.mobileLoginScreen ,);
          },
        ),
      ],
    );
  }
}
