import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../data/local/boxes.dart';
import '../model/hive_post.dart';
import '../model/post_model.dart';
import 'dart:developer';

final favouriteProvider =
    StateNotifierProvider<FavouriteProvider, List<PostModelData>>((ref) {
  return FavouriteProvider();
});

class FavouriteProvider extends StateNotifier<List<PostModelData>> {
  FavouriteProvider() : super([]) {
    initHiveState();
  }

  bool isFavourite(int postId) => (state.isNotEmpty &&
          state.where((e) => e.id == postId).toList().isNotEmpty)
      ? true
      : false;

  initHiveState() {
    final box = Boxes.getFavouritePosts();
    state = box.values
        .map((e) => PostModelData(id: e.id, title: e.title, body: e.body))
        .toList();
  }

  Future addToFavourite(PostModelData model) async {
    final post = HivePost()
      ..id = model.id
      ..title = model.title
      ..body = model.body;

    final box = Boxes.getFavouritePosts();
    await box.put(post.id, post);
    state = box.values
        .map((e) => PostModelData(id: e.id, title: e.title, body: e.body))
        .toList();
  }

  void removeFromFavourite(PostModelData postModel) async {
    final box = Boxes.getFavouritePosts();
    List<HivePost> listDelete = box.values.toList();
    for (int i = 0; i < listDelete.length; i++) {
      if (listDelete[i].id == postModel.id) {
        box.deleteAt(i);
      }
    }
    // final boxAfterDelete = Boxes.getFavouritePosts();
    state = box.values
        .map((e) => PostModelData(id: e.id, title: e.title, body: e.body))
        .toList();
  }
}
