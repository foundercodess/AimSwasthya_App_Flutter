// doctor_section/view/schedule/clinic_location_screen.dart
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/doctor_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../patient_section/p_view_model/slot_schedule_view_model.dart';

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
              if (clinics.isEmpty)
                const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: const Center(
                      child: NoDataMessages(
                        message: "No Clinics Found",
                        title: "You haven’t added any clinics yet.",
                      ),
                    ))
              else
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  width: Sizes.screenWidth,
                  alignment: Alignment.center,
                  constraints:
                      BoxConstraints(minHeight: Sizes.screenHeight / 2),
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
                          debugPrint(
                              "clinic.clinicId.toString() ${clinic.clinicId}");
                          slotScheduleCon
                              .setSelectedClinicId(clinic.clinicId.toString());
                        },
                        child: Container(
                          width: Sizes.screenWidth * 0.4,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
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
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
