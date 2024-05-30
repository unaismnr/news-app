import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/models/source_model.dart';
part 'favorite_model.g.dart';

@HiveType(typeId: 1)
class FavoriteModel {
  @HiveField(0)
  SourceModel? source;

  @HiveField(1)
  String? author;

  @HiveField(2)
  String? title;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? url;

  @HiveField(5)
  String? urlToImage;

  @HiveField(6)
  String? publishedAt;

  @HiveField(7)
  String? content;

  FavoriteModel(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});
}
