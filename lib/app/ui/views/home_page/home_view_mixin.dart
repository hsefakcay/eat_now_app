import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_soyle_app/app/core/utils/screen_utility.dart';
import 'package:yemek_soyle_app/app/data/entity/foods.dart';
import 'package:yemek_soyle_app/app/ui/cubit/home_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/home_page/home_view.dart';

mixin HomeViewMixin on State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadFoods();
  }

  AppLocalizations localization() {
    return AppLocalizations.of(context)!;
  }

  double getWidth() {
    return ScreenUtil.screenWidth(context);
  }

  void sortNameFood(List<Foods> yemeklerListesi, bool isDesc) {
    Comparator<Foods> sortName;
    if (isDesc == true) {
      sortName = (a, b) => a.ad.compareTo(b.ad);
    } else {
      sortName = (a, b) => b.ad.compareTo(a.ad);
    }
    yemeklerListesi.sort(sortName);
  }

  void sortCountFood(List<Foods> yemeklerListesi, bool isDesc) {
    Comparator<Foods> sortName;

    if (isDesc == true) {
      sortName = (a, b) => (int.parse(a.fiyat)).compareTo(int.parse(b.fiyat));
    } else {
      sortName = (a, b) => (int.parse(b.fiyat)).compareTo(int.parse(a.fiyat));
    }
    yemeklerListesi.sort(sortName);
  }

  void sortFoods(String? sortType, List<Foods> foodsList) {
    if (sortType != null) {
      setState(() {
        if (sortType == localization().sortByPriceAscending) {
          sortCountFood(foodsList, true);
        } else if (sortType == localization().sortByPriceDescending) {
          sortCountFood(foodsList, false);
        } else if (sortType == localization().sortByAlphabeticalAscending) {
          sortNameFood(foodsList, true);
        } else if (sortType == localization().sortByAlphabeticalDescending) {
          sortNameFood(foodsList, false);
        }
      });
    }
  }
}
