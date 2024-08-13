import 'package:finance/app/global_navigator/global_navigator.dart';
import 'package:finance/core/data/news_data.dart';
import 'package:finance/core/extensions/align_ext_on_widget.dart';
import 'package:finance/core/extensions/padding_extension_on_widget.dart';
import 'package:finance/features/main/news/detail_news/detail_news_screen.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
      children: [
        const Text(
          'News',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ).paddingOnly(bottom: 45).align(),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 140,
            mainAxisSpacing: 12,
            crossAxisSpacing: 4,
          ),
          itemCount: news.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            final item = news[index];
            return Container(
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.10000000149011612),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
              child: Column(
                children: [
                  Container(
                    width: 106,
                    height: 30,
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.15000000596046448),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).paddingOnly(bottom: 10),
                  Text(
                    item.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ).paddingOnly(bottom: 9),
                  GestureDetector(
                    onTap: () {
                      GlobalNavigator.push(context,
                          page: DetailNewsScreen(
                            item: item,
                          ));
                    },
                    child: Container(
                      width: 82,
                      height: 20,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFB3883B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Read',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ).align(Alignment.centerRight),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
