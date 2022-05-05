import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/models/article.dart';
import 'package:project_finaltask/utils/changedate.dart';

import '../qiita_qlient.dart';
import '../utils/color_extension.dart';
import 'articlepage.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  String searchword = "";
  //List<Article> articlegetList =
  //bool _isSearching = false;
  List<Article> articleList = [];

  bool _isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    loadArticle(searchword);
  }

  @override
  Widget build(BuildContext context) {
    print(searchword);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Feed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Pacifico',
                color: '#000000'.toColor(),
              ),
            ),
            Container(
              height: 36,
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (String word) {
                    articleList.clear();
                    setState(() {
                      searchword = word;
                      loadArticle(searchword);
                    });
                  }),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
            future: QiitaClient().fetchArticle(1),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (!_isLoading &&
                        notification.metrics.extentAfter == 0.0) {
                      loadArticle(searchword);
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
                      : _isLoading
                          ? CircularProgressIndicator()
                          : _emptyView(),
                );
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  void loadArticle(searchword) async {
    //List<Article> results = [];
    //新たなデータを取得
    try {
      _isLoading = true;
      List<Article> results =
          await QiitaClient().fetchArticle(page, searchword);
      // {
      //   if (searchword.isEmpty) {
      //     results = articlegetList;
      //   } else {
      //     setState(() {
      //       results = articlegetList
      //           .where((element) => element.title.contains(searchword))
      //           .toList();
      //     });
      //}
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

// class _ArticleListView extends StatelessWidget {
//   final bool _isLoading = false;
//   final List<Article> articleList;
//   final String searchword;
//   final Function(String searchword) loadArticle;
//
//   const _ArticleListView({
//     Key? key,
//     required this.articleList,
//     required this.searchword,
//     required this.loadArticle,
//   }) : super(key: key);
