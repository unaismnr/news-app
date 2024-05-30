import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_data_model.dart';
import 'package:news_app/utils/color_consts.dart';

class SingleNewsWidget extends StatelessWidget {
  final bool isMaxLinesWant;
  final NewsDataModel news;
  const SingleNewsWidget({
    super.key,
    required this.isMaxLinesWant,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  image: news.urlToImage != null && news.urlToImage!.isNotEmpty
                      ? NetworkImage(news.urlToImage!)
                      : const AssetImage('assets/news-app-logos.png')
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
          height: MediaQuery.of(context).size.height * 0.008,
        ),
        Text(
          news.title.toString(),
          maxLines: isMaxLinesWant ? 2 : null,
          overflow: isMaxLinesWant ? TextOverflow.ellipsis : null,
          style: const TextStyle(
            color: kBlackColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          news.description.toString(),
          maxLines: isMaxLinesWant ? 2 : null,
          overflow: isMaxLinesWant ? TextOverflow.ellipsis : null,
          style: TextStyle(
            color: isMaxLinesWant ? kBlackColor.withOpacity(0.6) : kBlackColor,
            fontSize: 15,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              news.source!.name.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: kMainColor,
                fontSize: 15,
              ),
            ),
            Text(
              DateFormat.MMMEd().format(
                DateTime.parse(
                  news.publishedAt.toString(),
                ),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kBlackColor.withOpacity(0.5),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
