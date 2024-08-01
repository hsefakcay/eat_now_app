import 'package:flutter/material.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key,
    required this.yemek,
    required this.mWidth,
  });

  final Yemekler yemek;
  final double mWidth;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Image.network(
                "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.resim}",
                width: mWidth * 0.4,
              ),
            ]),
            Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                    icon: Icon(Icons.favorite_border_rounded, size: mWidth * 0.07),
                    onPressed: () {
                      // Favori butonuna tıklama işlemi
                    })),
          ]),
          Text(
            "${yemek.ad}",
            style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.thumb_up,
                color: Colors.green,
                size: mWidth * 0.05,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                //defalut atama
                "%${int.parse(yemek.id) * 7} Beğenildi",
                style: TextStyle(color: Colors.green, fontSize: 13),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "₺ ${yemek.fiyat}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.add_box_rounded,
                    color: AppColor.primaryColor,
                    size: mWidth * 0.07,
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
