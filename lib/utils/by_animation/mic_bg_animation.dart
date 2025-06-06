// utils/by_animation/mic_bg_animation.dart
import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:aim_swasthya/generated/assets.dart';
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
            image: DecorationImage(
                image: AssetImage(frames[currentIndex]), fit: BoxFit.cover)),
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

class _SecMicAnimation extends State<SecMicAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Duration for one complete orbit
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear, // Linear curve for continuous orbit
      ),
    );

    _controller.repeat(); // Repeat the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define the radius of the small orbit path
    final double orbitRadius =
        Sizes.screenHeight * 0.01; // Adjust for slight movement

    return Container(
      height: Sizes.screenHeight * 0.2,
      width: Sizes.screenHeight * 0.2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Blue Background Circle with Blur
          Container(
            height: Sizes.screenHeight * 0.2,
            width: Sizes.screenHeight * 0.2,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue, // Blue background
            ),
          ),
          // Add a BackdropFilter to blur the background
          Positioned.fill(
            child: ClipOval(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Adjust blur values as needed
                child: Container(
                  color: Colors.transparent, // Needs a child container, color can be transparent
                ),
              ),
            ),
          ),
          // Animated Microphone Container
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              // Calculate the offset based on the animated value (0 to 1 maps to 0 to 2*pi)
              final double angle =
                  _animation.value * 2 * 3.14159; // Angle in radians
              final double offsetX = orbitRadius * cos(angle);
              final double offsetY = orbitRadius * sin(angle);

              return Transform.translate(
                offset: Offset(offsetX, offsetY),
                child: Image.asset(
                   Assets.assetsMicc, // Your microphone icon asset path
                  height: Sizes.screenHeight * 0.15,
                  width: Sizes.screenHeight * 0.15,
                  //  color: Colors.blue, // Icon color
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
