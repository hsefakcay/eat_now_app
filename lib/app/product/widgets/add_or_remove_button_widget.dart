import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/constants/icon_sizes.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';

/// A widget that displays a button with an icon, allowing the user to add or remove items.
class AddOrRemoveButtonWidget extends StatelessWidget {
  const AddOrRemoveButtonWidget({
    super.key,
    required this.process,
    required this.icon,
  });

  /// The function to be executed when the button is pressed.
  final VoidCallback process;
  /// The icon to be displayed on the button.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
