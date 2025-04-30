import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/material.dart';

class LoadData extends StatelessWidget {
  const LoadData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.screenWidth/4,
      width: Sizes.screenWidth/4,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage(Assets.assetsLoading))
      ),
    );
  }
}
