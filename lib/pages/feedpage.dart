import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/pages/articlepage.dart';
import 'package:project_finaltask/utils/changedate.dart';

import '../models/article.dart';
import '../utils/color_extension.dart';
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
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
            future: articles,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ArticleListView(articles: snapshot.data!.toList());
              }
              return CircularProgressIndicator();
            }),
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
          return Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: '#B2B2B2'.toColor(), width: 0.5)),
            ),
            child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(article.user.iconUrl),
                ),
                title: Text(article.title),
                subtitle: Text(
                    '@${article.user.id} 投稿日:${changeDateFormat(article.date)} LGTM:${article.lgtm.toString()}'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArticlePage(article: article)));
                }),
          );
        });
  }
}
