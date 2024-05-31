import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controllers/favorite_provider.dart';
import 'package:news_app/models/favorite_model.dart';
import 'package:news_app/models/news_data_model.dart';
import 'package:news_app/services/hive/favorite_db.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:news_app/utils/other_consts.dart';
import 'package:news_app/view/common/background_container.dart';
import 'package:news_app/view/common/circle_icon_widget.dart';
import 'package:news_app/view/common/news_image_container.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenSingleNews extends StatelessWidget {
  final NewsDataModel news;
  final bool isFav;
  final bool isFromFav;
  const ScreenSingleNews({
    super.key,
    required this.news,
    required this.isFav,
    this.isFromFav = false,
  });

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(
      context,
    );
    final isAlreadyInFav = favProvider.favoriteNews
        .where(
          (element) => element.url == news.url,
        )
        .isEmpty;
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          kHeight10,
          Expanded(
            child: BackgroundContainer(
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          NewsImageContainer(
                            image: news.urlToImage != null &&
                                    news.urlToImage!.isNotEmpty
                                ? NetworkImage(news.urlToImage!)
                                : const AssetImage(
                                    'assets/image-no.png',
                                  ) as ImageProvider,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: CircleIconWidget(
                                onTap: () {
                                  final favorites = FavoriteModel(
                                    source: news.source,
                                    title: news.title,
                                    author: news.author,
                                    description: news.description,
                                    content: news.content,
                                    publishedAt: news.publishedAt,
                                    url: news.url,
                                    urlToImage: news.urlToImage,
                                  );
                                  isAlreadyInFav && isFav
                                      ? FavoriteDb.instance
                                          .addFavorite(favorites)
                                      : FavoriteDb.instance.deleteFavorite(
                                          favorites.url!,
                                        );
                                  favProvider.getFavoriteNews();
                                  isFromFav
                                      ? Navigator.pop(context)
                                      : const SizedBox();
                                },
                                radius: 15.w,
                                iconColor:
                                    isAlreadyInFav ? kBlackColor : kMainColor,
                                iconSize: 25.sp,
                                icon: isFav ? Icons.favorite : Icons.delete,
                              ),
                            ),
                          ),
                        ],
                      ),
                      kHeight10,
                      Text(
                        news.title == null || news.title!.isEmpty
                            ? 'No Data Available'
                            : news.title!,
                        style: TextStyle(
                          color: kBlackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                      kHeight10,
                      Row(
                        children: [
                          Icon(
                            Icons.person_pin,
                            color: kBlackColor.withOpacity(0.5),
                            size: 30.sp,
                          ),
                          SizedBox(width: 7.w),
                          Expanded(
                            child: Text(
                              news.author == null || news.author!.isEmpty
                                  ? 'Unknown'
                                  : news.author.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: kBlackColor.withOpacity(0.5),
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      kHeight10,
                      Text(
                        news.source!.name == null || news.source!.name!.isEmpty
                            ? 'No Data Available'
                            : news.source!.name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: kMainColor,
                          fontSize: 15.sp,
                        ),
                      ),
                      Text(
                        DateFormat('MMM d, yyyy h:mm a').format(
                          DateTime.parse(
                            news.publishedAt.toString(),
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: kBlackColor.withOpacity(0.5),
                          fontSize: 15.sp,
                        ),
                      ),
                      kHeight10,
                      Text(
                        news.content == null
                            ? 'No Data Available'
                            : news.content.toString(),
                        style: TextStyle(
                          color: kBlackColor,
                          fontSize: 15.sp,
                        ),
                      ),
                      kHeight10,
                      TextButton(
                        onPressed: () => _launchURL(context, news.url ?? ''),
                        child: Text(
                          'Read More - ${news.url == null ? 'No Data' : news.url!}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kMainColor,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(BuildContext context, String url) async {
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Url is not working')),
      );
      return;
    }
    if (!await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
