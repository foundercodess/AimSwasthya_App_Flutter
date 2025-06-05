// view/animation_con.dart
// import 'package:flutter/material.dart';
// import 'dart:math';

// class AnimationDemo extends StatefulWidget {
//   @override
//   _AnimationDemoState createState() => _AnimationDemoState();
// }

// class _AnimationDemoState extends State<AnimationDemo>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _rotation;
//   late Animation<double> _scale;
//   late Animation<double> _opacity;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     )..repeat(reverse: true);

//     _rotation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
//     _scale = Tween<double>(begin: 0.8, end: 1.2).animate(_controller);
//     _opacity = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _controller,
//           builder: (_, child) {
//             return Opacity(
//               opacity: _opacity.value,
//               child: Transform.rotate(
//                 angle: _rotation.value,
//                 child: Transform.scale(
//                   scale: _scale.value,
//                   child: Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.blueAccent,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(Icons.sync, color: Colors.white, size: 50),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }



// class CustomLoadingAnimation extends StatefulWidget {
//   @override
//   _CustomLoadingAnimationState createState() => _CustomLoadingAnimationState();
// }

// class _CustomLoadingAnimationState extends State<CustomLoadingAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> rotationAnimation;
//   late Animation<double> scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 3),
//     )..repeat();

//     rotationAnimation =
//         Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);

//     scaleAnimation = TweenSequence([
//       TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1), weight: 50),
//       TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 50),
//     ]).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Widget _buildRotatingGlow() {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (_, child) {
//         return Transform.rotate(
//           angle: rotationAnimation.value,
//           child: Container(
//             width: 200,
//             height: 200,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.blueAccent.withOpacity(0.6),
//                   blurRadius: 40,
//                   spreadRadius: 5,
//                 ),
//               ],
//               gradient: SweepGradient(
//                 colors: [
//                   Colors.transparent,
//                   Colors.blueAccent.withOpacity(0.7),
//                   Colors.transparent,
//                 ],
//                 startAngle: 0.0,
//                 endAngle: pi * 2,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildCenterIcon() {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (_, child) {
//         return Transform.scale(
//           scale: scaleAnimation.value,
//           child: Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.blueAccent.withOpacity(0.5),
//                   blurRadius: 20,
//                   spreadRadius: 5,
//                 ),
//               ],
//             ),
//             child: Icon(
//               Icons.power_settings_new,
//               size: 40,
//               color: Colors.blueAccent,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             _buildRotatingGlow(),
//             _buildCenterIcon(),
//           ],
//         ),
//       ),
//     );
//   }
// }




// class MicPulseAnimation extends StatefulWidget {
//   @override
//   _MicPulseAnimationState createState() => _MicPulseAnimationState();
// }

// class _MicPulseAnimationState extends State<MicPulseAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scale;
//   late Animation<double> _opacity;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     )..repeat();

//     _scale = Tween<double>(begin: 1.0, end: 2.5).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );
//     _opacity = Tween<double>(begin: 0.5, end: 0.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Widget buildCircle({required double size, required Color color}) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) => Transform.scale(
//         scale: _scale.value,
//         child: Container(
//           width: size,
//           height: size,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: color.withOpacity(_opacity.value),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             buildCircle(size: 120, color: Colors.purpleAccent),
//             buildCircle(size: 120, color: Colors.purpleAccent),
//             Container(
//               height: 60,
//               width: 60,
//               decoration: BoxDecoration(
//                 color: Colors.purpleAccent,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.mic, color: Colors.white, size: 30),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class MicPulseEffect extends StatefulWidget {
//   @override
//   _MicPulseEffectState createState() => _MicPulseEffectState();
// }

// class _MicPulseEffectState extends State<MicPulseEffect>
//     with TickerProviderStateMixin {
//   late AnimationController _rippleController1;
//   late AnimationController _rippleController2;

//   @override
//   void initState() {
//     super.initState();

//     _rippleController1 = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     )..repeat();

//     _rippleController2 = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     );

//     // Delay start of second ripple
//     Future.delayed(Duration(milliseconds: 1000), () {
//       _rippleController2.repeat();
//     });
//   }

//   @override
//   void dispose() {
//     _rippleController1.dispose();
//     _rippleController2.dispose();
//     super.dispose();
//   }

//   Widget _buildRipple(AnimationController controller) {
//     return AnimatedBuilder(
//       animation: controller,
//       builder: (context, child) {
//         final scale = Tween<double>(begin: 0.8, end: 2.8)
//             .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut))
//             .value;
//         final opacity = Tween<double>(begin: 0.4, end: 0.0)
//             .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut))
//             .value;
//         return Transform.scale(
//           scale: scale,
//           child: Container(
//             width: 120,
//             height: 120,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.purpleAccent.withOpacity(opacity),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             _buildRipple(_rippleController1),
//             _buildRipple(_rippleController2),
//             Container(
//               width: 70,
//               height: 70,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.purpleAccent,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.purpleAccent.withOpacity(0.6),
//                     blurRadius: 20,
//                     spreadRadius: 4,
//                   ),
//                 ],
//               ),
//               child: Icon(Icons.mic, color: Colors.white, size: 32),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class MicPulseExactAnimation extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             for (int i = 0; i < 4; i++) AnimatedRipple(delay: i * 800),
//             MicIcon(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AnimatedRipple extends StatefulWidget {
//   final int delay;
//   const AnimatedRipple({required this.delay});

//   @override
//   _AnimatedRippleState createState() => _AnimatedRippleState();
// }

// class _AnimatedRippleState extends State<AnimatedRipple>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scale;
//   late Animation<double> _opacity;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: Duration(milliseconds: 3200),
//       vsync: this,
//     );

//     _scale = Tween<double>(begin: 0.0, end: 2.8).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );

//     _opacity = Tween<double>(begin: 0.35, end: 0.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );

//     Future.delayed(Duration(milliseconds: widget.delay), () {
//       if (mounted) _controller.repeat();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (_, __) => Opacity(
//         opacity: _opacity.value,
//         child: Transform.scale(
//           scale: _scale.value,
//           child: Container(
//             width: 120,
//             height: 120,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.purpleAccent,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MicIcon extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 70,
//       height: 70,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.purpleAccent,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.purpleAccent.withOpacity(0.6),
//             blurRadius: 20,
//             spreadRadius: 6,
//           ),
//         ],
//       ),
//       child: Icon(Icons.mic, color: Colors.white, size: 32),
//     );
//   }
// }



// class FinalMicVideoAnimation extends StatefulWidget {
//   @override
//   _FinalMicVideoAnimationState createState() => _FinalMicVideoAnimationState();
// }

// class _FinalMicVideoAnimationState extends State<FinalMicVideoAnimation>
//     with TickerProviderStateMixin {
//   late AnimationController _entranceController;
//   late Animation<Offset> _slideUpAnimation;
//   late Animation<double> _fadeAnimation;

//   late AnimationController _ripple1;
//   late AnimationController _ripple2;

//   @override
//   void initState() {
//     super.initState();

//     _entranceController = AnimationController(
//       duration: Duration(milliseconds: 1000),
//       vsync: this,
//     );

//     _slideUpAnimation = Tween<Offset>(
//       begin: Offset(0, 0.5),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _entranceController,
//       curve: Curves.easeOut,
//     ));

//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(_entranceController);

//     _entranceController.forward();

//     _ripple1 = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     )..repeat();

//     _ripple2 = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     );

//     Future.delayed(Duration(milliseconds: 1000), () {
//       if (mounted) _ripple2.repeat();
//     });
//   }

//   @override
//   void dispose() {
//     _entranceController.dispose();
//     _ripple1.dispose();
//     _ripple2.dispose();
//     super.dispose();
//   }

//   Widget buildRipple(AnimationController controller) {
//     return AnimatedBuilder(
//       animation: controller,
//       builder: (_, __) {
//         final scale = Tween<double>(begin: 0.8, end: 2.5).animate(
//           CurvedAnimation(parent: controller, curve: Curves.easeOut),
//         ).value;
//         final opacity = Tween<double>(begin: 0.35, end: 0.0).animate(
//           CurvedAnimation(parent: controller, curve: Curves.easeOut),
//         ).value;

//         return Transform.scale(
//           scale: scale,
//           child: Container(
//             width: 120,
//             height: 120,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.purpleAccent.withOpacity(opacity),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SlideTransition(
//           position: _slideUpAnimation,
//           child: Center(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 buildRipple(_ripple1),
//                 buildRipple(_ripple2),
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.purpleAccent,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.purpleAccent.withOpacity(0.6),
//                         blurRadius: 20,
//                         spreadRadius: 6,
//                       ),
//                     ],
//                   ),
//                   child: Icon(Icons.mic, color: Colors.white, size: 32),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// class HoverMicApp extends StatelessWidget {
//   const HoverMicApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: HoverMicAnimated(),
//         ),
//       ),
//     );
//   }
// }

// class HoverMicAnimated extends StatefulWidget {
//   const HoverMicAnimated({super.key});

//   @override
//   State<HoverMicAnimated> createState() => _HoverMicAnimatedState();
// }

// class _HoverMicAnimatedState extends State<HoverMicAnimated>
//     with SingleTickerProviderStateMixin {
//   bool isHovered = false;
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     )..repeat(reverse: true);

//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _onEnter(bool hover) {
//     setState(() {
//       isHovered = hover;
//       if (hover) {
//         _controller.repeat(reverse: true);
//       } else {
//         _controller.stop();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => _onEnter(true),
//       onExit: (_) => _onEnter(false),
//       child: AnimatedBuilder(
//         animation: _scaleAnimation,
//         builder: (context, child) {
//           return Transform.scale(
//             scale: isHovered ? _scaleAnimation.value : 1.0,
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 400),
//               curve: Curves.easeOutCubic,
//               padding: const EdgeInsets.all(25),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: isHovered
//                     ? const RadialGradient(
//                   colors: [Colors.redAccent, Colors.deepOrange],
//                   center: Alignment.center,
//                   radius: 1.2,
//                 )
//                     : const RadialGradient(
//                   colors: [Colors.grey, Colors.black],
//                   center: Alignment.center,
//                   radius: 1.0,
//                 ),
//                 boxShadow: isHovered
//                     ? [
//                   BoxShadow(
//                     color: Colors.redAccent.withOpacity(0.6),
//                     blurRadius: 25,
//                     spreadRadius: 5,
//                   )
//                 ]
//                     : [],
//               ),
//               child: Icon(
//                 Icons.mic,
//                 color: isHovered ? Colors.white : Colors.grey[400],
//                 size: 40,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }




// class GradientMicApp extends StatelessWidget {
//   const GradientMicApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: GradientHoverMic(),
//         ),
//       ),
//     );
//   }
// }

// class GradientHoverMic extends StatefulWidget {
//   const GradientHoverMic({super.key});

//   @override
//   State<GradientHoverMic> createState() => _GradientHoverMicState();
// }

// class _GradientHoverMicState extends State<GradientHoverMic> {
//   bool isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => isHovered = true),
//       onExit: (_) => setState(() => isHovered = false),
//       child: TweenAnimationBuilder<double>(
//         duration: const Duration(milliseconds: 1000),
//         curve: Curves.easeInOut,
//         tween: Tween<double>(begin: isHovered ? 0.0 : 1.0, end: isHovered ? 1.0 : 0.0),
//         builder: (context, value, child) {
//           return ShaderMask(
//             shaderCallback: (bounds) {
//               return LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 stops: [0.0, value],
//                 colors: [
//                   Colors.redAccent,
//                   Colors.white,
//                 ],
//               ).createShader(bounds);
//             },
//             blendMode: BlendMode.srcIn,
//             child: Icon(
//               Icons.mic,
//               size: 80,
//               color: Colors.white, // base color will be overridden by gradient
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



// class AnimatedMicApp extends StatelessWidget {
//   const AnimatedMicApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: AnimatedMicWithCircle(),
//         ),
//       ),
//     );
//   }
// }

// class AnimatedMicWithCircle extends StatefulWidget {
//   const AnimatedMicWithCircle({super.key});

//   @override
//   State<AnimatedMicWithCircle> createState() => _AnimatedMicWithCircleState();
// }

// class _AnimatedMicWithCircleState extends State<AnimatedMicWithCircle>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   bool isHovered = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 4),
//       vsync: this,
//     )..repeat(); // keeps rotating
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _setHover(bool hover) {
//     setState(() {
//       isHovered = hover;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => _setHover(true),
//       onExit: (_) => _setHover(false),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           // Rotating circular border
//           RotationTransition(
//             turns: _controller,
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 500),
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: SweepGradient(
//                   colors: isHovered
//                       ? [Colors.red, Colors.orange, Colors.deepOrange, Colors.red]
//                       : [Colors.grey.shade800, Colors.grey.shade900],
//                   startAngle: 0.0,
//                   endAngle: 2 * pi,
//                 ),
//                 boxShadow: isHovered
//                     ? [
//                   BoxShadow(
//                     color: Colors.redAccent.withOpacity(0.6),
//                     blurRadius: 20,
//                     spreadRadius: 3,
//                   )
//                 ]
//                     : [],
//               ),
//             ),
//           ),
//           // Mic icon
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 400),
//             width: 90,
//             height: 90,
//             decoration: BoxDecoration(
//               color: isHovered ? Colors.redAccent : Colors.grey[900],
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.mic,
//               color: Colors.white,
//               size: 40,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// class MicCircleWaveApp extends StatelessWidget {
//   const MicCircleWaveApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: MicWithVerticalCircleAnimation(),
//         ),
//       ),
//     );
//   }
// }

// class MicWithVerticalCircleAnimation extends StatefulWidget {
//   const MicWithVerticalCircleAnimation({super.key});

//   @override
//   State<MicWithVerticalCircleAnimation> createState() =>
//       _MicWithVerticalCircleAnimationState();
// }

// class _MicWithVerticalCircleAnimationState
//     extends State<MicWithVerticalCircleAnimation>
//     with SingleTickerProviderStateMixin {
//   bool isHovered = false;
//   late AnimationController _controller;
//   late Animation<double> _sweepAnim;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );

//     _sweepAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );
//   }

//   void _onHover(bool hover) {
//     setState(() {
//       isHovered = hover;
//     });
//     if (hover) {
//       _controller.repeat(reverse: true);
//     } else {
//       _controller.stop();
//       _controller.reset();
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => _onHover(true),
//       onExit: (_) => _onHover(false),
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return CustomPaint(
//             painter: CircleFillPainter(progress: _sweepAnim.value),
//             child: Container(
//               width: 150,
//               height: 150,
//               alignment: Alignment.center,
//               child: Container(
//                 width: 90,
//                 height: 90,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: isHovered ? Colors.redAccent : Colors.grey[900],
//                   boxShadow: isHovered
//                       ? [
//                     BoxShadow(
//                       color: Colors.redAccent.withOpacity(0.4),
//                       blurRadius: 20,
//                       spreadRadius: 4,
//                     )
//                   ]
//                       : [],
//                 ),
//                 child: const Icon(
//                   Icons.mic,
//                   color: Colors.white,
//                   size: 40,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class CircleFillPainter extends CustomPainter {
//   final double progress;

//   CircleFillPainter({required this.progress});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final strokeWidth = 10.0;
//     final rect = Offset.zero & size;

//     final backgroundPaint = Paint()
//       ..color = Colors.grey.shade800
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth;

//     final gradientPaint = Paint()
//       ..shader = LinearGradient(
//         begin: Alignment.bottomCenter,
//         end: Alignment.topCenter,
//         stops: [0.0, progress],
//         colors: [
//           Colors.red,
//           Colors.orange,
//         ],
//       ).createShader(rect)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth
//       ..strokeCap = StrokeCap.round;

//     // Draw base ring
//     canvas.drawCircle(
//       Offset(size.width / 2, size.height / 2),
//       size.width / 2 - strokeWidth / 2,
//       backgroundPaint,
//     );

//     // Draw animated arc
//     final arcRect = Rect.fromLTWH(
//       strokeWidth / 2,
//       strokeWidth / 2,
//       size.width - strokeWidth,
//       size.height - strokeWidth,
//     );

//     double sweep = 2 * 3.1416 * progress;

//     canvas.drawArc(arcRect, 3.1416 * (1 - progress), sweep, false, gradientPaint);
//   }

//   @override
//   bool shouldRepaint(CircleFillPainter oldDelegate) =>
//       oldDelegate.progress != progress;
// }


// class MicWaveApp extends StatelessWidget {
//   const MicWaveApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: MicWaveAnimation(),
//         ),
//       ),
//     );
//   }
// }

// class MicWaveAnimation extends StatefulWidget {
//   const MicWaveAnimation({super.key});

//   @override
//   State<MicWaveAnimation> createState() => _MicWaveAnimationState();
// }

// class _MicWaveAnimationState extends State<MicWaveAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _progress;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: true);

//     _progress = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: MicCanvasPainter(progress: _progress),
//       child: SizedBox(
//         width: 200,
//         height: 200,
//         child: Center(
//           child: Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               color: Colors.black,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.redAccent.withOpacity(0.5),
//                   blurRadius: 15,
//                   spreadRadius: 2,
//                 ),
//               ],
//             ),
//             child: const Icon(Icons.mic, color: Colors.white, size: 36),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MicCanvasPainter extends CustomPainter {
//   final Animation<double> progress;

//   MicCanvasPainter({required this.progress}) : super(repaint: progress);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint basePaint = Paint()
//       ..color = Colors.grey.shade800
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 8;

//     final Paint animatedPaint = Paint()
//       ..shader = LinearGradient(
//         begin: Alignment.bottomCenter,
//         end: Alignment.topCenter,
//         colors: [Colors.red, Colors.orange],
//         stops: [0.0, progress.value],
//       ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 8;

//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2 - 10;

//     // Base circle
//     canvas.drawCircle(center, radius, basePaint);

//     // Animated arc from bottom to top
//     final double sweepAngle = 2 * pi * progress.value;
//     final Rect arcRect = Rect.fromCircle(center: center, radius: radius);
//     canvas.drawArc(arcRect, pi / 2, sweepAngle, false, animatedPaint);
//   }

//   @override
//   bool shouldRepaint(MicCanvasPainter oldDelegate) => true;
// }




