import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:seyehatapp/services/model/not_model.dart';

class NotlarServices {
  var db = Hive.box<NotModel>('nots');
  Future<void> kaydet(NotModel notModel) async {
    try {
      await db.put(notModel.notID, notModel);
      debugPrint("not kaydedildi");
    } catch (e) {
      debugPrint("NotlarServices // kaydet fonk hata var");

      print(e);
    }
  }

  Future<void> sil(String ID) async {
    try {
      await db.delete(ID);
      debugPrint("not silindi");
    } catch (e) {
      debugPrint("NotlarServices // sil=> fonk hata var");

      print(e);
    }
  }

  Future<List<NotModel>> getAllNots() async {
    if (db.isEmpty) {
      return [];
    } else {
      List<NotModel> allNots = db.values.toList();
      debugPrint("notlar Geldi");
      return allNots;
    }
  }
}
