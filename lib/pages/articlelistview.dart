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
  //int _currentPage = 1;
  bool _isLoading = false;
  List<Article> _articleList = [];

  @override
  void initState() {
    super.initState();
    _loadArticle(1);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.extentAfter == 0.0) {
          _loadArticle(_articleList.length + 1);
        }
        return true;
      },
      child: ListView.builder(
        itemCount: _articleList.length,
        itemBuilder: (BuildContext context, int index) {
          final article = _articleList[index];
          if (index == _articleList.length) {
            return CircularProgressIndicator();
          }
          return Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: '#B2B2B2'.toColor(), width: 0.5)),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(article.user.iconUrl),
              ),
              title: Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                  '@${article.user.id} 投稿日:${changeDateFormat(article.date)} LGTM:${article.lgtm.toString()}'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ArticlePage(article: article)));
              },
            ),
          );
        },
      ),
    );
  }

  void _loadArticle(int page) {
    if (_isLoading) {
      return;
    }
    QiitaClient.fetchArticle(page).then((articleList) {
      setState(() {
        if (page == 1) {
          _articleList = articleList;
        } else if (page != 1) {
          _articleList.addAll(articleList);
        }
        //_currentPage = page;
      });
    }).catchError((e) {
      setState(() {
        print("Error");
      });
    }).whenComplete(() {
      _isLoading = false;
    });
    _isLoading = true;
  }
}
