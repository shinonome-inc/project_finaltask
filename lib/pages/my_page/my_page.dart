import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/components/appbar_component.dart';
import 'package:project_finaltask/views/user_view.dart';

import '../../models/user.dart';
import '../../qiita_client.dart';
import 'not_login_view.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool? _isLogined;
  User? user;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    _isLogined = await QiitaClient().accessTokenIsSaved();
    if (_isLogined!) {
      user = await QiitaClient().getAuthenticatedUser();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(text: 'MyPage'),
      body: Center(
          child: _isLogined == null
              ? CupertinoActivityIndicator()
              : _isLogined!
                  ? UserView(user!)
                  : NotLoginView()),
    );
  }
}
