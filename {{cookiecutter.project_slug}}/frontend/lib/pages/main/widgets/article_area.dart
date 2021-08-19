import 'package:flutter/material.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/api/api_models.dart';
import 'package:frontend/pages/main/widgets/pagination_input.dart';

class ArticleArea extends StatefulWidget {
  const ArticleArea();

  @override
  _ArticleAreaState createState() => _ArticleAreaState();
}

class _ArticleAreaState extends State<ArticleArea> {
  final int articlesPerPage = 10;

  List<ArticleItem> articles = [];
  int numOfPages = 0;
  int currentPage = 1;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _loadArticles();
    });
  }

  Future<void> _loadArticles() async {
    try {
      isLoading = true;
      final res = await Api.articlesGet(
        context,
        ArticlesGetRequest(
          limit: articlesPerPage.toString(),
          offset: (articlesPerPage * (currentPage - 1)).toString(),
        ),
      );
      articles = res.articles;
      numOfPages = (res.articlesCount / articlesPerPage).ceil();
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...articles
              .map(
                (article) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black12))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: Container(
                              height: 30,
                              child: Image.network(
                                article.author.image,
                                errorBuilder: (_, __, ___) => Image.network(
                                  'https://static.productionready.io/images/smiley-cyrus.jpg',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                article.author.username,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SelectableText(
                                article.createdAt,
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            width: 40,
                            height: 25,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                  (state) =>
                                      state.contains(MaterialState.hovered)
                                          ? Theme.of(context).primaryColor
                                          : null,
                                ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith(
                                  (state) =>
                                      state.contains(MaterialState.hovered)
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(
                                      width: 1.2,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 13,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    article.favoritesCount.toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        article.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        article.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black38,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Read more...',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          if (isLoading)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black12),
                ),
              ),
              child: Text('Loading articles...'),
            ),
          PaginationInput(
            numOfPages: numOfPages,
            currentPage: currentPage,
            onChanged: (page) {
              currentPage = page;
              setState(() {});
              _loadArticles();
            },
          ),
        ],
      ),
    );
  }
}
