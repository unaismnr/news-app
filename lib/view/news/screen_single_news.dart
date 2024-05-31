import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controllers/favorite_provider.dart';
import 'package:news_app/models/favorite_model.dart';
import 'package:news_app/models/news_data_model.dart';
import 'package:news_app/services/hive/favorite_db.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenSingleNews extends StatelessWidget {
  final NewsDataModel news;
  final bool isFavOrDelete;
  final bool isFromFav;
  const ScreenSingleNews({
    super.key,
    required this.news,
    required this.isFavOrDelete,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.w),
                  topRight: Radius.circular(18.w),
                ),
                color: kBlackColor.withOpacity(0.05),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 200.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kMainColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.w),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: news.urlToImage != null &&
                                      news.urlToImage!.isNotEmpty
                                  ? NetworkImage(news.urlToImage!)
                                  : const AssetImage('assets/bg-image.png')
                                      as ImageProvider,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: InkWell(
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
                                isAlreadyInFav && isFavOrDelete
                                    ? FavoriteDb.instance.addFavorite(favorites)
                                    : FavoriteDb.instance.deleteFavorite(
                                        favorites.url!,
                                      );
                                favProvider.getFavoriteNews();
                                isFromFav
                                    ? Navigator.pop(context)
                                    : const SizedBox();
                              },
                              child: CircleAvatar(
                                radius: 15.w,
                                backgroundColor: Colors.grey.shade300,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 1.h),
                                  child: Icon(
                                    isFavOrDelete
                                        ? Icons.favorite
                                        : Icons.delete,
                                    color: isAlreadyInFav
                                        ? kBlackColor
                                        : kMainColor,
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
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
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(
                          Icons.person_pin,
                          color: kBlackColor.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 7.w,
                        ),
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
                    SizedBox(
                      height: 10.h,
                    ),
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      news.content == null
                          ? 'No Data Available'
                          : news.content.toString(),
                      style: TextStyle(
                        color: kBlackColor,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
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
          ],
        ),
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
