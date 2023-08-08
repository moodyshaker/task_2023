import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants.dart';
import '../../../core/model/post_model.dart';
import '../../../core/riverpod/favourite_provider.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/main_text.dart';

class Details extends ConsumerWidget {
  final PostModelData model;

  const Details({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(favouriteProvider);
    return CustomScaffold(
      title: model.title,
      fab: FloatingActionButton(
          onPressed: () {
            if (ref.read(favouriteProvider.notifier).isFavourite(model.id!)) {
              ref
                  .read(favouriteProvider.notifier)
                  .removeFromFavourite(model);
            } else {
              ref.read(favouriteProvider.notifier).addToFavourite(model);
            }
          },
          backgroundColor: ref.read(favouriteProvider.notifier).isFavourite(
              model.id!) ? kAccentColor:kPrimaryColor,
          child: Icon(
            ref.read(favouriteProvider.notifier).isFavourite(model.id!)
                ? Icons.favorite
                : Icons.favorite_border,
            color: ref.read(favouriteProvider.notifier).isFavourite(model.id!)
                ? kRedColor
                : kAccentColor,
          )),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: model.body,
                font: 18.sp,
                textAlign: TextAlign.start,
                weight: FontWeight.bold,
                color: kHeaderColor,
              ),
            ],
          )),
    );
  }
}
