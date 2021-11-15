import 'package:flutter/material.dart';
import 'package:project_finaltask/feedpage.dart';
import 'package:project_finaltask/mypage.dart';
import 'package:project_finaltask/settingpage.dart';
import 'package:project_finaltask/tagpage.dart';

import 'color_extension.dart';

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _selectedIndex = 0;

  //表示するもの
  static List<Widget> _pages = <Widget>[
    Feed(),
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
