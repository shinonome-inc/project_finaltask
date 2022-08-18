import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/components/appbar_component.dart';
import 'package:project_finaltask/models/tag.dart';
import 'package:project_finaltask/views/article_list_view.dart';
import 'package:project_finaltask/views/error_view.dart';

import '../models/article.dart';
import '../qiita_client.dart';

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
    print(page);
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
                      ? CustomScrollView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          slivers: [
                            CupertinoSliverRefreshControl(
                                onRefresh: refreshArticle),
                            SliverToBoxAdapter(
                              child: ArticleListView(
                                  articleList: articleList, header: true),
                            )
                          ],
                        )
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
              } else
                return CupertinoActivityIndicator();
            }),
      ),
    );
  }

  Future<void> loadArticle() async {
    _isLoading = true;
    List<Article> results =
        await QiitaClient().fetchTagArticle(page, widget.tag.id);
    page++;
    articleList.addAll(results);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> refreshArticle() async {
    page = 1;
    _isLoading = true;
    List<Article> results =
        await QiitaClient().fetchTagArticle(page, widget.tag.id);
    page++;
    setState(() {
      articleList = results;
      _isLoading = false;
    });
  }
}
