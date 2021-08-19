import 'package:flutter/material.dart';
import 'package:frontend/pages/main/widgets/article_area.dart';
import 'package:frontend/pages/main/widgets/main_banner.dart';
import 'package:frontend/pages/main/widgets/tags_box.dart';
import 'package:frontend/widgets/custom_base.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBase(
        banner: MainBanner(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: ArticleArea(),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: TagsBox(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
