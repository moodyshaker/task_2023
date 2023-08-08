import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_2023/core/riverpod/favourite_provider.dart';

import '../../../constants.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/main_text.dart';

class Favourite extends ConsumerWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(favouriteProvider);
    return CustomScaffold(
        title: 'Favourite',
        body: state.isEmpty
            ? Center(
                child: MainText(
                  text: 'There is no Favourites',
                  font: 18.sp,
                  weight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                itemCount: state.length,
                itemBuilder: (BuildContext context, int i) => Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(8.r)),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MainText(
                              text: '${state[i].title}',
                              font: 16.sp,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                ref
                                    .read(favouriteProvider.notifier)
                                    .removeFromFavourite(state[i]);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      MainText(
                        text: '${state[i].body}',
                        font: 12.sp,
                        color: kHeaderColor,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
