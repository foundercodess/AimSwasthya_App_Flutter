// common/intro/about_us_screen.dart
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:flutter/material.dart';
import '../../res/common_material.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: Sizes.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppbarConst(
                title: 'About us',
                color: AppColor.blue,
                titleColor: AppColor.white,
                iconColor: AppColor.white,
                fontWeight: FontWeight.w600,
              ),
              Sizes.spaceHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.logoAimswasthyaBox,
                    height: Sizes.screenHeight * 0.22,
                    width: Sizes.screenHeight * 0.22,
                  ),
                ],
              ),
              Sizes.spaceHeight20,
              title(
                "Your health. Your language. Your specialist.",
              ),
              Sizes.spaceHeight10,
              content(
                "At AIMSwasthya, we believe that early diagnosis is not a privilege it’s a right. In India, millions suffer from delayed treatments simply because the right specialist wasn’t consulted in time. More often than not, people turn to general physicians due to lack of awareness, language barriers, and limited access to specialist care especially in Tier 2 and Tier 3 cities. ",
              ),
              Sizes.spaceHeight10,
              message("We’re here to change that."),
              Sizes.spaceHeight10,
              title("Our Mission"),
              Sizes.spaceHeight10,
              content(
                  "To simplify early diagnosis by making healthcare accessible, understandable, and personalized—right from your phone. We aim to reduce preventable complications by helping people connect with the right specialist, at the right time, using the language they are most comfortable with."),
              Sizes.spaceHeight10,
              title(
                "How We Help",
              ),
              Sizes.spaceHeight10,
              message("🤖 AI-Powered Symptom Analysis"),
              Sizes.spaceHeight10,
              content(
                  "Our smart engine analyzes your inputs and suggests the exact type of specialist you should consult—whether it’s a cardiologist, neurologist, orthopedist, or anyone else."),
              Sizes.spaceHeight10,
              message("🩺 No More Guesswork"),
              Sizes.spaceHeight10,
              content(
                  "No more running from one doctor to another. No more wasting time on the wrong treatments. AIMSwasthya gives you clarity from Day 1."),
              Sizes.spaceHeight10,
              message("📱 Seamless Mobile Experience"),
              Sizes.spaceHeight10,
              content(
                  "Built for Bharat, our mobile app is lightweight, intuitive, and designed for ease-of-use—even for first-time smartphone users."),
              Sizes.spaceHeight10,
              title("Why It Matters"),
              Sizes.spaceHeight10,
              content(
                  "India’s healthcare system is under pressure. But we can ease that pressure by enabling early diagnosis. Early diagnosis leads to better treatment outcomes, lower costs, and healthier communities. By bridging the gap between symptoms and specialists, AIMSwasthya empowers individuals to take control of their health journey—with confidence, clarity, and care."),
              Sizes.spaceHeight35,
              Container(
                width: Sizes.screenWidth,
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes.screenWidth * 0.06,
                    vertical: Sizes.screenHeight * 0.04),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.naviBlue, AppColor.blue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins-Bold',
                          color: Colors.blue,
                        ),
                        children: [
                          TextSpan(text: 'Built for '),
                          TextSpan(
                            text: 'Bh',
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontFamily: 'Poppins-Bold',
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: 'ar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins-Bold',
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: 'at',
                            style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Poppins-Bold',
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: '. Backed by Tech.',
                          ),
                        ],
                      ),
                    ),
                    Sizes.spaceHeight25,
                    TextConst(
                      textAlign: TextAlign.center,
                      "AIMSwasthya is a healthtech innovation inspired by on ground realities and backed by cutting-edge Al. We've collaborated with doctors, linguists, and engineers to ensure our platform is medically accurate, culturally relevant, and linguistically inclusive.",
                      size: Sizes.fontSizeFour,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                  ],
                ),
              ),
              Sizes.spaceHeight15,
              Center(
                child: TextConst(
                  "Made with ❤ by AIMSwasthya",
                  size: Sizes.fontSizeFive,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Sizes.spaceHeight20,
            ],
          ),
        ),
      ),
    );
  }

  Widget title(String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.screenWidth * 0.06,
      ),
      child: TextConst(
        label,
        size: Sizes.fontSizeFourPFive,
        fontWeight: FontWeight.w600,
        color: AppColor.black,
      ),
    );
  }

  Widget content(String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.screenWidth * 0.06,
      ),
      child: TextConst(
        text,
        size: Sizes.fontSizeFour,
        fontWeight: FontWeight.w400,
        color: AppColor.black,
      ),
    );
  }

  Widget message(String message, {String? image}) {
    return Row(
      children: [
        if (image != null)
          Image.asset(
            image,
            width: 20,
          ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.screenWidth * 0.06,
          ),
          child: TextConst(
            message,
            size: Sizes.fontSizeFour,
            fontWeight: FontWeight.w500,
            color: AppColor.blue,
          ),
        ),
      ],
    );
  }
}
