import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:provider/provider.dart';
import '../../../model/user/patient_home_model.dart';
import '../../../view_model/user/patient_home_view_model.dart';

class DoctorTile extends StatelessWidget {
  final Doctors doctor;
  final Color? color;
  const DoctorTile({
    super.key,
    required this.doctor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final patientHomeCon = Provider.of<PatientHomeViewModel>(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.doctorProfileScreen,
            arguments: {
              "isNew": true,
              "doctor_id": doctor.doctorId,
              "clinic_id": "${doctor.clinic_id}",
            });
      },
      child: Container(
        width: Sizes.screenWidth * 0.41,
        decoration: BoxDecoration(
            color: color ?? AppColor.grey,
            borderRadius: BorderRadius.circular(17)),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(17)),
                  child:
                  doctor.signedImageUrl != null
                          ? Image.network(
                        doctor.signedImageUrl!,
                              height: Sizes.screenHeight * 0.13,
                              width: double.infinity,
                              fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                            )
                          : Image(
                        image: const AssetImage(Assets.logoDoctor),
                        height: Sizes.screenHeight * 0.13,
                        width:double.infinity,
                        fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 2, top: 2, bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Sizes.spaceHeight3,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextConst(
                            overflow: TextOverflow.ellipsis,
                            doctor.experience.toString(),
                            size: Sizes.fontSizeThree,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xffAAAAAA),
                          ),
                          Row(
                            children: [
                              Text(
                                '${doctor.averageRating}',
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 1),
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 14),
                            ],
                          ),
                        ],
                      ),
                      Sizes.spaceHeight3,
                      TextConst(
                        overflow: TextOverflow.ellipsis,
                        doctor.doctorName ?? "",
                        size: Sizes.fontSizeFour * 1.1,
                        fontWeight: FontWeight.w500,
                      ),
                      Sizes.spaceHeight3,
                      TextConst(
                        overflow: TextOverflow.ellipsis,
                        '${doctor.qualification??""}(${doctor.specializationName ?? ''})',
                        size: Sizes.fontSizeThree,
                        // size: Sizes.fontSizeThree,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                top: 10,
                right: -12,
                child: Column(
                  children: [
                    if(doctor.topRated?.toLowerCase() == "Y".toLowerCase())
                    proContainer(AppColor.lightGreen, 'Top choice'),
                    SizedBox(height: Sizes.screenHeight * 0.002),
                    doctor.consultationFee != null
                        ? Container(
                            height: Sizes.screenHeight * 0.022,
                            width: Sizes.screenWidth * 0.16,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.blue),
                            child: Center(
                              child: TextConst(
                                '${doctor.consultationFee}',
                                size: Sizes.fontSizeThree,
                                fontWeight: FontWeight.w500,
                                color: AppColor.white,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                )),
            if(!patientHomeCon.userSearchingOutOfLocation && doctor.distanceInKm != null)
            Positioned(
              top: 8,
              left: 10,
              child: TextConst(
                doctor.distanceInKm??"",
                size: Sizes.fontSizeTwo * 1.1,
                fontWeight: FontWeight.w400,
                color: AppColor.black,
              ),
            ),

            // Positioned(
            //     bottom: -12,
            //     left: 46,
            //     child: Container(
            //       height: Sizes.screenHeight * 0.028,
            //       width: Sizes.screenWidth * 0.18,
            //       padding: const EdgeInsets.all(1),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(8),
            //         gradient:  LinearGradient(
            //           colors: [AppColor.lightBlue, AppColor.blue.withOpacity(0.5)],
            //           begin: Alignment.topCenter,
            //           end: Alignment.bottomCenter,
            //         ),
            //         boxShadow: [
            //           BoxShadow(
            //             color: AppColor.black.withOpacity(0.1),
            //             offset: const Offset(0, 5),
            //             blurRadius: 5,
            //             spreadRadius: 2,
            //           ),
            //         ]
            //       ),
            //       child: Container(
            //         // height: Sizes.screenHeight * 0.028,
            //         // width: Sizes.screenWidth * 0.18,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(8),
            //             color: AppColor.lightBlue),
            //         child: Center(
            //             child: TextConst(
            //           "Book",
            //           color: AppColor.white,
            //           size: Sizes.fontSizeFour,
            //           fontWeight: FontWeight.w500,
            //         )),
            //       ),
            //     )),
          ],
        ),
      ),
    );
  }

  Widget proContainer(
    Color color,
    dynamic label,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      height: 14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Image(
              image: AssetImage(Assets.iconsCheck),
              height: 10,
              width: 10,
              fit: BoxFit.cover,
            ),
            // Sizes.spaceWidth5,
            TextConst(
              label,
              size: Sizes.fontSizeOne,
              fontWeight: FontWeight.w400,
              color: AppColor.white,
            )
          ],
        ),
      ),
    );
  }
}
