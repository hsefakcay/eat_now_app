import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';
import 'package:yemek_soyle_app/app/ui/views/login_page/login_page_mixin.dart';
import 'package:yemek_soyle_app/app/ui/views/sign_up_page/signup_view.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginPageMixin {
  @override
  Widget build(BuildContext context) {
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
                          localization().appName,
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
                top: MediaQuery.sizeOf(context).height * 0.2, // Yukarıda konum
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                    decoration: ProjectUtility.signUpBoxDecoration,
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    child: SafeArea(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.sizeOf(context).height * 0.5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
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
        Text(localization().emailTitle, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: emailController,
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
        Text(localization().passwordTitle, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(
          height: 16,
        ),
        TextField(
          obscureText: true,
          controller: passwordController,
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
      onPressed: signIn,
      child: Text(
        localization().loginTitle,
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
              text: localization().notAMemberSubtitle,
              style: TextStyle(
                  color: AppColor.blackColor, fontWeight: FontWeight.normal, fontSize: 16),
            ),
            TextSpan(
                text: localization().signUpTitle,
                style: TextStyle(
                    color: AppColor.primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<SignupView>(builder: (context) => SignupView()),
                    );
                  }),
          ])),
    );
  }
}
