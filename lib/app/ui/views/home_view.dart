import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';
import 'package:yemek_soyle_app/app/core/utils/screen_utility.dart';
import 'package:yemek_soyle_app/app/data/entity/foods.dart';
import 'package:yemek_soyle_app/app/ui/cubit/home_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/detail_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_soyle_app/app/ui/widgets/food_card_widget.dart';
import 'package:yemek_soyle_app/app/ui/widgets/lottie_shadow_container_widget.dart';
import 'package:yemek_soyle_app/app/ui/widgets/search_text_field_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomePageState();
}

class _HomePageState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadFoods();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    var mWidth = ScreenUtil.screenWidth(context);

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(localizations.appName,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColor.whiteColor, fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<HomeCubit, List<Foods>>(
        builder: (context, yemeklerListesi) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: mWidth * 0.78,
                      child: searchFoodTextFieldWidget(),
                    ),
                    Container(
                        decoration: ProjectUtility.primaryColorBoxDecoration,
                        width: mWidth * 0.14,
                        child: _dropDownMenu(mWidth, context, localizations, yemeklerListesi)),
                  ],
                ),
              ),
              Expanded(
                child: yemeklerListesi.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          itemCount: yemeklerListesi.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.6,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            var yemek = yemeklerListesi[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DetailView(yemek: yemek)),
                                );
                              },
                              child: FoodCardWidget(
                                yemek: yemek,
                                isFavoritePage: false,
                              ),
                            );
                          },
                        ),
                      )
                    : Center(child: LottieShadowContainerWidget()),
              ),
            ],
          );
        },
      ),
    );
  }

  DropdownMenu<String> _dropDownMenu(
    double mWidth,
    BuildContext context,
    AppLocalizations localizations,
    List<Foods> yemeklerListesi,
  ) {
    return DropdownMenu(
        menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.resolveWith((
          states,
        ) {
          return AppColor.whiteColor;
        })),
        trailingIcon: Icon(Icons.filter_list_rounded),
        inputDecorationTheme: InputDecorationTheme(suffixIconColor: AppColor.whiteColor),
        width: mWidth * 0.3,
        textStyle: Theme.of(context).textTheme.labelSmall,
        onSelected: (sortType) {
          if (sortType != null) {
            setState(() {
              if (sortType == localizations.sortByPriceAscending) {
                sortCountFood(yemeklerListesi, true);
              } else if (sortType == localizations.sortByPriceDescending) {
                sortCountFood(yemeklerListesi, false);
              } else if (sortType == localizations.sortByAlphabeticalAscending) {
                sortNameFood(yemeklerListesi, true);
              } else if (sortType == localizations.sortByAlphabeticalDescending) {
                sortNameFood(yemeklerListesi, false);
              }
            });
          }
        },
        dropdownMenuEntries: <DropdownMenuEntry<String>>[
          DropdownMenuEntry(
            value: localizations.sortByPriceAscending,
            label: localizations.sortByPriceAscending,
            style: MenuItemButton.styleFrom(
              backgroundColor: Colors.white, //unselected background color,
            ),
          ),
          DropdownMenuEntry(
            value: localizations.sortByPriceDescending,
            label: localizations.sortByPriceDescending,
            style: MenuItemButton.styleFrom(
              backgroundColor: Colors.white, //unselected background color,
            ),
          ),
          DropdownMenuEntry(
            value: localizations.sortByAlphabeticalAscending,
            label: localizations.sortByAlphabeticalAscending,
            style: MenuItemButton.styleFrom(
              backgroundColor: Colors.white, //unselected background color,
            ),
          ),
          DropdownMenuEntry(
            value: localizations.sortByAlphabeticalDescending,
            label: localizations.sortByAlphabeticalDescending,
            style: MenuItemButton.styleFrom(
              backgroundColor: Colors.white, //unselected background color,
            ),
          ),
        ]);
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
}
