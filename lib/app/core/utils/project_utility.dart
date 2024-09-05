import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';

class ProjectUtility {
  static BoxDecoration cartBoxDecoration = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [AppColor.primaryColor, AppColor.primaryLightColor, AppColor.whiteColor]));

  static BoxDecoration primaryColorBoxDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor.primaryColor);

  static BoxDecoration lightColorBoxDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor.primaryLightColor);

  static BoxDecoration greyColorBoxDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor.lightgreyColor);
}
