import 'package:flutter/material.dart';
import 'package:news_app/utils/color_consts.dart';

class SingleNewsWidget extends StatelessWidget {
  final bool isMaxLinesWant;
  const SingleNewsWidget({
    super.key,
    required this.isMaxLinesWant,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.21,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: kMainColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.008,
        ),
        Text(
          'This is Title for news',
          maxLines: isMaxLinesWant ? 2 : null,
          overflow: isMaxLinesWant ? TextOverflow.ellipsis : null,
          style: const TextStyle(
            color: kBlackColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          'This is Title for news',
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
              'This is',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kBlackColor.withOpacity(0.5),
                fontSize: 15,
              ),
            ),
            Text(
              'Title for news',
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
