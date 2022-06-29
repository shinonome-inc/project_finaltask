import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/components/appbar.dart';
import 'package:project_finaltask/pages/articlelistview.dart';

import '../models/article.dart';
import '../models/user.dart';
import '../qiita_client.dart';
import '../utils/color_extension.dart';
import '../view.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<Article> articleList = [];
  final Future<User> user = QiitaClient().getAuthenticatedUser();
  final Future<List<Article>> userarticle = QiitaClient().fetchUserArticle();

  bool _isLoading = false;
  bool _isLogined = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    checklogin();
    loadArticle();
  }

  void checklogin() async {
    _isLogined = await QiitaClient().accessTokenIsSaved();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(text: 'MyPage'),
      body: Center(
          child: _isLogined
              ? Column(
                  children: [
                    FutureBuilder<User>(
                        future: user,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return _UserProfile(user: snapshot.data!);
                          }
                          return CircularProgressIndicator();
                        }),
                    FutureBuilder<List<Article>>(
                        future: userarticle,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return NotificationListener<ScrollNotification>(
                                onNotification:
                                    (ScrollNotification notification) {
                                  if (!_isLoading &&
                                      notification.metrics.extentAfter == 0.0) {
                                    loadArticle();
                                  }
                                  return true;
                                },
                                child: articleList.isNotEmpty
                                    ? Column(children: [
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
                                          child: ArticleListView(
                                              articleList: articleList),
                                        ),
                                      ])
                                    : Center(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text('投稿記事がありません'),
                                        ),
                                      ));
                          }
                          return CircularProgressIndicator();
                        }),
                  ],
                )
              : NotLoginView()),
    );
  }

  void loadArticle() async {
    setState(() {
      _isLoading = true;
    });
    List<Article> results = await QiitaClient().fetchUserArticle();
    setState(() {
      page++;
      articleList.addAll(results);
    });
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.iconUrl),
            radius: 40,
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              user.name,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Text('@${user.id}',
              style: TextStyle(
                fontSize: 12,
                color: '#828282'.toColor(),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(user.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: '#828282'.toColor(),
                )),
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {},
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                          ),
                          children: [
                        TextSpan(
                            text: '${user.followeescount}',
                            style: TextStyle(
                              color: '#000000'.toColor(),
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                            text: 'フォロー中',
                            style: TextStyle(
                              color: '#828282'.toColor(),
                            )),
                      ]))),
              TextButton(
                  onPressed: () {},
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                          ),
                          children: [
                        TextSpan(
                            text: '${user.followerscount}',
                            style: TextStyle(
                              color: '#000000'.toColor(),
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                            text: 'フォロワ―',
                            style: TextStyle(
                              color: '#828282'.toColor(),
                            )),
                      ]))),
            ],
          ),
          SizedBox(height: 8)
        ],
      ),
    );
  }
}
