// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/constants/icon_sizes.dart';
import 'package:yemek_soyle_app/app/data/entity/sepet_yemekler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';
import 'package:yemek_soyle_app/app/data/repo/favoritesdao_repository.dart';
import 'package:yemek_soyle_app/app/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/cart_view.dart';
import 'package:yemek_soyle_app/app/ui/widgets/add_or_remove_button_widget.dart';
import 'package:yemek_soyle_app/app/ui/widgets/detail_chip_widget.dart';

// ignore: must_be_immutable
class DetailView extends StatefulWidget {
  Yemekler yemek;
  DetailView({
    Key? key,
    required this.yemek,
  }) : super(key: key);

  @override
  State<DetailView> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetailView> {
  int siparisAdet = 0;
  bool isFavorite = false;
  var favRepo = FavoritesRepository();

  final String _userName = "hsefakcay";

  void _incrementSiparisAdet() {
    setState(() {
      siparisAdet++;
    });
  }

  void _decrementSiparisAdet() {
    setState(() {
      if (siparisAdet > 0) {
        siparisAdet--;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    bool result = await favRepo.favoriYemekMi(widget.yemek.ad);
    setState(() {
      isFavorite = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    var mWidth = MediaQuery.sizeOf(context).width;
    var mHeight = MediaQuery.sizeOf(context).height;
    SepetYemekler eklenecekYemek;

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
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: IconSizes.iconLarge,
                color: AppColor.primaryColor,
              ),
              onPressed: () async {
                if (isFavorite) {
                  await favRepo.favorilerdenSil(widget.yemek.ad);
                } else {
                  await favRepo.favorilereEkle(widget.yemek);
                }
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          )
        ],
      ),
      body: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
        builder: (context, sepettekiYemekler) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: mHeight * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: Colors.green,
                      size: IconSizes.iconMedium,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      //defalut atama
                      "% 87 ${localizations.liked}",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.green),
                    )
                  ],
                ),
                Image.network(
                  "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.resim}",
                  width: mWidth,
                  height: mHeight * 0.35,
                ),
                Text(widget.yemek.ad,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text(
                  "₺ ${widget.yemek.fiyat}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    addOrRemoveButtonWidget(
                        mWidth: mWidth, process: _decrementSiparisAdet, icon: Icons.remove),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "$siparisAdet",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    addOrRemoveButtonWidget(
                        mWidth: mWidth, process: _incrementSiparisAdet, icon: Icons.add),
                  ],
                ),
                SizedBox(height: mHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DetailChipWidget(text: localizations.deliveryTime),
                    DetailChipWidget(text: localizations.freeDelivery),
                    DetailChipWidget(text: localizations.discount),
                  ],
                ),
                SizedBox(height: mHeight * 0.05),
                Row(
                  children: [
                    SizedBox(
                      width: mWidth * 0.5,
                      child: Center(
                        child: Text(
                          //toplam tutar
                          "₺ ${int.parse(widget.yemek.fiyat) * siparisAdet}",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mHeight * 0.08,
                      width: mWidth * 0.5,
                      child: Expanded(
                        child: ElevatedButton(
                          child: Text(localizations.addToCart,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: AppColor.whiteColor, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            if (siparisAdet > 0) {
                              //Sepete ekleme fonksiyonu ve sepet sayfasına gitme

                              eklenecekYemek = SepetYemekler(
                                id: widget.yemek.id,
                                ad: widget.yemek.ad,
                                resim: widget.yemek.resim,
                                fiyat: widget.yemek.fiyat,
                                siparisAdet: siparisAdet.toString(),
                                kullaniciAdi: _userName,
                              );
                              context.read<SepetSayfaCubit>().sepeteEkle(eklenecekYemek);

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CartView()),
                              );
                            } else {
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
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
