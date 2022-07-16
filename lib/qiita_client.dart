import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'models/article.dart';
import 'models/tag.dart';
import 'models/user.dart';

class QiitaClient {
  final clientID = '806515abce77408e98feed9ab93cab135a43182f';
  final clientSecret = '0c4fe0a00f290f04f905f6a982b2ed4848b615d6';
  final keyAccessToken = 'qiita/accessToken';

  // 'df9586e167ea06de68a460858b20b6a237d2b3a2'; //登録したアクセストークン

  String createAuthorizeUrl(String state) {
    final scope = 'read_qiita';
    return 'https://qiita.com/api/v2/oauth/authorize?client_id=$clientID&scope=$scope&state=$state';
  } //scope

  Future<String> createAccessTokenFromCallbackUri(
      Uri uri, String expectedState) async {
    final String? state = uri.queryParameters['state'];
    final String? code = uri.queryParameters['code'];
    if (expectedState != state) {
      throw Exception('The state is different from expectedState.');
    }
    final response = await http.post(
      Uri.parse('https://qiita.com/api/v2/access_tokens'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({
        'client_id': clientID,
        'client_secret': clientSecret,
        'code': code,
      }),
    );
    final body = jsonDecode(response.body); //デコード
    final accessToken = body['token'];
    return accessToken;
  } //リダイレクトURLからアクセストークンを受け取る

  Future<void> saveAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyAccessToken, accessToken);
  } //アクセストークンをローカルに保存

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyAccessToken);
  } //アクセストークンを取り出す

  Future<bool> accessTokenIsSaved() async {
    final accessToken = await getAccessToken();
    return accessToken != null;
  }

  Future<List<Article>> fetchArticle(int page, String? query) async {
    final accessToken = await getAccessToken();
    String? url = 'https://qiita.com/api/v2/items?page=$page&per_page=20';
    if (query != '') {
      url += '&query=$query';
    }
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      return jsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  } //記事を取得

  Future<List<Article>> fetchTagArticle(int page, String? tagid) async {
    final accessToken = await getAccessToken();
    final url =
        'https://qiita.com/api/v2/tags/$tagid/items?page=$page&per_page=20';
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      return jsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tag article');
    }
  }

  Future<List<Article>> fetchUserArticle() async {
    final accessToken = await getAccessToken();
    final url =
        'https://qiita.com/api/v2/authenticated_user/items?page=1&per_page=20';
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      return jsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Fail to load user article');
    }
  }

  Future<User> getAuthenticatedUser() async {
    final accessToken = await getAccessToken();
    final url = 'https://qiita.com/api/v2/authenticated_user';
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return User.fromJson(body);
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<List<Tag>> fetchTag() async {
    final accessToken = await getAccessToken();
    final url = 'https://qiita.com/api/v2/tags?page=1&per_page=20&sort=count';
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      return jsonArray.map((json) => Tag.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tag');
    }
  }
}
