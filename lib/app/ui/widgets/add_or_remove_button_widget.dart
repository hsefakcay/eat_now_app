import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/constants/icon_sizes.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';

class addOrRemoveButtonWidget extends StatelessWidget {
  const addOrRemoveButtonWidget({
    super.key,
    required this.process,
    required this.icon,
  });

  final Function() process;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ProjectUtility.primaryColorBoxDecoration,
      child: IconButton(
        onPressed: process,
        icon: Icon(
          icon,
          color: AppColor.whiteColor,
        ),
        iconSize: IconSizes.iconLarge,
      ),
    );
  }
}
