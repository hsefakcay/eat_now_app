import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';
import 'package:yemek_soyle_app/app/ui/views/main_tab_view.dart';
import 'package:yemek_soyle_app/app/ui/widgets/cart_alert_dialog_widget.dart';

class CardTextButtonWidget extends StatelessWidget {
  const CardTextButtonWidget({
    super.key,
    required this.totalCoast,
  });
  final String _buttonTitle = "SEPETİ ONAYLA";
  final int totalCoast;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        _buttonTitle,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold, color: AppColor.whiteColor),
      ),
      onPressed: () {
        if (totalCoast > 0) {
          showDialog(
            context: context,
            builder: (context) {
              return const CartAlertDialogWidget();
            },
          );
        }
      },
    );
  }
}
