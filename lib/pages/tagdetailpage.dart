import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/components/appbar.dart';
import 'package:project_finaltask/models/tag.dart';
import 'package:project_finaltask/pages/articlelistview.dart';

import '../models/article.dart';
import '../qiita_qlient.dart';
import '../utils/color_extension.dart';
import '../view.dart';

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
  //final Future<List<Article>> articles =
  //  QiitaClient().fetchArticle(1, "", tag.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(text: 'Tag', backButton: true),
      body: Center(
        child: FutureBuilder<List<Article>>(
            future: QiitaTagArticle().fetchArticle(widget.tag, 1),
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
                              "  投稿記事",
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
                      : EmptyView(),
                );
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  void loadArticle() async {
    //新たなデータを取得
    try {
      _isLoading = true;
      List<Article> results =
          await QiitaTagArticle().fetchArticle(widget.tag, page);
      page++;
      setState(() {
        if (page == 1) {
          articleList = results;
        } else if (page != 1) articleList.addAll(results);
      });
      _isLoading = false;
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }
}
