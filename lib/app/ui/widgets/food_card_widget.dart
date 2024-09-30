// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/constants/icon_sizes.dart';
import 'package:yemek_soyle_app/app/core/utils/screen_utility.dart';
import 'package:yemek_soyle_app/app/data/entity/foods.dart';
import 'package:yemek_soyle_app/app/ui/widgets/favorite_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FoodCardWidget extends StatefulWidget {
  Foods yemek;
  bool isFavoritePage;

  FoodCardWidget({
    Key? key,
    required this.yemek,
    required this.isFavoritePage,
  }) : super(key: key);

  @override
  State<FoodCardWidget> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCardWidget> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

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
                width: ScreenUtil.screenWidth(context) * 0.4,
              ),
            ]),
            Positioned(
                top: 0,
                right: 0,
                child: FavoriteButtonWidget(
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.thumb_up,
                  color: Colors.green,
                  size: IconSizes.iconSmall,
                ),
              ),
              Text(
                //defalut atama
                "% 87 ${localizations.liked}",
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
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: AppColor.blackColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.add_circle,
                    color: AppColor.primaryColor,
                    size: IconSizes.iconLarge,
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
