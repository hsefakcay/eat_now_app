// ignore_for_file: public_member_api_docs, sort_constructors_first

class SepetYemekler {
  String id;
  String ad;
  String resim;
  String fiyat;
  String siparisAdet;
  String kullaniciAdi;

  SepetYemekler({
    required this.id,
    required this.ad,
    required this.resim,
    required this.fiyat,
    required this.siparisAdet,
    required this.kullaniciAdi,
  });

  factory SepetYemekler.fromJson(Map<String, dynamic> json) {
    return SepetYemekler(
        id: json["sepet_yemek_id"] as String,
        ad: json["yemek_adi"] as String,
        resim: json["yemek_resim_adi"] as String,
        fiyat: json["yemek_fiyat"] as String,
        siparisAdet: json["yemek_siparis_adet"] as String,
        kullaniciAdi: json["kullanici_adi"] as String);
  }
}
