import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/controllers/search_provider.dart';
import 'package:news_app/services/apis/get_category_news_api.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:news_app/view/common/navigation_helper.dart';
import 'package:news_app/view/common/single_news_widget.dart';
import 'package:news_app/view/news/screen_single_news.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: CupertinoSearchTextField(
          prefixIcon: const SizedBox(),
          onChanged: (value) {
            final text = value.trim();
            Provider.of<SearchProvider>(
              context,
              listen: false,
            ).searchQuery(text);
          },
          backgroundColor: Colors.grey.shade200,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Consumer<SearchProvider>(
            builder: (context, newSearch, _) {
              return FutureBuilder(
                  future: getCategoryNewsApi(
                    newSearch.searchText.toString(),
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
                        child: Text('Nothing Found'),
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                        'An error occurred\n Try again later',
                      );
                    } else if (snapshot.hasData) {
                      return Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                            horizontal: 15.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18.r),
                              topRight: Radius.circular(18.r),
                            ),
                            color: kBlackColor.withOpacity(0.05),
                          ),
                          child: ListView.separated(
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
                                        isFavOrDelete: false,
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
                            ),
                            itemCount: snapshot.data!.length,
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
