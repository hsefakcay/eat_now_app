import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';
import 'package:yemek_soyle_app/app/data/repo/favoritesdao_repository.dart';
import 'package:yemek_soyle_app/app/ui/cubit/favori_sayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/widgets/food_card_widget.dart';

class FavoriteButtonWidget extends StatefulWidget {
  FavoriteButtonWidget({
    Key? key,
    required this.widget,
    required this.yemek,
    required this.isFavoritePage,
  }) : super(key: key);

  final FoodCardWidget widget;
  final Yemekler yemek;
  bool isFavoritePage;

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButtonWidget> {
  bool isFavorite = false;
  var favRepo = FavoritesRepository();

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
    if (widget.isFavoritePage) {
      isFavorite = true;
    }
  }

  Future<void> _checkIfFavorite() async {
    bool result = await favRepo.favoriYemekMi(widget.yemek.ad);
    setState(() {
      isFavorite = result;
      if (isFavorite) {
        print("${widget.yemek.ad} favori yemek");
      }
    });
  }

  void _toggleFavorite() {
    setState(() {
      if (isFavorite == false) {
        favRepo.favorilereEkle(widget.yemek);
      } else {
        favRepo.favorilerdenSil(widget.yemek.ad);
      }
      isFavorite = !isFavorite;
      //silindiğinde sayfa güncellemesi
      context.read<FavorilerSayfaCubit>().favYemekleriYukle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: AppColor.primaryColor,
        size: widget.widget.mWidth * 0.07,
      ),
      onPressed: _toggleFavorite,
    );
  }
}
