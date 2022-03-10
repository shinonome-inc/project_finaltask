import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/article.dart';
import 'models/tag.dart';

class QiitaClient {
  static Future<List<Article>> fetchArticle(int page) async {
    final url = 'https://qiita.com/api/v2/items?page=$page';
    final response = await http.get(Uri.parse(url));
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
