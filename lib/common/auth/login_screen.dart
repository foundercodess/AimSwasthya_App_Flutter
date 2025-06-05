import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BackGroundPage(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: TextConst("Log in",
                    size: Sizes.fontSizeFive,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white),
              ),
              Sizes.spaceHeight5,
              TextConst("Let’s begin your health journey",
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff4c86cc)),
              Sizes.spaceHeight10,
              SizedBox(
                height: Sizes.screenHeight * 0.02,
              ),
              CustomTextField(
                hintText: "Email",
                controller: _emailController,
              ),
              Sizes.spaceHeight35,
              CustomTextField(
                hintText: "Password",
                controller: _passController,
              ),
              Sizes.spaceHeight15,
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextConst("Forgot password?",
                        size: Sizes.fontSizeFour * 1.1,
                        fontWeight: FontWeight.w300,
                        color: AppColor.white),
                    Sizes.spaceHeight5,
                    TextConst("Don’t have an account?",
                        size: Sizes.fontSizeFour * 1.1,
                        fontWeight: FontWeight.w300,
                        color: AppColor.white),
                  ],
                ),
              ),
              SizedBox(
                height: Sizes.screenHeight * 0.01,
              ),
              AppBtn(
                title: "Log in",
                onTap: () {
                  // Navigator.pushNamed(context, RoutesName.mobileLoginScreen);
                },
                color: AppColor.blue,
                height: Sizes.screenHeight * 0.07,
              ),
              SizedBox(
                height: Sizes.screenHeight * 0.02,
              ),
              const Divider(color: AppColor.white),
              SizedBox(height: Sizes.screenHeight * 0.016),
              TextConst("Or log in using",
                  size: Sizes.fontSizeFour,
                  fontWeight: FontWeight.w300,
                  color: AppColor.white),
              SizedBox(height: Sizes.screenHeight * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){},
                      child: Image.asset(Assets.iconsGoogle,width: 27,)),
                  Sizes.spaceWidth15,
                  GestureDetector
                    (onTap: (){},
                      child: Image.asset(Assets.iconsFacebook,width: 27,))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget constContainer(String imageUrl, String text) {
    return Container(
      width: Sizes.screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.white, width: 1.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            height: Sizes.screenHeight * 0.03,
            fit: BoxFit.contain,
          ),
          SizedBox(width: Sizes.screenWidth * 0.04),
          TextConst(text,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w300,
              color: AppColor.white),
        ],
      ),
    );
  }

}
