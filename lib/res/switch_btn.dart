
import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _circleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _circleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(_animationController);
  }

  @override
  void didUpdateWidget(CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSwitch() {
    print("sjabvdjb: ${widget.value}");
    if (widget.value) {
      _animationController.reverse();
      widget.onChanged(false);
    } else {
      _animationController.forward();
      widget.onChanged(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            width: 48.0,
            height: 28.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: _animationController.value < 0.5 ? AppColor.textfieldGrayColor : AppColor.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Align(
                alignment: _circleAnimation.value,
                child: Container(
                  width: 22.0,
                  height: 22.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}

// import 'package:flutter/material.dart';
//
// class SwitchExample extends StatefulWidget {
//   @override
//   _SwitchExampleState createState() => _SwitchExampleState();
// }
//
// class _SwitchExampleState extends State<SwitchExample> {
//   bool _isSwitched = false; // Initial switch state
//
//   void _toggleSwitch(bool value) {
//     setState(() {
//       _isSwitched = value;
//       print('Switch is ${_isSwitched ? "ON" : "OFF"}'); // Debugging log
//     });
//
//     // Call your function when switch changes
//     _onSwitchChanged(value);
//   }
//
//   void _onSwitchChanged(bool value) {
//     // Perform some action when the switch changes
//     print('Switch changed to: $value');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Switch Button Example')),
//       body: Center(
//         child: Switch(
//           value: _isSwitched,
//           onChanged: _toggleSwitch,
//           activeColor: Colors.green, // Customize switch color
//           inactiveThumbColor: Colors.grey,
//         ),
//       ),
//     );
//   }
// }


