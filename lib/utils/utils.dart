// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// class Utils {
//   static OverlayEntry? _overlayEntry;
//   static bool _isShowing = false;
//
//   static void show(String message, BuildContext context,{Color? color}) {
//     if (_isShowing) {
//       _overlayEntry?.remove();
//     }
//
//     _overlayEntry = OverlayEntry(
//       builder: (BuildContext context) => Center(
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//             decoration: BoxDecoration(
//               color: color??Colors.black.withOpacity(0.8),
//               borderRadius: BorderRadius.circular(24.0),
//             ),
//             child: Text(
//               message,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//
//     Overlay.of(context).insert(_overlayEntry!);
//     _isShowing = true;
//     _startTimer();
//   }
//
//   static void _startTimer() {
//     Timer(const Duration(seconds: 2), () {
//       if (_overlayEntry != null && _isShowing) {
//         _overlayEntry!.remove();
//         _isShowing = false;
//       }
//     });
//   }}
import 'dart:async';
import 'package:aim_swasthya/res/color_const.dart';
import 'package:flutter/material.dart';

class Utils {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  static void show(String message, BuildContext context, {Color? color}) {
    if (_isShowing) {
      _overlayEntry?.remove();
    }

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          bottom: 80, // Adjust bottom padding as needed
          left: 0,
          right: 0,
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                padding:  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: color ?? AppColor.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isShowing = true;
    _startTimer();
  }

  static void _startTimer() {
    Timer(const Duration(seconds: 2), () {
      if (_overlayEntry != null && _isShowing) {
        _overlayEntry!.remove();
        _isShowing = false;
      }
    });
  }
}
