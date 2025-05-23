// view/doctor/profile/doctor_profile_screen.dart
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/utils/google_map/view_static_location.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/view/common/add_clinic_overlay.dart';
import 'package:aim_swasthya/view/common/select_location_screen.dart';
import 'package:aim_swasthya/view/doctor/common_nav_bar.dart';
import 'package:aim_swasthya/view/user/drawer/med_reports/image_picker.dart';
import 'package:aim_swasthya/view_model/doctor/add_clinic_doctor_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_auth_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doc_map_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doctor_profile_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/all_specialization_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDocProfilePage extends StatefulWidget {
  const UserDocProfilePage({super.key});

  @override
  State<UserDocProfilePage> createState() => _UserDocProfilePageState();
}

class _UserDocProfilePageState extends State<UserDocProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _speController = TextEditingController();
  final TextEditingController _expController = TextEditingController();
  int currentPage = 0;
  bool isClicked = false;
  bool isEditMode = false;
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AllSpecializationViewModel>(context, listen: false)
          .docAllSpecializationApi();
    });
  }

  void _toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  void _saveProfile() async {
    final docProfileCon =
        Provider.of<DoctorProfileViewModel>(context, listen: false);
    final success = await docProfileCon.updateDoctorProfileApi(
      context,
      name: _nameController.text,
      gender: _genderController.text,
      email: _emailController.text,
      phoneNumber: _numberController.text,
      // specializationId: docProfileCon
      //         .doctorProfileModel?.data?.doctors?[0].specializationId?.toString() ?? '',
      specializationId:_speController.text,
      practiceStartYear: _expController.text,
    );

    if (success) {
      setState(() {
        isEditMode = false;
        _nameController.clear();
        _genderController.clear();
        _emailController.clear();
        _numberController.clear();
        _speController.clear();
        _expController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final docProfileCon = Provider.of<DoctorProfileViewModel>(context);
    return docProfileCon.doctorProfileModel == null || docProfileCon.loading
        ? const Center(
            child: Scaffold(
            body: LoadData(),
          ))
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
                      hintText: docProfileCon.doctorProfileModel?.data
                              ?.doctors?[0].doctorName ??
                          "Name",
                      controller: _nameController,
                      cursorColor: AppColor.textGrayColor,
                      enabled: isEditMode,
                    ),
                    Sizes.spaceHeight10,
                    Center(
                      child: Container(
                        height: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.textfieldGrayColor.withOpacity(0.4),
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
                            docProfileCon.doctorProfileModel?.data?.doctors?[0]
                                    .gender ??
                                "Gender",
                            size: Sizes.fontSizeFive,
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
                          onChanged: isEditMode
                              ? (String? gender) {
                                  if (gender != null) {
                                    setState(() {
                                      _genderController.text = gender;
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
                      fillColor: AppColor.textfieldGrayColor.withOpacity(0.4),
                      hintText: docProfileCon.doctorProfileModel?.data
                              ?.doctors?[0].phoneNumber ??
                          "Phone Number",
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.textGrayColor,
                      maxLength: 10,
                      enabled: false,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      contentPadding:
                          const EdgeInsets.only(top: 18, bottom: 20, left: 10),
                      fillColor: AppColor.textfieldGrayColor.withOpacity(0.4),
                      hintText: docProfileCon
                              .doctorProfileModel?.data?.doctors?[0].email ??
                          "Email address",
                      controller: _emailController,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColor.textGrayColor,
                      maxLength: 10,
                      enabled: false,
                    ),
                    Sizes.spaceHeight10,
                    Center(
                      child: Container(
                        height: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.textfieldGrayColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.screenWidth * 0.03),
                        child: Consumer<AllSpecializationViewModel>(
                          builder: (context, docSpecialization, child) {
                            final specializations = docSpecialization
                                .allSpecializationDocModel?.specializations;
                            return (specializations != null &&
                                    specializations.isNotEmpty)
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
                                      docProfileCon
                                              .doctorProfileModel
                                              ?.data
                                              ?.doctors?[0]
                                              .specializationName ??
                                          "Specialization",
                                      size: Sizes.fontSizeFive,
                                      color: AppColor.textfieldTextColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    items: specializations.map((data) {
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
                                    onChanged: isEditMode
                                        ? (String? newId) {
                                            if (newId != null) {
                                              setState(() {
                                                _speController.text = newId;
                                              });
                                            }
                                          }
                                        : null,
                                  )
                                : const SizedBox();
                          },
                        ),
                      ),
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
                      enabled: isEditMode,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                    ),
                    Sizes.spaceHeight30,
                    TextConst(
                      "Clinic details",
                      size: Sizes.fontSizeFive * 1.1,
                      fontWeight: FontWeight.w500,
                    ),
                    // Sizes.spaceHeight10,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: docProfileCon
                              .doctorProfileModel?.data?.clinics?.length ??
                          0,
                      itemBuilder: (context, index) {
                        final clinic = docProfileCon
                            .doctorProfileModel!.data!.clinics![index];

                        Widget clinicInfoTile(dynamic label) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 10),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color:
                                  AppColor.textfieldGrayColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextConst(
                              label.toString(),
                              size: Sizes.fontSizeFourPFive,
                              fontWeight: FontWeight.normal,
                              color: AppColor.textGrayColor,
                            ),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextConst(
                                  "Clinic ${index + 1}",
                                  size: Sizes.fontSizeFourPFive,
                                  fontWeight: FontWeight.w500,
                                ),
                                if (isEditMode)
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: AppColor.blue),
                                    onPressed: () {
                                      final addClinicVM =
                                          Provider.of<AddClinicDoctorViewModel>(
                                              context,
                                              listen: false);
                                      addClinicVM.setEditMode(true,
                                          clinicIndex: index);
                                      addClinicVM.setEditClinicData(
                                        name: clinic.name,
                                        address: clinic.address,
                                        phone: clinic.phoneNumber,
                                        landmark: clinic.landmark,
                                        city: clinic.city,
                                        clinicId: clinic.clinicId.toString(),
                                        latitude: double.tryParse(
                                            clinic.latitude ?? '0'),
                                        longitude: double.tryParse(
                                            clinic.longitude ?? '0'),
                                      );
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
                                  ),
                              ],
                            ),
                            Sizes.spaceHeight10,
                            Container(
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
                              height: Sizes.screenHeight * 0.2,
                              // width: Sizes.screenWidth,
                              child: GetLocationOnMap(
                                latitude: double.parse(clinic.latitude!),
                                longitude: double.parse(clinic.longitude!),
                              ),
                            ),
                            Sizes.spaceHeight35,
                            clinicInfoTile(clinic.name ?? "Clinic name"),
                            clinicInfoTile(clinic.address ?? "Address"),
                            // clinicInfoTile(clinic. ?? "Address"),
                            clinicInfoTile(clinic.city ?? "City"),
                            clinicInfoTile(clinic.phoneNumber ?? "Contact no"),
                            clinicInfoTile(
                                clinic.landmark ?? "Landmark (optional)"),
                            clinicInfoTile(
                                clinic.consultationFee ?? "Consultation Fees"),
                            Sizes.spaceHeight35,
                          ],
                        );
                      },
                    ),
                    Sizes.spaceHeight10,
                    Center(
                      child: TextButton(
                          onPressed: () {
                            final addClinicVM =
                                Provider.of<AddClinicDoctorViewModel>(context,
                                    listen: false);
                            addClinicVM.setEditMode(false, clinicIndex: -1);
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
                      child: isEditMode
                          ? ButtonConst(
                              title: "Save Profile",
                              width: Sizes.screenWidth / 1.7,
                              height: Sizes.screenHeight * 0.055,
                              color: AppColor.blue,
                              onTap: _saveProfile)
                          : ButtonConst(
                              title: "Edit Profile",
                              width: Sizes.screenWidth / 1.7,
                              height: Sizes.screenHeight * 0.055,
                              color: AppColor.blue,
                              onTap: _toggleEditMode),
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
            // bottomNavigationBar: Container(
            //   height: 70,
            //   width: Sizes.screenWidth,
            //   color: Colors.transparent,
            //   child: const DocComBottomNevBar(),
            // ),
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
                          img.path.toString(), "profile_photo", context);
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
                          img.path.toString(), "profile_photo", context);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _selectLocation() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectLocationScreen(),
      ),
    );

    final viewModel =
        Provider.of<AddClinicDoctorViewModel>(context, listen: false);
    if (viewModel.selectedAddress != null) {
      // addressController.text = viewModel.selectedAddress!;
    }
  }

  Widget docProfileSec() {
    final docProfileCon = Provider.of<DoctorProfileViewModel>(context);
    return GestureDetector(
        onTap: () {
          print("sdfsa");
          showImageBottomSheet(true);
        },
        child: Container(
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
                        image: docProfileCon.doctorProfileModel!.data!
                                    .doctors![0].signedImageUrl !=
                                null
                            ? NetworkImage(docProfileCon.doctorProfileModel!
                                .data!.doctors![0].signedImageUrl!)
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
        ));
  }
}
