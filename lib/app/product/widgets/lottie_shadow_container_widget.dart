import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';

class LottieShadowContainerWidget extends StatelessWidget {
  const LottieShadowContainerWidget({
    super.key,
    this.height = 200,
  });
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.primaryLightColor,
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.shade500, // Gölge rengi ve şeffaflık
            spreadRadius: 10, // Gölgenin yayılma yarıçapı
            blurRadius: 30, // Gölgenin bulanıklık yarıçapı
          ),
        ],
      ),
      child: ClipOval(
          child: Lottie.asset("lib/assets/animations/food_animation.json", fit: BoxFit.cover)),
    );
  }
}
