import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/data/repo/favoritesdao_repository.dart';
import 'package:yemek_soyle_app/app/ui/views/detail_page/detail_view.dart';

mixin DetailViewMixin on State<DetailView> {
  final FavoritesRepository favoritesRepository = FavoritesRepository();
  int orderQuantity = 0;
  final String userName = 'hsefakcay';

  bool isFavorite = false;

  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  // Favori kontrolü async yapılır
  Future<void> _checkFavoriteStatus() async {
    try {
      final bool result = await favoritesRepository.isFavoriteFood(widget.food.name);
      setState(() {
        isFavorite = result;
      });
    } catch (e) {
      debugPrint('Error checking favorite status: $e');
    }
  }

  // Sipariş adedini artırma fonksiyonu
  void incrementOrderQuantity() {
    setState(() {
      orderQuantity++;
    });
  }

  void decrementOrderQuantity() {
    setState(() {
      if (orderQuantity > 0) {
        orderQuantity--;
      }
    });
  }
}
