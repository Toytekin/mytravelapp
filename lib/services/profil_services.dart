import 'package:hive/hive.dart';
import 'package:seyehatapp/services/model/profilmodel.dart';

class ProfilServices {
  var db = Hive.box<ProfilModel>('prf');

  Future<void> save(ProfilModel profilModel) async {
    await db.put('1', profilModel);
  }

  Future<ProfilModel?> getProfil() async {
    if (db.isEmpty) {
      ProfilModel boskisi = ProfilModel(
        name: 'Kullanıcı adı olustur',
      );
      return boskisi;
    } else {
      ProfilModel? kisi = await db.get('1');
      return kisi;
    }
  }
}
