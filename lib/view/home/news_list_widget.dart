import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/services/apis/get_category_news_api.dart';
import 'package:news_app/services/apis/get_top_headline_api.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:news_app/view/common/navigation_helper.dart';
import 'package:news_app/view/common/single_news_widget.dart';
import 'package:news_app/view/news/screen_single_news.dart';

class NewsListWidget extends StatelessWidget {
  final bool isTopHeadline;
  final String category;
  const NewsListWidget({
    super.key,
    this.isTopHeadline = false,
    this.category = '',
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isTopHeadline
          ? getTopHeadlineApi()
          : getCategoryNewsApi(
              category,
            ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No Data'),
          );
        } else if (snapshot.hasError) {
          return const Text(
            'An error occurred\n Try again later',
          );
        } else if (snapshot.hasData) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final news = snapshot.data![index];
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
                        isFavOrDelete: true,
                      ),
                    );
                  },
                  child: SingleNewsWidget(
                    isMaxLinesWant: true,
                    news: news,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: kBlackColor.withOpacity(0.2),
              height: 1.h,
            ),
            itemCount: snapshot.data!.length,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
