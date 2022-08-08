import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/components/appbar_component.dart';
import 'package:project_finaltask/models/tag.dart';
import 'package:project_finaltask/views/article_list_view.dart';
import 'package:project_finaltask/views/error_view.dart';

import '../models/article.dart';
import '../qiita_client.dart';
import '../utils/color_extension.dart';

class TagDetailPage extends StatefulWidget {
  late final Tag tag;
  TagDetailPage(this.tag);

  @override
  _TagDetailPageState createState() => _TagDetailPageState();
}

class _TagDetailPageState extends State<TagDetailPage> {
  List<Article> articleList = [];
  bool _isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    loadArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(text: widget.tag.id, backButton: true),
      body: Center(
        child: FutureBuilder<List<Article>>(
            future: QiitaClient().fetchTagArticle(page, widget.tag.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (!_isLoading &&
                        notification.metrics.extentAfter == 0.0) {
                      loadArticle();
                    }
                    return false;
                  },
                  child: articleList.isNotEmpty
                      ? Column(children: [
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            child: Text(
                              " 投稿記事",
                              style: TextStyle(
                                fontSize: 12,
                                color: '#828282'.toColor(),
                              ),
                            ),
                            color: '#F2F2F2'.toColor(),
                            height: 28,
                            width: double.infinity,
                            alignment: Alignment(-1, 0),
                          ),
                          Flexible(
                            child: ArticleListView(articleList: articleList),
                          ),
                        ])
                      : _isLoading
                          ? CupertinoActivityIndicator()
                          : Center(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text('投稿記事がありません'),
                              ),
                            ),
                );
              } else if (snapshot.hasError) {
                return ErrorView();
              }
              return CupertinoActivityIndicator();
            }),
      ),
    );
  }

  void loadArticle() async {
    _isLoading = true;
    List<Article> results =
        await QiitaClient().fetchTagArticle(page, widget.tag.id);
    page++;
    articleList.addAll(results);
    setState(() {
      _isLoading = false;
    });
  }
}