import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/data/entity/cart_foods.dart';
import 'package:yemek_soyle_app/app/data/repo/foodsdao_repository.dart';

class CartPageCubit  extends Cubit<List<CartFoods>> {
  CartPageCubit () : super(<CartFoods>[]);

  //yrepo = yemeker Dao Repo nesnesi
  var yrepo = FoodsDaoRepository ();

  Future<void> loadCartFoods() async {
    var list = await yrepo.loadCartFoods();

    emit(list);
  }

  Future<void> addToCart(CartFoods foodToAdd) async {
    await yrepo.addToCart(foodToAdd);
    await loadCartFoods();
  }

  Future<void> removeFromCart(CartFoods foodToRemove) async {
    await yrepo.removeFromCart(foodToRemove);
    await loadCartFoods();
  }
}
