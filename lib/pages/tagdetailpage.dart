import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/models/tag.dart';
import 'package:project_finaltask/pages/articlepage.dart';
import 'package:project_finaltask/utils/changedate.dart';

import '../models/article.dart';
import '../qiita_qlient.dart';
import '../utils/color_extension.dart';

class TagDetailPage extends StatelessWidget {
  late final Tag tag;
  TagDetailPage({Key? key, required this.tag}) : super(key: key);

  final Future<List<Article>> articles = QiitaTagArticle.fetchArticle();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tag.id,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Pacifico',
            color: '#000000'.toColor(),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
            future: articles,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TagArticleListView(articles: snapshot.data!.toList());
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}

class TagArticleListView extends StatelessWidget {
  late final List<Article> articles;
  TagArticleListView({Key? key, required this.articles}) : super(key: key);

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
                title: Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
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
