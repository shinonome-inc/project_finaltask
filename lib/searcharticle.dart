import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/pages/articlepage.dart';
import 'package:project_finaltask/utils/changedate.dart';

import '../models/article.dart';
import '../qiita_qlient.dart';
import '../utils/color_extension.dart';

class SearchListView extends StatefulWidget {
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  int page = 1;
  bool _isLoading = false;
  bool _isSearching = false;
  String searchword = "";
  List<Article> _searchList = [];

  // _SearchListState() {
  //   _searchQuery.addListener(() {
  //     if (_searchQuery.text.isEmpty) {
  //       setState(() {
  //         _isSearching = false;
  //         _searchText = "";
  //       });
  //     } else {
  //       setState(() {
  //         _isSearching = true;
  //         _searchText = _searchQuery.text;
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    this._loadArticle();
    _isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (!_isLoading && notification.metrics.extentAfter == 0.0) {
            _loadArticle();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: _searchList.length,
          itemBuilder: (BuildContext context, int index) {
            final article = _searchList[index];
            return index >= _searchList.length
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(article.user.iconUrl),
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
                                color: '#B2B2B2'.toColor(), width: 0.5)),
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

  void _loadArticle() async {
    try {
      _isLoading = true;
      var articleList = await QiitaClient().fetchArticle(page);
      {
        page++;
        setState(() {
          if (page == 1) {
            _searchList = articleList;
          } else if (page != 1) {
            _searchList.addAll(articleList);
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
}
