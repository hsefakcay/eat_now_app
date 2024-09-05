import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/constants/project_keys.dart';
import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';
import 'package:yemek_soyle_app/app/ui/cubit/favori_sayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/detail_view.dart';
import 'package:yemek_soyle_app/app/ui/widgets/food_card_widget.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesView> {
  final String _title = "Favoriler";

  @override
  void initState() {
    super.initState();
    context.read<FavorilerSayfaCubit>().favYemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(_title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold))),
        body: BlocBuilder<FavorilerSayfaCubit, List<Yemekler>>(
          builder: (context, favYemeklerListesi) {
            if (favYemeklerListesi.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: favYemeklerListesi.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.5,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    var yemek = favYemeklerListesi[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailView(yemek: yemek),
                              ));
                        },
                        child: FoodCardWidget(
                          yemek: yemek,
                          mWidth: mWidth,
                          isFavoritePage: true,
                        ));
                  },
                ),
              );
            } else {
              return Center(
                child: Text(
                  ProjectKeys().addFavoriteFood,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            }
          },
        ));
  }
}
