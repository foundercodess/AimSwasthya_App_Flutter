// patient_section/view/p_home/specialists_top_screen.dart
import 'package:aim_swasthya/patient_section/view/p_home/doctor_Tile.dart';
import 'package:flutter/material.dart';
import 'package:aim_swasthya/res/common_material.dart';
import '../../../model/user/patient_home_model.dart';
import '../../../utils/no_data_found.dart';

class SpecialistsTopScreen extends StatefulWidget {
  final double? ratio;
  final List<Doctors> doctors;
  const SpecialistsTopScreen({super.key, this.ratio, required this.doctors});

  @override
  State<SpecialistsTopScreen> createState() => _SpecialistsTopScreenState();
}

class _SpecialistsTopScreenState extends State<SpecialistsTopScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.doctors.isNotEmpty
        ? GridView.builder(
            padding: EdgeInsets.only(
                left: Sizes.screenWidth * 0.04,
                right: Sizes.screenWidth * 0.05),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 30.0,
              mainAxisSpacing: 30.0,
              childAspectRatio: widget.ratio ?? 0.89,
            ),
            itemCount: widget.doctors.length,
            itemBuilder: (context, index) {
              final doctor = widget.doctors[index];
              return DoctorTile(
                doctor: doctor,
              );
            },
          )
        : const NoMessage(
            message: "No specialists around here, for now...",
            title: "We’re working to bring expert care to your area",
          );
  }
  // Widget build(BuildContext context) {
  //   final doctorDetailCon = Provider.of<DoctorDetailsViewModel>(context).doctorDetailsModel;
  //   if (doctorDetailCon?.data?.doctors?.isEmpty ?? false) {
  //     return GridView.builder(
  //       padding: EdgeInsets.only(
  //         left: Sizes.screenWidth * 0.04,
  //         right: Sizes.screenWidth * 0.05,
  //       ),
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 30.0,
  //         mainAxisSpacing: 30.0,
  //         childAspectRatio: widget.ratio ?? 0.89,
  //       ),
  //       itemCount: doctorDetailCon!.data!.doctors!.length,
  //       itemBuilder: (context, index) {
  //         final doctor = doctorDetailCon.data!.doctors![index];
  //         return DoctorTile(
  //           doctor: doctor,
  //         );
  //       },
  //     );
  //   } else {
  //     return Center(child: TextConst("No doctor found"));
  //   }
  // }

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
            ),
          ],
        ),
      ),
    );
  }
}
