import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/constants/icon_sizes.dart';
import 'package:yemek_soyle_app/app/core/utils/screen_utility.dart';
import 'package:yemek_soyle_app/app/data/entity/cart_foods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_soyle_app/app/data/entity/foods.dart';
import 'package:yemek_soyle_app/app/data/repo/favoritesdao_repository.dart';
import 'package:yemek_soyle_app/app/ui/cubit/cart_page_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/cart_view.dart';
import 'package:yemek_soyle_app/app/ui/widgets/add_or_remove_button_widget.dart';
import 'package:yemek_soyle_app/app/ui/widgets/detail_chip_widget.dart';
import 'package:yemek_soyle_app/app/ui/widgets/favorite_button_widget.dart';
import 'package:yemek_soyle_app/app/ui/widgets/food_image_widget.dart';

class DetailView extends StatefulWidget {
  final Foods food; // Immutable olmalı

  const DetailView({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  int siparisAdet = 0;
  bool isFavorite = false;

  final FavoritesRepository favoritesRepository = FavoritesRepository();

  final String _userName = "hsefakcay";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfFavorite();
  }

  // Favori kontrolü async yapılır
  Future<void> _checkIfFavorite() async {
    bool result = await favoritesRepository.isFavoriteFood(widget.food.ad);
    setState(() {
      isFavorite = result;
    });
  }

  // Sipariş adedini artırma fonksiyonu
  void _incrementOrderQuantity() {
    setState(() {
      siparisAdet++;
    });
  }

  void _decrementOrderQuantity() {
    setState(() {
      if (siparisAdet > 0) {
        siparisAdet--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    var height = ScreenUtil.screenHeight(context);
    var width = ScreenUtil.screenWidth(context);

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        title: Text(
          localizations.productDetailTitle,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: FavoriteButtonWidget(yemek: widget.food, isFavoritePage: false),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: height * 0.05),
            _favoriteInfoRow(localizations),
            FoodImage(height: height, name: widget.food.resim),
            _foodDetails(context),
            _orderQuantityRow(context),
            SizedBox(height: height * 0.05),
            _detailChips(localizations),
            SizedBox(height: height * 0.05),
            _totalPriceText(width, height, localizations, context),
          ],
        ),
      ),
    );
  }

//siparişin toplam fiyatını gösteren text
  Row _totalPriceText(
      double width, double height, AppLocalizations localizations, BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width * 0.5,
          child: Center(
            child: Text(
              //toplam tutar
              "₺ ${int.parse(widget.food.fiyat) * siparisAdet}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        _addToCartButton(height, width, localizations, context)
      ],
    );
  }

// Sipariş adedini değiştirme butonları
  Row _orderQuantityRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AddOrRemoveButtonWidget(process: _decrementOrderQuantity, icon: Icons.remove),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "$siparisAdet",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        AddOrRemoveButtonWidget(process: _incrementOrderQuantity, icon: Icons.add),
      ],
    );
  }

  SizedBox _addToCartButton(
      double height, double width, AppLocalizations localizations, BuildContext context) {
    return SizedBox(
      height: height * 0.08,
      width: width * 0.5,
      child: Expanded(
        child: ElevatedButton(
          child: Text(localizations.addToCart,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: AppColor.whiteColor, fontWeight: FontWeight.bold)),
          onPressed: () {
            if (siparisAdet > 0) {
              //Sepete ekleme fonksiyonu ve sepet sayfasına gitme

              final cartItem = CartFoods(
                id: widget.food.id,
                ad: widget.food.ad,
                resim: widget.food.resim,
                fiyat: widget.food.fiyat,
                siparisAdet: siparisAdet.toString(),
                kullaniciAdi: _userName,
              );
              context.read<CartPageCubit>().addToCart(cartItem);

              Navigator.push(
                context,
                MaterialPageRoute<CartView>(builder: (context) => const CartView()),
              );
            } else {
              _showSnackbar(context, localizations);
            }
          },
        ),
      ),
    );
  }

  // Snackbar gösterimi
  void _showSnackbar(BuildContext context, AppLocalizations localizations) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        localizations.snackBarTitleZeroOrder,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      behavior: SnackBarBehavior.fixed,
      duration: Durations.long4,
      backgroundColor: AppColor.primaryLightColor,
    ));
  }

  // Favori bilgisi gösterimi
  Row _favoriteInfoRow(AppLocalizations localizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.thumb_up, color: Colors.green, size: IconSizes.iconMedium),
        const SizedBox(width: 5),
        Text(
          "% 87 ${localizations.liked}",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.green),
        )
      ],
    );
  } // Ürün resmi gösterimi

  // Ürün bilgileri gösterimi
  Column _foodDetails(BuildContext context) {
    return Column(
      children: [
        Text(widget.food.ad,
            style:
                Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold)),
        Text("₺ ${widget.food.fiyat}",
            style:
                Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Detay bilgilerini gösteren Chip'ler
  Row _detailChips(AppLocalizations localizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DetailChipWidget(text: localizations.deliveryTime),
        DetailChipWidget(text: localizations.freeDelivery),
        DetailChipWidget(text: localizations.discount),
      ],
    );
  }
}
