import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/pages/articlepage.dart';
import 'package:project_finaltask/utils/changedate.dart';

import '../models/article.dart';
import '../qiita_qlient.dart';
import '../utils/color_extension.dart';

class ArticleListView extends StatefulWidget {
  State<ArticleListView> createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  int page = 1;
  bool _isLoading = false;
  List<Article> _articleList = [];

  @override
  void initState() {
    super.initState();
    _loadArticle();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification.metrics.extentAfter == 0.0) {
            _loadArticle();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: _articleList.length,
          itemBuilder: (BuildContext context, int index) {
            final article = _articleList[index];
            // if (index == _articleList.length) {
            // return CircularProgressIndicator();
            //}
            //else if(index > _articleList.length){return null;}
            return ListTile(
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
              },
            );
          },
        ));
  }

  void _loadArticle() async {
    if (_isLoading) {
      return;
    }
//新たなデータを取得
    try {
      page++;
      var articleList = await QiitaClient().fetchArticle(page);
      {
        setState(() {
          if (page == 1) {
            _articleList = articleList;
          } else if (page != 1) {
            _articleList.addAll(articleList);
          }
          //_currentPage = page;
        });
      }
    } on Exception catch (e) {
      setState(() {
        print(e);
      });
    }
    _isLoading = false;
  }
}
