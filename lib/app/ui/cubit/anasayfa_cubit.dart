import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';
import 'package:yemek_soyle_app/app/data/repo/yemeklerdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit() : super(<Yemekler>[]);

  //yrepo = yemeker Dao Repo nesnesi
  var yrepo = YemeklerDaoRepository();

  Future<void> yemekleriYukle() async {
    var liste = await yrepo.yemekleriYukle();
    emit(liste);
  }

  Future<void> searchFoods(String query) async {
    var liste = await yrepo.yemekleriYukle();

    if (query.isEmpty) {
      emit(liste);
    } else {
      final filteredList = liste.where((yemek) {
        return yemek.ad.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(filteredList);
    }
  }
}
