import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_2023/core/model/hive_post.dart';
import 'package:task_2023/core/router/router.dart';
import 'feature/pages/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HivePostAdapter());
  await Hive.openBox<HivePost>('hive_post');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext ctx, Widget? child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task',
        navigatorKey: navigatorKey,
        builder: (context, child) => Directionality(
          textDirection: TextDirection.ltr,
          child: child!,
        ),
        home: Home(),
      ),
    );
  }
}
