import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/pages/articlepage.dart';
import 'package:project_finaltask/utils/changedate.dart';

import '../models/article.dart';
import '../utils/color_extension.dart';

class ArticleListView extends StatelessWidget {
  final List<Article> articleList;
  const ArticleListView({Key? key, required this.articleList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articleList.length,
      itemBuilder: (BuildContext context, int index) {
        final article = articleList[index];
        return index >= articleList.length
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(article.user.iconUrl),
                ),
                title: Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: '#B2B2B2'.toColor(), width: 0.5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '@${article.user.id} 投稿日:${changeDateFormat(article.date)} LGTM:${article.lgtm.toString()}',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArticlePage(article: article)));
                });
      },
    );
  }
}
