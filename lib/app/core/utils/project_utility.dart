import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';

class ProjectUtility {
  static BoxDecoration cartBoxDecoration = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [AppColor.primaryColor, AppColor.primaryLightColor, AppColor.whiteColor]));

  static BoxDecoration primaryColorBoxDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor.primaryColor);

  static BoxDecoration signUpBoxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: AppColor.whiteColor,
      border: Border.all(width: 0.5, color: Colors.black45));

  static BoxDecoration cartDismissibleBoxDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor.redColor);

  static BoxDecoration lightColorBoxDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor.primaryLightColor);

  static BoxDecoration greyColorBoxDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor.lightgreyColor);
}
