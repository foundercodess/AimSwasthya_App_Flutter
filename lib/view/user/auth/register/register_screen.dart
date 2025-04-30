import 'package:aim_swasthya/res/back_btn_const.dart';
import 'package:aim_swasthya/res/custom_calendar.dart';
import 'package:aim_swasthya/res/glassmorphism_const.dart'
    show GlassmorphismExample;
import 'package:aim_swasthya/view_model/user/auth_view_model.dart';
import 'package:aim_swasthya/view_model/user/userRegisterCon.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});
  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String selectedGender = '';
  dynamic dateTime;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userRegCon =
          Provider.of<UserRegisterViewModel>(context, listen: false);
      userRegCon.resetValues();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final patientAuthCon =
        Provider.of<PatientAuthViewModel>(context, listen: false);
    final userRegCon = Provider.of<UserRegisterViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: Sizes.screenHeight,
        width: Sizes.screenWidth,
        decoration: const BoxDecoration(
          gradient: AppColor.primaryBlueRadGradient,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.screenWidth * 0.06,
              vertical: Sizes.screenHeight * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Sizes.spaceHeight10,
              BackBtnConst(
                onTap: () {
                  if (userRegCon.isPersonalInfoSelected > 1) {
                    userRegCon
                        .changeWidget(userRegCon.isPersonalInfoSelected - 1);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              const Spacer(),
              userRegCon.isPersonalInfoSelected == 1
                  ? Center(child: introSection())
                  : userRegCon.isPersonalInfoSelected == 2
                      ? genderSection()
                      : userRegCon.isPersonalInfoSelected == 3
                          ? calendarSection()
                          : userRegCon.isPersonalInfoSelected == 4
                              ? heightSection()
                              : const SizedBox(),
              const Spacer(),
              AppBtn(
                fontSize: Sizes.fontSizeFive,
                borderRadius: 15,
                borderGradient: const [AppColor.lightBlue, AppColor.blue],
                height: Sizes.screenHeight * 0.06,
                width: Sizes.screenWidth,
                fontWidth: FontWeight.w500,
                title: AppLocalizations.of(context)!.next,

                // isShadowEnable: true,
                titleColor: AppColor.textFieldBtnColor,
                onTap: () {
                  if (userRegCon.isPersonalInfoSelected == 1) {
                    userRegCon.changeWidget(2);
                  }
                  else if (userRegCon.isPersonalInfoSelected == 2) {
                    userRegCon.changeWidget(3);
                  } else if (userRegCon.isPersonalInfoSelected == 3) {
                    userRegCon.changeWidget(4);
                  } else if (userRegCon.isPersonalInfoSelected == 4) {
                    patientAuthCon.patientRegisterApi(
                        _nameController.text,
                        selectedGender,
                        dateTime,
                        _heightController.text,
                        _weightController.text,
                        context);
                    // Navigator.pushNamed(context, RoutesName.allSetDocScreen);
                  }
                },
                color: AppColor.white,
              ),
              Sizes.spaceHeight10,
            ],
          ),
        ),
      ),
    );
  }

  Widget introSection() {
    return Container(
      height: Sizes.screenHeight * 0.7,
      width: Sizes.screenWidth * 0.9,
      padding: EdgeInsets.only(
        left: Sizes.screenWidth * 0.09,
        right: Sizes.screenWidth * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextConst(
            AppLocalizations.of(context)!.hello_introduction,
            size: Sizes.fontSizeFive,
            fontWeight: FontWeight.w500,
            color: AppColor.darkBlack,
          ),
          Sizes.spaceHeight5,
          TextConst(
            AppLocalizations.of(context)!.tell_name,
            size: Sizes.fontSizeFive,
            fontWeight: FontWeight.w600,
            color: AppColor.white,
          ),
          Sizes.spaceHeight25,
          TextField(
            controller: _nameController,
            // keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enter_full_name,
              hintStyle: TextStyle(
                  color: AppColor.textFieldBtnColor,
                  fontWeight: FontWeight.w300,
                  fontSize: Sizes.fontSizeFive),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.black.withOpacity(0.75)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.black.withOpacity(0.75)),
              ),
            ),
            cursorColor: AppColor.textGrayColor,
            cursorHeight: 22,
            style: const TextStyle(
              color: AppColor.blue,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget genderSection() {
    return Container(
      padding: EdgeInsets.only(
        left: Sizes.screenWidth * 0.09,
        right: Sizes.screenWidth * 0.05,
      ),
      // padding: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.06),
      height: Sizes.screenHeight / 2,
      width: Sizes.screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextConst(
            AppLocalizations.of(context)!.step_1,
            size: Sizes.fontSizeFive,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
          Sizes.spaceHeight25,
          ListTile(
            title: TextConst(
              "${AppLocalizations.of(context)!.hi_prashant}${_nameController.text}!",
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w500,
              color: AppColor.darkBlack,
            ),
            subtitle: TextConst(
              AppLocalizations.of(context)!.gender_identify,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
          ),
          Sizes.spaceHeight35,
          AppBtn(
            height: Sizes.screenHeight * 0.05,
            width: Sizes.screenWidth * 0.42,
            title: AppLocalizations.of(context)!.male,
            titleColor: AppColor.black,
            color: selectedGender == "Male"
                ? AppColor.textGrayColor
                : AppColor.grey,
            fontWidth: FontWeight.w400,
            onTap: () {
              setState(() {
                selectedGender = "Male";
              });
            },
          ),
          Sizes.spaceHeight30,
          AppBtn(
            height: Sizes.screenHeight * 0.05,
            width: Sizes.screenWidth * 0.42,
            title: AppLocalizations.of(context)!.female,
            titleColor: AppColor.black,
            color: selectedGender == "Female"
                ? AppColor.textGrayColor
                : AppColor.grey,
            onTap: () {
              setState(() {
                selectedGender = "Female";
              });
            },
          ),
          Sizes.spaceHeight30,
          AppBtn(
            height: Sizes.screenHeight * 0.05,
            width: Sizes.screenWidth * 0.42,
            title: AppLocalizations.of(context)!.others,
            titleColor: AppColor.black,
            color: selectedGender == "Other"
                ? AppColor.textGrayColor
                : AppColor.grey,
            onTap: () {
              setState(() {
                selectedGender = "Other";
              });
            },
          ),
        ],
      ),
    );
  }

  Widget calendarSection() {
    return Column(
      children: [
        TextConst(
          AppLocalizations.of(context)!.step_2,
          color: Colors.black54,
          size: Sizes.fontSizeFive,
          fontWeight: FontWeight.w500,
        ),
        Sizes.spaceHeight25,
        SizedBox(
          width: Sizes.screenWidth * 0.55,
          child: ListTile(
            title: TextConst(
              AppLocalizations.of(context)!.great,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w500,
              color: AppColor.darkBlack,
            ),
            subtitle: TextConst(
              AppLocalizations.of(context)!.birthday,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
          ),
        ),
        Sizes.spaceHeight20,
        CustomCalendar(
          onDateSelected: (v) {
            setState(() {
              dateTime = v;
            });
          },
        ),
      ],
    );
  }

  Widget heightSection() {
    return Container(
      padding: EdgeInsets.only(
        left: Sizes.screenWidth * 0.09,
        right: Sizes.screenWidth * 0.05,
      ),
      height: Sizes.screenHeight / 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextConst(
            AppLocalizations.of(context)!.step_3,
            color: Colors.black54,
            size: Sizes.fontSizeFive,
            fontWeight: FontWeight.w500,
          ),
          Sizes.spaceHeight25,
          ListTile(
            title: TextConst(
              AppLocalizations.of(context)!.awesome,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w500,
              color: AppColor.darkBlack,
            ),
            subtitle: TextConst(
              AppLocalizations.of(context)!.height_weight,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
          ),
          SizedBox(height: Sizes.screenHeight * 0.08),
          SizedBox(
            width: Sizes.screenWidth / 2.6,
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextConst(
                      AppLocalizations.of(context)!.height,
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                    Container(
                      width: 50,
                      margin:
                          const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                      child: TextField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Sizes.fontSizeFivePFive,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blue,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.only(bottom: 0, left: 0, right: 0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.white),
                          ),
                          counterText: "",
                        ),
                        cursorColor: AppColor.textGrayColor,
                        cursorHeight: 20,
                      ),
                    ),
                    TextConst(
                      AppLocalizations.of(context)!.cm,
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                  ],
                ),
                Sizes.spaceHeight25,
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextConst(
                      AppLocalizations.of(context)!.weight,
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                      width: 50.0,
                      child: TextField(
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Sizes.fontSizeFivePFive,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blue,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 8.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.white),
                          ),
                          counterText: "",
                        ),
                        cursorColor: AppColor.textGrayColor,
                        cursorHeight: 20,
                      ),
                    ),
                    TextConst(
                      AppLocalizations.of(context)!.kg,
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
