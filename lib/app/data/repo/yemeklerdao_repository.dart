import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yemek_soyle_app/app/data/entity/sepet_yemekler.dart';
import 'package:yemek_soyle_app/app/data/entity/sepet_yemekler_cevap.dart';
import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';
import 'package:yemek_soyle_app/app/data/entity/yemekler_cevap.dart';

class YemeklerDaoRepository {
  List<Yemekler> parseYemekler(String cevap) {
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  List<SepetYemekler> parseSepetYemekler(String cevap) {
    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepetYemekler;
  }

  Future<List<Yemekler>> yemekleriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);

    return parseYemekler(cevap.data.toString());
  }

  Future<void> sepeteYemekEkle(SepetYemekler eklenecekYemek) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi": eklenecekYemek.ad,
      "yemek_resim_adi": eklenecekYemek.resim,
      "yemek_fiyat": eklenecekYemek.fiyat,
      "yemek_siparis_adet": eklenecekYemek.siparisAdet,
      "kullanici_adi": eklenecekYemek.kullaniciAdi
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Sepete yemek ekle : ${cevap.data.toString()}");
  }

  Future<void> sepettekiYemegiSil(SepetYemekler silinecekYemek) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {
      "sepet_yemek_id": silinecekYemek.id,
      "kullanici_adi": silinecekYemek.kullaniciAdi,
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Sepetten yemek silindi: ${cevap.data.toString()}");
  }

  Future<List<SepetYemekler>> sepettekiYemekleriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var kullaniciId = {"kullanici_adi": "hsefakcay"};

    try {
      var cevap = await Dio().post(url, data: FormData.fromMap(kullaniciId));

      if (cevap.statusCode == 200) {
        var jsonData = json.decode(cevap.data);

        // Gelen JSON'da success değeri kontrol ediliyor
        if (jsonData['success'] == 1 && jsonData['sepet_yemekler'] != null) {
          print("AAAA");
          return parseSepetYemekler(cevap.data.toString());
        } else {
          print("Sepet boş ya da kullanıcının sepeti bulunamadı.");
        }
      } else {
        print("HTTP isteği başarısız oldu. Kod: ${cevap.statusCode}");
      }
    } catch (e) {
      print("Bir hata oluştu: $e");
    }

    return [];
  }
}
