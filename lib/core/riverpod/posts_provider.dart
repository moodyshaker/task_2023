import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/network/dio/networking.dart';
import '../model/post_model.dart';

final postsProvider = FutureProvider.family<List<PostModelData>?, int>(
    (ref, page) => getPosts(page));

List<PostModelData>? postsModel;

Future<List<PostModelData>?> getPosts(int page) async {
  try {
    if (page <= 3) {
      final r =
          await DioManager().get('posts', queryParameters: {'page': page});
      log('getPosts body -> ${r.data}');
      log('getPosts url -> ${r.requestOptions.uri}');
      log('getPosts statusCode -> ${r.statusCode}');
      if (page == 1) {
        postsModel = [];
        postsModel!.addAll(PostModel.fromJson(r.data).data!);
      } else {
        postsModel!.addAll(PostModel.fromJson(r.data).data!);
      }
      page++;
    }
    return postsModel;
  } catch (e) {
    log(e.toString());
  }
  return null;
}
