import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/article.dart';
import 'models/tag.dart';

class QiitaClient {
  final clientID = '806515abce77408e98feed9ab93cab135a43182f';
  final clientSecret = '0c4fe0a00f290f04f905f6a982b2ed4848b615d6';
  final keyAccessToken =
      'df9586e167ea06de68a460858b20b6a237d2b3a2'; //発行したアクセストークン

  String createAuthorizeUrl(String state) {
    final scope = 'read_qiita';
    return 'https://qiita.com/api/v2/oauth/authorize?client_id=$clientID&scope=$scope&state=$state';
  } //scope

  Future<List<Article>> fetchArticle(int page) async {
    final accessToken = keyAccessToken;
    final url = 'https://qiita.com/api/v2/items?page=$page&per_page=20';
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      return jsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }
}

class QiitaTag {
  static Future<List<Tag>> fetchTag() async {
    final url = 'https://qiita.com/api/v2/tags?page=1&per_page=20&sort=count';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      return jsonArray.map((json) => Tag.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tag');
    }
  }
}

class QiitaTagArticle {
  late final Tag tag;
  static Future<List<Article>> fetchArticle() async {
    final url = 'https://qiita.com/api/v2/tags/flutter/items';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      return jsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tag article');
    }
  }
}
