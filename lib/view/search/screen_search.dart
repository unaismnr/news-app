import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controllers/search_provider.dart';
import 'package:news_app/services/apis/get_category_news_api.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:news_app/view/common/navigation_helper.dart';
import 'package:news_app/view/common/single_news_widget.dart';
import 'package:news_app/view/news/screen_single_news.dart';
import 'package:provider/provider.dart';

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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
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
                        'An error occured\n Try agin later',
                      );
                    } else if (snapshot.hasData) {
                      return Expanded(
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
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final news = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 5,
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
