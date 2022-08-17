import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/views/error_view.dart';
import 'package:project_finaltask/views/user_article_list_view.dart';
import 'package:project_finaltask/views/user_view/user_profile.dart';

import '../../models/article.dart';
import '../../models/user.dart';
import '../../qiita_client.dart';
import '../../utils/color_extension.dart';

class UserView extends StatefulWidget {
  late final User user;
  UserView(this.user);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  List<Article> articleList = [];
  late User _user;
  User? _newUser;
  bool _isDataLoading = false;
  bool _isLoading = false;
  int page = 1;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    loadArticle();
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    print(page);
    return Scaffold(
        body: _isDataLoading
            ? Center(child: CupertinoActivityIndicator())
            : _isError
                ? ErrorView()
                : NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      if (!_isLoading &&
                          notification.metrics.extentAfter == 0.0) {
                        loadArticle();
                      }
                      return true;
                    },
                    child: CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          CupertinoSliverRefreshControl(
                              onRefresh: refreshUserData),
                          SliverToBoxAdapter(
                              child: SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: Column(children: [
                                UserProfile(user: _user),
                                articleList.isNotEmpty
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                268,
                                        child: Column(children: [
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
                                            child: UserArticleListView(
                                                articleList: articleList),
                                          ),
                                        ]),
                                      )
                                    : Container(
                                        padding: EdgeInsets.only(top: 72),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '投稿記事がありません',
                                          style: TextStyle(
                                              color: '#B2B2B2'.toColor()),
                                        ),
                                      ),
                              ]),
                            ),
                          ))
                        ]),
                  ));
  }

  Future<void> refreshUserData() async {
    _newUser = await QiitaClient().getUser(_user.id);
    setState(() {
      _user = _newUser!;
    });
  }

  Future<void> loadArticle() async {
    _isDataLoading = true;
    _isLoading = true;
    try {
      List<Article> results =
          await QiitaClient().fetchArticle(page, 'user%3A${widget.user.id}');
      page++;
      articleList.addAll(results);
      _isDataLoading = false;
    } catch (e) {
      _isError = true;
      print(e);
    }
    setState(() {
      _isDataLoading = false;
      _isLoading = false;
    });
  }
}
