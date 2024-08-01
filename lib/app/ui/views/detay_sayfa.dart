// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/data/entity/sepet_yemekler.dart';

import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';
import 'package:yemek_soyle_app/app/ui/cubit/anasayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/sepet_sayfa.dart';
import 'package:yemek_soyle_app/app/ui/widgets/add_or_remove_button_widget.dart';
import 'package:yemek_soyle_app/app/ui/widgets/detail_chip_widget.dart';

// ignore: must_be_immutable
class DetaySayfa extends StatefulWidget {
  Yemekler yemek;
  DetaySayfa({
    Key? key,
    required this.yemek,
  }) : super(key: key);

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  int siparisAdet = 0;

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
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.sizeOf(context).width;
    var mHeight = MediaQuery.sizeOf(context).height;
    SepetYemekler eklenecekYemek;

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ürün Detayı",
          style: TextStyle(color: AppColor.primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.favorite,
              size: mWidth * 0.08,
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
                      size: mWidth * 0.05,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      //defalut atama
                      "%${int.parse(widget.yemek.id) * 7} Beğenildi",
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    )
                  ],
                ),
                Image.network(
                  "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.resim}",
                  width: mWidth,
                  height: mHeight * 0.35,
                ),
                Text(
                  "₺ ${widget.yemek.fiyat}",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                ),
                Text(
                  widget.yemek.ad,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    addOrRemoveButtonWidget(mWidth: mWidth, process: _decrementSiparisAdet, icon: Icons.remove),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "$siparisAdet",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                    addOrRemoveButtonWidget(mWidth: mWidth, process: _incrementSiparisAdet, icon: Icons.add),
                  ],
                ),
                SizedBox(height: mHeight * 0.05),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DetailChipWidget(text: "25-35 dk"),
                    DetailChipWidget(text: "Ücretsiz Teslimat"),
                    DetailChipWidget(text: "İndirim %10"),
                  ],
                ),
                SizedBox(height: mHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
                        color: AppColor.lightgreyColor,
                      ),
                      width: mWidth * 0.5,
                      height: mHeight * 0.08,
                      child: Center(
                          child: Text(
                        //toplam tutar
                        "₺ ${int.parse(widget.yemek.fiyat) * siparisAdet}",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                        color: AppColor.primaryColor,
                      ),
                      width: mWidth * 0.5,
                      height: mHeight * 0.08,
                      child: Expanded(
                        child: TextButton(
                          child: Text("Sepete Ekle",
                              style: TextStyle(color: AppColor.whiteColor, fontSize: 24, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            if (siparisAdet > 0) {
                              //Sepete ekleme fonksiyonu ve sepet sayfasına gitme
                              eklenecekYemek = SepetYemekler(
                                id: widget.yemek.id,
                                ad: widget.yemek.ad,
                                resim: widget.yemek.resim,
                                fiyat: widget.yemek.fiyat,
                                siparisAdet: siparisAdet.toString(),
                                kullaniciAdi: "hsefakcay",
                              );
                              context.read<SepetSayfaCubit>().sepeteEkle(eklenecekYemek);

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SepetSayfa()),
                              );
                            } else {
                              print("0 adet sipariş girilemez");
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
