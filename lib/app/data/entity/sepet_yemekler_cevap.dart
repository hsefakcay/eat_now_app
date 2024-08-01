// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:yemek_soyle_app/app/data/entity/sepet_yemekler.dart';
import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';

class SepetYemeklerCevap {
  List<SepetYemekler> sepetYemekler;
  int success;

  SepetYemeklerCevap({required this.sepetYemekler, required this.success});

  factory SepetYemeklerCevap.fromJson(Map<String, dynamic> json) {
    
    var jsonArray = json["sepet_yemekler"] as List;
    var success = json["success"] as int;

    var yemekler = jsonArray.map((jsonArrayNesnesi) => SepetYemekler.fromJson(jsonArrayNesnesi)).toList();

    return SepetYemeklerCevap(sepetYemekler: yemekler, success: success);
  }
}
