import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';
import 'package:yemek_soyle_app/app/data/entity/foods.dart';
import 'package:yemek_soyle_app/app/ui/cubit/home_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/detail_page/detail_view.dart';
import 'package:yemek_soyle_app/app/ui/views/home_page/home_view_mixin.dart';
import 'package:yemek_soyle_app/app/product/widgets/food_card_widget.dart';
import 'package:yemek_soyle_app/app/product/widgets/lottie_shadow_container_widget.dart';
import 'package:yemek_soyle_app/app/product/widgets/search_text_field_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomePageState();
}

class _HomePageState extends State<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(localization().appName,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColor.whiteColor, fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<HomeCubit, List<Foods>>(
        builder: (context, foodList) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: getWidth() * 0.78,
                      child: const searchFoodTextFieldWidget(),
                    ),
                    Container(
                        decoration: ProjectUtility.primaryColorBoxDecoration,
                        width: getWidth() * 0.14,
                        child: _dropDownMenu(getWidth(), context, localization(), foodList)),
                  ],
                ),
              ),
              Expanded(
                child: foodList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          itemCount: foodList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.6,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            final yemek = foodList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<DetailView>(
                                      builder: (context) => DetailView(food: yemek)),
                                );
                              },
                              child: FoodCardWidget(food: yemek, isFavoritePage: false),
                            );
                          },
                        ),
                      )
                    : const Center(child: LottieShadowContainerWidget()),
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
    List<Foods> foodsList,
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
          sortFoods(sortType, foodsList);
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
}
