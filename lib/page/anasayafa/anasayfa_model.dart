import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seyehatapp/page/anasayafa/anasayfa.dart';
import 'package:seyehatapp/services/havaservices.dart';
import 'package:seyehatapp/services/model/havamodel.dart';
import 'package:seyehatapp/services/model/illermodel.dart';
import 'package:seyehatapp/services/model/profilmodel.dart';
import 'package:seyehatapp/services/profil_services.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

mixin AnasayfaModel on State<AnaSayfa> {
//DEĞİŞKENLER

  var repo = ProfilServices();

  ProfilModel? profilModel;

  HavaModel? havadurumu;
  List<IllerModel> allIller = [];

  List<NetworkImage> resimler = [
    const NetworkImage(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Adana_Seyhan_River.png/1920px-Adana_Seyhan_River.png"),
    const NetworkImage(
        "https://upload.wikimedia.org/wikipedia/commons/0/04/Ankara_Montage_2020.jpg"),
    const NetworkImage(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Istanbul_asv2020-02_img61_Ortak%C3%B6y_Mosque.jpg/800px-Istanbul_asv2020-02_img61_Ortak%C3%B6y_Mosque.jpg"),
    const NetworkImage(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/%C4%B0zmir_Clock_Tower%2C_December_2018.jpg/800px-%C4%B0zmir_Clock_Tower%2C_December_2018.jpg"),
    const NetworkImage(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Falezlerden_Antalya_Konyaalt%C4%B1_Plaj%C4%B1na_do%C4%9Fru_bir_g%C3%B6r%C3%BCn%C3%BCm.jpg/1920px-Falezlerden_Antalya_Konyaalt%C4%B1_Plaj%C4%B1na_do%C4%9Fru_bir_g%C3%B6r%C3%BCn%C3%BCm.jpg"),
    const NetworkImage(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Bursa%2C_Turkey_%284505709750%29.jpg/1024px-Bursa%2C_Turkey_%284505709750%29.jpg"),
    const NetworkImage(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Erzurum%2C_Turkey_-_panoramio_%2814%29.jpg/1920px-Erzurum%2C_Turkey_-_panoramio_%2814%29.jpg"),
    const NetworkImage(
        "https://upload.wikimedia.org/wikipedia/commons/1/12/Samsun_kolaj_%282018%2C_2%29.png"),
  ];

  // init STATE

  @override
  void initState() {
    super.initState();
    havadurumunuAl();
    getData();
    veriGetir();
  }

  Future<void> veriGetir() async {
    var data = await repo.getProfil();

    if (data != null) {
      setState(() {
        profilModel = data;
      });
    }
  }

  //7 METOTLAR
  getData() async {
    try {
      final String respons =
          await rootBundle.loadString('asset/json/iller.json');
      final data = await jsonDecode(respons);
      debugPrint("Veri");
      debugPrint(data.toString());

      // JSON dosyasını "iller" anahtarını kullanarak işleyin
      allIller =
          (data["iller"] as List).map((e) => IllerModel.fromJson(e)).toList();
      setState(() {});
    } catch (e) {
      debugPrint('Iller services dosyası hatası: $e');
    }
  }

  Future<void> havadurumunuAl() async {
    var hava = LocationHelper();

    try {
      havadurumu = await hava.getLocation();
    } catch (e) {
      debugPrint('Hava durumu alınamadı: $e');
    }
    setState(() {});
  }

  void searchInGoogleMaps(String query) async {
    String url = 'https://www.google.com/maps/search/?api=1&query=$query';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
