import 'package:flutter/material.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:news_app/view/common/navigation_helper.dart';
import 'package:news_app/view/favorites/screen_favorites.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListTile(
        leading: const Icon(
          Icons.favorite_border,
          size: 30,
          color: kMainColor,
        ),
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        onTap: () {
          NavigationHelper.push(
            context,
            const ScreenFavorites(),
          );
        },
      ),
    );
  }
}
