import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controllers/favorite_provider.dart';
import 'package:news_app/models/favorite_model.dart';
import 'package:news_app/models/news_data_model.dart';
import 'package:news_app/services/hive/favorite_db.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenSingleNews extends StatelessWidget {
  final NewsDataModel news;
  final bool isFavOrDelete;
  final bool isFromFav;
  const ScreenSingleNews({
    super.key,
    required this.news,
    required this.isFavOrDelete,
    this.isFromFav = false,
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
                            color: kMainColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: news.urlToImage != null &&
                                      news.urlToImage!.isNotEmpty
                                  ? NetworkImage(news.urlToImage!)
                                  : const AssetImage('assets/bg-image.png')
                                      as ImageProvider,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                isFromFav
                                    ? Navigator.pop(context)
                                    : const SizedBox();
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.grey.shade300,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Icon(
                                    isFavOrDelete
                                        ? Icons.favorite
                                        : Icons.delete,
                                    color: isAlreadyInFav
                                        ? kBlackColor
                                        : kMainColor,
                                    size: 25,
                                  ),
                                ),
                              ),
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
                        Expanded(
                          child: Text(
                            news.author == null || news.author!.isEmpty
                                ? 'Unknown'
                                : news.author.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: kBlackColor.withOpacity(0.5),
                              fontSize: 15,
                            ),
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
                    TextButton(
                      onPressed: () {
                        _launchURL(
                          context,
                          news.url != null && news.url!.isNotEmpty
                              ? news.url!
                              : '',
                        );
                      },
                      child: Text(
                        'Read More - ${news.url == null ? 'No Data' : news.url!}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: kMainColor,
                          fontSize: 15,
                        ),
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

  Future<void> _launchURL(BuildContext context, String url) async {
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Url is not working')),
      );
    }
    if (!await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
