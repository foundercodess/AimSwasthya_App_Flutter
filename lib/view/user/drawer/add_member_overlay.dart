// view/user/drawer/add_member_overlay.dart
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:aim_swasthya/view_model/user/upsert_family_member_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../res/common_material.dart';

class AddMemberOverlay extends StatefulWidget {
  const AddMemberOverlay({super.key});

  @override
  State<AddMemberOverlay> createState() => _AddMemberOverlayState();
}

class _AddMemberOverlayState extends State<AddMemberOverlay> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }



  Future<void> _saveFamilyMember(BuildContext context) async {
    final memberCon = Provider.of<PatientHomeViewModel>(context, listen: false);
    final vm = Provider.of<PatientHomeViewModel>(context, listen: false);
    final upsertVM =
        Provider.of<UpsertFamilyMemberViewModel>(context, listen: false);

    if (vm.nameController.text.isEmpty ||
        _dobController.text.isEmpty ||
        vm.genderController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }


    String? familyMemberId;
    final members = memberCon.patientHomeModel?.data?.familyMembers;

    if (memberCon.selectedMemberIndex != -1 &&
        members != null &&
        members.length > memberCon.selectedMemberIndex!) {
      familyMemberId =
          members[memberCon.selectedMemberIndex!].familyMemberId?.toString();
    }
    await upsertVM.upsertFamilyMemberApi(
      context,
      familyMemberId,
      vm.nameController.text,
      vm.genderController.text,
      '', // email (optional)
      '', // phone (optional)
      _dobController.text,
      vm.heightController.text,
      vm.weightController.text,
      'Family Member', 
    );

    if (upsertVM.upsertFamilyMemberModel?.status == true) {
      // Clear form and refresh data
      vm.nameController.clear();
      _dobController.clear();
      vm.genderController.clear();
      vm.heightController.clear();
      vm.weightController.clear();
      memberCon.setSelectedMemberIndex(-1);

      await memberCon.patientHomeApi(context);

      // Close bottom sheet
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    final memberCon = Provider.of<PatientHomeViewModel>(context);
    final vm = Provider.of<PatientHomeViewModel>(context);
    final upsertVM = Provider.of<UpsertFamilyMemberViewModel>(context);


    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: Sizes.screenHeight * 0.03,
          left: Sizes.screenWidth * 0.05,
          right: Sizes.screenWidth * 0.05),
      width: Sizes.screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.allImagesAddProfile,
            height: Sizes.screenWidth * 0.28,
          ),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  memberCon.patientHomeModel?.data?.familyMembers?.length ?? 0,
                  (index) => Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          memberCon.setSelectedMemberIndex(index);
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: memberCon.selectedMemberIndex == index
                                ? Colors.grey[300]
                                : AppColor.blue,
                          ),
                          child: Center(
                            child: TextConst(
                              '${index + 1}',
                              size: Sizes.fontSizeFour,
                              fontWeight: FontWeight.w400,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                // Show add button only if less than 4 members
                if ((memberCon.patientHomeModel?.data?.familyMembers?.length ??
                        0) <
                    4)
                  DottedBorder(
                    borderType: BorderType.Circle,
                    color: AppColor.blue,
                    strokeWidth: 1.5,
                    dashPattern: const [4, 3],
                    padding: const EdgeInsets.all(4),
                    child: IconButton(
                      onPressed: () {
                        vm.nameController.clear();
                        vm.ageController.clear();
                        vm.genderController.clear();
                        vm.heightController.clear();
                        vm.weightController.clear();
                        memberCon.setSelectedMemberIndex(-1);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.blue,
                        size: 35,
                      ),
                    ),
                  ),
              ],
            ),
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
                      controller: vm.nameController,
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]')),
                      ],
                      cursorColor: AppColor.textGrayColor,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      height: Sizes.screenHeight * 0.06,
                      borderSide: const BorderSide(color: Color(0xffE5E5E5)),
                      fillColor: AppColor.grey,
                      hintText: "Date of Birth",
                      hintColor: const Color(0xffC3C3C3),
                      controller: _dobController,
                      enabled: true,
                      cursorColor: AppColor.textGrayColor,
                      suffixIcon: IconButton(
                        onPressed: () async {
                          print("ffdfdfd");
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              _dobController.text =
                                  DateFormat('yyyy-MM-dd').format(picked);
                              vm.ageController.text =
                                  vm.calculateAgeFromDob(_dobController.text);
                            });
                          }
                        },
                        icon: Image.asset(
                          Assets.allImagesSolarCalendar,
                          scale: 2,
                        ),
                      ),
                    ),
                    Sizes.spaceHeight10,
                    Center(
                      child: Container(
                        height: 49,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.grey,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Color(0xffE5E5E5)),
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.03),
                        child: DropdownButton<String>(
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                            size: 20,
                          ),
                          value: genderOptions.contains(vm.genderController.text)
                              ? vm.genderController.text
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
                                data.toString(),
                                fontWeight: FontWeight.w500,
                                size: Sizes.fontSizeFive,
                                color: AppColor.blue,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newId) {
                            setState(() {
                              if (newId != null){
                                vm.genderController.text = newId;

                              }
                            });
                          },
                        ),
                      ),
                    ),

                    // CustomTextField(
                    //   height: Sizes.screenHeight * 0.06,
                    //   borderSide: const BorderSide(color: Color(0xffE5E5E5)),
                    //   fillColor: AppColor.grey,
                    //   hintText: "Gender",
                    //   hintColor: const Color(0xffC3C3C3),
                    //   controller: vm.genderController,
                    //   keyboardType: TextInputType.name,
                    //   cursorColor: AppColor.textGrayColor,
                    // ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      height: Sizes.screenHeight * 0.06,
                      borderSide: const BorderSide(color: Color(0xffE5E5E5)),
                      fillColor: AppColor.grey,
                      hintText: "Height",
                      hintColor: const Color(0xffC3C3C3),
                      controller: vm.heightController,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.textGrayColor,
                    ),
                    Sizes.spaceHeight10,
                    CustomTextField(
                      height: Sizes.screenHeight * 0.06,
                      borderSide: const BorderSide(color: Color(0xffE5E5E5)),
                      fillColor: AppColor.grey,
                      hintText: "Weight",
                      hintColor: const Color(0xffC3C3C3),
                      controller: vm.weightController,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.textGrayColor,
                    ),
                    Sizes.spaceHeight30,
                    ButtonConst(
                      title: upsertVM.loading ? "Saving..." : "Save",
                      onTap: upsertVM.loading
                          ? () {}
                          : () => _saveFamilyMember(context),
                      color: AppColor.blue,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
