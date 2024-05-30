import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/controllers/favorite_provider.dart';
import 'package:news_app/controllers/search_provider.dart';
import 'package:news_app/models/favorite_model.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:news_app/view/home/screen_home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(
    FavoriteModelAdapter().typeId,
  )) {
    Hive.registerAdapter(
      FavoriteModelAdapter(),
    );
  }
  if (!Hive.isAdapterRegistered(
    SourceModelAdapter().typeId,
  )) {
    Hive.registerAdapter(
      SourceModelAdapter(),
    );
    runApp(const MyApp());
  }
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: kMainColor,
          ),
          appBarTheme: AppBarTheme(
            centerTitle: false,
            backgroundColor: Colors.grey.shade200,
            iconTheme: const IconThemeData(
              color: kBlackColor,
            ),
            titleTextStyle: const TextStyle(
              color: kBlackColor,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          scaffoldBackgroundColor: Colors.grey.shade100,
          textTheme: GoogleFonts.latoTextTheme(),
          useMaterial3: false,
        ),
        home: const ScreenHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
