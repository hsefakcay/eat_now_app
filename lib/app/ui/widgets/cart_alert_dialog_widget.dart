import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';
import 'package:yemek_soyle_app/app/ui/views/main_tab_view.dart';

class CartAlertDialogWidget extends StatelessWidget {
  const CartAlertDialogWidget({
    super.key,
  });
  final String _title = "Siparişiniz hazırlanıyor...";
  final String _buttonTitle = "Tamam";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          _title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      actions: [
        Center(
            child: Container(
          decoration: ProjectUtility.primaryColorBoxDecoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextButton(
              child: Text(_buttonTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: AppColor.whiteColor, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
              },
            ),
          ),
        ))
      ],
    );
  }
}
