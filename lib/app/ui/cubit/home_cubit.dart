import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/data/entity/foods.dart';
import 'package:yemek_soyle_app/app/data/repo/foodsdao_repository.dart';

class HomeCubit extends Cubit<List<Foods>> {
  HomeCubit() : super(<Foods>[]);

  //yrepo = yemeker Dao Repo nesnesi
  var yrepo = FoodsDaoRepository();

  Future<void> loadFoods() async {
    var list = await yrepo.loadFoods();
    emit(list);
  }

  Future<void> searchFoods(String query) async {
    var list = await yrepo.loadFoods();

    if (query.isEmpty) {
      emit(list);
    } else {
      final filteredList = list.where((food) {
        return food.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(filteredList);
    }
  }
}
