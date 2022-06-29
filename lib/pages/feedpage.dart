import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/models/article.dart';
import 'package:project_finaltask/pages/articlelistview.dart';

import '../qiita_client.dart';
import '../utils/color_extension.dart';
import '../view.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  String searchword = '';
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
    print(searchword);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
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
                      loadArticle();
                    });
                  }),
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
                      ? ArticleListView(articleList: articleList)
                      : _isLoading
                          ? CircularProgressIndicator()
                          : EmptyView(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error!}');
              } else
                return const CircularProgressIndicator();
            }),
      ),
    );
  }

  void loadArticle() async {
    setState(() {
      _isLoading = true;
    });
    List<Article> results = await QiitaClient().fetchArticle(page, searchword);
    setState(() {
      page++;
      articleList.addAll(results);
    });
    setState(() {
      _isLoading = false;
    });
  }
}
