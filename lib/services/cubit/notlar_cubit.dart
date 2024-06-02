import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seyehatapp/services/model/not_model.dart';
import 'package:seyehatapp/services/notlar_servicces.dart';

class NotlarCubit extends Cubit<List<NotModel>> {
  NotlarCubit() : super([]);

  var repo = NotlarServices();

  kaydet(NotModel notmodel) async {
    await repo.kaydet(notmodel);
  }

  sil(String ID) async {
    await repo.sil(ID);
  }

  notlariCek() async {
    var data = await repo.getAllNots();

    emit(data);
  }
}
