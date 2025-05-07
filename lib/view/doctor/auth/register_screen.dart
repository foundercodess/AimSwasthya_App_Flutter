import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/view/common/intro/all_set_doc_screen.dart';
import 'package:aim_swasthya/view_model/doctor/all_specialization_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_auth_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_reg_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/upser_smc_number_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  void _selectGender(String gender) {
    setState(() {
      _genderController.text = gender;
    });
  }
  List<int> years = List.generate(DateTime.now().year - 1950 + 1, (index) => 1950 + index);
  int? selectedYear;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final registerCon =
          Provider.of<RegisterViewModel>(context, listen: false);
      registerCon.resetValues();
      Provider.of<AllSpecializationViewModel>(context, listen: false)
          .docAllSpecializationApi();
      // selectedYear = _expController.text aint?s ;
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
              await smcViewModel.docUpsertSmcNumberApi(_smcNumController.text);

              final verified =
                  smcViewModel.upsertSmcNumberModel?.verifiedFlag == "Y";
              if (verified) {
                Navigator.push(context,
                    cupertinoTopToBottomRoute(const AllSetDocScreen()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("SMC Number  verified.")),
                );
              }
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
            keyboardType: TextInputType.name,

          ),
          Sizes.spaceHeight25,
          CustomTextField(
            contentPadding:
                const EdgeInsets.only(top: 18, bottom: 20, left: 10),
            fillColor: AppColor.textfieldGrayColor,
            hintText: "Gender",
            suffixIcon: PopupMenuButton<String>(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
                size: 20,
              ),
              onSelected: _selectGender,
              itemBuilder: (BuildContext context) {
                return genderOptions.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
            controller: _genderController,
            cursorColor: AppColor.textGrayColor,
            // enabled: false,
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
            // readOnly: true,
            suffixIcon: PopupMenuButton<String>(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
                size: 20,
              ),
              onSelected: (String value) {
                setState(() {
                  _speController.text = value;
                });
              },
              itemBuilder: (BuildContext context) {
                if (specializations!.specializations!.isEmpty) {
                  return [const PopupMenuItem(child: Text('Loading...'))];
                }
                return specializations.specializations!.map((spec) {
                  return PopupMenuItem<String>(
                    value: spec.specializationName,
                    child: Text(spec.specializationName.toString()),
                  );
                }).toList();
              },
            ),
          ),

          // CustomTextField(
          //   contentPadding:
          //       const EdgeInsets.only(top: 18, bottom: 20, left: 10),
          //   fillColor: AppColor.textfieldGrayColor,
          //   hintText: "Specialisation",
          //   suffixIcon: PopupMenuButton<String>(
          //     icon: const Icon(
          //       Icons.keyboard_arrow_down,
          //       color: Colors.grey,
          //       size: 20,
          //     ),
          //     onSelected: _selectSpecialization,
          //     itemBuilder: (BuildContext context) {
          //       return docSpecialization.allSpecializationDocModel == null
          //           ? [const PopupMenuItem(child: Text('Loading...'))]
          //           : docSpecialization.allSpecializationDocModel!.specializations!.map((spec) {
          //         return PopupMenuItem<String>(
          //           value: spec.specializationName,
          //           child: Text(spec.specializationName.toString()),
          //         );
          //       }).toList();
          //
          //       // PopupMenuButton(
          //   //   icon: const Icon(
          //   //     Icons.keyboard_arrow_down,
          //   //     color: Colors.grey,
          //   //     size: 20,
          //   //   ),
          //   //   onSelected: _selectGender,
          //   //   itemBuilder: (BuildContext context) {
          //   //     return docSpecialization.allSpecializationDocModel.map((String choice) {
          //   //       return PopupMenuItem(
          //   //         value: choice,
          //   //         child: Text(choice),
          //   //       );
          //   //     }).toList();
          //     },
          //   ),
          //   controller: _speController,
          //   cursorColor: AppColor.textGrayColor,
          // ),
          Sizes.spaceHeight25,
          CustomTextField(
            contentPadding:
                const EdgeInsets.only(top: 18, bottom: 20, left: 10),
            fillColor: AppColor.textfieldGrayColor,
            hintText: "Practice start year",
            suffixIcon: PopupMenuButton<int>(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
                size: 20,
              ),
              onSelected: (int year) {
                setState(() {
                  selectedYear = year;
                  _expController.text = year.toString();
                });
              },
              itemBuilder: (context) {
                return years.map((year) {
                  return PopupMenuItem<int>(
                    value: year,
                    child: Text(year.toString()),
                  );
                }).toList();
              },
            ),
            // DropdownButton<int>(
            //   value: selectedYear,
            //   underline: const SizedBox(),
            //   items: years
            //       .map((year) => DropdownMenuItem(
            //       value: year,
            //       child: SizedBox(width: 40, child: Text('$year'))))
            //       .toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       selectedYear = value!;
            //     });
            //   },
            // ),
            // suffixIcon: IconButton(
            //   icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 20),
            //   onPressed: _showYearDropdown,
            // ),
            controller: _expController,
            cursorColor: AppColor.textGrayColor,
          ),
          Sizes.spaceHeight35,
        ],
      ),
    );
  }

  Widget identityScreen() {
    final smcViewModel = Provider.of<UpsertSmcNumberViewModel>(context);
    final isVerified = smcViewModel.upsertSmcNumberModel?.verifiedFlag == "Y";

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
              // onChanged: (value) {
              //   if (value.length >= 6) {
              //     smcViewModel.docUpsertSmcNumberApi(value);
              //   }
              // },
              suffixIcon: Icon(
                Icons.check_circle,
                size: Sizes.screenWidth * 0.1,
                // color: Color(0xff4ECB71),
                color: isVerified ? const Color(0xff4ECB71) : Colors.grey,
              ),
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
