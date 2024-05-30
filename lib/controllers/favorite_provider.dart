import 'package:flutter/material.dart';
import 'package:news_app/models/favorite_model.dart';
import 'package:news_app/services/hive/favorite_db.dart';

class FavoriteProvider extends ChangeNotifier {
  List<FavoriteModel>? _favoriteNews;

  List<FavoriteModel>? get favoriteNews => _favoriteNews;

  void getFavoriteNews() async {
    _favoriteNews = await FavoriteDb.instance.getFavorites();
    notifyListeners();
  }
}
