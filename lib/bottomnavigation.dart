import 'package:flutter/material.dart';
import 'package:project_finaltask/pages/feedpage.dart';
import 'package:project_finaltask/pages/mypage.dart';
import 'package:project_finaltask/pages/settingpage.dart';
import 'package:project_finaltask/pages/tagpage.dart';

import 'color_extension.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  //表示するもの
  static List<Widget> _pages = <Widget>[
    FeedPage(),
    Tag(),
    MyPage(),
    Setting(),
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
              icon: Icon(Icons.format_list_bulleted), label: 'フィード'),
          BottomNavigationBarItem(icon: Icon(Icons.label), label: 'タグ'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'マイページ'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
        ],
      ),
    );
  }

//タップ時の処理
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
