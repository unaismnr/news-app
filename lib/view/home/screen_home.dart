import 'package:flutter/material.dart';
import 'package:news_app/controllers/favorite_provider.dart';
import 'package:news_app/controllers/search_provider.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:news_app/view/common/navigation_helper.dart';
import 'package:news_app/view/favorites/screen_favorites.dart';
import 'package:news_app/view/home/news_list_widget.dart';
import 'package:news_app/view/search/screen_search.dart';
import 'package:page_transition/page_transition.dart';
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
              padding: const EdgeInsets.only(left: 10),
              child: TabBar(
                indicatorColor: kMainColor,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicator: BoxDecoration(
                  border: Border.all(
                    color: kMainColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                indicatorPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                overlayColor: const MaterialStatePropertyAll(
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
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  color: kBlackColor.withOpacity(0.05),
                ),
                child: const TabBarView(
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
              ),
            ),
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
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.38,
    ),
    actions: [
      InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          Provider.of<SearchProvider>(
            context,
            listen: false,
          ).resetSearch();
          Navigator.of(context).push(
            PageTransition(
              child: const ScreenSearch(),
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 150),
            ),
          );
        },
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          child: const Padding(
            padding: EdgeInsets.only(top: 1),
            child: Icon(
              Icons.search_rounded,
              color: kBlackColor,
              size: 30,
            ),
          ),
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.02,
      ),
      InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          NavigationHelper.push(
            context,
            const ScreenFavorites(),
          );
        },
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          child: const Padding(
            padding: EdgeInsets.only(top: 1),
            child: Icon(
              Icons.favorite_border,
              color: kBlackColor,
              size: 30,
            ),
          ),
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.04,
      ),
    ],
  );
}
