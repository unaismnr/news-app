import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controllers/favorite_provider.dart';
import 'package:news_app/models/favorite_model.dart';
import 'package:news_app/models/news_data_model.dart';
import 'package:news_app/services/hive/favorite_db.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleNewsWidget extends StatelessWidget {
  final bool isMaxLinesWant;
  final NewsDataModel news;
  final bool isFavOrDelete;
  const SingleNewsWidget({
    super.key,
    required this.isMaxLinesWant,
    required this.news,
    this.isFavOrDelete = true,
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
    return Column(
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
                  image: news.urlToImage != null && news.urlToImage!.isNotEmpty
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
                  },
                  child: CircleAvatar(
                    radius: 15.w,
                    backgroundColor: Colors.grey.shade300,
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: Icon(
                        isFavOrDelete ? Icons.favorite : Icons.delete,
                        color: isAlreadyInFav ? kBlackColor : kMainColor,
                        size: 25.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          news.title == null || news.title!.isEmpty
              ? 'No Data Available'
              : news.title!,
          maxLines: isMaxLinesWant ? 2 : null,
          overflow: isMaxLinesWant ? TextOverflow.ellipsis : null,
          style: TextStyle(
            color: kBlackColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(
          height: 4.h,
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
      ],
    );
  }
}
