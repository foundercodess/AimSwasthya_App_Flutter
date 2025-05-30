// view/user/drawer/your_profile_screen.dart
import 'dart:io';

import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/view/user/drawer/add_member_overlay.dart';
import 'package:aim_swasthya/view/user/secound_nav_bar.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:aim_swasthya/view_model/user/patient_profile_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../res/common_material.dart';
import 'med_reports/image_picker.dart' show ImagePickerHelper;

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
  final TextEditingController _bloodController = TextEditingController();
  final TextEditingController _allergyController = TextEditingController();
  final TextEditingController _currMedController = TextEditingController();
  final TextEditingController _chronicController = TextEditingController();
  final TextEditingController _lifeStyleController = TextEditingController();

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
          .userPatientProfileApi(context);
    });
    super.initState();
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      // Try parsing the date in dd-MM-yyyy format
      final parts = dateStr.split('-');
      if (parts.length == 3) {
        final day = parts[0];
        final month = parts[1];
        final year = parts[2];
        return '$year-$month-$day';
      }
      return dateStr;
    } catch (e) {
      return dateStr;
    }
  }

  void _toggleEditMode() {
    final patProfileCon =
        Provider.of<UserPatientProfileViewModel>(context, listen: false);
    patProfileCon.setEditMode(!patProfileCon.isEditMode);
  }

  void _saveProfile() async {
    final patProfileCon =
        Provider.of<UserPatientProfileViewModel>(context, listen: false);
    final profileData = patProfileCon.userPatientProfileModel?.data!;
            if (_nameController.text.isEmpty) {
      _nameController.text = profileData![0].name ?? '';
    }
    if (_genderController.text.isEmpty) {
      _genderController.text = profileData![0].gender ?? '';
    }
    if (_numberEmailController.text.isEmpty) {
      _numberEmailController.text = profileData![0].phoneNumber ?? '';
    }
    if (_emailController.text.isEmpty) {
      _emailController.text = profileData![0].email ?? '';
    }
    if (_dobController.text.isEmpty) {
      _dobController.text = formatDate(profileData![0].dateOfBirth);
      // _dobController.text = profileData![0].dateOfBirth ?? '';
    }
    if (_heightController.text.isEmpty) {
      _heightController.text = profileData![0].height ?? '';
    }
    if (_weightController.text.isEmpty) {
      _weightController.text = profileData![0].weight ?? '';
    }
    if (_bloodController.text.isEmpty) {
      _bloodController.text = profileData![0].bloodGroup ?? '';
    }
    if (_allergyController.text.isEmpty) {
      _allergyController.text = profileData![0].allergies ?? '';
    }
    if (_currMedController.text.isEmpty) {
      _currMedController.text = profileData![0].currentMedications ?? '';
    }
    if (_chronicController.text.isEmpty) {
      _chronicController.text = profileData![0].chronicIllnesses ?? '';
    }
    if (_lifeStyleController.text.isEmpty) {
      _lifeStyleController.text = profileData![0].lifestyleHabbits ?? '';
    }
    final success = await patProfileCon.updatePatientProfileApi(
      context,
      name: _nameController.text,
      gender: _genderController.text,
      phone: _numberEmailController.text,
      email: _emailController.text,
      dob: _dobController.text,
      height: _heightController.text,
      weight: _weightController.text,
      bloodGroup: _bloodController.text,
      allergies: _allergyController.text,
      currentMed: _currMedController.text,
      chronicIll: _chronicController.text,
      lifestyleHab: _lifeStyleController.text,
    );

    if (success) {
      setState(() {
        _nameController.clear();
        _genderController.clear();
        _numberEmailController.clear();
        _emailController.clear();
        _dobController.clear();
        _heightController.clear();
        _weightController.clear();
        _bloodController.clear();
        _allergyController.clear();
        _currMedController.clear();
        _chronicController.clear();
        _lifeStyleController.clear();
      });
      _toggleEditMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Sizes.spaceHeight30,
            isFirstSelected == false
                ? Container(
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
                  )
                : const SizedBox(),
            isFirstSelected ? generalContent() : medicalContent(),
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

  Widget generalContent() {
    return Column(
      children: [
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
                      color:
                          isFirstSelected ? AppColor.blue : Colors.transparent,
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
                      color:
                          !isFirstSelected ? AppColor.blue : Colors.transparent,
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
        addProfileSec(),
        Sizes.spaceHeight30,
        personalDetails(),
      ],
    );
  }

  Widget medicalContent() {
    final yourProfile = Provider.of<UserPatientProfileViewModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.04),
      child: Column(
        children: [
          Sizes.spaceHeight30,
          CustomTextField(
            contentPadding:
                const EdgeInsets.only(top: 18, bottom: 20, left: 10),
            fillColor: AppColor.grey,
            hintText: yourProfile.userPatientProfileModel?.data?[0].bloodGroup?.isNotEmpty == true
                ? yourProfile.userPatientProfileModel!.data![0].bloodGroup!
                : "Blood Group",
            controller: _bloodController,
            cursorColor: AppColor.textGrayColor,
            keyboardType: TextInputType.text,
            enabled: yourProfile.isEditMode,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9+-]')),
            ],
          ),
          Sizes.spaceHeight10,
          CustomTextField(
            contentPadding:
                const EdgeInsets.only(top: 18, bottom: 20, left: 10),
            fillColor: AppColor.grey,
            hintText: yourProfile.userPatientProfileModel?.data?[0].allergies?.isNotEmpty == true
                ? yourProfile.userPatientProfileModel!.data![0].allergies!
                : "Allergies",
            controller: _allergyController,
            cursorColor: AppColor.textGrayColor,
            keyboardType: TextInputType.text,
            enabled: yourProfile.isEditMode,
          ),
          Sizes.spaceHeight10,
          CustomTextField(
            contentPadding:
                const EdgeInsets.only(top: 18, bottom: 20, left: 10),
            fillColor: AppColor.grey,
            hintText: yourProfile.userPatientProfileModel?.data?[0].currentMedications?.isNotEmpty == true
                ? yourProfile.userPatientProfileModel!.data![0].currentMedications!
                : "Current Medications",
            controller: _currMedController,
            cursorColor: AppColor.textGrayColor,
            keyboardType: TextInputType.text,
            enabled: yourProfile.isEditMode,
          ),
          Sizes.spaceHeight10,
          CustomTextField(
            contentPadding:
                const EdgeInsets.only(top: 18, bottom: 20, left: 10),
            fillColor: AppColor.grey,
            hintText: yourProfile.userPatientProfileModel?.data?[0].chronicIllnesses?.isNotEmpty == true
                ? yourProfile.userPatientProfileModel!.data![0].chronicIllnesses!
                : "Chronic Illnesses",
            controller: _chronicController,
            cursorColor: AppColor.textGrayColor,
            keyboardType: TextInputType.text,
            enabled: yourProfile.isEditMode,
          ),
          Sizes.spaceHeight10,
          CustomTextField(
            contentPadding:
                const EdgeInsets.only(top: 18, bottom: 20, left: 10),
            fillColor: AppColor.grey,
            hintText: yourProfile.userPatientProfileModel?.data?[0].lifestyleHabbits?.isNotEmpty == true
                ? yourProfile.userPatientProfileModel!.data![0].lifestyleHabbits!
                : "Lifestyle Habits",
            controller: _lifeStyleController,
            cursorColor: AppColor.textGrayColor,
            keyboardType: TextInputType.text,
            enabled: yourProfile.isEditMode,
          ),
          Sizes.spaceHeight30,
          yourProfile.isEditMode
              ? ButtonConst(
                  title: "Save",
                  onTap: _saveProfile,
                  color: AppColor.blue,
                  width: Sizes.screenWidth * 0.66,
                )
              : ButtonConst(
                  title: "Edit Profile",
                  onTap: _toggleEditMode,
                  color: AppColor.blue,
                  width: Sizes.screenWidth * 0.66,
                ),
          Sizes.spaceHeight30,
        ],
      ),
    );
  }

  Widget addMemberSec() {
    final memberCon = Provider.of<PatientHomeViewModel>(context);

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
                  return const AddMemberOverlay();
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
        Consumer<UserPatientProfileViewModel>(
            builder: (context, viewModel, child) {
          return DottedBorder(
            borderType: BorderType.Circle,
            color: AppColor.lightBlue,
            strokeWidth: 1,
            dashPattern: const [4, 3],
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.screenWidth * 0.05,
                vertical: Sizes.screenHeight * 0.02),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.screenWidth * 0.05,
                  vertical: Sizes.screenHeight * 0.02),
              child: Column(
                children: [
                  Sizes.spaceHeight5,
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        elevation: 10,
                        isScrollControlled: true,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16.0)),
                        ),
                        backgroundColor: AppColor.white,
                        builder: (BuildContext context) {
                          return showImageBottomSheet(true);
                        },
                      );
                    },
                    child: viewModel.profileImage != null
                        ? Stack(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(viewModel.profileImage!.path),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: AppColor.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: AppColor.whiteColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Container(
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
                          ),
                  ),
                  if (viewModel.profileImage == null) ...[
                    Sizes.spaceHeight10,
                    TextConst(
                      "Add a profile photo",
                      size: Sizes.fontSizeThree,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textfieldGrayColor,
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
        _ageController.text = calculateAgeFromDOB(_dobController.text);
      });
    }
  }

  Widget personalDetails() {
    final yourProfile = Provider.of<UserPatientProfileViewModel>(context);
    final profileData = yourProfile.userPatientProfileModel?.data;
    if (profileData == null || profileData.isEmpty) {
      return const SizedBox();
    }

    // Format the date when displaying
    if (_dobController.text.isEmpty && profileData[0].dateOfBirth != null) {
      _dobController.text = formatDate(profileData[0].dateOfBirth);
    }

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.04),
        child: Column(
          children: [
            CustomTextField(
              contentPadding:
                  const EdgeInsets.only(top: 18, bottom: 20, left: 10),
              fillColor: AppColor.grey,
              hintText:
                  yourProfile.userPatientProfileModel!.data![0].name ?? "Name",
              controller: _nameController,
              cursorColor: AppColor.textGrayColor,
              keyboardType: TextInputType.name,
              enabled: yourProfile.isEditMode,
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
                padding:
                    EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.03),
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
                  onChanged: yourProfile.isEditMode
                      ? (String? newId) {
                          if (newId != null) {
                            setState(() {
                              _genderController.text = newId;
                            });
                          }
                        }
                      : null,
                ),
              ),
            ),
            Sizes.spaceHeight10,
            CustomTextField(
              contentPadding:
                  const EdgeInsets.only(top: 18, bottom: 20, left: 10),
              fillColor: AppColor.grey,
              hintText:
                  yourProfile.userPatientProfileModel!.data![0].phoneNumber ??
                      "Contact no",
              controller: _numberEmailController,
              keyboardType: TextInputType.number,
              cursorColor: AppColor.textGrayColor,
              maxLength: 10,
              enabled: false,
            ),
            Sizes.spaceHeight10,
            CustomTextField(
              contentPadding:
                  const EdgeInsets.only(top: 18, bottom: 20, left: 10),
              fillColor: AppColor.grey,
              hintText: yourProfile.userPatientProfileModel!.data![0].email ??
                  "Email Id",
              controller: _emailController,
              cursorColor: AppColor.textGrayColor,
              enabled: false,
            ),
            Sizes.spaceHeight10,
            GestureDetector(
              onTap: yourProfile.isEditMode ? () => selectDate(context) : null,
              child: CustomTextField(
                contentPadding:
                    const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                fillColor: AppColor.grey,
                hintText: yourProfile
                    .userPatientProfileModel!.data![0].dateOfBirth
                    .toString(),
                controller: _dobController,
                cursorColor: AppColor.textGrayColor,
                enabled: false,
                suffixIcon: yourProfile.isEditMode
                    ? IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => selectDate(context),
                      )
                    : null,
              ),
            ),
            Sizes.spaceHeight30,
            yourProfile.isEditMode
                ? ButtonConst(
                    title: "Save",
                    onTap: _saveProfile,
                    color: AppColor.blue,
                    width: Sizes.screenWidth * 0.66,
                  )
                : ButtonConst(
                    title: "Edit Profile",
                    onTap: _toggleEditMode,
                    color: AppColor.blue,
                    width: Sizes.screenWidth * 0.66,
                  ),
            Sizes.spaceHeight30,
          ],
        ));
  }

  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  Widget showImageBottomSheet(bool isProfile) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () async {
              final img = await _imagePickerHelper.pickImageFromCamera(context,
                  isProfileSelection: true);
              if (img != null) {
                if (isProfile) {
                  Provider.of<UserPatientProfileViewModel>(context,
                          listen: false)
                      .setProfileImage(img);
                  Provider.of<UserPatientProfileViewModel>(context,
                          listen: false)
                      .addImageApi('doctor', img.name.toString(),
                          img.path.toString(), 'profile_photo', context);
                }
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                final img = await _imagePickerHelper
                    .pickImageFromGallery(context, isProfileSelection: true);
                if (img != null) {
                  if (isProfile) {
                    Provider.of<UserPatientProfileViewModel>(context,
                            listen: false)
                        .setProfileImage(img);
                    Provider.of<UserPatientProfileViewModel>(context,
                            listen: false)
                        .addImageApi('doctor', img.name.toString(),
                            img.path.toString(), 'profile_photo', context);
                  }
                }
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  String calculateAgeFromDOB(String dob) {
    try {
      final birthDate = DateTime.parse(dob);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age.toString();
    } catch (e) {
      return '';
    }
  }
}
