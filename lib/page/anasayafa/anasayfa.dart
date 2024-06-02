import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seyehatapp/generated/locale_keys.g.dart';
import 'package:seyehatapp/services/havaservices.dart';
import 'package:seyehatapp/services/model/havamodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seyehatapp/services/model/illermodel.dart';
import 'package:url_launcher/url_launcher.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  HavaModel? havadurumu;
  List<IllerModel> allIller = [];

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
              /// Hava durumu
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
              // İLLER
              yazi(),

              Expanded(
                flex: 2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allIller.length,
                  itemBuilder: (context, index) {
                    var item = allIller[index];
                    return InkWell(
                        onTap: () {
                          searchInGoogleMaps(item.il);
                        },
                        child: kart(index, context, item));
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

  void searchInGoogleMaps(String query) async {
    String url = 'https://www.google.com/maps/search/?api=1&query=$query';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Padding kart(int index, BuildContext context, IllerModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
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
                  LocaleKeys.anasayfa_meshur.tr(),
                  style: GoogleFonts.seymourOne(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(58, 33, 149, 243),
                      letterSpacing: .4,
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  item.meshurluk,
                  style: GoogleFonts.seymourOne(
                    textStyle: const TextStyle(
                      color: Colors.blue,
                      letterSpacing: .4,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.location_pin,
                  color: Colors.blue,
                  size: 25,
                ),
                Text(
                  item.il,
                  style: GoogleFonts.seymourOne(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 16, 78, 128),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding yazi() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            LocaleKeys.anasayfa_iller.tr(),
            style: GoogleFonts.seymourOne(
              textStyle: TextStyle(
                  color: Theme.of(context).appBarTheme.backgroundColor),
              letterSpacing: .3,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration decor(int index) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        fit: BoxFit.cover,
        opacity: 0.3,
        image: resimler[index % resimler.length],
      ),
    );
  }
}
