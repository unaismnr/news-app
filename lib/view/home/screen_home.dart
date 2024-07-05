import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/controllers/favorite_provider.dart';
import 'package:news_app/controllers/search_provider.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:news_app/view/common/background_container.dart';
import 'package:news_app/view/common/circle_icon_widget.dart';
import 'package:news_app/view/common/navigation_helper.dart';
import 'package:news_app/view/favorites/screen_favorites.dart';
import 'package:news_app/view/news/news_list_widget.dart';
import 'package:news_app/view/search/screen_search.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<FavoriteProvider>(context).getFavoriteNews();
    return Scaffold(
      appBar: _homeAppBar(context),
      body: DefaultTabController(
        length: 8,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 1.h),
              child: TabBar(
                indicatorColor: kMainColor,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicator: BoxDecoration(
                  border: Border.all(
                    color: kMainColor,
                    width: 1.5.w,
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                indicatorPadding: EdgeInsets.symmetric(
                  vertical: 8.h,
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                ),
                overlayColor: WidgetStateProperty.all(
                  Colors.transparent,
                ),
                dividerColor: Colors.transparent,
                labelColor: kBlackColor,
                unselectedLabelColor: kBlackColor,
                tabs: const [
                  Tab(text: 'TOP HEADLINES'),
                  Tab(text: 'GENERAL'),
                  Tab(text: 'BUSINESS'),
                  Tab(text: 'ENTERTAINMENT'),
                  Tab(text: 'HEALTH'),
                  Tab(text: 'SCIENCE'),
                  Tab(text: 'SPORTS'),
                  Tab(text: 'TECHNOLOGY'),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            const Expanded(
                child: BackgroundContainer(
              child: TabBarView(
                children: [
                  NewsListWidget(isTopHeadline: true),
                  NewsListWidget(category: 'general'),
                  NewsListWidget(category: 'business'),
                  NewsListWidget(category: 'entertainment'),
                  NewsListWidget(category: 'health'),
                  NewsListWidget(category: 'science'),
                  NewsListWidget(category: 'sports'),
                  NewsListWidget(category: 'technology'),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

AppBar _homeAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    title: Image.asset(
      'assets/app-news.png',
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.35,
    ),
    actions: [
      CircleIconWidget(
        onTap: () {
          Provider.of<SearchProvider>(
            context,
            listen: false,
          ).resetSearch();
          NavigationHelper.push(
            context,
            const ScreenSearch(),
          );
        },
        radius: 20.w,
        iconColor: kBlackColor,
        iconSize: 28.w,
        icon: Icons.search_rounded,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.02,
      ),
      CircleIconWidget(
        onTap: () {
          NavigationHelper.push(
            context,
            const ScreenFavorites(),
          );
        },
        radius: 20.w,
        iconColor: kBlackColor,
        iconSize: 28.w,
        icon: Icons.favorite_border,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.04,
      ),
    ],
  );
}
