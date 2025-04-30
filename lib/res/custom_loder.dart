import 'dart:ui';
import 'package:flutter/material.dart';
import 'color_const.dart';

class LoaderOverlay {
  static final LoaderOverlay _instance = LoaderOverlay._internal();
  factory LoaderOverlay() => _instance;

  LoaderOverlay._internal();

  OverlayEntry? _overlayEntry;
  bool _isShowing = false;

  void show(BuildContext context) {
    if (_isShowing) return;

    _overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
             const Center(
              child: CircularProgressIndicator(
                color: AppColor.blue,
              ),
            ),
          ],
        )
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isShowing = true;
  }

  void hide() {
    if (_isShowing && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isShowing = false;
    }
  }
}