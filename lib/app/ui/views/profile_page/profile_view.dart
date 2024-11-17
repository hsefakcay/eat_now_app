// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/constants/icon_sizes.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';
import 'package:yemek_soyle_app/app/ui/views/main_tab_page/main_tab_view.dart';
import 'package:yemek_soyle_app/app/ui/views/profile_page/widgets/profile_icon_text_button_widget.dart';
import 'package:yemek_soyle_app/services/auth_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context)!.profileTitle,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColor.whiteColor, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: ProjectUtility.lightColorBoxDecoration,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.person_rounded,
                            size: IconSizes.iconLarge,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        Text(FirebaseAuth.instance.currentUser!.email.toString(),
                            style: Theme.of(context).textTheme.titleLarge),
                        Text(
                          "+90 507 XXXX XX",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                spacing: 10,
                children: [
                  ProfileIconTextButton(
                      text: AppLocalizations.of(context)!.liveSupportTitle,
                      icon: Icons.comment_rounded,
                      onPressed: () {}),
                  ProfileIconTextButton(
                      text: AppLocalizations.of(context)!.addressesTitle,
                      icon: Icons.location_on_outlined,
                      onPressed: () {}),
                  ProfileIconTextButton(
                      text: AppLocalizations.of(context)!.favorites,
                      icon: Icons.favorite_rounded,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<MainPage>(
                              builder: (context) => const MainPage(currentIndex: 1)),
                        );
                      }),
                  ProfileIconTextButton(
                      text: AppLocalizations.of(context)!.orderHistoryTitle,
                      icon: Icons.shopping_cart_outlined,
                      onPressed: () {}),
                  ProfileIconTextButton(
                      text: AppLocalizations.of(context)!.paymentMethodsTitle,
                      icon: Icons.credit_card_rounded,
                      onPressed: () {}),
                  ProfileIconTextButton(
                      text: AppLocalizations.of(context)!.contactPreferencesTitle,
                      icon: Icons.notifications_active_rounded,
                      onPressed: () {}),
                  ProfileIconTextButton(
                      text: AppLocalizations.of(context)!.logoutTitle,
                      icon: Icons.exit_to_app_rounded,
                      onPressed: () {
                        AuthService().signOut(context: context);
                      }),
                  const SizedBox(height: 75),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
