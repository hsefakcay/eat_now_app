import 'package:yemek_soyle_app/app/data/entity/foods.dart';
import 'package:yemek_soyle_app/assets/database/sqlite/database_helper.dart';

class FavoritesRepository {
  Future<List<Foods>> loadFavoriteFoods() async {
    var db = await DatabaseHelper.accesToDatabase();
    // Delete rows where 'ad' is null
    await db.rawDelete("DELETE FROM favori_yemekler WHERE ad IS NULL");

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM favori_yemekler");

    if (maps.isEmpty) {
      print("MAPS EMPTY");
    } else {
      print("MAPS NOT EMPTY");
    }

    return List.generate(
      maps.length,
      (index) {
        var row = maps[index];
        return Foods(
            id: row["id"].toString(),
            ad: row["ad"].toString(),
            resim: row["resim"].toString(),
            fiyat: row["fiyat"].toString());
      },
    );
  }

  Future<void> addToFavorites(Foods food) async {
    var db = await DatabaseHelper.accesToDatabase();

    var favoriteFood = Map<String, dynamic>();
    favoriteFood["ad"] = food.ad;
    favoriteFood["resim"] = food.resim;
    favoriteFood["fiyat"] = int.parse(food.fiyat);

    await db.insert("favori_yemekler", favoriteFood);
  }

  Future<void> removeFromFavorites(String foodName) async {
    var db = await DatabaseHelper.accesToDatabase();

    await db.delete("favori_yemekler", where: "ad = ?", whereArgs: [foodName]);
  }

  Future<bool> isFavoriteFood(String foodName) async {
    var db = await DatabaseHelper.accesToDatabase();

    List<Map<String, dynamic>> result =
        await db.query("favori_yemekler", where: "ad = ?", whereArgs: [foodName]);
    // If the result list is not empty, the food is in favorites.
    return result.isNotEmpty;
  }
}
