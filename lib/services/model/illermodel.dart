import 'dart:convert';

List<IllerModel> illerModelFromJson(String str) => List<IllerModel>.from(
    json.decode(str)["iller"].map((x) => IllerModel.fromJson(x)));

String illerModelToJson(List<IllerModel> data) =>
    json.encode({"iller": List<dynamic>.from(data.map((x) => x.toJson()))});

class IllerModel {
  String il;
  String meshurluk;

  IllerModel({
    required this.il,
    required this.meshurluk,
  });

  IllerModel copyWith({
    String? il,
    String? meshurluk,
  }) =>
      IllerModel(
        il: il ?? this.il,
        meshurluk: meshurluk ?? this.meshurluk,
      );

  factory IllerModel.fromJson(Map<String, dynamic> json) => IllerModel(
        il: json["il"],
        meshurluk: json["meshurluk"],
      );

  Map<String, dynamic> toJson() => {
        "il": il,
        "meshurluk": meshurluk,
      };
}
