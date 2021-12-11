import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/utils/changedate.dart';

import '../article.dart';
import '../color_extension.dart';
import '../qiita_qlient.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  final Future<List<Article>> articles = QiitaClient.fetchArticle();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feed',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Pacifico',
            color: '#000000'.toColor(),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<Article>>(
            future: articles,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ArticleListView(articles: snapshot.data!.toList());
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class ArticleListView extends StatelessWidget {
  late final List<Article> articles;

  ArticleListView({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          final article = articles[index];
          return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(article.user.iconUrl),
              ),
              title: Text(article.title),
              subtitle: Text(
                  '@${article.user.id} 投稿日:${changeDateFormat(article.date)} LGTM:${article.lgtm.toString()}'),
              onTap: () {});
        });
  }
}
