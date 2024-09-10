import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';
import 'package:yemek_soyle_app/app/ui/views/main_tab_view.dart';
import 'package:yemek_soyle_app/app/ui/widgets/lottie_shadow_container_widget.dart';

class CartAlertDialogWidget extends StatelessWidget {
  const CartAlertDialogWidget({
    super.key,
  });
  final String _title = "Siparişiniz hazırlanıyor...";
  final String _buttonTitle = "TAMAM";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.whiteColor,
      titlePadding: EdgeInsets.only(bottom: 50, top: 20),
      title: Center(
        child: Text(
          _title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      actions: [
        Center(
            child: Column(
          children: [
            const LottieShadowContainerWidget(
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
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
              ),
            ),
          ],
        ))
      ],
    );
  }
}
