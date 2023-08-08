import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_2023/feature/pages/home/favourite.dart';
import '../../constants.dart';
import '../../core/riverpod/favourite_provider.dart';
import '../../core/router/router.dart';
import 'action_dialog.dart';
import 'main_text.dart';

class CustomScaffold extends StatefulWidget {
  final String? title;
  final bool hasAppbar;
  final Widget body;
  final bool isHome;
  final Widget? fab;
  final int? favouriteNo;
  final Function()? onBackPressed;

  const CustomScaffold(
      {this.title,
      required this.body,
      this.hasAppbar = true,
      this.isHome = false,
      this.fab,
      this.onBackPressed,
      this.favouriteNo,
      Key? key})
      : super(key: key);

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentColor,
      floatingActionButton: widget.fab,
      appBar: AppBar(
        backgroundColor: kAccentColor,
        elevation: 0,
        toolbarHeight: 70.h,
        title: MainText(
          text: widget.title,
          color: kPrimaryColor,
          font: 20.sp,
          weight: FontWeight.bold,
        ),
        actions: [
          widget.isHome
              ? Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                      onPressed: () {
                        MagicRouter.navigateTo(Favourite());
                      },
                      icon: const Icon(
                        Icons.bookmark,
                        color: kPrimaryColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.h, right: 4.w),
                      height: 20.h,
                      width: 20.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: kAccentColor, width: 2),
                          shape: BoxShape.circle,
                          color: kPrimaryColor),
                      child: Center(
                        child: MainText(
                          text: '${widget.favouriteNo}',
                          font: 10.sp,
                          weight: FontWeight.bold,
                          color: kAccentColor,
                        ),
                      ),
                    ),
                  ],
                )
              : Container()
        ],
        leading: widget.isHome
            ? null
            : IconButton(
                onPressed: () {
                  if (!MagicRouter.canPop) {
                    showDialog(
                        context: navigatorKey.currentContext!,
                        builder: (c) => ActionDialog(
                              content: 'Do You Want To Exit App ?',
                              onCancelClick: () {
                                MagicRouter.pop();
                              },
                              approveAction: 'Yes',
                              cancelAction: 'No',
                              onApproveClick: () {
                                MagicRouter.pop();
                                SystemNavigator.pop();
                              },
                            ));
                  } else {
                    widget.onBackPressed != null
                        ? widget.onBackPressed!()
                        : MagicRouter.pop();
                  }
                },
                icon: Icon(
                  Platform.isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back,
                  color: kPrimaryColor,
                )),
      ),
      body: SafeArea(child: widget.body),
    );
  }
}
