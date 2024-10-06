import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';
import 'package:yemek_soyle_app/app/core/utils/screen_utility.dart';
import 'package:yemek_soyle_app/app/ui/widgets/cart_text_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    super.key,
    required this.totalCoast,
  });

  final int totalCoast;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    var mHeight = ScreenUtil.screenHeight(context);

    return Container(
      height: mHeight * 0.25,
      decoration: ProjectUtility.cartBoxDecoration,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 30, bottom: 10, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${localizations.shippingCost} :",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "₺ 0",
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${localizations.total} :",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "₺$totalCoast",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: mHeight * 0.02),
            Container(
                decoration: ProjectUtility.primaryColorBoxDecoration,
                height: mHeight * 0.07,
                alignment: Alignment.center,
                child: CardTextButtonWidget(totalCoast: totalCoast))
          ],
        ),
      ),
    );
  }
}
