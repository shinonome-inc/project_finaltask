import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/pages/articlelistview.dart';

import '../../models/article.dart';
import '../../models/user.dart';
import '../../qiita_client.dart';
import '../../utils/color_extension.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  List<Article> articleList = [];
  final Future<User> user = QiitaClient().getAuthenticatedUser();
  final Future<List<Article>> userarticle = QiitaClient().fetchUserArticle();

  bool _isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    loadArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    onNotification: (ScrollNotification notification) {
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
                              child: ArticleListView(articleList: articleList),
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
              Text('${user.followeescount}',
                  style: TextStyle(
                    color: '#000000'.toColor(),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text('フォロー中',
                      style: TextStyle(
                        color: '#828282'.toColor(),
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                      ))),
              Text('${user.followerscount}',
                  style: TextStyle(
                    color: '#000000'.toColor(),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text('フォロワー',
                      style: TextStyle(
                        color: '#828282'.toColor(),
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                      ))),
            ],
          ),
          SizedBox(height: 8)
        ],
      ),
    );
  }
}
