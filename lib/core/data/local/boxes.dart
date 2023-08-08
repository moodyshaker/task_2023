import 'package:hive/hive.dart';

import '../../model/hive_post.dart';
class Boxes {
  static Box<HivePost> getFavouritePosts() =>
      Hive.box<HivePost>('hive_post');
}