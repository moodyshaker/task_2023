import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/router/router.dart';
import 'feature/widgets/main_text.dart';

const Color kMainColor = Color(0xff8FC741);
const Color kSecondaryColor = Color(0xFF7E1E5E);
const Color kPrimaryColor = Color(0xFF000000);
const Color kHeaderColor = Color(0xff7c7c7c);
const Color kAccentColor = Color(0xFFFFFFFF);
const Color kRedColor = Color(0xFFD31027);

void showSnackBar(String msg) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).clearSnackBars();
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
      backgroundColor: kMainColor,
      content: MainText(
        text: msg,
        color: kAccentColor,
        font: 16.sp,
      )));
}

