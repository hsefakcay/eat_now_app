import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_soyle_app/app/core/constants/icon_sizes.dart';
import 'package:yemek_soyle_app/app/ui/cubit/home_cubit.dart';

class searchFoodTextFieldWidget extends StatelessWidget {
  const searchFoodTextFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return TextField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: localizations.searchInFoodSoyle,
          prefixIcon: const Icon(
            Icons.search,
            size: IconSizes.iconMedium,
          ),
          filled: true,
          fillColor: Colors.black12,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        onChanged: (value) {
          context.read<HomeCubit>().searchFoods(value);
        });
  }
}
