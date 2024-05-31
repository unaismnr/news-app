import 'package:flutter/material.dart';
import 'package:news_app/controllers/favorite_provider.dart';
import 'package:news_app/models/news_data_model.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:news_app/utils/other_consts.dart';
import 'package:news_app/view/common/background_container.dart';
import 'package:news_app/view/common/navigation_helper.dart';
import 'package:news_app/view/common/single_news_widget.dart';
import 'package:news_app/view/news/screen_single_news.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenFavorites extends StatelessWidget {
  const ScreenFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<FavoriteProvider>(context).getFavoriteNews();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          kHeight10,
          Expanded(
            child: BackgroundContainer(
              child: Consumer<FavoriteProvider>(
                builder: (context, newFavorites, _) {
                  if (newFavorites.favoriteNews.isEmpty) {
                    return const Center(
                      child: Text('No Favorites'),
                    );
                  } else {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final favorites = newFavorites.favoriteNews[index];
                        final news = NewsDataModel(
                          source: favorites.source,
                          author: favorites.author,
                          title: favorites.title,
                          description: favorites.description,
                          url: favorites.url,
                          urlToImage: favorites.urlToImage,
                          publishedAt: favorites.publishedAt,
                          content: favorites.content,
                        );
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 5.h,
                          ),
                          child: InkWell(
                            onTap: () {
                              NavigationHelper.push(
                                context,
                                ScreenSingleNews(
                                  news: news,
                                  isFav: false,
                                  isFromFav: true,
                                ),
                              );
                            },
                            child: SingleNewsWidget(
                              isMaxLinesWant: true,
                              news: news,
                              isFavOrDelete: false,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: kBlackColor.withOpacity(0.2),
                      ),
                      itemCount: newFavorites.favoriteNews.length,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
