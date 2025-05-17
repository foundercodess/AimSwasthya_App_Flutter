// view/doctor/auth/register_screen.dart
import 'dart:io';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/view/common/intro/all_set_doc_screen.dart';
import 'package:aim_swasthya/view_model/doctor/all_specialization_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_auth_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_reg_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/upser_smc_number_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/utils.dart';
import '../../user/drawer/med_reports/image_picker.dart';

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

  void _selectGender(String gender) {
    setState(() {
      _genderController.text = gender;
    });
  }

  List<int> years =
      List.generate(DateTime.now().year - 1950 + 1, (index) => 1950 + index);
  int? selectedYear;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final registerCon =
          Provider.of<RegisterViewModel>(context, listen: false);
      registerCon.resetValues();
      Provider.of<AllSpecializationViewModel>(context, listen: false)
          .docAllSpecializationApi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final doctorCon = Provider.of<DoctorAuthViewModel>(context, listen: false);
    final registerCon = Provider.of<RegisterViewModel>(context);
    _numberController.text = doctorCon.senOtpData['phone'];
    final smcViewModel = Provider.of<UpsertSmcNumberViewModel>(context);

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
          onTap: () async {
            if (registerCon.isPersonalInfoSelected == true) {
              doctorCon.doctorRegisterApi(
                  _nameController.text,
                  _genderController.text,
                  _speController.text,
                  selectedYear,
                  context);
            } else {
              final verified =
                  smcViewModel.upsertSmcNumberModel?.verifiedFlag == "Y";
              if (_smcNumController.text.isEmpty || !verified) {
                Utils.show(
                    "Please verify your smc number to continue", context);
              } else if (doctorCon.profileImage == null) {
                Utils.show(
                    "Please upload your profile image to continue", context);
              } else if (doctorCon.identityImage == null) {
                Utils.show(
                    "Please upload your identity proof to continue", context);
              } else {
                Navigator.push(context,
                    cupertinoTopToBottomRoute(const AllSetDocScreen()));
              }
              // await smcViewModel.docUpsertSmcNumberApi(_smcNumController.text);
              // final verified =
              //     smcViewModel.upsertSmcNumberModel?.verifiedFlag == "Y";
              // if (verified) {
              //   Navigator.push(context,
              //       cupertinoTopToBottomRoute(const AllSetDocScreen()));
              // } else {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text("SMC Number verified.")),
              //   );
              // }
            }
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

  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  Widget personalInfoScreen() {
    final docSpecialization = Provider.of<AllSpecializationViewModel>(context);
    final specializations = docSpecialization.allSpecializationDocModel;
    return SingleChildScrollView(
      child: Column(
        children: [
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
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
            ],
          ),
          Sizes.spaceHeight25,
          Center(
            child: Container(
              height: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.textfieldGrayColor,
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
                      data.toString() ?? '',
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
          Center(
            child: Container(
              height: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.textfieldGrayColor,
                borderRadius: BorderRadius.circular(15),
              ),
              padding:
                  EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.03),
              child: (specializations?.specializations != null &&
                      specializations!.specializations!.isNotEmpty)
                  ? DropdownButton<String>(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                        size: 20,
                      ),
                      value: _speController.text.isNotEmpty
                          ? _speController.text
                          : null,
                      hint: TextConst(
                        "Specialization",
                        size: Sizes.fontSizeFour,
                        color: AppColor.textfieldTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                      underline: const SizedBox(),
                      isExpanded: true,
                      items: specializations.specializations!.map((data) {
                        return DropdownMenuItem<String>(
                          value: data.specializationId.toString(),
                          child: TextConst(
                            data.specializationName ?? '',
                            fontWeight: FontWeight.w500,
                            size: Sizes.fontSizeFive,
                            color: AppColor.blue,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newId) {
                        print("$newId");
                        setState(() {
                          _speController.text = newId!;
                        });
                      },
                    )
                  : const SizedBox(),
            ),
          ),
          Sizes.spaceHeight25,
          Center(
            child: Container(
              height: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.textfieldGrayColor,
                borderRadius: BorderRadius.circular(15),
              ),
              padding:
                  EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.03),
              child: DropdownButton<int>(
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                  size: 20,
                ),
                value: int.tryParse(_expController.text) ?? null,
                hint: TextConst(
                  "Practice start year",
                  size: Sizes.fontSizeFour,
                  color: AppColor.textfieldTextColor,
                  fontWeight: FontWeight.w400,
                ),
                underline: const SizedBox(),
                isExpanded: true,
                items: years.map((data) {
                  return DropdownMenuItem<int>(
                    value: data,
                    child: TextConst(
                      data.toString(),
                      fontWeight: FontWeight.w500,
                      size: Sizes.fontSizeFive,
                      color: AppColor.blue,
                    ),
                  );
                }).toList(),
                onChanged: (int? year) {
                  setState(() {
                    selectedYear = year;
                    _expController.text = year.toString();
                  });
                },
              ),
            ),
          ),
          Sizes.spaceHeight35,
        ],
      ),
    );
  }

  bool isSmcEntered = false;

  Widget identityScreen() {
    final smcViewModel = Provider.of<UpsertSmcNumberViewModel>(context);
    final isVerified = smcViewModel.upsertSmcNumberModel?.verifiedFlag == "Y";
    final doctorCon = Provider.of<DoctorAuthViewModel>(context, listen: false);

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
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    isSmcEntered = false;
                  });
                } else {
                  setState(() {
                    isSmcEntered = true;
                  });
                }
              },
              suffixIcon: GestureDetector(
                onTap: () async {
                  if (!isSmcEntered) {
                    Utils.show("Please enter smc number to verify", context);
                    return;
                  }
                  await smcViewModel
                      .docUpsertSmcNumberApi(_smcNumController.text);
                  final verified =
                      smcViewModel.upsertSmcNumberModel?.verifiedFlag == "Y";
                  if (verified) {
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("SMC Number verified.")),
                    );
                  }
                },
                child: smcViewModel.upsertSmcNumberModel?.verifiedFlag == "Y"
                    ? Icon(
                        Icons.check_circle,
                        size: Sizes.screenWidth * 0.1,
                        // color: Color(0xff4ECB71),
                        color:
                            isVerified ? const Color(0xff4ECB71) : Colors.grey,
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: isSmcEntered
                                ? AppColor.blue
                                : AppColor.textfieldGrayColor,
                            borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.all(10),
                        height: Sizes.screenHeight * 0.02,
                        width: Sizes.screenWidth * 0.22,
                        alignment: Alignment.center,
                        child: TextConst(
                          "verify".toUpperCase(),
                          size: Sizes.fontSizeFour,
                          fontWeight: FontWeight.w400,
                          color:
                              isSmcEntered ? AppColor.whiteColor : Colors.black,
                        ),
                      ),
              ),
              controller: _smcNumController,
              cursorColor: AppColor.textGrayColor,
            ),
            Sizes.spaceHeight30,
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextConst(
                      padding: EdgeInsets.only(left: Sizes.screenWidth * 0.02),
                      AppLocalizations.of(context)!.identity_proof,
                      size: Sizes.fontSizeFour,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                    if (doctorCon.identityImage != null) ...[
                      Sizes.spaceHeight3,
                      TextConst(
                        padding:
                            EdgeInsets.only(left: Sizes.screenWidth * 0.02),
                        doctorCon.identityImage!.name,
                        size: Sizes.fontSizeFour,
                        fontWeight: FontWeight.w500,
                        color: CupertinoColors.activeGreen,
                      ),
                    ]
                  ],
                ),
                const Spacer(),
                AppBtn(
                    fontSize: 12,
                    borderRadius: 12,
                    title: AppLocalizations.of(context)!.add,
                    height: Sizes.screenHeight * 0.044,
                    width: Sizes.screenWidth * 0.38,
                    color: AppColor.blue,
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
                          return showImageBottomSheet(false);
                        },
                      );
                    })
              ],
            ),
            Sizes.spaceHeight20,
          ],
        )),
        SizedBox(
          height: Sizes.screenHeight * 0.03,
        ),
        Consumer<DoctorAuthViewModel>(
          builder: (context, viewModel, child) {
            return DottedBorder(
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
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: Sizes.screenHeight * 0.003),
                    TextConst(
                      AppLocalizations.of(context)!.add_a_profile_photo_for,
                      size: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.lightBlack,
                    ),
                    SizedBox(height: Sizes.screenHeight * 0.05),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          elevation: 10,
                          isScrollControlled: true,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.0)),
                          ),
                          backgroundColor: AppColor.white,
                          builder: (BuildContext context) {
                            return showImageBottomSheet(true);
                          },
                        );
                      },
                      child: viewModel.profileImage != null
                          ? Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(15),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: FileImage(
                                        File(viewModel.profileImage!.path),
                                      ),
                                      fit: BoxFit.cover)),
                              // child: Image.file(
                              //   File(viewModel.profileImage!.path),
                              //   fit: BoxFit.cover,
                              //   width: double.infinity,
                              //   height: 200,
                              // ),
                            )
                          : Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.lightSkyBlue,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: AppColor.blue,
                                size: 45,
                              ),
                            ),
                    ),
                    SizedBox(height: Sizes.screenHeight * 0.06),
                  ],
                ),
              ),
            );
          },
        ),

        // DottedBorder(
        //   color: AppColor.lightBlue,
        //   strokeWidth: 4,
        //   borderType: BorderType.RRect,
        //   radius: const Radius.circular(15),
        //   dashPattern: const [5, 4],
        //   padding: EdgeInsets.zero,
        //   child: constContainer(
        //     child: Column(
        //       children: [
        //         TextConst(
        //           AppLocalizations.of(context)!.profile_photo,
        //           size: 16,
        //           // size: Sizes.fontSizeFivePFive,
        //           fontWeight: FontWeight.w400,
        //         ),
        //         SizedBox(height: Sizes.screenHeight * 0.003),
        //         TextConst(
        //           AppLocalizations.of(context)!.add_a_profile_photo_for,
        //           size: 12,
        //           // size: Sizes.fontSizeFour,
        //           fontWeight: FontWeight.w400,
        //           color: AppColor.lightBlack,
        //         ),
        //         SizedBox(height: Sizes.screenHeight * 0.05),
        //         GestureDetector(
        //           onTap: (){
        //             showModalBottomSheet(
        //               elevation: 10,
        //               isScrollControlled: true,
        //               context: context,
        //               shape: const RoundedRectangleBorder(
        //                 borderRadius:
        //                 BorderRadius.vertical(top: Radius.circular(16.0)),
        //               ),
        //               backgroundColor: AppColor.white,
        //               builder: (BuildContext context) {
        //                 return showImageBottomSheet();
        //               },
        //             );
        //           },
        //           child: Container(
        //             height: 50,
        //             width: 50,
        //             decoration: const BoxDecoration(
        //                 shape: BoxShape.circle, color: AppColor.lightSkyBlue),
        //             child: const Icon(
        //               Icons.add,
        //               color: AppColor.blue,
        //               size: 45,
        //             ),
        //           ),
        //         ),
        //         // Sizes.spaceHeight35,
        //         SizedBox(height: Sizes.screenHeight * 0.06),
        //       ],
        //     ),
        //   ),
        // ),
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
              Navigator.pop(context);
              final img = await _imagePickerHelper.pickImageFromCamera(context,
                  isProfileSelection: true);
              if (img != null) {
                if (isProfile) {
                  Provider.of<DoctorAuthViewModel>(context, listen: false)
                      .setProfileImage(img);
                  Provider.of<DoctorAuthViewModel>(context, listen: false)
                      .addImageApi('doctor', img.name.toString(),
                          img.path.toString(),'profile_photo' ,context);
                } else {
                  Provider.of<DoctorAuthViewModel>(context, listen: false)
                      .setIdentityImage(img);
                       Provider.of<DoctorAuthViewModel>(context, listen: false)
                      .addImageApi('doctor', img.name.toString(),
                          img.path.toString(),'identity_document' ,context);
                }

              }
            },
            // onTap: () async {
            //   Navigator.pop(context);
            //  final img= await _imagePickerHelper.pickImageFromCamera(context, isProfileSelection: true);
            //  print("xfile: ${img!.path}");
            //  Provider.of<DoctorAuthViewModel>(context).profileImage;
            // },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () async {
              final img = await _imagePickerHelper.pickImageFromGallery(context,
                  isProfileSelection: true);
               if (img != null) {
                if (isProfile) {
                  Provider.of<DoctorAuthViewModel>(context, listen: false)
                      .setProfileImage(img);
                  Provider.of<DoctorAuthViewModel>(context, listen: false)
                      .addImageApi('doctor', img.name.toString(),
                          img.path.toString(),'profile_photo' ,context);
                } else {
                  Provider.of<DoctorAuthViewModel>(context, listen: false)
                      .setIdentityImage(img);
                       Provider.of<DoctorAuthViewModel>(context, listen: false)
                      .addImageApi('doctor', img.name.toString(),
                          img.path.toString(),'identity_document' ,context);
                }
               }}
          ),
          // ListTile(
          //   leading: const Icon(Icons.photo_library)
          //   title: const Text('File'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     _imagePickerHelper.pickDocument(context);
          //   },
          // ),
        ],
      ),
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
