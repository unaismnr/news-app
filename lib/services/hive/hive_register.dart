import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/models/favorite_model.dart';
import 'package:news_app/models/source_model.dart';

void hiveRegister() {
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
  }
}
