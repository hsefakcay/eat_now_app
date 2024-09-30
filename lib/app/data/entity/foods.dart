// ignore_for_file: public_member_api_docs, sort_constructors_first
class Foods {
  String id;
  String ad;
  String resim;
  String fiyat;
  
  Foods({
    required this.id,
    required this.ad,
    required this.resim,
    required this.fiyat,
  });

  factory Foods.fromJson(Map<String, dynamic> json) {
    return Foods(
      id: json["yemek_id"] as String,
      ad: json["yemek_adi"] as String,
      resim: json["yemek_resim_adi"] as String,
      fiyat: json["yemek_fiyat"] as String,
    );
  }
}
