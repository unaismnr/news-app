import 'package:flutter/material.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:news_app/view/common/navigation_helper.dart';
import 'package:news_app/view/home/news_list_widget.dart';
import 'package:news_app/view/search/screen_search.dart';
import 'package:news_app/view/settings/screen_settings.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _homeAppBar(context),
      body: DefaultTabController(
        length: 8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 1),
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
                  color: Colors.grey.shade200,
                ),
                child: const TabBarView(
                  children: [
                    NewListWidget(isTopHeadline: true),
                    NewListWidget(category: 'general'),
                    NewListWidget(category: 'business'),
                    NewListWidget(category: 'entertainment'),
                    NewListWidget(category: 'health'),
                    NewListWidget(category: 'science'),
                    NewListWidget(category: 'sports'),
                    NewListWidget(category: 'technology'),
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
    iconTheme: const IconThemeData(color: kBlackColor),
    backgroundColor: kWhiteColor,
    elevation: 0,
    title: Image.asset(
      'assets/news-app-logos.png',
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.38,
    ),
    actions: [
      IconButton(
        onPressed: () {
          NavigationHelper.pushRightToLeft(
            context,
            const ScreenSearch(),
          );
        },
        icon: const Icon(
          Icons.search,
          size: 28,
        ),
      ),
      IconButton(
        onPressed: () {
          NavigationHelper.pushRightToLeft(
            context,
            const ScreenSettings(),
          );
        },
        icon: const Icon(
          Icons.settings,
          size: 28,
        ),
      ),
      SizedBox(width: MediaQuery.of(context).size.width * 0.02)
    ],
  );
}
