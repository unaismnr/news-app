import 'package:flutter/material.dart';
import 'package:news_app/utils/color_consts.dart';

Widget songsListWidget(
  String title,
  String description,
  VoidCallback butttonOnpPress,
  int itemCount,
  VoidCallback onTap,
) {
  return ListView.separated(
    itemBuilder: (context, index) => ListTile(
      leading: const CircleAvatar(
        radius: 20,
        backgroundColor: kMainColor,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: butttonOnpPress,
        icon: const Icon(
          Icons.more_vert,
        ),
      ),
      onTap: onTap,
    ),
    separatorBuilder: (context, index) => Divider(
      indent: 72,
      color: Theme.of(context).colorScheme.secondary,
    ),
    itemCount: itemCount,
  );
}
