import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/tag.dart';

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
