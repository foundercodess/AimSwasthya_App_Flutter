import 'package:aim_swasthya/generated/assets.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/material.dart';
class BackBtnConst extends StatelessWidget {
  final void Function()? onTap;
  const BackBtnConst({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap?? () {
          Navigator.pop(context);
        },
        child: const Image(image: AssetImage(Assets.iconsBackBtn),height: 33,),
    );
  }
}
