import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/view/user/secound_nav_bar.dart';
import 'package:aim_swasthya/view_model/doctor/patient_profile_view_model.dart';
import 'package:aim_swasthya/view_model/user/patient_profile_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../res/common_material.dart';

class YourProfileScreen extends StatefulWidget {
  const YourProfileScreen({super.key});

  @override
  State<YourProfileScreen> createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {
  bool isFirstSelected = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _numberEmailController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  void _selectGender(String gender) {
    setState(() {
      _genderController.text = gender;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserPatientProfileViewModel>(context, listen: false)
          .userPatientProfileApi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final yourProfile = Provider.of<UserPatientProfileViewModel>(context);

    return   Scaffold(
      extendBody: true,
      primary: false,
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBarConstant(
              context,
              isBottomAllowed: true,
              child: Center(
                child: TextConst(
                  "Your profile",
                  size: Sizes.fontSizeSix * 1.1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Sizes.spaceHeight25,
            addMemberSec(),
            Sizes.spaceHeight30,
            Container(
              height: Sizes.screenHeight * 0.03,
              width: Sizes.screenWidth * 0.85,
              decoration: BoxDecoration(
                color: const Color(0xffDFEDFF).withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirstSelected = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isFirstSelected
                              ? AppColor.blue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: TextConst(
                          'General',
                          color: isFirstSelected
                              ? const Color(0xffE4E4E4)
                              : const Color(0xffAAAAAA),
                          size: Sizes.fontSizeFour,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirstSelected = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: !isFirstSelected
                              ? AppColor.blue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: TextConst(
                          'Medical',
                          color: isFirstSelected
                              ? const Color(0xffAAAAAA)
                              : const Color(0xffE4E4E4),
                          size: Sizes.fontSizeFour,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Sizes.spaceHeight30,
            // Sizes.spaceHeight30,
            addProfileSec(),
            Sizes.spaceHeight30,
            personalDetails(),
            Sizes.spaceHeight30,
            Sizes.spaceHeight30,
            Sizes.spaceHeight30,
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        width: Sizes.screenWidth,
        color: AppColor.white,
        child: const CommenBottomNevBar(),
      ),
    );
  }

  Widget addMemberSec() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.04),
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.04,
          vertical: Sizes.screenHeight * 0.02),
      // height: Sizes.screenHeight * 0.4,
      width: Sizes.screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffDFEDFF)),
      child: Column(
        children: [
          // Sizes.spaceHeight15,
          Image.asset(
            Assets.assetsYourProfile,
            height: Sizes.screenHeight * 0.03,
          ),
          Sizes.spaceHeight15,
          TextConst(
            "Add family members",
            size: Sizes.fontSizeFourPFive,
            fontWeight: FontWeight.w600,
          ),
          Sizes.spaceHeight10,
          Center(
            child: TextConst(
              textAlign: TextAlign.center,
              "Get personalized doctor recommendations for\n upto 4 family members",
              size: Sizes.fontSizeFour,
              fontWeight: FontWeight.w400,
            ),
          ),
          Sizes.spaceHeight10,
          ButtonConst(
            title: "Add members",
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return addMemberBottom();
                },
              );
            },
            width: Sizes.screenWidth * 0.45,
            height: Sizes.screenHeight * 0.037,
            color: AppColor.blue,
          )
        ],
      ),
    );
  }

  Widget addProfileSec() {
    return Column(
      children: [
        DottedBorder(
          borderType: BorderType.Circle,
          color: AppColor.lightBlue,
          strokeWidth: 1,
          dashPattern: const [4, 3],
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.screenWidth * 0.05,
              vertical: Sizes.screenHeight * 0.02),
          // padding: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.screenWidth * 0.05,
                vertical: Sizes.screenHeight * 0.02),
            child: Column(
              children: [
                Sizes.spaceHeight5,
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffDFEDFF),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: AppColor.blue,
                    size: 35,
                  ),
                ),
                Sizes.spaceHeight10,
                TextConst(
                  "Add a profile photo",
                  size: Sizes.fontSizeThree,
                  // size: 8,
                  fontWeight: FontWeight.w400,
                  color: AppColor.textfieldGrayColor,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget personalDetails() {
    final yourProfile = Provider.of<UserPatientProfileViewModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.04),
      child: yourProfile != null  &&
              yourProfile.userPatientProfileModel!.data!.isNotEmpty
          ? Column(
              children: [
                CustomTextField(
                  contentPadding:
                      const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                  fillColor: AppColor.grey,
                  hintText:
                      yourProfile.userPatientProfileModel!.data![0].name ??
                          "Name",
                  controller: _nameController,
                  cursorColor: AppColor.textGrayColor,
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                ),
                Sizes.spaceHeight10,
                Center(
                  child: Container(
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes.screenWidth * 0.03),
                    child: DropdownButton<String>(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                        size: 20,
                      ),
                      value: genderOptions.contains(_genderController.text)
                          ? _genderController.text
                          : null,
                      hint: TextConst(
                        yourProfile.userPatientProfileModel!.data![0].gender ??
                            "Gender",
                        size: Sizes.fontSizeFour,
                        color: AppColor.textfieldTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                      underline: const SizedBox(),
                      isExpanded: true,
                      items: genderOptions.map((data) {
                        return DropdownMenuItem<String>(
                          value: data,
                          child: TextConst(
                            data.toString(),
                            fontWeight: FontWeight.w500,
                            size: Sizes.fontSizeFive,
                            color: AppColor.blue,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? gender) {
                        _selectGender(gender!);
                      },
                    ),
                  ),
                ),
                Sizes.spaceHeight10,
                CustomTextField(
                  contentPadding:
                      const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                  fillColor: AppColor.grey,
                  hintText: yourProfile
                          .userPatientProfileModel!.data![0].phoneNumber ??
                      "Contact no",
                  controller: _numberEmailController,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColor.textGrayColor,
                  maxLength: 10,
                  // enabled: false,
                ),
                Sizes.spaceHeight10,
                CustomTextField(
                  contentPadding:
                      const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                  fillColor: AppColor.grey,
                  hintText:
                      yourProfile.userPatientProfileModel!.data![0].email ??
                          "Email Id",
                  controller: _emailController,
                  cursorColor: AppColor.textGrayColor,
                  // enabled: false,
                ),
                Sizes.spaceHeight10,
                CustomTextField(
                  contentPadding:
                      const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                  fillColor: AppColor.grey,
                  // hintText: yourProfile
                  //         .userPatientProfileModel!.data![0].dateOfBirth ??
                  //     "Date Of Birth",
                  hintText: DateFormat('dd/MM/yyyy').format(DateTime.parse(
                      yourProfile.userPatientProfileModel!.data![0].dateOfBirth
                          .toString())),
                  controller: _dobController,
                  cursorColor: AppColor.textGrayColor,
                  // enabled: false,
                ),
                Sizes.spaceHeight30,
                Sizes.spaceHeight10,
                ButtonConst(
                  title: "Save",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  color: AppColor.blue,
                  width: Sizes.screenWidth * 0.66,
                ),
                Sizes.spaceHeight30,
              ],
            )
          : const SizedBox(),
    );
  }

  Widget addMemberBottom() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.screenWidth * 0.04,
          vertical: Sizes.screenHeight * 0.03),
      width: Sizes.screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset(Assets.allImagesAddProfile),
          Image.asset(Assets.assetsYourProfile),
          Sizes.spaceHeight15,
          TextConst(
            "Add family members",
            size: Sizes.fontSizeNine,
            fontWeight: FontWeight.w600,
          ),
          Sizes.spaceHeight10,
          Center(
              child: TextConst(
            textAlign: TextAlign.center,
            "Get personalized doctor recommendations for\nupto 4 family members",
            size: Sizes.fontSizeFour,
            fontWeight: FontWeight.w400,
          )),
          Sizes.spaceHeight15,
          // Row(
          //   children: List.generate(steps.length + 1, (index) {
          //     if (index < steps.length) {
          //       return Row(
          //         children: [
          //           Container(
          //             width: 60,
          //             height: 60,
          //             decoration: const BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: Colors.blue,
          //             ),
          //             child: Center(
          //               child: Text(
          //                 '${steps[index]}',
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 18,
          //                 ),
          //               ),
          //             ),
          //           ),
          //           const SizedBox(width: 20),
          //         ],
          //       );
          //     } else {
          //       // "+" Button
          //       return DottedBorder(
          //         borderType: BorderType.Circle,
          //         color: Colors.blue,
          //         strokeWidth: 1.5,
          //         dashPattern: [4, 3],
          //         padding: const EdgeInsets.all(4),
          //         child: IconButton(
          //           onPressed: addStep,
          //           icon: const Icon(
          //             Icons.add,
          //             color: Colors.blue,
          //             size: 35,
          //           ),
          //         ),
          //       );
          //     }
          //   }),
          // ),
          Row(
            children: [
              Container(
                width: Sizes.screenHeight * 0.075,
                height: Sizes.screenHeight * 0.075,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.blue),
                child: Center(
                  child: TextConst(
                    "1",
                    size: Sizes.fontSizeFour,
                    fontWeight: FontWeight.w400,
                    color: AppColor.white,
                  ),
                ),
              ),
              Sizes.spaceWidth20,
              DottedBorder(
                borderType: BorderType.Circle,
                color: AppColor.blue,
                strokeWidth: 1.5,
                dashPattern: const [4, 3],
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes.screenWidth * 0.012,
                    vertical: Sizes.screenHeight * 0.02),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: AppColor.blue,
                      size: 35,
                    )),
              )
            ],
          ),
          Sizes.spaceHeight10,
          const Divider(
            color: AppColor.grey,
          ),
          Sizes.spaceHeight15,
          SizedBox(
            height: Sizes.screenHeight * 0.26,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextField(
                      height: Sizes.screenHeight * 0.06,
                      borderSide: const BorderSide(color: Color(0xffE5E5E5)),
                      fillColor: AppColor.grey,
                      hintText: "Name",
                      hintColor: const Color(0xffC3C3C3),
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]')),
                      ],
                      cursorColor: AppColor.textGrayColor,
                      // enabled: false,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      height: Sizes.screenHeight * 0.06,
                      borderSide: const BorderSide(color: Color(0xffE5E5E5)),
                      fillColor: AppColor.grey,
                      hintText: "Age",
                      hintColor: const Color(0xffC3C3C3),
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.textGrayColor,
                      maxLength: 10,
                      suffixIcon: IconButton(
                          onPressed: () {},
                          // icon: Image.asset(Assets.allImagesSolarCalendar,scale: 3,)),
                          icon: Image.asset(
                            Assets.iconsNotification,
                            scale: 3,
                          )),
                      // enabled: false,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      height: Sizes.screenHeight * 0.06,
                      borderSide: const BorderSide(color: Color(0xffE5E5E5)),
                      fillColor: AppColor.grey,
                      hintText: "Gender",
                      hintColor: const Color(0xffC3C3C3),
                      controller: _genderController,
                      keyboardType: TextInputType.name,
                      cursorColor: AppColor.textGrayColor,
                      // enabled: false,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      height: Sizes.screenHeight * 0.06,
                      borderSide: const BorderSide(color: Color(0xffE5E5E5)),
                      fillColor: AppColor.grey,
                      hintText: "Height",
                      hintColor: const Color(0xffC3C3C3),
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.textGrayColor,
                      // enabled: false,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      height: Sizes.screenHeight * 0.06,
                      borderSide: const BorderSide(color: Color(0xffE5E5E5)),
                      fillColor: AppColor.grey,
                      hintText: "Weight",
                      hintColor: const Color(0xffC3C3C3),
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.textGrayColor,
                      // enabled: false,
                    ),
                    Sizes.spaceHeight30,
                    ButtonConst(
                      title: "Save",
                      onTap: () {},
                      color: AppColor.blue,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
