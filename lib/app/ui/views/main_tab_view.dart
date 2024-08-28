import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/ui/views/favorites_page.dart';
import 'package:yemek_soyle_app/app/ui/views/home_page.dart';
import 'package:yemek_soyle_app/app/ui/views/profile_page.dart';
import 'package:yemek_soyle_app/app/ui/widgets/floating_actions_button.dart';

class MainPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: _pages[_currentIndex],
        extendBody: true,
        floatingActionButton: MainFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          color: AppColor.whiteColor,
          height: mHeight * 0.08,
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  _currentIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
                  size: mHeight * 0.04,
                  color: AppColor.primaryColor,
                ),
                onPressed: () {
                  _onTabTapped(0);
                },
              ),
              IconButton(
                icon: Icon(
                  _currentIndex == 1 ? Icons.favorite : Icons.favorite_outline_rounded,
                  size: mHeight * 0.04,
                  color: AppColor.primaryColor,
                ),
                onPressed: () {
                  _onTabTapped(1);
                },
              ),
              IconButton(
                icon: Icon(
                  _currentIndex == 2 ? Icons.person : Icons.person_outline_rounded,
                  size: mHeight * 0.04,
                  color: AppColor.primaryColor,
                ),
                onPressed: () {
                  _onTabTapped(2);
                },
              ),
              SizedBox(
                width: 0,
              )
            ],
          ),
        ));
  }
}
