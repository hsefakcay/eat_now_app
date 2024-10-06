// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:yemek_soyle_app/app/data/entity/cart_foods.dart';

class CartFoodsResponse {
  List<CartFoods> cartFoods;
  int success;

  CartFoodsResponse({required this.cartFoods, required this.success});

  factory CartFoodsResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List;
    var success = json["success"] as int;

    var yemekler = (jsonArray)
        .map((jsonArrayNesnesi) => CartFoods.fromJson(jsonArrayNesnesi as Map<String, dynamic>))
        .toList();

    return CartFoodsResponse(cartFoods: yemekler, success: success);
  }
}
