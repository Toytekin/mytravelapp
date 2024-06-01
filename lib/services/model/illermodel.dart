// To parse this JSON data, do
//
//     final illerModdel = illerModdelFromJson(jsonString);

import 'dart:convert';

List<IllerModdel> illerModdelFromJson(String str) => List<IllerModdel>.from(
    json.decode(str).map((x) => IllerModdel.fromJson(x)));

String illerModdelToJson(List<IllerModdel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IllerModdel {
  int plaka;
  String ilAdi;
  double lat;
  double lon;
  double northeastLat;
  double northeastLon;
  double southwestLat;
  double southwestLon;

  IllerModdel({
    required this.plaka,
    required this.ilAdi,
    required this.lat,
    required this.lon,
    required this.northeastLat,
    required this.northeastLon,
    required this.southwestLat,
    required this.southwestLon,
  });

  factory IllerModdel.fromJson(Map<String, dynamic> json) => IllerModdel(
        plaka: json["plaka"],
        ilAdi: json["il_adi"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        northeastLat: json["northeast_lat"]?.toDouble(),
        northeastLon: json["northeast_lon"]?.toDouble(),
        southwestLat: json["southwest_lat"]?.toDouble(),
        southwestLon: json["southwest_lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "plaka": plaka,
        "il_adi": ilAdi,
        "lat": lat,
        "lon": lon,
        "northeast_lat": northeastLat,
        "northeast_lon": northeastLon,
        "southwest_lat": southwestLat,
        "southwest_lon": southwestLon,
      };
}
