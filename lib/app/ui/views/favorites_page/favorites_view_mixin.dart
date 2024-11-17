import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/ui/cubit/favorites_page_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/favorites_page/favorites_view.dart';

mixin FavoritesViewMixin on State<FavoritesView> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesPageCubit>().loadFavoriteFoods();
  }
}
