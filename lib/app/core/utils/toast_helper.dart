import 'package:fluttertoast/fluttertoast.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';

class ToastHelper {
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: AppColor.redColor,
      fontSize: 16,
    );
  }
}