import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/data/repo/favoritesdao_repository.dart';
import 'package:yemek_soyle_app/app/ui/views/detail_page/detail_view.dart';

mixin DetailViewMixin on State<DetailView> {
  final FavoritesRepository favoritesRepository = FavoritesRepository();
  int siparisAdet = 0;
  final String userName = "hsefakcay";

  bool isFavorite = false;

  void initState() {
    super.initState();
    checkIfFavorite();
  }

  // Favori kontrolü async yapılır
  Future<void> checkIfFavorite() async {
    bool result = await favoritesRepository.isFavoriteFood(widget.food.ad);
    setState(() {
      isFavorite = result;
    });
  }

  // Sipariş adedini artırma fonksiyonu
  void incrementOrderQuantity() {
    setState(() {
      siparisAdet++;
    });
  }

  void decrementOrderQuantity() {
    setState(() {
      if (siparisAdet > 0) {
        siparisAdet--;
      }
    });
  }
}
