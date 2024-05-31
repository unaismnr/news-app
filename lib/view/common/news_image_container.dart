import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/utils/color_consts.dart';

class NewsImageContainer extends StatelessWidget {
  final ImageProvider<Object> image;
  const NewsImageContainer({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kMainColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.w),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: image,
        ),
      ),
    );
  }
}
