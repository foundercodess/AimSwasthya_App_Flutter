import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view_model/user/userRegisterCon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authCon = Provider.of<UserRegisterViewModel>(context, listen: false);

    return BackGroundPage(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: TextConst("Sign up",
                    size: Sizes.fontSizeFive,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white),
              ),
              Sizes.spaceHeight10,
              TextConst("Let’s begin your health journey",
                  size: Sizes.fontSizeFourPFive,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff4c86cc)),
              Sizes.spaceHeight25,
              CustomTextField(
                hintText: "Email",
                controller: _emailController,
              ),
              Sizes.spaceHeight35,
              CustomTextField(
                hintText: "Password",
                controller: _passController,
              ),
              Sizes.spaceHeight35,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  checkBox(),
                  Sizes.spaceWidth10,
                  SizedBox(
                    width: Sizes.screenWidth * 0.75,
                    child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "By signing up, you accept the ",
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: Sizes.fontSizeFour,
                                fontWeight: FontWeight.w400,
                                color: AppColor.white,
                              ),
                            ),
                            TextSpan(
                              text: "Terms and Conditions",
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                decoration: TextDecoration.underline,
                                decorationColor: AppColor.naviBlue,
                                fontSize: Sizes.fontSizeFour,
                                fontWeight: FontWeight.w500,
                                color: AppColor.naviBlue,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            TextSpan(
                              text: " and ",
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: Sizes.fontSizeFour,
                                fontWeight: FontWeight.w400,
                                color: AppColor.white,
                              ),
                            ),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                decoration: TextDecoration.underline,
                                decorationColor: AppColor.naviBlue,
                                fontSize: Sizes.fontSizeFour,
                                fontWeight: FontWeight.w500,
                                color: AppColor.naviBlue,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        )),
                  )
                ],
              ),
              SizedBox(
                height: Sizes.screenHeight * 0.02,
              ),
              AppBtn(
                title: "Sign up",
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.otpScreen);
                },
                color: AppColor.blue,
                height: Sizes.screenHeight * 0.07,
              ),
              SizedBox(
                height: Sizes.screenHeight * 0.1,
              ),
              TextConst("Already have an account?",
                  size: Sizes.fontSizeFive,
                  fontWeight: FontWeight.w300,
                  color:AppColor.white),
              SizedBox(height: Sizes.screenHeight * 0.02),
            ],
          ),
        )
      ],
    );
  }
  Widget checkBox() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        // if (_otpController.text.length == 6 && isChecked == true) {
        //   Navigator.pushNamed(context, RoutesName.bottomNavBar);
        // }
      },
      child: Container(
        height: Sizes.screenHeight * 0.022,
        width: Sizes.screenWidth * 0.046,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColor.white,
        ),
        child:  Center(
          child: isChecked
              ? const Icon(
            Icons.check,
            size: 15,
            color: AppColor.blue,
          )
              : null,
        ),
      ),
    );
  }
}
