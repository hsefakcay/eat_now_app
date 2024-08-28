import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/data/entity/sepet_yemekler.dart';
import 'package:yemek_soyle_app/app/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/home_page.dart';
import 'package:yemek_soyle_app/app/ui/views/main_tab_view.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({super.key});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepettekiYemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.sizeOf(context).width;
    var mHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sepetim",
          style: TextStyle(color: AppColor.blackColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocListener<SepetSayfaCubit, List<SepetYemekler>>(
        listener: (context, state) {
          setState(() {}); // Değişiklik: BlocListener eklendi ve setState çağrıldı.
        },
        child: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
          builder: (context, sepettekiYemeklerListesi) {
            int totalCoast = sepettekiYemeklerListesi.fold(
                0,
                (sum, yemek) =>
                    sum +
                    (int.parse(yemek.fiyat) *
                        int.parse(yemek.siparisAdet))); // Değişiklik: totalCoast hesaplaması buraya taşındı.

            return Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    itemCount: sepettekiYemeklerListesi.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, childAspectRatio: 1 / 0.4, mainAxisSpacing: 10, crossAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      var yemek = sepettekiYemeklerListesi[index];
                      return GestureDetector(
                          onTap: () {},
                          child: Card(
                            color: AppColor.whiteColor,
                            elevation: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.network(
                                        "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.resim}",
                                        width: mWidth * 0.3,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${yemek.ad}",
                                          style: TextStyle(
                                              color: AppColor.blackColor, fontSize: 22, fontWeight: FontWeight.w900),
                                        ),
                                        Text("Fiyat: ₺${yemek.fiyat}",
                                            style: TextStyle(
                                                color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.bold)),
                                        Text("Adet: ${yemek.siparisAdet}",
                                            style: TextStyle(
                                                color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            context.read<SepetSayfaCubit>().sepettenSil(yemek);
                                            context.read<SepetSayfaCubit>().sepettekiYemekleriYukle();
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: mHeight * 0.04,
                                            color: AppColor.primaryColor,
                                          )),
                                      Text(
                                        "₺${int.parse(yemek.fiyat) * int.parse(yemek.siparisAdet)}",
                                        style: TextStyle(
                                            fontSize: 22, fontWeight: FontWeight.w900, color: AppColor.blackColor),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                    },
                  ),
                )),
                Container(
                  height: mHeight * 0.25,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColor.primaryLightColor),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 30, bottom: 10, right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Gönderim Ücreti:",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "₺ 0",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Toplam:",
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "₺${totalCoast}",
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                        SizedBox(height: mHeight * 0.02),
                        Container(
                            decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor.primaryColor),
                            height: mHeight * 0.07,
                            alignment: Alignment.center,
                            child: TextButton(
                              child: Text(
                                "SEPETİ ONAYLA",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.whiteColor),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Siparişiniz hazırlanıyor...",
                                        style: TextStyle(color: AppColor.primaryColor, fontSize: 24),
                                      ),
                                      actions: [
                                        Center(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12), color: AppColor.primaryColor),
                                          child: TextButton(
                                            child: Text("Tamam",
                                                style: TextStyle(color: AppColor.whiteColor, fontSize: 24)),
                                            onPressed: () {
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) => MainPage()));
                                            },
                                          ),
                                        ))
                                      ],
                                    );
                                  },
                                );
                              },
                            ))
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
      backgroundColor: AppColor.whiteColor,
    );
  }
}
