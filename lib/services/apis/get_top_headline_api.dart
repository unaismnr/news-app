import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/models/news_data_model.dart';
import 'package:news_app/utils/api_consts.dart';

Future<List<NewsDataModel>> getTopHeadlineApi() async {
  try {
    final response = await http.get(Uri.parse(
      '${apiMainUrl}top-headlines?country=us&$apiKey',
    ));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final articles = parsed['articles'] as List;
      return articles
          .map<NewsDataModel>(
            (json) => NewsDataModel.fromJson(json),
          )
          .toList();
    } else {
      throw Exception('Top Headline Api Fetching Error');
    }
  } catch (e) {
    log(e.toString());
  }
  return [];
}
