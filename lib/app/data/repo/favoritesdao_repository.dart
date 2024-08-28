import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';
import 'package:yemek_soyle_app/sqlite/database_helper.dart';

class FavoritesRepository {
  Future<List<Yemekler>> favoriYemekleriYukle() async {
    var db = await DatabaseHelper.accesToDatabase();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM favori_yemekler");
    if (maps.isEmpty) {
      print("MAPS BOŞ");
    }

    return List.generate(
      maps.length,
      (index) {
        var row = maps[index];
        return Yemekler(id: row["id"].toString(), ad: row["ad"], resim: row["resim"], fiyat: row["fiyat"].toString());
      },
    );
  }

  Future<void> favorilereEkle(Yemekler yemek) async {
    var db = await DatabaseHelper.accesToDatabase();

    var favYemek = Map<String, dynamic>();
    favYemek["ad"] = yemek.ad;
    favYemek["resim"] = yemek.resim;
    favYemek["fiyat"] = int.parse(yemek.fiyat);

    await db.insert("favori_yemekler", favYemek);
  }

  Future<void> favorilerdenSil(String yemekAdi) async {
    var db = await DatabaseHelper.accesToDatabase();

    await db.delete("favori_yemekler", where: "ad = ?", whereArgs: [yemekAdi]);
  }

  Future<bool> favoriYemekMi(String yemekAdi) async {
    var db = await DatabaseHelper.accesToDatabase();

    List<Map<String, dynamic>> result = await db.query("favori_yemekler", where: "ad = ?", whereArgs: [yemekAdi]);
    // Eğer sonuç listesi boş değilse, yemek favorilerde var demektir.
    return result.isNotEmpty;
  }
}
