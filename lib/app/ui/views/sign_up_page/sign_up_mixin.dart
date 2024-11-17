import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/ui/views/sign_up_page/signup_view.dart';
import 'package:yemek_soyle_app/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

mixin SignUpPageMixin on State<SignupView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AppLocalizations localization() {
    final localizations = AppLocalizations.of(context)!;
    return localizations;
  }

  // sign up with firebase authentication
  Future<void> signUp() async {
    {
      await AuthService()
          .signUp(email: emailController.text, password: passwordController.text, context: context);
    }
  }
}
