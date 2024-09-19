import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';
import 'package:yemek_soyle_app/app/ui/views/signup_view.dart';
import 'package:yemek_soyle_app/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: _signupText(context),
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none, // Taşan widget'ların görünmesini sağlar
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.4,
                    decoration: BoxDecoration(color: AppColor.primaryColor),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 150),
                        child: Text(
                          localizations.appName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: AppColor.whiteColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.4,
                    decoration: BoxDecoration(color: AppColor.whiteColor),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.2, // Yukarıda konumlandır
                left: 0, // Sol hizalama ekleyelim
                right: 0, // Sağ hizalama ekleyelim
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                    decoration: ProjectUtility.signUpBoxDecoration,
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    child: SafeArea(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.sizeOf(context).height * 0.5, // Yüksekliği sınırla
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              _emailAddressField(context),
                              const SizedBox(
                                height: 20,
                              ),
                              _passwordField(context),
                              const SizedBox(
                                height: 50,
                              ),
                              _signinButton(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _emailAddressField(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.emailTitle,
            style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              filled: true,
              hintText: 'mahdiforwork@gmail.com',
              hintStyle: TextStyle(
                  color: AppColor.lightgreyColor, fontWeight: FontWeight.normal, fontSize: 14),
              fillColor: const Color(0xffF7F7F9),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none, borderRadius: BorderRadius.circular(14))),
        )
      ],
    );
  }

  Widget _passwordField(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.passwordTitle,
            style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(
          height: 16,
        ),
        TextField(
          obscureText: true,
          controller: _passwordController,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF7F7F9),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none, borderRadius: BorderRadius.circular(14))),
        )
      ],
    );
  }

  Widget _signinButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: () async {
        await AuthService().signin(
            email: _emailController.text, password: _passwordController.text, context: context);
      },
      child: Text(
        AppLocalizations.of(context)!.loginTitle,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColor.whiteColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: AppLocalizations.of(context)!.notAMemberSubtitle,
              style: TextStyle(
                  color: AppColor.blackColor, fontWeight: FontWeight.normal, fontSize: 16),
            ),
            TextSpan(
                text: AppLocalizations.of(context)!.signUpTitle,
                style: TextStyle(
                    color: AppColor.primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupView()),
                    );
                  }),
          ])),
    );
  }
}
