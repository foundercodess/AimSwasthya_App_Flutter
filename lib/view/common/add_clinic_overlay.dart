// view/common/add_clinic_overlay.dart
import 'package:aim_swasthya/utils/google_map/view_static_location.dart';
import 'package:aim_swasthya/view_model/doctor/add_clinic_doctor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../generated/assets.dart';
import '../../res/color_const.dart';
import '../../res/size_const.dart';
import '../../res/text_const.dart';
import '../../res/user_button_const.dart';
import 'package:aim_swasthya/view/common/select_location_screen.dart';

class AddClinicOverlay extends StatefulWidget {
  const AddClinicOverlay({super.key});

  @override
  State<AddClinicOverlay> createState() => _AddClinicOverlayState();
}

class _AddClinicOverlayState extends State<AddClinicOverlay> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController feeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final addClinicVM =
          Provider.of<AddClinicDoctorViewModel>(context, listen: false);
      if (addClinicVM.isEditMode) {
        // Pre-fill the form fields when in edit mode
        nameController.text = addClinicVM.editClinicName ?? '';
        addressController.text = addClinicVM.editClinicAddress ?? '';
        // feeController.text = addClinicVM.editClinicFee ?? '';
        phoneController.text = addClinicVM.editClinicPhone ?? '';
        landmarkController.text = addClinicVM.editClinicLandmark ?? '';

        // Set the location if available
        if (addClinicVM.editClinicLatitude != null &&
            addClinicVM.editClinicLongitude != null) {
          addClinicVM.updateSelectedLocation(LatLng(
              addClinicVM.editClinicLatitude!,
              addClinicVM.editClinicLongitude!));
        }
      } else {
        addClinicVM.clearSelectedLocation();
      }
    });
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

  @override
  Widget build(BuildContext context) {
    final addClinicData = Provider.of<AddClinicDoctorViewModel>(context);

    if (addClinicData.isClicked == true) {
      return confirmClinic();
    }
    return addMoreClinic();
  }

  Widget addMoreClinic() {
    final addClinicData = Provider.of<AddClinicDoctorViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Sizes.screenWidth * 0.05,
                  right: Sizes.screenWidth * 0.05,
                  top: Sizes.screenHeight * 0.03),
              width: Sizes.screenWidth,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.lightBlue,
                      image: DecorationImage(
                          image: AssetImage(Assets.imagesHospital), scale: 4),
                    ),
                    // child: Image.asset(
                    //   Assets.imagesHospital,
                    //   height: 50,
                    // ),
                  ),
                  Sizes.spaceHeight5,
                  TextConst(
                    addClinicData.isEditMode
                        ? "Edit Clinic"
                        : "Add more clinics",
                    size: Sizes.fontSizeNine,
                    fontWeight: FontWeight.w600,
                  ),
                  Sizes.spaceHeight5,
                  TextConst(
                    "Let patients find you, add your clinic details below",
                    size: Sizes.fontSizeFourPFive,
                    fontWeight: FontWeight.w400,
                  ),
                  Sizes.spaceHeight25,
                  GestureDetector(
                    onTap: _selectLocation,
                    child: Container(
                      height: Sizes.screenHeight * 0.165,
                      width: Sizes.screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage(Assets.imagesSetLocationPage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: addClinicData.selectedLatitude != null &&
                              addClinicData.selectedLongitude != null
                          ? GetLocationOnMap(
                              latitude: addClinicData.selectedLatitude!,
                              longitude: addClinicData.selectedLongitude!,
                            )
                          : null,
                    ),
                  ),
                  Sizes.spaceHeight20,
                  SizedBox(
                    height: Sizes.screenHeight * 0.19,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: "Clinic name",
                              hintStyle: TextStyle(
                                  color: const Color(0xffC3C3C3),
                                  fontWeight: FontWeight.w400,
                                  fontSize: Sizes.fontSizeFourPFive),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              fillColor: const Color(0xffF5F5F5),
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                            style: const TextStyle(
                              color: AppColor.blue,
                            ),
                            cursorColor: AppColor.textGrayColor,
                          ),
                          Sizes.spaceHeight10,
                           TextField(
                            controller: cityController,
                            decoration: InputDecoration(
                              hintText: "City",
                              hintStyle: TextStyle(
                                  color: const Color(0xffC3C3C3),
                                  fontWeight: FontWeight.w400,
                                  // fontSize: 12,
                                  fontSize: Sizes.fontSizeFourPFive),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              fillColor: const Color(0xffF5F5F5),
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                            style: const TextStyle(
                              color: AppColor.blue,
                            ),
                            cursorColor: AppColor.textGrayColor,
                          ),
                          Sizes.spaceHeight10,
                          TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                              hintText: "Address",
                              hintStyle: TextStyle(
                                  color: const Color(0xffC3C3C3),
                                  fontWeight: FontWeight.w400,
                                  // fontSize: 12,
                                  fontSize: Sizes.fontSizeFourPFive),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              fillColor: const Color(0xffF5F5F5),
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                            style: const TextStyle(
                              color: AppColor.blue,
                            ),
                            cursorColor: AppColor.textGrayColor,
                          ),
                          Sizes.spaceHeight10,

                          TextField(
                            controller: feeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Fee",
                              counterText: "",
                              hintStyle: TextStyle(
                                  color: const Color(0xffC3C3C3),
                                  fontWeight: FontWeight.w400,
                                  // fontSize: 12,
                                  fontSize: Sizes.fontSizeFourPFive),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              fillColor: const Color(0xffF5F5F5),
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                            maxLength: 10,
                            style: const TextStyle(
                              color: AppColor.blue,
                            ),
                            cursorColor: AppColor.textGrayColor,
                          ),
                          Sizes.spaceHeight10,
                          TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Contact no",
                              counterText: "",
                              hintStyle: TextStyle(
                                  color: const Color(0xffC3C3C3),
                                  fontWeight: FontWeight.w400,
                                  // fontSize: 12,
                                  fontSize: Sizes.fontSizeFourPFive),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              fillColor: const Color(0xffF5F5F5),
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                            maxLength: 10,
                            style: const TextStyle(
                              color: AppColor.blue,
                            ),
                            cursorColor: AppColor.textGrayColor,
                          ),
                          Sizes.spaceHeight10,
                          TextField(
                            controller: landmarkController,
                            decoration: InputDecoration(
                              hintText: "Landmark (optional)",
                              hintStyle: TextStyle(
                                  color: const Color(0xffC3C3C3),
                                  fontWeight: FontWeight.w400,
                                  // fontSize: 12,
                                  fontSize: Sizes.fontSizeFourPFive),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Color(0xffE5E5E5), width: 1.0),
                              ),
                              fillColor: const Color(0xffF5F5F5),
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                            style: const TextStyle(
                              color: AppColor.blue,
                            ),
                            cursorColor: AppColor.textGrayColor,
                          ),
                          Sizes.spaceHeight10,
                          ButtonConst(
                            height: Sizes.screenHeight * 0.06,
                            title: addClinicData.isEditMode ? "Update" : "Save",
                            width: Sizes.screenWidth,
                            onTap: () {
                              addClinicData.addClinicDoctorApi(
                                addClinicData.editClinicId??"",
                                  nameController.text,
                                  addressController.text,
                                  feeController.text,
                                  cityController.text,
                                  phoneController.text,
                                  landmarkController.text,
                                  context);
                            },
                            color: AppColor.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Sizes.spaceHeight30,
                  Sizes.spaceHeight10,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget confirmClinic() {
    final addClinicData = Provider.of<AddClinicDoctorViewModel>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(
              top: Sizes.screenHeight * 0.03,
              bottom: Sizes.screenHeight * 0.02,
              left: Sizes.screenWidth * 0.06,
              right: Sizes.screenWidth * 0.06),
          // height: Sizes.screenHeight * 0.54,
          width: Sizes.screenWidth * 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.lightBlue),
                child: Center(
                    child: Icon(
                  Icons.check,
                  color: AppColor.blue,
                  size: Sizes.screenHeight * 0.05,
                )),
              ),
              TextConst(
                "Done",
                size: Sizes.fontSizeNine,
                fontWeight: FontWeight.w600,
              ),
              TextConst(
                "Your clinic has been added successfully",
                size: Sizes.fontSizeFourPFive,
                fontWeight: FontWeight.w400,
              ),
              Sizes.spaceHeight20,
              SizedBox(
                width: Sizes.screenWidth,
                child: const Image(image: AssetImage(Assets.imagesMapImg)),
              ),
              Sizes.spaceHeight25,
              ButtonConst(
                title: "Confirm",
                width: Sizes.screenWidth,
                onTap: () {
                  Navigator.pop(context);
                  addClinicData.setClinicData(false);
                },
                color: AppColor.blue,
              ),
              Sizes.spaceHeight15,
            ],
          ),
        ),
      ],
    );
  }
}
