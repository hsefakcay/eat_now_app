import 'package:yemek_soyle_app/app/data/entity/foods.dart';

class FoodsResponse {
  List<Foods> foods;
  int success;

  FoodsResponse({required this.foods, required this.success});

  factory FoodsResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["yemekler"] as List;
    var success = json["success"] as int;

    var foodsList = (jsonArray)
        .map((jsonArrayObject) => Foods.fromJson(jsonArrayObject as Map<String, dynamic>))
        .toList();

    return FoodsResponse(foods: foodsList, success: success);
  }
}
