import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/data/entity/sepet_yemekler.dart';
import 'package:yemek_soyle_app/app/data/repo/yemeklerdao_repository.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>> {
  SepetSayfaCubit() : super(<SepetYemekler>[]);

  //yrepo = yemeker Dao Repo nesnesi
  var yrepo = YemeklerDaoRepository();

  Future<void> sepettekiYemekleriYukle() async {
    var liste = await yrepo.sepettekiYemekleriYukle();

    emit(liste);
  }

  Future<void> sepeteEkle(SepetYemekler eklenecekYemek) async {
    await yrepo.sepeteYemekEkle(eklenecekYemek);
    await sepettekiYemekleriYukle();
  }

  Future<void> sepettenSil(SepetYemekler silinecekYemek) async {
    await yrepo.sepettekiYemegiSil(silinecekYemek);
    await sepettekiYemekleriYukle();
  }
}
