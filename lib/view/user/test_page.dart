// import 'package:aim_swasthya/res/common_material.dart';
// import 'package:flutter/material.dart';
//
// class TestPage extends StatefulWidget {
//   const TestPage({super.key});
//
//   @override
//   State<TestPage> createState() => _TestPageState();
// }
//
// class _TestPageState extends State<TestPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Center(
//             child:
//             Container(
//           height: Sizes.screenWidth,
//           width: Sizes.screenWidth,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                     offset: const Offset(0, 0),
//                     color: AppColor.black.withOpacity(.3),
//                     blurStyle: BlurStyle.inner,
//                     spreadRadius: 3,
//                     blurRadius: 20),
//                 BoxShadow(
//                     offset: const Offset(0, 0),
//                     color: AppColor.white.withOpacity(.9),
//                     blurStyle: BlurStyle.inner,
//                     spreadRadius: 5,
//                     blurRadius: 15),
//                 BoxShadow(
//                     offset: const Offset(0, 0),
//                     color: AppColor.black.withOpacity(.03),
//                     blurStyle: BlurStyle.inner,
//                     spreadRadius: 0,
//                     blurRadius: 8),
//               ]
//               // boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.3), blurRadius: 2, blurStyle: BlurStyle.inner,spreadRadius: 2)]
//               ),
//         )
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 0),
                blurRadius: 0,
                spreadRadius: -2,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.6),
                offset: const Offset(0, 0),
                blurRadius: 0,
                spreadRadius: -2,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.grey.withOpacity(0.1),
                      Colors.black.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  // border: Border.all(
                  //   color: Colors.white.withOpacity(0.6),
                  //   width: 1.5,
                  // ),
                ),
                child: Text(
                  'Glass Effect',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

