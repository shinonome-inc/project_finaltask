import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/models/tag.dart';
import 'package:project_finaltask/pages/articlepage.dart';
import 'package:project_finaltask/utils/changedate.dart';

import '../models/article.dart';
import '../qiita_qlient.dart';
import '../utils/color_extension.dart';

class TagDetailPage extends StatefulWidget {
  late final Tag tag;
  TagDetailPage(this.tag);

  @override
  _TagDetailPageState createState() => _TagDetailPageState();
}

class _TagDetailPageState extends State<TagDetailPage> {
  //late final Tag tag;
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.tag.id,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Pacifico',
            color: '#000000'.toColor(),
          ),
        ),
        backgroundColor: Colors.white,
      ),
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
                      ? ListView.builder(
                          itemCount: articleList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final article = articleList[index];
                            //else if(index > _articleList.length){return null;}
                            return index >= articleList.length
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(article.user.iconUrl),
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
                                            bottom: BorderSide(
                                                color: '#B2B2B2'.toColor(),
                                                width: 0.5)),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
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
                                              builder: (context) => ArticlePage(
                                                  article: article)));
                                    },
                                  );
                          },
                        )
                      : _emptyView(),
                );
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  void loadArticle() async {
    //List<Article> results = [];
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
        //_currentPage = page;
      });
      _isLoading = false;
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }

  Widget _emptyView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '検索にマッチする記事はありませんでした',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              '検索条件を変えるなどして再度検索をしてください',
              style: TextStyle(
                fontSize: 12,
                color: '#828282'.toColor(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
