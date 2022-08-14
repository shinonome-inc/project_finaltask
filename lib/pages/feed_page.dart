import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/models/article.dart';
import 'package:project_finaltask/views/article_list_view.dart';
import 'package:project_finaltask/views/empty_view.dart';
import 'package:project_finaltask/views/error_view.dart';

import '../qiita_client.dart';
import '../utils/color_extension.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  String searchWord = '';
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
    print(searchWord);
    print(page);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 114,
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
            SizedBox(height: 19),
            CupertinoSearchTextField(
              onSubmitted: (String word) {
                articleList.clear();
                setState(() {
                  searchWord = word;
                  refreshArticle();
                });
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
            future: QiitaClient().fetchArticle(page, ''),
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
                      ? CustomScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          physics: BouncingScrollPhysics(),
                          slivers: [
                            CupertinoSliverRefreshControl(
                                onRefresh: refreshArticle),
                            SliverToBoxAdapter(
                                child:
                                    ArticleListView(articleList: articleList)),
                          ],
                        )
                      : _isLoading
                          ? CupertinoActivityIndicator()
                          : CustomScrollView(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              physics: BouncingScrollPhysics(),
                              slivers: [
                                CupertinoSliverRefreshControl(
                                    onRefresh: refreshSearchWordArticle),
                                SliverToBoxAdapter(child: EmptyView()),
                              ],
                            ),
                );
              } else if (snapshot.hasError) {
                return ErrorView();
              } else
                return CupertinoActivityIndicator();
            }),
      ),
    );
  }

  Future<void> loadArticle() async {
    _isLoading = true;
    List<Article> results = await QiitaClient().fetchArticle(page, searchWord);
    page++;
    articleList.addAll(results);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> refreshArticle() async {
    page = 1;
    _isLoading = true;
    List<Article> results = await QiitaClient().fetchArticle(page, searchWord);
    page++;
    setState(() {
      articleList = results;
      _isLoading = false;
    });
  }

  Future<void> refreshSearchWordArticle() async {
    searchWord = '';
    refreshArticle();
  }
}
