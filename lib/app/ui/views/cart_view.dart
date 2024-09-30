import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/data/entity/cart_foods.dart';
import 'package:yemek_soyle_app/app/ui/cubit/cart_page_cubit.dart';
import 'package:yemek_soyle_app/app/ui/widgets/cart_card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_soyle_app/app/ui/widgets/order_summary_widget.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    context.read<CartPageCubit >().loadCartFoods();
  }

  @override
  Widget build(BuildContext context) {
    
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(localizations.cartViewTitle,
            style:
                Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
      ),
      backgroundColor: AppColor.whiteColor,
      body: BlocListener<CartPageCubit , List<CartFoods>>(
        listener: (context, state) {
          setState(() {}); // Değişiklik: BlocListener eklendi ve setState çağrıldı.
        },
        child: BlocBuilder<CartPageCubit , List<CartFoods>>(
          builder: (context, sepettekiYemeklerListesi) {
            int totalCoast = sepettekiYemeklerListesi.fold(
                0, (sum, yemek) => sum + (int.parse(yemek.fiyat) * int.parse(yemek.siparisAdet)));

            return Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    itemCount: sepettekiYemeklerListesi.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1 / 0.4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      var yemek = sepettekiYemeklerListesi[index];
                      return CartCardWidget(yemek: yemek);
                    },
                  ),
                )),
                OrderSummaryWidget(totalCoast: totalCoast)
              ],
            );
          },
        ),
      ),
    );
  }
}
