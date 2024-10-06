import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yemek_soyle_app/app/data/entity/cart_foods.dart';
import 'package:yemek_soyle_app/app/data/entity/cart_foods_response.dart';
import 'package:yemek_soyle_app/app/data/entity/foods.dart';
import 'package:yemek_soyle_app/app/data/entity/foods_response.dart';

class FoodsDaoRepository {
  List<Foods> parseFoods(String cevap) {
    final decoded = json.decode(cevap) as Map<String, dynamic>;
    return FoodsResponse.fromJson(decoded).foods;
  }

  List<CartFoods> parseCartFoods(String cevap) {
    final decoded = json.decode(cevap) as Map<String, dynamic>;
    return CartFoodsResponse.fromJson(decoded).cartFoods;
  }

  Future<List<Foods>> loadFoods() async {
    final url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    final cevap = await Dio().get(url);

    return parseFoods(cevap.data.toString());
  }

  Future<void> addToCart(CartFoods eklenecekYemek) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var data = {
      "yemek_adi": eklenecekYemek.ad,
      "yemek_resim_adi": eklenecekYemek.resim,
      "yemek_fiyat": eklenecekYemek.fiyat,
      "yemek_siparis_adet": eklenecekYemek.siparisAdet,
      "kullanici_adi": eklenecekYemek.kullaniciAdi
    };
    var response = await Dio().post(url, data: FormData.fromMap(data));
    print("Sepete yemek ekle : ${response.data.toString()}");
  }

  Future<void> removeFromCart(CartFoods silinecekYemek) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var data = {
      "sepet_yemek_id": silinecekYemek.id,
      "kullanici_adi": silinecekYemek.kullaniciAdi,
    };
    var response = await Dio().post(url, data: FormData.fromMap(data));
    print("Sepetten yemek silindi: ${response.data.toString()}");
  }

  Future<List<CartFoods>> loadCartFoods() async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var userId = {"kullanici_adi": "hsefakcay"};

    try {
      var response = await Dio().post(url, data: FormData.fromMap(userId));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.data.toString());

        // Gelen JSON'da success değeri kontrol ediliyor
        if (jsonData['success'] == 1 && jsonData['sepet_yemekler'] != null) {
          print("AAAA");
          return parseCartFoods(response.data.toString());
        } else {
          print("Sepet boş ya da kullanıcının sepeti bulunamadı.");
        }
      } else {
        print("HTTP isteği başarısız oldu. Kod: ${response.statusCode}");
      }
    } catch (e) {
      print("Bir hata oluştu: $e");
    }

    return [];
  }
}
