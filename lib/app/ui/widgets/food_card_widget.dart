// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';
import 'package:yemek_soyle_app/app/data/repo/favoritesdao_repository.dart';
import 'package:yemek_soyle_app/app/ui/cubit/favori_sayfa_cubit.dart';

class FoodCard extends StatefulWidget {
  Yemekler yemek;
  double mWidth;
  bool isFavoritePage;

  FoodCard({
    Key? key,
    required this.yemek,
    required this.mWidth,
    required this.isFavoritePage,
  }) : super(key: key);

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: AppColor.whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Image.network(
                "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.resim}",
                width: widget.mWidth * 0.4,
              ),
            ]),
            Positioned(
                top: 0,
                right: 0,
                child: FavoriteButton(
                  widget: widget,
                  yemek: widget.yemek,
                  isFavoritePage: widget.isFavoritePage,
                )),
          ]),
          Text(
            "${widget.yemek.ad}",
            style: TextStyle(color: AppColor.blackColor, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.thumb_up,
                color: Colors.green,
                size: widget.mWidth * 0.05,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                //defalut atama
                "% 87 Beğenildi",
                style: TextStyle(color: Colors.green, fontSize: 13),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "₺ ${widget.yemek.fiyat}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColor.blackColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.add_circle,
                    color: AppColor.primaryColor,
                    size: widget.mWidth * 0.085,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  FavoriteButton({
    Key? key,
    required this.widget,
    required this.yemek,
    required this.isFavoritePage,
  }) : super(key: key);

  final FoodCard widget;
  final Yemekler yemek;
  bool isFavoritePage;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
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
