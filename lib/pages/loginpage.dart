import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/components/appbar.dart';
import 'package:project_finaltask/pages/toppage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../qiita_client.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _state;
  late StreamSubscription _sub;
  bool _hascode = false;

  @override
  void initState() {
    super.initState();
    _state = _randomString(40);
    // initUniLinks();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  // Future<void> initUniLinks() async {
  //   _sub = uriLinkStream.listen((Uri? uri) {
  //     if (!mounted) return;
  //     print('Received URI:$uri');
  //     setState(() {
  //       _onAuthorizeCallbackIsCalled(uri!);
  //     });
  //   }, onError: (err) {
  //     print(err);
  //   });
  // }

//   Future<void> WebView() async{
//     initialUrl: url;
//     navigationDelegate:(request){}
// }//リダイレクトURLのcodeクエリの中の"code"を読みとり
//   //アクセストークンを取得するリクエストを作成する
//   //リダイレクトURLを受け取る

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(text: 'Qiita Auth'),
      body: Center(
        child: WebView(
          initialUrl: QiitaClient().createAuthorizeUrl(_state),
          navigationDelegate: (NavigationRequest request) {
            if (request.url
                .contains('https://qiita.com/settings/applications?code')) {
              // setState(() {
              //   _hascode = true;
              // });
              Uri uri = Uri.parse(request.url);
              _onAuthorizeCallbackIsCalled(uri);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          // onPageFinished: (String url) {
          //   // if (request.url
          //   //     .contains('https://qiita.com/settings/applications?code')) {
          //   if (_hascode) {
          //     Uri uri = Uri.parse(url);
          //     _onAuthorizeCallbackIsCalled(uri);
          //   }
        ),
      ),
    );
  }

  void _onAuthorizeCallbackIsCalled(Uri uri) async {
    // closeWebView();
    final accessToken =
        await QiitaClient().createAccessTokenFromCallbackUri(uri, _state);
    // リダイレクトURLからアクセストークンを受け取る
    await QiitaClient().saveAccessToken(accessToken);
    print(accessToken);

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
