import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_finaltask/pages/toppage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../components/webview_modal_component.dart';
import '../qiita_client.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _state;

  @override
  void initState() {
    super.initState();
    _state = _randomString(40);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewModalComponent(
      title: 'Qiita Auth',
      initialUrl: QiitaClient().createAuthorizeUrl(_state),
      navigationDelegate: (NavigationRequest request) {
        if (request.url
            .contains('https://qiita.com/settings/applications?code')) {
          Uri uri = Uri.parse(request.url);
          _onAuthorizeCallbackIsCalled(uri);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }

  void _onAuthorizeCallbackIsCalled(Uri uri) async {
    final accessToken =
        await QiitaClient().createAccessTokenFromCallbackUri(uri, _state);
    // リダイレクトURLからアクセストークンを受け取る
    await QiitaClient().saveAccessToken(accessToken);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => TopPage()),
    );
  }

  String _randomString(int length) {
    final chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rand = Random.secure();
    final codeUnits = List.generate(length, (index) {
      final n = rand.nextInt(chars.length);
      return chars.codeUnitAt(n);
    });
    return String.fromCharCodes(codeUnits);
  }
}
