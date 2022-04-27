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
  var articlegetList = QiitaClient().fetchArticle(1);
  bool _isSearching = false;
  //List<int> _searchIndexList = [];
  List<Article> articleList = [];
  String searchword = "";

  bool _isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    loadArticle(searchword);
  }

  @override
  Widget build(BuildContext context) {
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
                  // onPressed: () {
                  //   setState(() { //追加
                  //     _searchBoolean = true;
                  //   });
                  // }
                  onSubmitted: (String word) {
                    setState(() {
                      searchword = word;
                      _loadSearch(searchword);
                    });
                  }),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
            future: articlegetList,
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
                    child: ListView.builder(
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
                                          builder: (context) =>
                                              ArticlePage(article: article)));
                                },
                              );
                      },
                    ));
              }
              // _isSearching ? SearchListView() :
              //     _ArticleListView(
              //   searchword: searchword,
              //   loadArticle: (searchword) {},
              //   articleList: snapshot.data!.toList(),
              // );
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  void loadArticle(String searchword) async {
    List<Article> results = [];
    //新たなデータを取得
    try {
      _isLoading = true;
      var articlegetList = await QiitaClient().fetchArticle(page);
      {
        if (searchword.isEmpty) {
          results = articlegetList;
        } else {
          setState(() {
            results = articlegetList
                .where((element) => element.title.contains(searchword))
                .toList();
          });
        }
        page++;
        setState(() {
          if (page == 1) {
            articleList = results;
          } else if (page != 1) {
            articleList.addAll(results);
          }
          //_currentPage = page;
        });
        _isLoading = false;
      }
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }

  void _loadSearch(searchword) async {
    List<Article> _results = [];
    try {
      final articlegetList = await QiitaClient().fetchArticle(page);
      if (searchword.isEmpty) {
        _results = articlegetList;
      } else {
        setState(() {
          _results = articlegetList
              .where((element) => element.title.contains(searchword))
              .toList();
        });
      }
    } catch (e) {
      setState(() {
        print(e);
      });
    }
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
