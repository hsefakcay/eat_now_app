import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';
import 'package:yemek_soyle_app/app/ui/cubit/anasayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/detay_sayfa.dart';

import 'package:yemek_soyle_app/app/ui/views/sepet_sayfa.dart';
import 'package:yemek_soyle_app/app/ui/widgets/floating_actions_button.dart';
import 'package:yemek_soyle_app/app/ui/widgets/food_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  String dropdownValue = "Alfabetik Artan"; // Varsayılan değer
  List<String> dropDownList = <String>[
    'Alfabetik Artan',
    'Alfabetik Azalan',
    'Fiyat Artan',
    'Fiyat Azalan',
  ];

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: const Text("Yemek Söyle",
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24, fontStyle: FontStyle.italic)),
      ),
      body: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
        builder: (context, yemeklerListesi) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: mWidth * 0.68,
                      child: TextField(
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: "Yemek Söyle'de Ara",
                            prefixIcon: Icon(
                              Icons.search,
                              size: 32,
                            ),
                            filled: true,
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          onChanged: (value) {
                            context.read<AnasayfaCubit>().searchFoods(value);
                          }),
                    ),
                    Container(
                      width: mWidth * 0.25,
                      height: mWidth * 0.13,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButton<String>(
                        alignment: Alignment.center,
                        icon: Icon(
                          Icons.filter_list,
                          color: AppColor.whiteColor,
                        ),
                        value: null,
                        hint: Text(
                          "  Sırala",
                          style: TextStyle(fontSize: 16, color: AppColor.whiteColor),
                        ),
                        // Text stilini burada belirtiyorsunuz
                        onChanged: (String? newValue) {
                          setState(() {
                            if (newValue == "Fiyat Artan") {
                              sortCountFood(yemeklerListesi, true);
                            } else if (newValue == "Fiyat Azalan") {
                              sortCountFood(yemeklerListesi, false);
                            } else if (newValue == "Alfabetik Artan") {
                              sortNameFood(yemeklerListesi, true);
                            } else if (newValue == "Alfabetik Azalan") {
                              sortNameFood(yemeklerListesi, false);
                            }
                            dropdownValue = newValue!;
                          });
                        },
                        items: dropDownList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.black), // Text stilini burada belirtiyorsunuz
                            ),
                          );
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
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.6,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            var yemek = yemeklerListesi[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetaySayfa(yemek: yemek),
                                  ),
                                );
                              },
                              child: FoodCard(
                                yemek: yemek,
                                mWidth: mWidth,
                                isFavoritePage: false,
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          "Yükleniyor...",
                          style: TextStyle(fontSize: 20, color: AppColor.blackColor),
                        ),
                      ),
              ),
            ],
          );
        },
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
