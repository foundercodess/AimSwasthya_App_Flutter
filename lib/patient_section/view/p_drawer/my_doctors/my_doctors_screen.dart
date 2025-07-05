// patient_section/view/p_drawer/my_doctors/my_doctors_screen.dart
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/patient_section/view/p_home/doctor_Tile.dart';
import 'package:aim_swasthya/patient_section/view/p_bottom_nav/secound_nav_bar.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_pref_doc_view_model.dart';
import 'package:flutter/material.dart';
import 'package:aim_swasthya/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MyDoctorsScreen extends StatefulWidget {
  const MyDoctorsScreen({super.key});

  @override
  State<MyDoctorsScreen> createState() => _MyDoctorsScreenState();
}

class _MyDoctorsScreenState extends State<MyDoctorsScreen> {
  int currentPage = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PatientPrefDocViewModel>(context, listen: false)
          .patientPrefDocApi(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final patientPreCon = Provider.of<PatientPrefDocViewModel>(context);
    return Scaffold(
      primary: false,
      extendBody: true,
      body: patientPreCon.patienPreferredDocModel == null
          ? const Center(child: LoadData())
          : (patientPreCon.patienPreferredDocModel!.data!.doctors?.isNotEmpty ??
                  false)
              ? RefreshIndicator(
                  onRefresh: () async {
                    Provider.of<PatientPrefDocViewModel>(context, listen: false)
                        .patientPrefDocApi(context);
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        AppbarConst(
                          title: AppLocalizations.of(context)!.my_doctors,
                        ),
                        Sizes.spaceHeight10,
                        Image.asset(
                          Assets.logoMedicalDoctor,
                          height: Sizes.screenHeight * 0.07,
                        ),
                        Sizes.spaceHeight15,
                        TextConst(
                          AppLocalizations.of(context)!
                              .your_health_is_our_priority,
                          size: Sizes.fontSizeFour,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                        ),
                        Sizes.spaceHeight20,
                        myDoctorsScreen(),
                        Sizes.spaceHeight30,
                        const SizedBox(
                          height: kBottomNavigationBarHeight,
                        )
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: ImageContainer(
                  imagePath: 'assets/images/noDoctorFound.png',
                )),
      bottomNavigationBar: Container(
        height: 70,
        width: Sizes.screenWidth,
        color: Colors.transparent,
        child: const CommenBottomNevBar(),
      ),
    );
  }

  Widget myDoctorsScreen() {
    final patientPreCon =
        Provider.of<PatientPrefDocViewModel>(context, listen: false);
    return Container(
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.only(
            top: Sizes.screenHeight * 0.015,
            bottom: Sizes.screenHeight * 0.015),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.2),
              offset: const Offset(0, 0),
              blurRadius: 0,
              spreadRadius: -2,
            ),
            BoxShadow(
              color: AppColor.grey.withOpacity(0.9),
              offset: const Offset(0, 0),
              blurRadius: 0,
              spreadRadius: -2,
            ),
            BoxShadow(
              color: AppColor.black.withOpacity(0.05),
              offset: const Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
          // color: AppColor.docProfileColor,
        ),
        child: GridView.builder(
          padding: EdgeInsets.only(
              left: Sizes.screenWidth * 0.04, right: Sizes.screenWidth * 0.05),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 30.0,
            mainAxisSpacing: 30.0,
            childAspectRatio: 0.855,
          ),
          itemCount:
              patientPreCon.patienPreferredDocModel!.data!.doctors!.length,
          itemBuilder: (context, index) {
            final doctor =
                patientPreCon.patienPreferredDocModel!.data!.doctors![index];
            return DoctorTile(
              doctor: doctor,
            );
          },
        ));
  }
}
