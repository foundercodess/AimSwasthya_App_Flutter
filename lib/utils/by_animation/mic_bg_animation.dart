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

class MicWaveSideAnimation extends StatefulWidget {
  final bool isListening;
  final double size;
  const MicWaveSideAnimation({Key? key, required this.isListening, this.size = 180}) : super(key: key);

  @override
  State<MicWaveSideAnimation> createState() => _MicWaveSideAnimationState();
}

class _MicWaveSideAnimationState extends State<MicWaveSideAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleAnim;
  late Animation<Color?> _micColorAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    if (widget.isListening) {
      _controller.repeat(reverse: true);
    }
    _circleAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _micColorAnim = ColorTween(
      begin: Colors.white,
      end: Colors.purple,
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(MicWaveSideAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isListening && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isListening && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double borderWidth = widget.size * 0.06;
    final double circleSize = widget.size * 1.7;
    final double horizontalOffset = widget.size * 0.65;
    final double verticalOffset = (widget.size - borderWidth * 2) / 2;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Purple border circle
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.purple, width: borderWidth),
            ),
          ),
          // Clip the animation to the inside of the border
          ClipOval(
            child: SizedBox(
              width: widget.size - borderWidth * 2,
              height: widget.size - borderWidth * 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Left circle
                  AnimatedBuilder(
                    animation: _circleAnim,
                    builder: (context, child) {
                      final dx = -horizontalOffset * (1 - _circleAnim.value);
                      final dy = verticalOffset * (1 - _circleAnim.value) - verticalOffset * _circleAnim.value;
                      return Opacity(
                        opacity: _circleAnim.value,
                        child: Transform.translate(
                          offset: Offset(dx, dy),
                          child: Container(
                            width: circleSize,
                            height: circleSize,
                            decoration: BoxDecoration(
                              color: Colors.blue[700]!.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Right circle
                  AnimatedBuilder(
                    animation: _circleAnim,
                    builder: (context, child) {
                      final dx = horizontalOffset * (1 - _circleAnim.value);
                      final dy = verticalOffset * (1 - _circleAnim.value) - verticalOffset * _circleAnim.value;
                      return Opacity(
                        opacity: _circleAnim.value,
                        child: Transform.translate(
                          offset: Offset(dx, dy),
                          child: Container(
                            width: circleSize,
                            height: circleSize,
                            decoration: BoxDecoration(
                              color: Colors.blue[300]!.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Mic icon in the center with animated color
          AnimatedBuilder(
            animation: _micColorAnim,
            builder: (context, child) {
              return Icon(
                Icons.mic,
                size: widget.size * 0.36,
                color: _micColorAnim.value,
              );
            },
          ),
        ],
      ),
    );
  }
}
