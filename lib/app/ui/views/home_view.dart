import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/constants/project_keys.dart';
import 'package:yemek_soyle_app/app/core/utils/project_utility.dart';
import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';
import 'package:yemek_soyle_app/app/ui/cubit/anasayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/detail_view.dart';

import 'package:yemek_soyle_app/app/ui/views/cart_view.dart';
import 'package:yemek_soyle_app/app/ui/widgets/floating_actions_button.dart';
import 'package:yemek_soyle_app/app/ui/widgets/food_card_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomePageState();
}

class _HomePageState extends State<HomeView> {
  final String _title = "Yemek Söyle";
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
        automaticallyImplyLeading: false,
        title: Text(_title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColor.whiteColor, fontWeight: FontWeight.bold)),
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
                      width: mWidth * 0.65,
                      child: TextField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: ProjectKeys().searchInYemekSoyle,
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 32,
                            ),
                            filled: true,
                            fillColor: Colors.black12,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          onChanged: (value) {
                            context.read<AnasayfaCubit>().searchFoods(value);
                          }),
                    ),
                    Container(
                      width: mWidth * 0.28,
                      height: mWidth * 0.13,
                      decoration: ProjectUtility.primaryColorBoxDecoration,
                      child: DropdownButton<String>(
                        alignment: Alignment.center,
                        icon: Icon(
                          Icons.filter_list,
                          color: AppColor.whiteColor,
                        ),
                        value: null,
                        hint: Text(
                          ProjectKeys().sort,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColor.whiteColor),
                        ),
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
                            child: Text(value,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall // Text stilini burada belirtiyorsunuz
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
                                  MaterialPageRoute(builder: (context) => DetailView(yemek: yemek)),
                                );
                              },
                              child: FoodCardWidget(
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
                          ProjectKeys().loading,
                          style: Theme.of(context).textTheme.headlineSmall,
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
