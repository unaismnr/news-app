import 'package:flutter/material.dart';
import 'package:news_app/controllers/tab_index_provider.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:news_app/view/home/screen_home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kMainColor,
        ),
        useMaterial3: false,
      ),
      home: ScreenHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
