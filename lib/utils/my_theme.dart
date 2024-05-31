import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/utils/color_consts.dart';

class MyTheme {
  static final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: kMainColor,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: Colors.grey.shade200,
      iconTheme: const IconThemeData(
        color: kBlackColor,
      ),
      titleTextStyle: TextStyle(
        color: kBlackColor,
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    scaffoldBackgroundColor: Colors.grey.shade100,
    textTheme: GoogleFonts.latoTextTheme(),
    useMaterial3: false,
  );
}
