import 'package:flutter/material.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:news_app/view/common/navigation_helper.dart';
import 'package:news_app/view/common/single_news_widget.dart';
import 'package:news_app/view/news/screen_single_news.dart';

Widget newsListWidget(
  String title,
  String description,
  VoidCallback butttonOnpPress,
  int itemCount,
  VoidCallback onTap,
) {
  return ListView.separated(
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 5,
        ),
        child: InkWell(
            onTap: () {
              NavigationHelper.pushRightToLeft(
                context,
                const ScreenSingleNews(),
              );
            },
            child: const SingleNewsWidget(isMaxLinesWant: true)),
      );
    },
    separatorBuilder: (context, index) => Divider(
      color: kBlackColor.withOpacity(0.2),
    ),
    itemCount: itemCount,
  );
}
