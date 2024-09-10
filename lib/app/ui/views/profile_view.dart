// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';
import 'package:yemek_soyle_app/app/ui/views/favorites_view.dart';
import 'package:yemek_soyle_app/app/ui/views/main_tab_view.dart';
import 'package:yemek_soyle_app/app/ui/widgets/lottie_shadow_container_widget.dart';
import 'package:yemek_soyle_app/app/ui/widgets/profile_icon_text_button_widget.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with TickerProviderStateMixin {
  final String _title = "Profile";

  final String _latestOrder = "Geçmiş Siparişleriniz";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(_title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColor.whiteColor, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
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
                          size: 34,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      Text("Hüseyin Sefa Akçay", style: Theme.of(context).textTheme.titleLarge),
                      Text(
                        "hsefakcay@gmail.com",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        "+90 507 XXXX 25",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              spacing: 10,
              children: [
                ProfileIconTextButton(
                    text: "Canlı Destek", icon: Icons.comment_rounded, onPressed: () {}),
                ProfileIconTextButton(
                    text: "Adreslerim", icon: Icons.location_on_outlined, onPressed: () {}),
                ProfileIconTextButton(
                    text: "Favorilerim",
                    icon: Icons.favorite_rounded,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage(
                                  currentIndex: 1,
                                )),
                      );
                    }),
                ProfileIconTextButton(
                    text: _latestOrder, icon: Icons.shopping_cart_outlined, onPressed: () {}),
                ProfileIconTextButton(
                    text: "Ödeme Yöntemlerim", icon: Icons.credit_card_rounded, onPressed: () {}),
                ProfileIconTextButton(
                    text: "İletişim Tercihleri",
                    icon: Icons.notifications_active_rounded,
                    onPressed: () {})
              ],
            ),
          ],
        ),
      ),
    );
  }
}
