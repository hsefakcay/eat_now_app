import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/constants/icon_sizes.dart';
import 'package:yemek_soyle_app/app/core/utils/screen_utility.dart';
import 'package:yemek_soyle_app/app/ui/views/main_tab_page/main_tab_mixin.dart';
import 'package:yemek_soyle_app/app/ui/widgets/floating_actions_button.dart';

class MainPage extends StatefulWidget {
  final int currentIndex;

  const MainPage({super.key, this.currentIndex = 0});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with MainTabMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentIndex],
        extendBody: true,
        floatingActionButton: MainFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: _bottomAppBar(context, notchValue));
  }


  //BottomNavigationBar widget
  BottomAppBar _bottomAppBar(BuildContext context, double notchValue) {
    return BottomAppBar(
      color: AppColor.whiteColor,
      height: ScreenUtil.screenHeight(context) * 0.08,
      padding: const EdgeInsets.only(bottom: 3),
      shape: const CircularNotchedRectangle(),
      notchMargin: notchValue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(
              currentIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
              size: IconSizes.iconLarge,
              color: AppColor.primaryColor,
            ),
            onPressed: () {
              onTabTapped(0);
            }
          ),
          IconButton(
            icon: Icon(
              currentIndex == 1 ? Icons.favorite : Icons.favorite_outline_rounded,
              size: IconSizes.iconLarge,
              color: AppColor.primaryColor,
            ),
            onPressed: () {
              onTabTapped(1);
            },
          ),
          IconButton(
            icon: Icon(
              currentIndex == 2 ? Icons.person : Icons.person_outline_rounded,
              size: IconSizes.iconLarge,
              color: AppColor.primaryColor,
            ),
            onPressed: () {
              onTabTapped(2);
            },
          ),
          const SizedBox(width: 0),
        ],
      ),
    );
  }
}
