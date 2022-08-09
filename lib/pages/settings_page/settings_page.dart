import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:project_finaltask/pages/settings_page/privacy_policy_screen.dart';
import 'package:project_finaltask/pages/settings_page/settings_list_item_component.dart';
import 'package:project_finaltask/pages/settings_page/term_of_service_screen.dart';
import 'package:project_finaltask/utils/color_extension.dart';

import '../../components/appbar_component.dart';
import '../../qiita_client.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool? _isLogined;
  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );

  @override
  void initState() {
    super.initState();
    checkLogin();
    _getPackageInfo();
  }

  void checkLogin() async {
    _isLogined = await QiitaClient().accessTokenIsSaved();
    setState(() {});
  }

  Future<void> _getPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarComponent(text: 'Settings'),
        body: _isLogined == null
            ? Center(child: CupertinoActivityIndicator())
            : Container(
                color: '#F7F7F7'.toColor(),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 32),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'アプリ情報',
                        style: TextStyle(
                          fontSize: 12,
                          color: '#828282'.toColor(),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SettingsListItemComponent(
                        title: 'プライバシーポリシー',
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          showCupertinoModalBottomSheet(
                              enableDrag: true,
                              context: context,
                              builder: (context) {
                                return PrivacyPolicyScreen();
                              });
                        }),
                    SettingsListItemComponent(
                        title: '利用規約',
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          showCupertinoModalBottomSheet(
                              enableDrag: true,
                              context: context,
                              builder: (context) {
                                return TermOfServiceScreen();
                              });
                        }),
                    SettingsListItemComponent(
                        title: 'アプリバージョン',
                        trailing: Text(
                          'v${_packageInfo.version}',
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () {}),
                    SizedBox(height: 36),
                    _isLogined!
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  'その他',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: '#828282'.toColor(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              SettingsListItemComponent(
                                  title: 'ログアウトする',
                                  trailing: SizedBox.shrink(),
                                  onTap: () {}),
                            ],
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ));
  }
}
