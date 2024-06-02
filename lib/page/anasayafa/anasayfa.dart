import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seyehatapp/constant/router/router.dart';
import 'package:seyehatapp/generated/locale_keys.g.dart';
import 'package:seyehatapp/page/anasayafa/anasayfa_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seyehatapp/services/model/illermodel.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> with AnasayfaModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: profilModel != null
            ? Text(
                profilModel!.name,
                style: TextStyle(fontSize: 22, color: Colors.orange),
              )
            : null,
        actions: [
          profilModel != null
              ? InkWell(
                  onTap: () {
                    context.go(AppRouterName.setting.path);
                  },
                  child: ClipOval(
                    child: Image.file(
                      File(profilModel!.photoURL.toString()),
                      fit: BoxFit.cover,
                      width: 50, // Resmin genişliği
                      height: 50, // Resmin yüksekliği
                    ),
                  ),
                )
              : IconButton(
                  onPressed: () {
                    context.go(AppRouterName.setting.path);
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                ),
        ],
      ),
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
              iller(),
              yazi2(),
              Expanded(child: LayoutBuilder(
                builder: (context, constraints) {
                  return InkWell(
                    onTap: () {
                      context.go(AppRouterName.notGiris.path);
                    },
                    child: Image.asset(
                      "asset/image/buton.png",
                      width: constraints.maxWidth,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Expanded iller() {
    return Expanded(
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
    );
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
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Padding yazi2() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            LocaleKeys.anasayfa_notlar.tr(),
            style: GoogleFonts.seymourOne(
              textStyle: TextStyle(
                  color: Theme.of(context).appBarTheme.backgroundColor),
              letterSpacing: .3,
              fontSize: 12,
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
