import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/data/entity/cart_foods.dart';
import 'package:yemek_soyle_app/app/ui/cubit/cart_page_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/cart_page/car_page_mixin.dart';
import 'package:yemek_soyle_app/app/ui/views/cart_page/widgets/cart_card_widget.dart';
import 'package:yemek_soyle_app/app/ui/views/cart_page/widgets/order_summary_widget.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> with CarPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: _appBarTitleText(context)),
      backgroundColor: AppColor.whiteColor,
      body: BlocListener<CartPageCubit, List<CartFoods>>(
        listener: (context, state) {
          setState(() {}); // Değişiklik: BlocListener eklendi ve setState çağrıldı.
        },
        child: BlocBuilder<CartPageCubit, List<CartFoods>>(
          builder: (context, cartFoodList) {
            int totalCoast = cartFoodList.fold(
                0, (sum, food) => sum + (int.parse(food.fiyat) * int.parse(food.siparisAdet)));

            return Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                    itemCount: cartFoodList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1 / 0.4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      final food = cartFoodList[index];
                      return CartCardWidget(food: food);
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

  Text _appBarTitleText(BuildContext context) {
    return Text(localization().cartViewTitle,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold));
  }
}
