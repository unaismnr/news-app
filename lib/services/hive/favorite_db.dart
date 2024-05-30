import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/models/favorite_model.dart';

class FavoriteDb {
  static String favoriteDbName = 'favoriteDB';
  late Box<FavoriteModel> favoriteDbBox;

  FavoriteDb.internal();
  static FavoriteDb instance = FavoriteDb.internal();
  factory FavoriteDb() => instance;

  Future<void> openBox() async {
    favoriteDbBox = await Hive.openBox(favoriteDbName);
  }

  Future<void> addFavorite(FavoriteModel newNews) async {
    await openBox();

    final newsinDb = favoriteDbBox.values.toList();

    final isAlready = newsinDb
        .where(
          (news) => news.url == newNews.url,
        )
        .isEmpty;

    if (isAlready) {
      favoriteDbBox.put(newNews.url, newNews);
    } else {
      final checkedNews = newsinDb.indexWhere(
        (element) => element.url == newNews.url,
      );
      await favoriteDbBox.deleteAt(checkedNews);
      await favoriteDbBox.put(newNews.url, newNews);
    }
    await getFavorites();
  }

  Future<List<FavoriteModel>> getFavorites() async {
    await openBox();
    return favoriteDbBox.values.toList();
  }

  Future<void> deleteFavorite(String newsUrl) async {
    await openBox();
    favoriteDbBox.delete(newsUrl);
    await getFavorites();
  }
}
