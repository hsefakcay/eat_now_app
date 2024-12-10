import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/data/entity/foods.dart';
import 'package:yemek_soyle_app/app/ui/cubit/favorites_page_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/detail_page/detail_view.dart';
import 'package:yemek_soyle_app/app/ui/views/favorites_page/favorites_view_mixin.dart';
import 'package:yemek_soyle_app/app/product/widgets/food_card_widget.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesView> with FavoritesViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: _favoritesText(context),
        ),
        body: BlocBuilder<FavoritesPageCubit, List<Foods>>(
          builder: (context, favFoodList) {
            if (favFoodList.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  itemCount: favFoodList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.5,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    var food = favFoodList[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<DetailView>(
                                builder: (context) => DetailView(food: food),
                              ));
                        },
                        child: FoodCardWidget(food: food, isFavoritePage: true));
                  },
                ),
              );
            } else {
              return Center(
                child: _addFavoriteFoodText(context),
              );
            }
          },
        ));
  }

  Text _favoritesText(BuildContext context) {
    return Text(AppLocalizations.of(context)!.favorites,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold));
  }

  Text _addFavoriteFoodText(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.addFavoriteFood,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
