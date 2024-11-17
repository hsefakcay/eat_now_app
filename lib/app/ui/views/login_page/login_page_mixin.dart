import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/ui/views/login_page/login_view.dart';
import 'package:yemek_soyle_app/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

mixin LoginPageMixin on State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AppLocalizations localization() {
    final localizations = AppLocalizations.of(context)!;
    return localizations;
  }

  // sign in with firebase authentication
  Future<void> signIn() async {
    {
      await AuthService()
          .signin(email: emailController.text, password: passwordController.text, context: context);
    }
  }
}
