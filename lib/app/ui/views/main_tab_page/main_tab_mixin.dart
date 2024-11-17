import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/ui/views/favorites_page/favorites_view.dart';
import 'package:yemek_soyle_app/app/ui/views/home_page/home_view.dart';
import 'package:yemek_soyle_app/app/ui/views/main_tab_page/main_tab_view.dart';
import 'package:yemek_soyle_app/app/ui/views/profile_page/profile_view.dart';

mixin MainTabMixin on State<MainPage> {
  late int currentIndex;
  final double notchValue = 8;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  final List<Widget> pages = [
    HomeView(),
    FavoritesView(),
    ProfileView(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
