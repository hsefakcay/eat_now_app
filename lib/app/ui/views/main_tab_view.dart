import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/constants/icon_sizes.dart';
import 'package:yemek_soyle_app/app/core/utils/screen_utility.dart';
import 'package:yemek_soyle_app/app/ui/views/favorites_view.dart';
import 'package:yemek_soyle_app/app/ui/views/home_view.dart';
import 'package:yemek_soyle_app/app/ui/views/profile_view.dart';
import 'package:yemek_soyle_app/app/ui/widgets/floating_actions_button.dart';

class MainPage extends StatefulWidget {
  final int currentIndex;

  const MainPage({super.key, this.currentIndex = 0});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MainPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex; // `currentIndex`'i `_currentIndex`'e atama
  }

  final List<Widget> _pages = [
    HomeView(),
    FavoritesView(),
    ProfileView(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double _notchValue = 8;

    return Scaffold(
        body: _pages[_currentIndex],
        extendBody: true,
        floatingActionButton: MainFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          color: AppColor.whiteColor,
          height: ScreenUtil.screenHeight(context) * 0.08,
          shape: CircularNotchedRectangle(),
          notchMargin: _notchValue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  _currentIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
                  size: IconSizes.iconLarge,
                  color: AppColor.primaryColor,
                ),
                onPressed: () {
                  _onTabTapped(0);
                },
              ),
              IconButton(
                icon: Icon(
                  _currentIndex == 1 ? Icons.favorite : Icons.favorite_outline_rounded,
                  size: IconSizes.iconLarge,
                  color: AppColor.primaryColor,
                ),
                onPressed: () {
                  _onTabTapped(1);
                },
              ),
              IconButton(
                icon: Icon(
                  _currentIndex == 2 ? Icons.person : Icons.person_outline_rounded,
                  size: IconSizes.iconLarge,
                  color: AppColor.primaryColor,
                ),
                onPressed: () {
                  _onTabTapped(2);
                },
              ),
              const SizedBox(
                width: 0,
              )
            ],
          ),
        ));
  }
}
