import 'package:flutter/material.dart';
import 'package:seyehatapp/services/havaservices.dart';
import 'package:seyehatapp/services/model/havamodel.dart';
import 'package:google_fonts/google_fonts.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  HavaModel? havadurumu;
  @override
  void initState() {
    super.initState();
    havadurumunuAl();
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
                child: Container(
                  color: Colors.green,
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
}
