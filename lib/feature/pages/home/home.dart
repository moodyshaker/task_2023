import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_2023/constants.dart';
import 'package:task_2023/core/model/post_model.dart';
import 'package:task_2023/core/riverpod/posts_provider.dart';
import 'package:task_2023/core/riverpod/favourite_provider.dart';
import 'package:task_2023/core/router/router.dart';
import 'package:task_2023/feature/pages/details/details.dart';
import 'package:task_2023/feature/widgets/customScaffold.dart';
import 'package:task_2023/feature/widgets/main_text.dart';

import '../../../core/model/hive_post.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late ScrollController _controller;
  int _page = 1;

  @override
  initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() async {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _page++;
        ref.watch(postsProvider(_page));
      }
    });
  }

  @override
  dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(postsProvider(_page));
    ref.watch(favouriteProvider);
    return CustomScaffold(
      isHome: true,
      favouriteNo: ref.read(favouriteProvider.notifier).state.length,
      title: 'Home',
      body: data.when(
          data: (List<PostModelData>? data) => (data != null && data.isNotEmpty)
              ? ListView.builder(
                  controller: _controller,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int i) => GestureDetector(
                        onTap: () {
                          MagicRouter.navigateTo(Details(model: data[i]));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          decoration: BoxDecoration(
                              border: Border.all(color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(8.r)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: MainText(
                                      text: '${data[i].title}',
                                      font: 16.sp,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (ref
                                            .read(favouriteProvider.notifier)
                                            .isFavourite(data[i].id!)) {
                                          ref
                                              .read(favouriteProvider.notifier)
                                              .removeFromFavourite(data[i]);
                                        } else {
                                          ref
                                              .read(favouriteProvider.notifier)
                                              .addToFavourite(data[i]);
                                        }
                                      },
                                      icon: Icon(
                                        ref
                                                .read(
                                                    favouriteProvider.notifier)
                                                .isFavourite(data[i].id!)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: ref
                                                .read(
                                                    favouriteProvider.notifier)
                                                .isFavourite(data[i].id!)
                                            ? kRedColor
                                            : kPrimaryColor,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              MainText(
                                text: '${data[i].body}',
                                font: 12.sp,
                                color: kHeaderColor,
                              ),
                            ],
                          ),
                        ),
                      ))
              : Center(
                  child: MainText(
                    text: 'There is no Items',
                    font: 18.sp,
                    weight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
          error: (e, s) => MainText(
                text: e.toString(),
                font: 18.sp,
                weight: FontWeight.bold,
                color: kPrimaryColor,
              ),
          loading: () => const SpinKitFadingCircle(
                color: kPrimaryColor,
              )),
    );
  }
}
