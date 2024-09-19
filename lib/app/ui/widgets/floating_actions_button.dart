import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/core/constants/icon_sizes.dart';
import 'package:yemek_soyle_app/app/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/cart_view.dart';

class MainFloatingActionButton extends StatelessWidget {
  const MainFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: AppColor.whiteColor,
      backgroundColor: AppColor.primaryColor,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CartView())).then(
          (value) {
            context.read<SepetSayfaCubit>().sepettekiYemekleriYukle();
          },
        );
      },
      child: const Icon(
        Icons.shopping_cart_sharp,
        size: IconSizes.iconLarge,
      ),
    );
  }
}
