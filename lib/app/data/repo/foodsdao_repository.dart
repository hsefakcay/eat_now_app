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

  List<CartFoods> parseCartFoods(String response) {
    final decoded = json.decode(response) as Map<String, dynamic>;
    return CartFoodsResponse.fromJson(decoded).cartFoods;
  }

  Future<List<Foods>> loadFoods() async {
    final url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    final response = await Dio().get<dynamic>(url);

    return parseFoods(response.data.toString());
  }

  Future<void> addToCart(CartFoods cartFood) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var data = {
      "yemek_adi": cartFood.ad,
      "yemek_resim_adi": cartFood.resim,
      "yemek_fiyat": cartFood.fiyat,
      "yemek_siparis_adet": cartFood.siparisAdet,
      "kullanici_adi": cartFood.kullaniciAdi
    };
     await Dio().post<dynamic>(url, data: FormData.fromMap(data));
  }

  Future<void> removeFromCart(CartFoods silinecekYemek) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var data = {
      "sepet_yemek_id": silinecekYemek.id,
      "kullanici_adi": silinecekYemek.kullaniciAdi,
    };
    await Dio().post<Map<String, dynamic>>(url, data: FormData.fromMap(data));
  }

  Future<List<CartFoods>> loadCartFoods() async {
    const url = 'http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php';
    final userId = {'kullanici_adi': 'hsefakcay'};

    try {
      var response = await Dio().post<Map<String, dynamic>>(url, data: FormData.fromMap(userId));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.data.toString());

        // Gelen JSON'da success değeri kontrol ediliyor
        if (jsonData['success'] == 1 && jsonData['sepet_yemekler'] != null) {
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
