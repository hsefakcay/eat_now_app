import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/data/entity/yemekler.dart';
import 'package:yemek_soyle_app/app/data/repo/favoritesdao_repository.dart';

class FavorilerSayfaCubit extends Cubit<List<Yemekler>> {
  FavorilerSayfaCubit() : super(<Yemekler>[]);

  //yrepo = yemeker Dao Repo nesnesi
  var favsRepo = FavoritesRepository();

  Future<void> favYemekleriYukle() async {
    var liste = await favsRepo.favoriYemekleriYukle();
    emit(liste);
  }
}
