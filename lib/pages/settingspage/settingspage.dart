import 'package:flutter/material.dart';
import 'package:project_finaltask/pages/settingspage/privacypolicyscreen.dart';
import 'package:project_finaltask/pages/settingspage/tosscreen.dart';
import 'package:project_finaltask/utils/color_extension.dart';

import '../../components/appbar.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarComponent(text: 'Settings'),
        body: Container(
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
              ListItem(
                  title: 'プライバシーポリシー',
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => PrivacyPolicyScreen()));
                  }),
              ListItem(
                  title: '利用規約',
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => ToSScreen()));
                  }),
              ListItem(
                  title: 'アプリバージョン',
                  trailing: Text(
                    'v1.0.0',
                    style: TextStyle(fontSize: 14),
                  ),
                  onTap: () {}),
              SizedBox(height: 36),
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
              ListItem(
                  title: 'ログアウトする', trailing: SizedBox.shrink(), onTap: () {}),
            ],
          ),
        ));
  }
}

class ListItem extends StatelessWidget {
  ListItem({
    required this.title,
    required this.trailing,
    required this.onTap,
  });

  final String title;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: '#FFFFFF'.toColor(),
          border: Border(
              bottom: BorderSide(color: '#E0E0E0'.toColor(), width: 0.5))),
      child: ListTile(
        title: Text(title),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
