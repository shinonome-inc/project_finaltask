import 'package:flutter/material.dart';
import 'package:project_finaltask/pages/feed_page.dart';
import 'package:project_finaltask/pages/my_page/my_page.dart';
import 'package:project_finaltask/pages/settings_page/settings_page.dart';
import 'package:project_finaltask/pages/tag_page.dart';

import 'utils/color_extension.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  //表示するもの
  static List<Widget> _pages = <Widget>[
    FeedPage(),
    TagPage(),
    MyPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: '#74C13A'.toColor(),
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined), label: 'フィード'),
          BottomNavigationBarItem(icon: Icon(Icons.label_outline), label: 'タグ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'マイページ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: '設定'),
        ],
      ),
    );
  }
//  format_list_

//タップ時の処理
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
