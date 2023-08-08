import 'package:hive/hive.dart';

part 'hive_post.g.dart';

@HiveType(typeId: 0)
class HivePost extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? body;
}