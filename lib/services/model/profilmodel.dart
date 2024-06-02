import 'package:hive/hive.dart';

part 'profilmodel.g.dart';

@HiveType(typeId: 2)
class ProfilModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String? photoURL;
  ProfilModel({
    required this.name,
    this.photoURL,
  });
}
