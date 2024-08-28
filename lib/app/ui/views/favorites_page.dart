import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';
import 'package:yemek_soyle_app/app/ui/cubit/favori_sayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/detay_sayfa.dart';
import 'package:yemek_soyle_app/app/ui/widgets/food_card_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavorilerSayfaCubit>().favYemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          centerTitle: true,
          title: Text(
            "Favoriler",
            style: TextStyle(
              color: AppColor.blackColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
                                builder: (context) => DetaySayfa(yemek: yemek),
                              ));
                        },
                        child: FoodCard(
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
                  "Favori Yemek Ekleyiniz...",
                  style: TextStyle(fontSize: 20, color: AppColor.blackColor),
                ),
              );
            }
          },
        ));
  }
}
