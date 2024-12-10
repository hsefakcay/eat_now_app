import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';

ThemeData get lightTheme {
  return ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.whiteColor,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.whiteColor,
      iconColor: AppColor.whiteColor,
    )),
  );
}
