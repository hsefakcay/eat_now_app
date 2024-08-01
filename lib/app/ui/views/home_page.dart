import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';
import 'package:yemek_soyle_app/app/ui/cubit/anasayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/detay_sayfa.dart';
import 'package:yemek_soyle_app/app/ui/views/favorites_page.dart';
import 'package:yemek_soyle_app/app/ui/views/profile_page.dart';
import 'package:yemek_soyle_app/app/ui/views/sepet_sayfa.dart';
import 'package:yemek_soyle_app/app/ui/widgets/food_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<HomePage> {
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  List<String> list = <String>[
    'Alfabetik Artan',
    'Alfabetik Azalan',
    'Fiyat Artan',
    'Fiyat Azalan',
  ];

  @override
  Widget build(BuildContext context) {
    String dropdownValue = "";

    var mWidth = MediaQuery.sizeOf(context).width;
    int _currentIndex = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: const Text("Yemek Söyle", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
        builder: (context, yemeklerListesi) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: mWidth * 0.7,
                      child: const TextField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: " Ara",
                            suffixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)))),
                      ),
                    ),
                    SizedBox(
                      child: DropdownMenu<String>(
                        hintText: "Sırala",
                        textStyle: TextStyle(fontSize: 12),
                        width: mWidth * 0.25,
                        onSelected: (String? value) {
                          setState(() {
                            if (value == "Fiyat Artan") {
                              sortCountFood(yemeklerListesi, true);
                            } else if (value == "Fiyat Azalan") {
                              sortCountFood(yemeklerListesi, false);
                            } else if (value == "Alfabetik Artan") {
                              sortNameFood(yemeklerListesi, true);
                            } else if (value == "Alfabetik Azalan") {
                              sortNameFood(yemeklerListesi, false);
                            }
                            dropdownValue = value!;
                          });
                        },
                        dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(value: value, label: value);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: yemeklerListesi.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          itemCount: yemeklerListesi.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1 / 1.4, mainAxisSpacing: 10, crossAxisSpacing: 5),
                          itemBuilder: (context, index) {
                            var yemek = yemeklerListesi[index];
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetaySayfa(yemek: yemek),
                                      ));
                                },
                                child: FoodCard(yemek: yemek, mWidth: mWidth));
                          },
                        ),
                      )
                    : Center(child: Text("Yemekler Listesi Yüklenemedi")),
              ),
            ],
          );
        },
      ),

      //sepete gitmek için floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.yellow,
        backgroundColor: AppColor.primaryColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SepetSayfa())).then(
            (value) {
              context.read<SepetSayfaCubit>().sepettekiYemekleriYukle();
            },
          );
        },
        child: const Icon(
          Icons.shopping_cart_rounded,
          size: 40,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        currentIndex: _currentIndex,
        unselectedItemColor: AppColor.primaryColor,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          if (index == 0) {
            setState(() {
              _currentIndex = 0;
            });
          } else if (index == 1) {
            setState(() {
              _currentIndex = 1;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritesPage(),
                  ));
            });
          } else {
            setState(() {
              _currentIndex = 2;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ));
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: "Anasayfa"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 22,
              ),
              label: "Favoriler"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_rounded,
                size: 22,
              ),
              label: "Profil"),
        ],
      ),
    );
  }

  void sortNameFood(List<Yemekler> yemeklerListesi, bool isDesc) {
    Comparator<Yemekler> sortName;
    if (isDesc == true) {
      sortName = (a, b) => a.ad.compareTo(b.ad);
    } else {
      sortName = (a, b) => b.ad.compareTo(a.ad);
    }
    yemeklerListesi.sort(sortName);
  }

  void sortCountFood(List<Yemekler> yemeklerListesi, bool isDesc) {
    Comparator<Yemekler> sortName;

    if (isDesc == true) {
      sortName = (a, b) => (int.parse(a.fiyat)).compareTo(int.parse(b.fiyat));
    } else {
      sortName = (a, b) => (int.parse(b.fiyat)).compareTo(int.parse(a.fiyat));
    }
    yemeklerListesi.sort(sortName);
  }
}
