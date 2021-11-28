import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'color_extension.dart';

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

class User {
  final String id;
  final String iconUrl;
  User({required this.id, required this.iconUrl});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      iconUrl: json['profile_image_url'],
    );
  }
}

class Article {
  final String title;
  final String url;
  final String date;
  final User user;
  final int? lgtm;

  Article(
      {required this.title,
      required this.url,
      required this.user,
      required this.date,
      required this.lgtm});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      url: json['url'],
      date: json['created_at'],
      lgtm: json['likes_count'],
      user: User.fromJson(json['user']),
    );
  }
}

//日付変換
String changeDateFormat(String date) {
  initializeDateFormatting('ja_JP');
  // StringからDate
  final DateTime datetime = DateTime.parse(date);

  final DateFormat formatter = DateFormat('yyyy/MM/dd', 'ja_JP');
  // DateからString
  final String formatted = formatter.format(datetime);
  return formatted;
}

class QiitaClient {
  static Future<List<Article>> fetchArticle() async {
    final url = 'https://qiita.com/api/v2/items';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      return jsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
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
              subtitle: Row(
                children: [
                  Text('@'),
                  Text(article.user.id),
                  Text(' 投稿日: '),
                  Text(changeDateFormat(article.date)),
                  Text(' LGTM: '),
                  Text(article.lgtm.toString()),
                ],
              ),
              onTap: () {});
        });
  }
}
