import 'package:aim_swasthya/generated/assets.dart';
import 'package:aim_swasthya/res/border_const.dart';
import 'package:aim_swasthya/res/size_const.dart';
import 'package:flutter/material.dart';

class CustomSliderButton extends StatefulWidget {
  final VoidCallback onSlideComplete;
  final String label;
  final Color buttonColor;
  final Color backgroundColor;
  final double width;
  final double height;

  const CustomSliderButton({
    super.key,
    required this.onSlideComplete,
    this.label = "Slide to withdraw",
    this.buttonColor = Colors.blue,
    this.backgroundColor = Colors.blueGrey,
    this.width = 250,
    this.height = 50,
  });

  @override
  _CustomSliderButtonState createState() => _CustomSliderButtonState();
}

// class _CustomSliderButtonState extends State<CustomSliderButton>
//     with SingleTickerProviderStateMixin {
//   double _position = 0.0;
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   String _currentLabel = "Slide to withdraw";
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _animation = Tween<double>(begin: 0, end: 0).animate(_controller)
//       ..addListener(() {
//         setState(() {
//           _position = _animation.value;
//         });
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.centerLeft,
//       children: [
//         BorderContainer(
//           radius: 15,
//           padding: const EdgeInsets.all(1.2),
//           child: Container(
//             width: widget.width,
//             height: widget.height,
//             decoration: BoxDecoration(
//               color: widget.backgroundColor,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               _currentLabel,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           left: _position,
//           child: GestureDetector(
//             onHorizontalDragUpdate: (details) {
//               setState(() {
//                 _position += details.primaryDelta ?? 0.0;
//                 _position =
//                     // _position.clamp(0, widget.width / 1.1 - widget.height);
//                 _position = _position.clamp(0, widget.width/1.18 - widget.height);
//
//                 if (_position < widget.width / 2) {
//                   _currentLabel = "Slide to withdraw";
//                 } else {
//                   _currentLabel = "Payment in process";
//                 }
//               });
//             },
//
//             onHorizontalDragEnd: (details) {
//               if (_position >= widget.width - widget.height - 5) {
//                 widget.onSlideComplete();
//               }
//               if (_position <= widget.width / 8) {
//                 _controller.reset();
//                 _position = 1; // Reset to left side
//               }
//               // if (_position <= widget.width / 8) {
//               //   _controller.reset();
//               // }
//               _animation = Tween<double>(begin: _position, end: 0).animate(
//                   CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//               _controller.forward();
//             },
//             child: BorderContainer(
//               radius: 15,
//               padding: const EdgeInsets.all(1),
//               child: Container(
//                 width: Sizes.screenWidth / 6,
//                 height: widget.height,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: widget.buttonColor,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.3),
//                       blurRadius: 4,
//                       offset: Offset(2, 0),
//                     ),
//                   ],
//                 ),
//                 child: Center(
//                   child:
//                   Image.asset(Assets.iconsSlideForwrd,
//                       width: widget.height / 1.5),
//
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class _CustomSliderButtonState extends State<CustomSliderButton>
    with SingleTickerProviderStateMixin {
  double _position = 0.0;
  late AnimationController _controller;
  late Animation<double> _animation;
  String _currentLabel = "Slide to withdraw";
  bool _isTickIcon = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {
          _position = _animation.value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        BorderContainer(
          radius: 15,
          padding: const EdgeInsets.all(1.2),
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            child: Text(
              _currentLabel,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Positioned(
          left: _position,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _position += details.primaryDelta ?? 0.0;
                _position = _position.clamp(0, widget.width / 1.18 - widget.height);
                if (_position < widget.width / 2) {
                  _currentLabel = "Slide to withdraw";
                  _isTickIcon = false;
                } else {
                  _currentLabel = "Payment in process";
                  _isTickIcon = true;
                }
              });
            },

            onHorizontalDragEnd: (details) {
              if (_position >= widget.width - widget.height - 5) {
                widget.onSlideComplete();
              }

              if (_position <= widget.width / 8) {
                _controller.reset();
                _position = 1;
                _isTickIcon = false;
              }
              _animation = Tween<double>(begin: _position, end: 0).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.easeOut));
              _controller.forward();
            },
            child: BorderContainer(
              radius: 15,
              padding: const EdgeInsets.all(1),
              child: Container(
                width: Sizes.screenWidth / 6,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: widget.buttonColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(2, 0),
                    ),
                  ],
                ),
                child: Center(
                  child: _isTickIcon
                      ? Image.asset(
                    Assets.iconsTickIcon,
                    width: widget.height / 1.5,
                    height: widget.height / 2.5,
                  )
                      : Image.asset(
                    Assets.iconsSlideForwrd,
                    width: widget.height / 1.5,
                    height: widget.height / 2,
                  ),
                ),

              ),
            ),
          ),
        ),
      ],
    );
  }
}



//
// import 'package:aim_swasthya/res/border_const.dart';
// import 'package:aim_swasthya/res/common_material.dart';
// import 'package:flutter/material.dart';
//
// class CustomSliderButton extends StatefulWidget {
//   final VoidCallback onSlideComplete;
//   final String label;
//   final Color buttonColor;
//   final Color backgroundColor;
//   final double width;
//   final double height;
//
//   const CustomSliderButton({
//     super.key,
//     required this.onSlideComplete,
//     this.label = "Slide to withdraw",
//     this.buttonColor = Colors.blue,
//     this.backgroundColor = Colors.blueGrey,
//     this.width = 250,
//     this.height = 50,
//   });
//
//   @override
//   _CustomSliderButtonState createState() => _CustomSliderButtonState();
// }
//
// class _CustomSliderButtonState extends State<CustomSliderButton>
//     with SingleTickerProviderStateMixin {
//   double _position = 0.0;
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _animation = Tween<double>(begin: 0, end: 0).animate(_controller)
//       ..addListener(() {
//         setState(() {
//           _position = _animation.value;
//         });
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.centerLeft,
//       children: [
//         BorderContainer(
//           radius: 15,
//           padding: const EdgeInsets.all(1.2),
//           child: Container(
//             width: widget.width,
//             height: widget.height,
//             decoration: BoxDecoration(
//               color: widget.backgroundColor,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               widget.label,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//
//
//         Positioned(
//           left: _position,
//           child: GestureDetector(
//             onHorizontalDragUpdate: (details) {
//               setState(() {
//                 _position += details.delta.dx;
//                 _position = _position.clamp(0, widget.width/1.14 - widget.height);
//               });
//             },
//             onHorizontalDragEnd: (details) {
//               if (_position >= widget.width - widget.height - 5) {
//                 widget.onSlideComplete();
//               }
//               if(_position<= widget.width/8){
//                 _controller.reset();
//               }
//               _animation = Tween<double>(begin: _position, end: 0)
//                   .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//               _controller.forward();
//             },
//             child: BorderContainer(
//               radius: 15,
//               padding: EdgeInsets.all(1),
//               child: Container(
//                 width: Sizes.screenWidth/6,
//                 height: widget.height,
//                 decoration: BoxDecoration(
//                   borderRadius:BorderRadius.circular(15),
//                   color: widget.buttonColor,
//                 ),
//                 child:  Center(
//                   child: Image.asset(Assets.iconsSlideForwrd, width: widget.height/1.5,)
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
