// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';

class YemeklerCevap {
  List<Yemekler> yemekler;
  int success;

  YemeklerCevap({required this.yemekler, required this.success});

  factory YemeklerCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["yemekler"] as List;
    var success = json["success"] as int;

    var yemekler = jsonArray.map((jsonArrayNesnesi) => Yemekler.fromJson(jsonArrayNesnesi)).toList();

    return YemeklerCevap(yemekler: yemekler, success: success);
  }
}
