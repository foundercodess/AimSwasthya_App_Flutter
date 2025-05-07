import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/view_model/doctor/doc_reg_view_model.dart';
import 'package:aim_swasthya/view_model/doctor/doctor_profile_view_model.dart';
import 'package:aim_swasthya/view_model/user/bottom_nav_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/user/slot_schedule_view_model.dart';

class ClinicLocationScreen extends StatefulWidget {
  const ClinicLocationScreen({super.key});

  @override
  State<ClinicLocationScreen> createState() => _ClinicLocationScreenState();
}

class _ClinicLocationScreenState extends State<ClinicLocationScreen> {
  String? selectedClinicId;

  @override
  Widget build(BuildContext context) {
    final profileCon = Provider.of<DoctorProfileViewModel>(context);
    final clinics = profileCon.doctorProfileModel!.data!.clinics!;
    final slotScheduleCon = Provider.of<SlotScheduleViewModel>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Sizes.spaceHeight35,
          Center(
            child: TextConst(
              "Choose a location",
              size: Sizes.fontSizeSix * 1.07,
              fontWeight: FontWeight.w500,
            ),
          ),
          Center(
            child: TextConst(
              "Select a clinic/hospital to create a schedule",
              size: Sizes.fontSizeFour,
              fontWeight: FontWeight.w400,
              color: AppColor.textfieldTextColor.withOpacity(0.7),
            ),
          ),
          Sizes.spaceHeight20,
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(vertical: 25),
                width: Sizes.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade100,
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: clinics.map((clinic) {
                    return GestureDetector(
                      onTap: () {
                        slotScheduleCon
                            .setSelectedClinicId(clinic.clinicId.toString());
                      },
                      child: Container(
                        width: Sizes.screenWidth * 0.4,
                        padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                        decoration: BoxDecoration(
                          border: slotScheduleCon.selectedClinicId ==
                                  clinic.clinicId.toString()
                              ? Border.all(color: AppColor.blue)
                              : null,
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextConst(
                              clinic.name ?? "",
                              size: Sizes.fontSizeFour,
                              color: Colors.grey,
                              textAlign: TextAlign.center,
                            ),
                            Sizes.spaceHeight3,
                            Image.asset(
                              Assets.logoClinicImage,
                              height: Sizes.screenHeight * 0.1,
                            ),
                            Sizes.spaceHeight3,
                            TextConst(
                              "${clinic.address}, ${clinic.city}",
                              size: Sizes.fontSizeFour * 1.1,
                              color: Colors.grey,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Sizes.spaceHeight10,
        ],
      ),
    );
  }
}
