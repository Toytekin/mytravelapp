import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seyehatapp/page/anasayafa/ilsecme.dart';
import 'package:seyehatapp/services/havaservices.dart';
import 'package:seyehatapp/services/model/havamodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seyehatapp/services/model/illermodel.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  HavaModel? havadurumu;
  List<IllerModdel> allIller = [];
  IllerModdel? secilenIl;

  int resimGetir = 0;

  @override
  void initState() {
    super.initState();
    havadurumunuAl();
    getData();
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

  getData() async {
    try {
      // debugPrint('Servis çalıştı');

      final String respons =
          await rootBundle.loadString('asset/json/turkiye_illeri.json');
      final data = await jsonDecode(respons);
      allIller = (data as List).map((e) => IllerModdel.fromJson(e)).toList();
      secilenIl = allIller[0];
      setState(() {});
    } catch (e) {
      debugPrint('Iller sevices dosyası hatası');
    }
    return allIller;
  }

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

  name(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: havadurumu != null
                      ? Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'asset/image/hava.png',
                                width: 100,
                                height: 100,
                              ),
                              Text(
                                ' ${havadurumu?.name}:  ${havadurumu!.main.temp}°C',
                                style: GoogleFonts.seymourOne(
                                  textStyle: const TextStyle(
                                    color: Colors.blue,
                                    letterSpacing: .3,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Text(
                          'Hava durumu alınamadı',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allIller.length,
                  itemBuilder: (context, index) {
                    var item = allIller[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: decor(index),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width /
                              2, // Adjust the width as per requirement
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  item.ilAdi,
                                  style: const TextStyle(fontSize: 22),
                                ),
                                Text(
                                  "0${item.plaka}",
                                  style: const TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration decor(int index) {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        opacity: 0.3,
        image: resimler[index % resimler.length],
      ),
    );
  }
}
