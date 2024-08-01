import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';

class DetailChipWidget extends StatelessWidget {
  const DetailChipWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor: AppColor.lightgreyColor,
    );
  }
}
