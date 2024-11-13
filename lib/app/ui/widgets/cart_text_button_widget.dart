import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/ui/widgets/cart_alert_dialog_widget.dart';
import 'package:yemek_soyle_app/services/notification_service.dart';

class CardTextButtonWidget extends StatefulWidget {
  CardTextButtonWidget({
    super.key,
    required this.totalCoast,
  });
  // The total cost of the items in the cart.
  final int totalCoast;

  @override
  State<CardTextButtonWidget> createState() => _CardTextButtonWidgetState();
}

class _CardTextButtonWidgetState extends State<CardTextButtonWidget> {
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationService.setup();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        context.localizedConfirmCart,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold, color: AppColor.whiteColor),
      ),
      onPressed: () {
        if (widget.totalCoast <= 0) return;

        notificationService.showNotification(
          context.localizedAppName,
          context.localizedOrderPreparing,
        );
        showDialog<CartDialog>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return CartDialog(context: context);
          },
        );
      },
    );
  }
}

/// Extension for easier access to localization strings.
extension LocalizationExtension on BuildContext {
  String get localizedConfirmCart => AppLocalizations.of(this)!.confirmCart;
  String get localizedAppName => AppLocalizations.of(this)!.appName;
  String get localizedOrderPreparing => AppLocalizations.of(this)!.orderPreparing;
}
