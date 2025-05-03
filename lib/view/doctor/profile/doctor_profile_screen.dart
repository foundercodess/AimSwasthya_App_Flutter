import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view/doctor/common_nav_bar.dart'
    show DocComBottomNevBar;
import 'package:aim_swasthya/view_model/doctor/doctor_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/test.dart';

class UserDocProfilePage extends StatefulWidget {
  const UserDocProfilePage({super.key});

  @override
  State<UserDocProfilePage> createState() => _UserDocProfilePageState();
}

class _UserDocProfilePageState extends State<UserDocProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _speController = TextEditingController();
  final TextEditingController _expController = TextEditingController();
  final TextEditingController _clinicNameCon = TextEditingController();
  final TextEditingController _addressCon = TextEditingController();
  final TextEditingController _contactNumCon = TextEditingController();
  final TextEditingController _landMarkCon = TextEditingController();
  int currentPage = 0;
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    final docProfileCon = Provider.of<DoctorProfileViewModel>(context);
    return docProfileCon.doctorProfileModel == null || docProfileCon.loading
        ? const Center(child: LoadData())
        : Scaffold(
            backgroundColor: AppColor.white,
            body: Padding(
              padding: EdgeInsets.only(
                left: Sizes.screenWidth * 0.05,
                right: Sizes.screenWidth * 0.05,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Sizes.spaceHeight20,
                    appBarConstant(
                      context,
                      paddingAllowed: false,
                      isBottomAllowed: true,
                      child: Center(
                        child: TextConst(
                          "Your Profile",
                          size: Sizes.fontSizeSix * 1.07,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Sizes.spaceHeight20,
                    TextConst(
                      "General information",
                      size: Sizes.fontSizeFivePFive,
                      fontWeight: FontWeight.w500,
                    ),
                    Sizes.spaceHeight20,
                    docProfileSec(),
                    Sizes.spaceHeight30,
                    CustomTextField(
                      contentPadding:
                          const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                      fillColor: AppColor.textfieldGrayColor.withOpacity(0.4),
                      hintText: docProfileCon.doctorProfileModel!.data!
                              .doctors![0].doctorName ??
                          "Name",
                      controller: _nameController,
                      cursorColor: AppColor.textGrayColor,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      contentPadding:
                          const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                      fillColor: AppColor.textfieldGrayColor.withOpacity(0.4),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          Assets.assetsIconsArrowDown,
                          color: AppColor.lightBlack,
                        ),
                      ),
                      hintText: docProfileCon
                              .doctorProfileModel!.data!.doctors![0].gender ??
                          "Gender",
                      controller: _genderController,
                      cursorColor: AppColor.textGrayColor,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      contentPadding:
                          const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                      fillColor: AppColor.textfieldGrayColor.withOpacity(0.4),
                      hintText: docProfileCon
                          .doctorProfileModel!.data!.doctors![0].phoneNumber
                          .toString(),
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.textGrayColor,
                      maxLength: 10,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      contentPadding:
                          const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                      fillColor: AppColor.textfieldGrayColor.withOpacity(0.4),
                      hintText: docProfileCon.doctorProfileModel!.data!
                              .doctors![0].specializationName ??
                          "Specialization",
                      controller: _speController,
                      cursorColor: AppColor.textGrayColor,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      contentPadding:
                          const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                      fillColor: AppColor.textfieldGrayColor.withOpacity(0.4),
                      hintText: docProfileCon.doctorProfileModel!.data!
                              .doctors![0].experience ??
                          "Experience",
                      controller: _expController,
                      cursorColor: AppColor.textGrayColor,
                    ),
                    Sizes.spaceHeight30,
                    TextConst(
                      "Clinic details",
                      size: Sizes.fontSizeFive * 1.1,
                      fontWeight: FontWeight.w500,
                    ),
                    Sizes.spaceHeight20,
                    clinicDetails(),
                    Sizes.spaceHeight35,
                    // Sizes.spaceHeight5,
                    CustomTextField(
                      contentPadding:
                          const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                      fillColor: AppColor.textfieldGrayColor.withOpacity(0.4),
                      hintText:
                          docProfileCon.doctorProfileModel?.data?.clinics !=
                                      null &&
                                  docProfileCon.doctorProfileModel!.data!
                                      .clinics!.isNotEmpty &&
                                  docProfileCon.doctorProfileModel!.data!
                                          .clinics![0].name !=
                                      null
                              ? docProfileCon
                                  .doctorProfileModel!.data!.clinics![0].name!
                              : "Clinic name",
                      controller: _clinicNameCon,
                      cursorColor: AppColor.textGrayColor,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      contentPadding:
                          const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                      fillColor: AppColor.textfieldGrayColor.withOpacity(0.4),
                      hintText:
                          docProfileCon.doctorProfileModel!.data!.clinics !=
                                      null &&
                                  docProfileCon.doctorProfileModel!.data!
                                      .clinics!.isNotEmpty &&
                                  docProfileCon.doctorProfileModel!.data!
                                          .clinics![0].address !=
                                      null
                              ? docProfileCon.doctorProfileModel!.data!
                                  .clinics![0].address!
                              : "Address",
                      controller: _addressCon,
                      cursorColor: AppColor.textGrayColor,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      contentPadding:
                          const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                      fillColor: AppColor.textfieldGrayColor.withOpacity(0.4),
                      hintText:
                          docProfileCon.doctorProfileModel!.data!.clinics !=
                                      null &&
                                  docProfileCon.doctorProfileModel!.data!
                                      .clinics!.isNotEmpty &&
                                  docProfileCon.doctorProfileModel!.data!
                                          .clinics![0].phoneNumber !=
                                      null
                              ? docProfileCon.doctorProfileModel!.data!
                                  .clinics![0].phoneNumber!
                              : "Contact no",
                      keyboardType: TextInputType.number,
                      controller: _contactNumCon,
                      cursorColor: AppColor.textGrayColor,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      contentPadding:
                          const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                      fillColor: AppColor.textfieldGrayColor.withOpacity(0.4),
                      hintText:
                          docProfileCon.doctorProfileModel!.data!.clinics !=
                                      null &&
                                  docProfileCon.doctorProfileModel!.data!
                                      .clinics!.isNotEmpty &&
                                  docProfileCon.doctorProfileModel!.data!
                                          .clinics![0].landmark !=
                                      null
                              ? docProfileCon.doctorProfileModel!.data!
                                  .clinics![0].landmark!
                              : "Landmark (optional)",
                      controller: _landMarkCon,
                      cursorColor: AppColor.textGrayColor,
                    ),
                    Sizes.spaceHeight20,
                    Center(
                      child: TextButton(
                          onPressed: () {
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
                                return const AddClinicOverlay();
                              },
                            );
                          },
                          child: TextConst(
                            "Add more clinics",
                            size: Sizes.fontSizeFour,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    Sizes.spaceHeight10,
                    Center(
                      child: ButtonConst(
                          title: "Save",
                          width: Sizes.screenWidth / 1.7,
                          height: Sizes.screenHeight * 0.055,
                          color: AppColor.blue,
                          onTap: () {}),
                    ),
                    Sizes.spaceHeight30,
                    Sizes.spaceHeight30,
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              height: 70,
              width: Sizes.screenWidth,
              color: Colors.transparent,
              child: const DocComBottomNevBar(),
            ),
          );
  }

  Widget docProfileSec() {
    final docProfileCon = Provider.of<DoctorProfileViewModel>(context);
    return Container(
      width: Sizes.screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.textfieldGrayColor.withOpacity(0.5)),
      child: Row(
        children: [
          Container(
            height: Sizes.screenHeight * 0.18,
            width: Sizes.screenWidth / 3.2,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                image: DecorationImage(
                    image: docProfileCon.doctorProfileModel!.data!.doctors![0]
                                .signedImageUrl !=
                            null
                        ? NetworkImage(docProfileCon.doctorProfileModel!.data!
                            .doctors![0].signedImageUrl!)
                        : const AssetImage(Assets.logoDoctor),
                    fit: BoxFit.fitHeight)),
          ),
          Sizes.spaceWidth15,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextConst(
                docProfileCon
                        .doctorProfileModel!.data!.doctors![0].experience ??
                    "5 years Experience",
                size: Sizes.fontSizeFour,
                fontWeight: FontWeight.w400,
              ),
              Sizes.spaceHeight5,
              TextConst(
                docProfileCon
                        .doctorProfileModel!.data!.doctors![0].doctorName ??
                    "",
                size: Sizes.fontSizeSix * 1.06,
                fontWeight: FontWeight.w500,
              ),
              Sizes.spaceHeight3,
              TextConst(
                "${docProfileCon.doctorProfileModel!.data!.doctors![0].qualification ?? "MBBS, MD"} (${docProfileCon.doctorProfileModel!.data!.doctors![0].specializationName ?? "Cardiology"})",
                size: Sizes.fontSizeFive * 1.08,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget clinicDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RoutesName.fullScreenMapPage);
          },
          child: Container(
            padding: EdgeInsets.only(
                left: Sizes.screenWidth * 0.03,
                right: Sizes.screenWidth * 0.03,
                top: Sizes.screenHeight * 0.017,
                bottom: Sizes.screenHeight * 0.02),
            // height: Sizes.screenHeight * 0.3,
            width: Sizes.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffececec),
            ),
            child: Column(
              children: [
                Sizes.spaceHeight3,
                const Image(image: AssetImage(Assets.imagesMapImg)),
                Sizes.spaceHeight25,
                ButtonConst(
                    title: "Set location",
                    width: Sizes.screenWidth * 0.3,
                    height: Sizes.screenHeight * 0.045,
                    color: AppColor.blue,
                    onTap: () {})
              ],
            ),
          ),
        )
      ],
    );
  }
}
