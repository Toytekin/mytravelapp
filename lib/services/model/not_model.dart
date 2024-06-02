import 'package:hive/hive.dart';

part 'not_model.g.dart';

@HiveType(typeId: 1)
class NotModel {
  @HiveField(0)
  String notID;
  @HiveField(1)
  String notTitle;
  @HiveField(2)
  String ani;
  @HiveField(3)
  double score;
  @HiveField(4)
  String? imgURL;

  NotModel({
    required this.notID,
    required this.notTitle,
    required this.ani,
    this.score = 0,
    this.imgURL,
  });
}
