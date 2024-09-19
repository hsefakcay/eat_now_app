import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_soyle_app/app/ui/widgets/cart_alert_dialog_widget.dart';
import 'package:yemek_soyle_app/services/notification_service.dart';

class CardTextButtonWidget extends StatefulWidget {
  CardTextButtonWidget({
    super.key,
    required this.totalCoast,
  });
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
        AppLocalizations.of(context)!.confirmCart,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold, color: AppColor.whiteColor),
      ),
      onPressed: () {
        if (widget.totalCoast > 0) {
          notificationService.showNotification(
            AppLocalizations.of(context)!.appName,
            AppLocalizations.of(context)!.orderPreparing,
          );
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
