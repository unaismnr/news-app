import 'package:flutter/material.dart';
import 'package:news_app/utils/color_consts.dart';
import 'package:news_app/view/common/single_news_widget.dart';

class ScreenSingleNews extends StatelessWidget {
  const ScreenSingleNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhiteColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
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
                  color: Colors.grey.shade200,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: SingleNewsWidget(isMaxLinesWant: false),
                )),
          ],
        ),
      ),
    );
  }
}
