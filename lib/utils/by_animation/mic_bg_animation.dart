
import 'dart:async';

import 'package:flutter/material.dart';

import '../../res/size_const.dart';

class MicAnimation extends StatefulWidget {
  const MicAnimation({super.key});

  @override
  State<MicAnimation> createState() => _MicAnimationState();
}

class _MicAnimationState extends State<MicAnimation> {
  final List<String> frames = [
    // 'assets/mic-1.png',
    'assets/mic-2.png',
    'assets/mic-3.png',
    'assets/mic-4.png',
    'assets/mic-5.png',
  ];

  int currentIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startAnimationLoop();
  }

  void startAnimationLoop() {
    timer = Timer.periodic(const Duration(milliseconds: 400), (Timer t) {
      setState(() {
        currentIndex = (currentIndex + 1) % frames.length;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      switchInCurve: Curves.easeInOut,
      child: Container(
        key: ValueKey<String>(frames[currentIndex]),
        height: Sizes.screenHeight * 0.2,
        width: Sizes.screenHeight * 0.2,
        decoration: BoxDecoration(
          // color: Colors.red,
          image: DecorationImage(image: AssetImage( frames[currentIndex]),fit: BoxFit.cover)
        ),
        // child: Image.asset(
        //
        //   frames[currentIndex],
        //
        // ),
      ),
    );
  }
}


class SecMicAnimation extends StatefulWidget {
  const SecMicAnimation({super.key});

  @override
  State<SecMicAnimation> createState() => _SecMicAnimation();
}

class _SecMicAnimation extends State<SecMicAnimation> {
  final List<String> frame = [
    // 'assets/mic-1.png',
    'assets/animation_2mic.png',
    'assets/animation_3mic.png',
    'assets/animation_4mic.png',
    'assets/animation_5mic.png',
  ];

  int currentIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startAnimationLoop();
  }

  void startAnimationLoop() {
    timer = Timer.periodic(const Duration(milliseconds: 400), (Timer t) {
      setState(() {
        currentIndex = (currentIndex + 1) % frame.length;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      switchInCurve: Curves.easeInOut,
      child: Container(
        key: ValueKey<String>(frame[currentIndex]),
        height: Sizes.screenHeight * 0.2,
        width: Sizes.screenHeight * 0.2,
        decoration: BoxDecoration(
          // color: Colors.red,
            image: DecorationImage(image: AssetImage( frame[currentIndex]),fit: BoxFit.cover)
        ),
        // child: Image.asset(
        //
        //   frames[currentIndex],
        //
        // ),
      ),
    );
  }
}