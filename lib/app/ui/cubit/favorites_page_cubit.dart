import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/data/entity/foods.dart';
import 'package:yemek_soyle_app/app/data/repo/favoritesdao_repository.dart';

class FavoritesPageCubit extends Cubit<List<Foods>> {
  FavoritesPageCubit() : super(<Foods>[]);

  //yrepo = yemeker Dao Repo nesnesi
  var favsRepo = FavoritesRepository();

  Future<void> loadFavoriteFoods() async {
    var list = await favsRepo.loadFavoriteFoods();
    emit(list);
  }
}
