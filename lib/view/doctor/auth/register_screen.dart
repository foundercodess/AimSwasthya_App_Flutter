import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/view/common/intro/all_set_doc_screen.dart';
import 'package:aim_swasthya/view_model/doctor/doc_auth_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_reg_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _speController = TextEditingController();
  final TextEditingController _expController = TextEditingController();
  final TextEditingController _smcNumController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final registerCon =
          Provider.of<RegisterViewModel>(context, listen: false);
      registerCon.resetValues();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final doctorCon = Provider.of<DoctorAuthViewModel>(context, listen: false);
    final registerCon = Provider.of<RegisterViewModel>(context);
    _numberController.text= doctorCon.senOtpData['phone'];
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: appBarConstant(context,
          isBottomAllowed: true,
          child: Container(
            height: Sizes.screenHeight * 0.013,
            width: Sizes.screenWidth * 0.4,
            decoration: BoxDecoration(
              color: AppColor.textfieldGrayColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Sizes.screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: registerCon.isPersonalInfoSelected
                        ? AppColor.lightBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  width: Sizes.screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: !registerCon.isPersonalInfoSelected
                        ? AppColor.lightBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          )),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            Sizes.screenWidth * 0.1,
            Sizes.screenHeight * 0.06,
            Sizes.screenWidth * 0.1,
            Sizes.screenHeight * 0.12),
        // child: registerCon.isPersonalInfoSelected
        //     ? personalInfoScreen(onContinue: () => _registerDoctor(context))
        //     : identityScreen(),

        child: registerCon.isPersonalInfoSelected == true
            ? personalInfoScreen()
            : identityScreen(),
      ),
      bottomSheet: Container(
        color: AppColor.white,
        padding: EdgeInsets.only(bottom: Sizes.screenHeight / 22, top: 10),
        child: AppBtn(
          height: Sizes.screenHeight * 0.065,
          title: AppLocalizations.of(context)!.continue_con,
          onTap: () {
            if (registerCon.isPersonalInfoSelected == true) {
              doctorCon.doctorRegisterApi(
                  _nameController.text,
                  _genderController.text,
                  _speController.text,
                  _expController.text,
                  context);
            }
            // else{
            //   registerCon.changeWidget(false);
            // }

          },
          color: AppColor.blue,
        ),
      ),
    );
  }

  PreferredSizeWidget appBarConstant(BuildContext context,
      {Widget? child, bool isBottomAllowed = false, String? label}) {
    return AppBar(
        backgroundColor: AppColor.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Image(image: AssetImage(Assets.iconsBackBtn)),
            )),
        bottom: isBottomAllowed
            ? PreferredSize(
                preferredSize: const Size.fromHeight(10),
                child: child ?? TextConst(label ?? ""),
              )
            : null);
  }

  Widget personalInfoScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Sizes.spaceHeight10,
          TextConst(
            AppLocalizations.of(context)!.personal_information,
            size: Sizes.fontSizeSix,
            fontWeight: FontWeight.w500,
          ),
          TextConst(
            AppLocalizations.of(context)!.please_provide_your_details,
            size: Sizes.fontSizeFourPFive,
            fontWeight: FontWeight.w400,
            color: AppColor.textGrayColor,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Sizes.screenHeight * 0.05,
          ),
          CustomTextField(
            contentPadding:
                const EdgeInsets.only(top: 18, bottom: 20, left: 10),
            fillColor: AppColor.textfieldGrayColor,
            hintText: "Name",
            controller: _nameController,
            cursorColor: AppColor.textGrayColor,
          ),
          Sizes.spaceHeight25,
          CustomTextField(
            contentPadding:
                const EdgeInsets.only(top: 18, bottom: 20, left: 10),
            fillColor: AppColor.textfieldGrayColor,
            hintText: "Gender",
            suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.textfieldTextColor,
                  size: 20,
                )),
            controller: _genderController,
            cursorColor: AppColor.textGrayColor,
          ),
          Sizes.spaceHeight25,
          CustomTextField(
            contentPadding:
                const EdgeInsets.only(top: 18, bottom: 20, left: 10),
            fillColor: AppColor.textfieldGrayColor,
            hintText: "Contact no",
            controller: _numberController,
            keyboardType: TextInputType.number,
            cursorColor: AppColor.textGrayColor,
            maxLength: 10,
            enabled: false,
          ),
          Sizes.spaceHeight25,
          CustomTextField(
            contentPadding:
                const EdgeInsets.only(top: 18, bottom: 20, left: 10),
            fillColor: AppColor.textfieldGrayColor,
            hintText: "Specialisation",
            controller: _speController,
            cursorColor: AppColor.textGrayColor,
          ),
          Sizes.spaceHeight25,
          CustomTextField(
            contentPadding:
                const EdgeInsets.only(top: 18, bottom: 20, left: 10),
            fillColor: AppColor.textfieldGrayColor,
            hintText: "Experience",
            controller: _expController,
            cursorColor: AppColor.textGrayColor,
          ),
          Sizes.spaceHeight35,
        ],
      ),
    );
  }

  Widget identityScreen() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Center(
          child: TextConst(
            AppLocalizations.of(context)!.identity_verification,
            size: Sizes.fontSizeSix,
            fontWeight: FontWeight.w500,
          ),
        ),
        Sizes.spaceHeight20,
        constContainer(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Sizes.spaceHeight20,
            CustomTextField(
              fillColor: AppColor.whiteColor,
              hintText: "SMC number",
              hintSize: 10,
              hintWeight: FontWeight.w400,
              suffixIcon: Icon(
                Icons.check_circle,
                size: Sizes.screenWidth * 0.1,
                color: Color(0xff4ECB71),
              ),
              // Image.asset(Assets.iconsCircleCheck,height: 5,fit: BoxFit.contain,),
              // suffixIcon: const Image(
              //   image: AssetImage(Assets.iconsCircleCheck),
              //   width: 20,
              //
              controller: _smcNumController,
              cursorColor: AppColor.textGrayColor,
            ),
            Sizes.spaceHeight30,
            Row(
              children: [
                TextConst(
                  padding: EdgeInsets.only(left: Sizes.screenWidth * 0.02),
                  AppLocalizations.of(context)!.identity_proof,
                  // size: 10,
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                  color: AppColor.blackColor,
                ),
                const Spacer(),
                AppBtn(
                    fontSize: 12,
                    borderRadius: 12,
                    title: AppLocalizations.of(context)!.add,
                    height: Sizes.screenHeight * 0.044,
                    width: Sizes.screenWidth * 0.38,
                    color: AppColor.blue,
                    onTap: () {})
              ],
            ),
            Sizes.spaceHeight20,
          ],
        )),
        SizedBox(
          height: Sizes.screenHeight * 0.03,
        ),
        DottedBorder(
          color: AppColor.lightBlue,
          strokeWidth: 4,
          borderType: BorderType.RRect,
          radius: const Radius.circular(15),
          dashPattern: const [5, 4],
          padding: EdgeInsets.zero,
          child: constContainer(
            child: Column(
              children: [
                TextConst(
                  AppLocalizations.of(context)!.profile_photo,
                  size: 16,
                  // size: Sizes.fontSizeFivePFive,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: Sizes.screenHeight * 0.003),
                TextConst(
                  AppLocalizations.of(context)!.add_a_profile_photo_for,
                  size: 12,
                  // size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                  color: AppColor.lightBlack,
                ),
                SizedBox(height: Sizes.screenHeight * 0.05),
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColor.lightSkyBlue),
                  child: const Icon(
                    Icons.add,
                    color: AppColor.blue,
                    size: 45,
                  ),
                ),
                // Sizes.spaceHeight35,
                SizedBox(height: Sizes.screenHeight * 0.06),
              ],
            ),
          ),
        ),
        Sizes.spaceHeight10,
      ]),
    );
  }

  Widget constContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.screenWidth * 0.05,
        vertical: Sizes.screenHeight * 0.025,
      ),
      // height: Sizes.screenHeight * 0.3,
      width: Sizes.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor.textfieldGrayColor,
      ),
      child: child,
    );
  }
}

Route cupertinoTopToBottomRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 1000),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, -2.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return CupertinoPageTransition(
        linearTransition: false,
        primaryRouteAnimation: animation,
        secondaryRouteAnimation: secondaryAnimation,
        child: SlideTransition(position: offsetAnimation, child: child),
      );
    },
  );
}
