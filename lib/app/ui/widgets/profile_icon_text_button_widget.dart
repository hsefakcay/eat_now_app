// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/icon_sizes.dart';

class ProfileIconTextButton extends StatelessWidget {
  const ProfileIconTextButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    icon,
                    size: IconSizes.iconMedium,
                  ),
                ),
                Text(text),
              ],
            ),
            Icon(
              Icons.navigate_next_rounded,
              size: IconSizes.iconMedium,
            )
          ],
        ));
  }
}
