import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yemek_soyle_app/app/ui/cubit/cart_page_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/cart_page/cart_view.dart';

mixin CarPageMixin on State<CartView> {
  AppLocalizations localization() {
    return AppLocalizations.of(context)!;
  }

  @override
  void initState() {
    super.initState();
    context.read<CartPageCubit>().loadCartFoods();
  }
}
