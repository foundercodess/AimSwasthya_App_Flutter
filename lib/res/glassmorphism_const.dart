// import 'package:flutter/material.dart';
//
// class GlassmorphismConst extends StatelessWidget {
//   const GlassmorphismConst({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GlassmorphicFlexContainer(
//       borderRadius: 20,
//       blur: 20,
//       padding: EdgeInsets.all(40),
//       alignment: Alignment.bottomCenter,
//       border: 2,
//       linearGradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFFffffff).withOpacity(0.1),
//             Color(0xFFFFFFFF).withOpacity(0.05),
//           ],
//           stops: [
//             0.1,
//             1,
//           ]),
//       borderGradient: LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [
//           Color(0xFFffffff).withOpacity(0.5),
//           Color((0xFFFFFFFF)).withOpacity(0.5),
//         ],
//       ),
//       child: null,
//     ),;
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';

class GlassmorphismExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Center(
              child: Text(
                "Glassmorphism",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}