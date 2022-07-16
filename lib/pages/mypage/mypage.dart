import 'package:flutter/material.dart';
import 'package:project_finaltask/components/appbar.dart';
import 'package:project_finaltask/pages/mypage/loginview.dart';

import '../../qiita_client.dart';
import 'not_loginview.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool? _isLogined;

  @override
  void initState() {
    super.initState();
    checklogin();
  }

  void checklogin() async {
    _isLogined = await QiitaClient().accessTokenIsSaved();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(text: 'MyPage'),
      body: Center(
          child: _isLogined == null
              ? CircularProgressIndicator()
              : _isLogined!
                  ? LoginView()
                  : NotLoginView()),
    );
  }
}
