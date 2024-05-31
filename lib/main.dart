import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/controllers/favorite_provider.dart';
import 'package:news_app/controllers/search_provider.dart';
import 'package:news_app/services/hive/hive_register.dart';
import 'package:news_app/utils/my_theme.dart';
import 'package:news_app/view/home/screen_home.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  hiveRegister();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(
    const ScreenUtilInit(
      designSize: Size(375, 812),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'News App',
        theme: MyTheme.theme,
        home: const ScreenHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
