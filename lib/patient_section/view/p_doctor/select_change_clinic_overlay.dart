import 'dart:ui';

import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../p_view_model/doctor_avl_appointment_view_model.dart';

class ChangeClinicOverlay extends StatelessWidget {
  const ChangeClinicOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorAvlAppointmentViewModel>(builder: (context, dAVM, _) {
      if(dAVM.doctorAvlAppointmentModel == null || dAVM.doctorAvlAppointmentModel!.data == null){
        return SizedBox();
      }
      final otherClinicData =
          dAVM.doctorAvlAppointmentModel!.data!.otherClinic!.data;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: Sizes.screenWidth,
        constraints: BoxConstraints(maxHeight: Sizes.screenHeight / 1.5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Sizes.screenWidth / 3.5,
                width: Sizes.screenWidth / 3.5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.lightBlue,
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  Assets.iconsHugeiconsClinic,
                  width: Sizes.screenWidth / 8,
                ),
              ),
              Sizes.spaceHeight15,
              TextConst(
                "Other locations",
                size: Sizes.fontSizeEight,
                fontWeight: FontWeight.w600,
              ),
              Sizes.spaceHeight10,
              TextConst(
                textAlign: TextAlign.center,
                "We recommend the selected clinic according to your current location but you can still choose another location for this doctor",
                size: Sizes.fontSizeFour,
              ),
              Sizes.spaceHeight10,
              const Divider(
                color: AppColor.textfieldGrayColor,
              ),
              Sizes.spaceHeight10,
              Wrap(
                children: [
                  ...List.generate(otherClinicData!.length, (int i) {
                    final clinic = otherClinicData[i];
                    return GestureDetector(
                      onTap: () {
                        dAVM.setSelectedClinic(
                            clinic.clinicId.toString());
                      },
                      child: SizedBox(
                        width: Sizes.screenWidth / 3,
                        child: Column(
                          children: [
                            TextConst(
                              "Clinic ${i + 1}",
                              color: AppColor.textGrayColor,
                              size: Sizes.fontSizeFive,
                            ),
                            Sizes.spaceHeight5,
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: Sizes.screenWidth / 5,
                                  height: Sizes.screenWidth / 5,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColor.textfieldGrayColor
                                          .withOpacity(0.5)),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    Assets.iconsUimClinicMedical,
                                    width: Sizes.screenWidth / 10,
                                  ),
                                ),
                                Positioned(
                                  top: -5,
                                  right: -5,
                                  child: ClipOval(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 1.5,
                                        sigmaY: 1.5,
                                      ),
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                AppColor.white.withOpacity(0.4),
                                            border: Border.all(
                                                color:
                                                    AppColor.textfieldGrayColor,
                                                width: 1.5)),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(2),
                                        child: dAVM.selectedClinicId ==
                                                clinic.clinicId.toString()
                                            ? Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColor.blue,
                                                ),
                                              )
                                            : null,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Sizes.spaceHeight10,
                            TextConst(
                              overflow: TextOverflow.ellipsis,
                              "${clinic.address}",
                              color: AppColor.textGrayColor,
                              size: Sizes.fontSizeFour,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
              Sizes.spaceHeight25,
              AppBtn(
                title: "Choose",
                onTap: () {
                  if(dAVM.selectedClinicId==''){
                    Navigator.pop(context);
                    return;
                  }
                  Navigator.pop(context);
                  final docId = dAVM
                      .doctorAvlAppointmentModel!.data!.details![0].doctorId
                      .toString();
                  final docDCon = Provider.of<DoctorAvlAppointmentViewModel>(
                      context,
                      listen: false);
                  docDCon.doctorAvlAppointmentApi(
                      docId, dAVM.selectedClinicId, context, clearCon: false);
                },
                padding: const EdgeInsets.all(0),
                borderRadius: 12,
                height: 44,
              ),
              Sizes.spaceHeight20,
            ],
          ),
        ),
      );
    });
  }
}
