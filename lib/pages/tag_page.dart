import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/components/appbar_component.dart';
import 'package:project_finaltask/models/tag.dart';
import 'package:project_finaltask/qiita_client.dart';

import '../views/error_view.dart';
import '../views/tag_grid_view.dart';

class TagPage extends StatefulWidget {
  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  List<Tag> tagList = [];
  bool _isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    loadTag();
  }

  @override
  Widget build(BuildContext context) {
    print(page);
    return Scaffold(
      appBar: AppBarComponent(text: 'Tag'),
      body: Center(
        child: FutureBuilder<List<Tag>>(
            future: QiitaClient().fetchTag(page),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (!_isLoading &&
                        notification.metrics.extentAfter == 0.0) {
                      loadTag();
                    }
                    return false;
                  },
                  child: tagList.isNotEmpty
                      ? CustomScrollView(
                          physics: BouncingScrollPhysics(),
                          slivers: [
                            CupertinoSliverRefreshControl(
                                onRefresh: refreshTag),
                            SliverToBoxAdapter(
                                child: TagGridView(tags: tagList)),
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

  Future<void> loadTag() async {
    _isLoading = true;
    List<Tag> results = await QiitaClient().fetchTag(page);
    page++;
    tagList.addAll(results);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> refreshTag() async {
    page = 1;
    _isLoading = true;
    List<Tag> results = await QiitaClient().fetchTag(page);
    page++;
    setState(() {
      tagList = results;
      _isLoading = false;
    });
  }
}
