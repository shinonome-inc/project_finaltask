import 'package:flutter/material.dart';
import 'package:project_finaltask/pages/followerpage.dart';
import 'package:project_finaltask/pages/followpage.dart';
import 'package:project_finaltask/views/errorview.dart';
import 'package:project_finaltask/views/user_articlelistview.dart';

import '../models/article.dart';
import '../models/user.dart';
import '../qiita_client.dart';
import '../utils/color_extension.dart';

class UserView extends StatefulWidget {
  late final User user;
  UserView(this.user);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  List<Article> articleList = [];
  bool _isDataLoading = false;
  bool _isLoading = false;
  int page = 1;

  bool _isError = false;

  Future<void> fetchUserData() async {
    setState(() {
      _isDataLoading = true;
    });
    try {
      articleList =
          await QiitaClient().fetchArticle(page, 'user%3A${widget.user.id}');
      _isDataLoading = false;
    } catch (e) {
      _isError = true;
      print(e);
    }
    setState(() {
      _isDataLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    loadArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isDataLoading
            ? Center(child: CircularProgressIndicator())
            : _isError
                ? ErrorView()
                : Column(children: [
                    _UserProfile(user: widget.user),
                    NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        if (!_isLoading &&
                            notification.metrics.extentAfter == 0.0) {
                          loadArticle();
                        }
                        return true;
                      },
                      child: articleList.isNotEmpty
                          ? Expanded(
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
                          : Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '投稿記事がありません',
                                  style: TextStyle(color: '#B2B2B2'.toColor()),
                                ),
                              ),
                            ),
                    ),
                  ]));
  }

  void loadArticle() async {
    _isLoading = true;
    List<Article> results =
        await QiitaClient().fetchArticle(page, 'user%3A${widget.user.id}');
    page++;
    articleList.addAll(results);
    setState(() {
      _isLoading = false;
    });
  }
}

class _UserProfile extends StatelessWidget {
  final User user;
  const _UserProfile({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.iconUrl),
            radius: 40,
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              user.name ?? user.id,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Text('@${user.id}',
              style: TextStyle(
                fontSize: 12,
                color: '#828282'.toColor(),
              )),
          SizedBox(height: 8),
          Text(user.description ?? '未設定',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: '#828282'.toColor(),
              )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${user.followeescount}',
                style: TextStyle(
                  color: '#000000'.toColor(),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FollowPage(user);
                    }));
                  },
                  child: Text(
                    'フォロー中',
                    style: TextStyle(
                      color: '#828282'.toColor(),
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                    ),
                  )),
              Text(
                '${user.followerscount}',
                style: TextStyle(
                  color: '#000000'.toColor(),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FollowerPage(user);
                    }));
                  },
                  child: Text(
                    'フォロワー',
                    style: TextStyle(
                      color: '#828282'.toColor(),
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
