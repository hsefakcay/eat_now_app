import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';
import 'package:yemek_soyle_app/app/core/utils/screen_utility.dart';
import 'package:yemek_soyle_app/app/ui/views/main_tab_view.dart';
import 'package:yemek_soyle_app/app/ui/widgets/lottie_shadow_container_widget.dart';

class CartDialog extends AlertDialog {
  CartDialog({required BuildContext context, Key? key})
      : super(
          key: key,
          title: Center(
            child: Text(
              AppLocalizations.of(context)!.orderPreparing,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          actions: [
            Center(
                child: Column(
              children: [
                SizedBox(height: ScreenUtil.screenHeight(context) * 0.02),
                LottieShadowContainerWidget(
                  height: ScreenUtil.screenHeight(context) * 0.25,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    decoration: ProjectUtility.primaryColorBoxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextButton(
                        child: Text(AppLocalizations.of(context)!.ok,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColor.whiteColor, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<MainPage>(builder: (context) => const MainPage()),
                          );
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
