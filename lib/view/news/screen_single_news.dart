import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_data_model.dart';
import 'package:news_app/utils/color_consts.dart';

class ScreenSingleNews extends StatelessWidget {
  final NewsDataModel news;
  const ScreenSingleNews({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
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
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.21,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: kMainColor,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: news.urlToImage != null &&
                                      news.urlToImage!.isNotEmpty
                                  ? NetworkImage(news.urlToImage!)
                                  : const AssetImage(
                                          'assets/news-app-logos.png')
                                      as ImageProvider,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border,
                              color: kWhiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      news.title == null || news.title!.isEmpty
                          ? 'No Data Available'
                          : news.title!,
                      style: const TextStyle(
                        color: kBlackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person_pin,
                          color: kBlackColor.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.007,
                        ),
                        Text(
                          news.author == null || news.author!.isEmpty
                              ? 'Unknown'
                              : news.author.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kBlackColor.withOpacity(0.5),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      news.source!.name == null || news.source!.name!.isEmpty
                          ? 'No Data Available'
                          : news.source!.name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: kMainColor,
                        fontSize: 15,
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
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      news.content == null
                          ? 'No Data Available'
                          : news.content.toString(),
                      style: const TextStyle(
                        color: kBlackColor,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'Read More - ${news.url == null ? 'No Data' : news.url.toString()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: kBlackColor,
                        fontSize: 15,
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
}
